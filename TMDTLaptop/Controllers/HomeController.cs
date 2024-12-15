using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TMDTLaptop.Models;
using System.Web.Services.Description;
using System.Data.Entity;

namespace TMDTLaptop.Controllers
{
    public class HomeController : Controller
    {
        LaptopStoreEntities db = new LaptopStoreEntities();
        public ActionResult Index()
        {
            // Giả sử bạn có một danh sách các voucher từ database
            var vouchers = db.Voucher.ToList(); // Lấy tất cả các voucher từ database

            // Lọc voucher còn hiệu lực
            var currentVouchers = vouchers.Where(v => v.TrangThai == true // Voucher đang hoạt động
                                                       && v.NgayBatDau <= DateTime.Now // Ngày bắt đầu đã đến
                                                       && v.NgayKetThuc >= DateTime.Now // Ngày kết thúc chưa tới
                                                       && v.SoLuongSuDung != v.SoLuongSuDungToiDa) // Số lượng sử dụng chưa đạt giới hạn
                                           .ToList();

            // Chỉ lấy voucher đầu tiên trong danh sách hiện tại (nếu có)
            var voucher = currentVouchers;

            ViewBag.Voucher = voucher; // Truyền voucher vào view
                                       // Lấy dữ liệu từ cơ sở dữ liệu 
            var banners = db.Banner.ToList();

            // Truyền dữ liệu vào ViewBag
            ViewBag.Banners = banners;
            var products = db.SanPham.Where(u => u.TrangThai == true)
                      .OrderByDescending(p => p.MaSanPham)
                      .Take(8)
               .ToList();
            return View(products);
        }

        [HttpPost]
        public JsonResult ApplyCoupon(string coupon)
        {
            var username = Session["Username"] as string;
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == username);
            var giohang = db.GioHang.SingleOrDefault(u => u.MaTaiKhoan == user.MaTaiKhoan);
            if (giohang == null)
            {
                return Json(new { success = false, message = "Bạn không có sản phẩm nào để giảm." });
            }
            // Tìm mã giảm giá hợp lệ trong cơ sở dữ liệu
            var validCoupon = db.Voucher.SingleOrDefault(v => v.Code == coupon && v.SoLuongSuDung < v.SoLuongSuDungToiDa && v.NgayBatDau <= DateTime.Now && v.NgayKetThuc >= DateTime.Now && v.TrangThai != false);

            if (validCoupon == null)
            {
                return Json(new { success = false, message = "Mã giảm giá không hợp lệ hoặc đã hết lượt sử dụng." });
            }


            // Kiểm tra xem mã giảm giá đã được áp dụng cho đơn hàng nào chưa
            var donHangHienTai = db.DonHang.Any(u => u.MaTaiKhoan == user.MaTaiKhoan && u.MaVoucher == validCoupon.MaVoucher);
            if (donHangHienTai)
            {
                return Json(new { success = false, message = "Bạn đã sử dụng mã giảm giá này, mỗi người chỉ được sử dụng 1 lần." });
            }

            // Lưu mã coupon vào session hoặc đơn hàng
            Session["Coupon"] = validCoupon;



            return Json(new { success = true, message = "Áp dụng mã giảm giá thành công!" });
        }


        public ActionResult DatHangThanhCong()
        {
            var username = Session["Username"] as string;
            if (string.IsNullOrEmpty(username))
            {
                return RedirectToAction("DangNhap", "Home");
            }

            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == username);
            if (user == null)
            {
                return HttpNotFound("Người dùng không tìm thấy.");
            }

            var giohang = db.GioHang.SingleOrDefault(u => u.MaTaiKhoan == user.MaTaiKhoan);
            if (giohang == null)
            {
                return HttpNotFound("Giỏ hàng không tồn tại.");
            }

            var chitietgiohang = db.ChiTietGioHang
                .Where(u => u.MaGioHang == giohang.MaGioHang)
                .ToList();

            if (!chitietgiohang.Any())
            {
                ModelState.AddModelError("", "Giỏ hàng của bạn đang trống.");
                return View("GioHang");
            }
        
            // Tạo đơn hàng mới
            var donHang = new DonHang
            {
                MaTaiKhoan = user.MaTaiKhoan,
                NgayDatHang = DateTime.Now,
                TongTien = chitietgiohang.Sum(item => item.SoLuong * item.Gia),
                DiaChiGiaoHang = user.DiaChi,
                SoDienThoai = user.SoDienThoai,
                TrangThai = "Đang chờ xử lý"
            };
            // Kiểm tra xem có mã giảm giá hay không
            var voucher = Session["CouponDH"] as Voucher;

            if (voucher != null)
            {
                var mavoucher = db.Voucher.SingleOrDefault(u => u.Code == voucher.Code);
                mavoucher.SoLuongSuDung += 1;
                donHang.MaVoucher = mavoucher.MaVoucher;
                donHang.TongTien = donHang.TongTien - donHang.TongTien * mavoucher.GiamGia /100;
                ViewBag.MaVoucher = mavoucher.Code;
                ViewBag.phantram = mavoucher.GiamGia;
            }
            db.DonHang.Add(donHang);
            db.SaveChanges();

            // Thêm chi tiết đơn hàng
            var orderDetails = new List<string>(); // Danh sách thông tin sản phẩm
            foreach (var item in chitietgiohang)
            {
                var chiTietDonHang = new ChiTietDonHang
                {
                    MaDonHang = donHang.MaDonHang,
                    MaSanPham = item.MaSanPham,
                  
                    SoLuong = item.SoLuong,
                    Gia = item.SanPham.GiaMoi.HasValue ? item.SanPham.GiaMoi : item.SanPham.Gia
                };
                db.ChiTietDonHang.Add(chiTietDonHang);
                // Cập nhật số lượng tồn kho
                var sanpham = db.SanPham.SingleOrDefault(u=>u.MaSanPham==item.MaSanPham);
                sanpham.SoLuong -= item.SoLuong;
                db.SaveChanges();
                // Thêm thông tin chi tiết đơn hàng vào danh sách
                orderDetails.Add($"{item.SanPham.TenSanPham}|{item.Gia}|{item.SoLuong}|{item.SoLuong * item.Gia}");
            }

        
            db.ChiTietGioHang.RemoveRange(chitietgiohang);
            db.SaveChanges();

            // Gán thông tin vào ViewBag
            ViewBag.OrderId = donHang.MaDonHang.ToString();
           
            ViewBag.OrderDetails = orderDetails;
            ViewBag.TotalAmount = donHang.TongTien;
            Session.Remove("CouponDH");
            return View();
        }

        public ActionResult GetDanhMuc()
        {

            var danhMucs = db.DanhMucSanPham.Where(u => u.TrangThai == true).ToList(); // Lấy tất cả các danh mục từ database
            return PartialView("_DanhMucPartial", danhMucs); // Trả về partial view chứa danh mục
        }
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }
        public ActionResult DangKy()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }
        [HttpPost]
        public ActionResult DangKy(TaiKhoan model, string XacNhanMatKhau)
        {
            // Kiểm tra hợp lệ dữ liệu (nếu cần)
            if (ModelState.IsValid)
            {
                // Kiểm tra mật khẩu xác nhận
                if (model.Password != XacNhanMatKhau)
                {
                    ModelState.AddModelError("MatKhauNhapLai", "Mật khẩu xác nhận không khớp.");
                    return View(model);
                }

                // Kiểm tra xem tên đăng nhập đã tồn tại hay chưa
                var existingUser = db.TaiKhoan.SingleOrDefault(t => t.Username == model.Username);
                if (existingUser != null)
                {
                    ModelState.AddModelError("Username", "Tên đăng nhập đã tồn tại.");
                    return View(model);
                }

                // Kiểm tra xem email đã tồn tại hay chưa
                var existingEmail = db.TaiKhoan.SingleOrDefault(t => t.Email == model.Email);
                if (existingEmail != null)
                {
                    ModelState.AddModelError("Email", "Email đã tồn tại trong hệ thống.");
                    return View(model);
                }

                // Gán giá trị cho các trường còn lại (Ngày tạo, Trạng thái, ...)
                model.NgayTao = DateTime.Now;
                model.TrangThai = true; // Hoặc thiết lập theo logic 
                model.MaQuyen = 3;

                // Thêm vào database
                db.TaiKhoan.Add(model);
                db.SaveChanges();

                // Tạo giỏ hàng cho khách
                GioHang gioHang = new GioHang
                {
                    MaTaiKhoan = model.MaTaiKhoan,
                    TongTien = 0
                };
                db.GioHang.Add(gioHang);
                db.SaveChanges();

                TempData["SuccessMessage"] = "Đăng ký thành công.";
                // Redirect tới trang đăng nhập hoặc trang khác sau khi đăng ký thành công
                return RedirectToAction("DangNhap", "Home");
            }

            // Nếu dữ liệu không hợp lệ, trả về view với các thông tin lỗi
            return View(model);
        }

        public ActionResult GioHang()
        {
            var taikhoan = Session["Username"] as string;
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == taikhoan);

            if (user == null)
            {
                return RedirectToAction("Login", "Account"); // Nếu không tìm thấy người dùng, chuyển hướng đến trang đăng nhập
            }

            var giohang = db.GioHang.SingleOrDefault(u => u.MaTaiKhoan == user.MaTaiKhoan);
            if (giohang == null)
            {
                ViewBag.TongTien = 0; // Nếu giỏ hàng không tồn tại, tổng tiền là 0
                return View(new List<ChiTietGioHang>()); // Trả về danh sách rỗng
            }
            //kiểm tra xem có sản phẩm nào hết hàng hay không
            var sanpham = db.ChiTietGioHang.Where(u => u.SanPham.SoLuong==0 && u.MaGioHang == giohang.MaGioHang);
            if (sanpham != null)
            {
                db.ChiTietGioHang.RemoveRange(sanpham);
                db.SaveChanges();
            }
          
            // Kiểm tra xem có mã giảm giá hay không
            var voucher = Session["Coupon"] as Voucher;
            Session["CouponDH"] = voucher;
            // Tính tổng tiền
            decimal? tongTien = db.ChiTietGioHang
                .Where(u => u.MaGioHang == giohang.MaGioHang)
                .Sum(item => item.SoLuong * item.Gia);

            // Nếu có voucher và voucher chưa được áp dụng cho giỏ hàng
            if (voucher != null)
            {
               
              tongTien -= (tongTien * voucher.GiamGia / 100); // Giảm giá nếu voucher hợp lệ và chưa được sử dụng
               
            }

            ViewBag.TongTien = tongTien.HasValue ? tongTien : 0;
            var chitietgiohang = db.ChiTietGioHang
                .Where(u => u.MaGioHang == giohang.MaGioHang)
                .ToList();
            Session.Remove("Coupon");
            return View(chitietgiohang);
        }

        [HttpPost]
        public ActionResult AddToCart(int productId, int quantity)
        {

            // Tìm sản phẩm theo productId
            var product = db.SanPham.SingleOrDefault(sp => sp.MaSanPham == productId);
            if (product == null)
            {
                return HttpNotFound();
            }
            if (product.SoLuong == 0)
            {
                TempData["Message"] = "Sản phẩm đã hết.";
                return RedirectToAction("ChiTietSanPham", "Home", new { id = productId });
            }
            if (quantity > product.SoLuong)
            {
                TempData["Message"] = "Vượt quá số lượng tồn kho.";
                return RedirectToAction("ChiTietSanPham", "Home",new {id = productId });
            }
            // Lấy từ Session và tìm khách hàng tương ứng
            var taikhoan = Session["Username"] as string;
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == taikhoan);
            if (user == null)
            {
                return HttpNotFound("User not found.");
            }

            // Lấy giỏ hàng của người dùng
            var giohang = db.GioHang.SingleOrDefault(u => u.MaTaiKhoan == user.MaTaiKhoan);
            if (giohang == null)
            {
                // Nếu giỏ hàng không tồn tại, bạn có thể tạo một giỏ hàng mới
                giohang = new GioHang
                {
                    MaTaiKhoan = user.MaTaiKhoan,
                    TongTien = 0
                    // Thêm các thuộc tính khác cần thiết cho giỏ hàng
                };
                db.GioHang.Add(giohang);
                db.SaveChanges(); // Lưu giỏ hàng mới vào cơ sở dữ liệu
            }

            // Tìm sản phẩm trong giỏ hàng
            var cartItem = db.ChiTietGioHang
                .SingleOrDefault(ci => ci.MaGioHang == giohang.MaGioHang && ci.MaSanPham == productId );
           
            if (cartItem == null)
            {
                // Nếu sản phẩm chưa có trong giỏ, thêm sản phẩm mới vào giỏ
                var newCartItem = new ChiTietGioHang
                {
                    MaGioHang = giohang.MaGioHang,
                    MaSanPham = productId,
                    SoLuong = quantity,
                    Gia = product.GiaMoi.HasValue ? product.GiaMoi.Value : product.Gia

                };
                db.ChiTietGioHang.Add(newCartItem);
            }
            else
            {
                // Nếu sản phẩm đã có trong giỏ, cập nhật số lượng
                cartItem.SoLuong += quantity;
            }

            // Lưu thay đổi vào cơ sở dữ liệu
            db.SaveChanges();

            return RedirectToAction("GioHang", "Home"); // Chuyển hướng tới trang giỏ hàng
        }
        public ActionResult XoaGioHang(int id)
        {
            var taikhoan = Session["Username"] as string;
            var user = db.TaiKhoan.SingleOrDefault(k => k.Username.Contains(taikhoan));
            var giohang = db.GioHang.SingleOrDefault(u => u.MaTaiKhoan == user.MaTaiKhoan);
            var sanpham = db.ChiTietGioHang.SingleOrDefault(u => u.MaSanPham == id && u.MaGioHang == giohang.MaGioHang );
            db.ChiTietGioHang.Remove(sanpham);
            db.SaveChanges();
            return RedirectToAction("GioHang", "Home");
        }
        [HttpPost]
        public JsonResult CapNhatGioHang(int productId, int quantity)
        {
            var taikhoan = Session["Username"] as string;
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == taikhoan);
            if (user == null)
            {
                return Json(new { success = false, message = "Người dùng không tìm thấy." });
            }
           
            var giohang = db.GioHang.SingleOrDefault(u => u.MaTaiKhoan == user.MaTaiKhoan);
            if (giohang == null)
            {
                return Json(new { success = false, message = "Giỏ hàng không tồn tại." });
            }

            var cartItem = db.ChiTietGioHang
                .SingleOrDefault(ci => ci.MaGioHang == giohang.MaGioHang && ci.MaSanPham == productId);
            var sanpham = db.SanPham.SingleOrDefault(u=>u.MaSanPham==cartItem.MaSanPham);
            if (quantity > sanpham.SoLuong)
            {
                return Json(new { success = true, message = "Vượt quá số lượng tồn kho." });
            }
            if (cartItem != null)
            {
                cartItem.SoLuong = quantity;
                db.SaveChanges();
                return Json(new { success = true, message = "Sản phẩm đã được cập nhật trong giỏ hàng." });
            }

            return Json(new { success = false, message = "Sản phẩm không tồn tại trong giỏ hàng." });
        }
        public ActionResult DangXuat()
        {
            Session.Remove("Username");
            return RedirectToAction("Index", "Home");
        }
        public ActionResult Chat()
        {
            string currentUser = Session["Username"]?.ToString(); // Lấy tên người dùng từ session
            var user = db.TaiKhoan.SingleOrDefault(u=>u.Username==currentUser);
            // Lấy danh sách tin nhắn theo ID của người gửi và người nhận
            var userMessages = db.Messages
                .Where(m => m.SenderId == user.MaTaiKhoan || m.ReceiverId == user.MaTaiKhoan)
                .ToList(); // Chuyển đổi kết quả thành danh sách

            return View(userMessages);
        }
        [HttpPost]
        public ActionResult SendMessage(string receiver, string content)
        {
            string sender = Session["Username"]?.ToString(); // Lấy tên người gửi từ session
            if (string.IsNullOrEmpty(sender))
            {
                // Xử lý khi không có tên người dùng trong session (có thể redirect hoặc thông báo lỗi)
                return RedirectToAction("Chat");
            }
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == sender);
            var nv = db.TaiKhoan.SingleOrDefault(u => u.MaQuyen == 4 && u.TrangThai == true);
            var message = new Messages
            {
                // Giả sử bạn có một Id tự động tăng trong bảng Messages
                SenderId = user.MaTaiKhoan,
                ReceiverId = nv.MaTaiKhoan,
                Content = content,
                Timestamp = DateTime.Now
            };

            db.Messages.Add(message); // Thêm tin nhắn vào DB
            db.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

            return RedirectToAction("Chat");
        }
 

        public JsonResult GetMessages()
        {
            string currentUser = Session["Username"]?.ToString();
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == currentUser);

            // Lấy danh sách tin nhắn và chuyển đổi sau
            var userMessages = db.Messages
                .Where(m => m.SenderId == user.MaTaiKhoan || m.ReceiverId == user.MaTaiKhoan)
                .OrderBy(m => m.Timestamp)
                .Select(m => new
                {
                    m.Content,
                    m.SenderId,
                    // Chỉ trả về Timestamp mà không chuyển đổi
                    m.Timestamp
                })
                .ToList()
                .Select(m => new
                {
                    m.Content,
                    m.SenderId,
                    // Thực hiện chuyển đổi ở đây
                    Timestamp = m.Timestamp.ToString("dd/MM/yyyy HH:mm:ss") // Định dạng ISO 8601
                });

            return Json(userMessages, JsonRequestBehavior.AllowGet);
        }


        public ActionResult HoSo()
        {
            var taikhoan = Session["Username"] as string;
            var user = db.TaiKhoan.SingleOrDefault(k => k.Username.Contains(taikhoan));

            // Lấy danh sách đơn hàng của người dùng
            var orders = db.DonHang.Where(d => d.MaTaiKhoan == user.MaTaiKhoan).ToList(); 

            ViewBag.Orders = orders; // Đưa danh sách đơn hàng vào ViewBag
            return View(user);
        }
        [HttpPost]
        public ActionResult HoSo(string tenKhachHang, string soDienThoai, string diaChi, string matKhauHienTai, string matKhauMoi, string xacNhanMatKhauMoi)
        {
            var tendn = Session["Username"] as string;
            var user = db.TaiKhoan.SingleOrDefault(k => k.Username.Contains(tendn));

            if (!string.IsNullOrEmpty(matKhauHienTai))
            {

                if (user.Password == matKhauHienTai)
                {
                    if (matKhauMoi == xacNhanMatKhauMoi)
                    {
                        user.Password = matKhauMoi;
                    }
                    else
                    {
                        ModelState.AddModelError("", "Xác nhận mật khẩu mới không khớp.");
                        return View(user);
                    }
                }
                else
                {
                    ModelState.AddModelError("MatKhauHienTai", "Mật khẩu hiện tại không đúng.");
                    return View(user);
                }
            }

            if (ModelState.IsValid)
            {

                user.HoTen = tenKhachHang;
                user.SoDienThoai = soDienThoai;
                user.DiaChi = diaChi;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Thông tin đã được cập nhật thành công.";
                return RedirectToAction("HoSo", "Home");
            }

            return View();
        }
        public ActionResult DangNhap()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(string text, string MatKhau)
        {
            // Kiểm tra nếu tên đăng nhập hoặc mật khẩu không hợp lệ
            if (string.IsNullOrEmpty(text) || string.IsNullOrEmpty(MatKhau))
            {
                ModelState.AddModelError("", "Tên đăng nhập và mật khẩu là bắt buộc.");
                return View();
            }

            // Tìm kiếm tài khoản theo tên đăng nhập (ở đây là 'text')
            var user = db.TaiKhoan.SingleOrDefault(t => t.Username == text);
            if (user == null)
            {
                ModelState.AddModelError("", "Tên đăng nhập không tồn tại.");
                return View();
            }

            // Kiểm tra mật khẩu
            if (user.Password != MatKhau)
            {
                ModelState.AddModelError("", "Mật khẩu không đúng.");
                return View();
            }

            // Kiểm tra trạng thái tài khoản (nếu có)
            if (user.TrangThai == false)
            {
                ModelState.AddModelError("", "Tài khoản của bạn đã bị khóa vui lòng liên hệ admin để mở khóa.");
                return View();
            }

            // Đăng nhập thành công, lưu thông tin vào session
    
            Session["Username"] = user.Username;
           

            // Redirect về trang chủ hoặc trang người dùng sau khi đăng nhập thành công
            return RedirectToAction("Index", "Home");
        }
        public ActionResult CuaHang(int id, string search = "", decimal? minPrice = null, decimal? maxPrice = null, int? brand = null, int page = 1, int pageSize = 6)
        {
            var products = db.SanPham.Where(u => u.MaDanhMuc == id && u.TrangThai == true);

            // Tìm kiếm theo tên sản phẩm
            if (!string.IsNullOrEmpty(search))
            {
                products = products.Where(u => u.TenSanPham.Contains(search));
                ViewBag.Search = search;
            }

            // Lọc theo khoảng giá
            if (minPrice.HasValue)
            {
                products = products.Where(u => u.Gia >= minPrice.Value);
                ViewBag.MinPrice = minPrice.Value;
            }
            if (maxPrice.HasValue)
            {
                products = products.Where(u => u.Gia <= maxPrice.Value);
                ViewBag.MaxPrice = maxPrice.Value;
            }

            // Lọc theo thương hiệu
            if (brand.HasValue)
            {
                products = products.Where(u => u.MaHang == brand.Value);
                ViewBag.Brand = brand.Value;
            }

            // Nếu không tìm thấy sản phẩm nào, chuyển hướng đến action Error
            if (!products.Any())
            {
                return RedirectToAction("Error", "Home");
            }

            // Sắp xếp sản phẩm (ví dụ: theo tên sản phẩm)
            products = products.OrderByDescending(u => u.MaSanPham); // Thêm sắp xếp

            // Sắp xếp và phân trang
            var totalProducts = products.Count();
            var totalPages = (int)Math.Ceiling((double)totalProducts / pageSize);
            var productsToDisplay = products
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.TotalPages = totalPages;
            ViewBag.CurrentPage = page;
            ViewBag.Brands = db.HangSanPham.ToList();
            return View(productsToDisplay);
        }


        public ActionResult Error()
        {
            return View();
        }
        public ActionResult ChiTietSanPham(int id)
        {

            var sanPham = db.SanPham.FirstOrDefault(sp => sp.MaSanPham == id && sp.TrangThai == true);

            if (sanPham == null)
            {
                return HttpNotFound();
            }

            
          var sanPhamCungGia = db.SanPham
          .Where(sp => sp.Gia >= sanPham.Gia - 5000000 && sp.Gia <= sanPham.Gia + 5000000 && sp.MaSanPham != sanPham.MaSanPham && sp.TrangThai == true) // Lọc theo giá và loại trừ sản phẩm hiện tại
          .ToList();

            ViewBag.SanPhamCungGia = sanPhamCungGia;
            return View(sanPham);
        }
        public ActionResult ChiTietDonHang(int id)
        {
            // Lấy thông tin đơn hàng từ cơ sở dữ liệu theo id
            var order = db.DonHang.SingleOrDefault(o => o.MaDonHang == id);

            if (order == null)
            {
                return HttpNotFound(); // Nếu không tìm thấy đơn hàng
            }

            // Lấy chi tiết đơn hàng
            var chiTietDonHang = db.ChiTietDonHang.Where(ct => ct.MaDonHang == id).ToList();

            // Lưu thông tin vào ViewBag
            ViewBag.Order = order; // Lưu thông tin đơn hàng
            ViewBag.ChiTietDonHang = chiTietDonHang; // Lưu thông tin chi tiết đơn hàng
            var voucher = db.Voucher.SingleOrDefault(u => u.MaVoucher == order.MaVoucher);
            ViewBag.GiamGia = voucher != null ? voucher.GiamGia : null;

            return View(); // Trả về view
        }
        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        [HttpPost]
        public ActionResult Contact(string con_name, string con_email, string con_subject, string con_message)
        {
            try
            {
                // Tạo email message
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("luutrungnghi269@gmail.com"); // Địa chỉ email của bạn
                mail.To.Add(con_email); // Gửi email tới người dùng
                mail.Bcc.Add("luutrungnghi269@gmail.com"); // Email nhận bản sao
                mail.Subject = con_subject;
                mail.Body = $"Xin chào {con_name},\n\nCảm ơn bạn đã liên hệ với chúng tôi.\nNội dung tin nhắn: {con_message}";
                mail.IsBodyHtml = false;

                // Cấu hình SMTP
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587); // SMTP server, ví dụ Gmail
                smtpClient.Credentials = new NetworkCredential("luutrungnghi269@gmail.com", "vlnd erpg soxe jwsr"); // Đăng nhập email
                smtpClient.EnableSsl = true; // Sử dụng SSL

                // Gửi email
                smtpClient.Send(mail);

                // Thông báo gửi thành công
                ViewBag.Message = "Gửi email thành công!";
            }
            catch (Exception ex)
            {
                // Xử lý lỗi
                ViewBag.Message = "Gửi email thất bại: " + ex.Message;
            }

            return View();
        }
        // Hiển thị trang để người dùng nhập email
        [HttpGet]
        public ActionResult QuenMatKhau()
        {
            return View();
        }
        [HttpPost]
        public ActionResult QuenMatKhau(string userEmail)
        {
            try
            {
                // Kiểm tra xem email có trong hệ thống không
                var user = db.TaiKhoan.FirstOrDefault(u => u.Email == userEmail);
                if (user == null)
                {
                    ViewBag.Message = "Email này không tồn tại trong hệ thống!";
                    return View();
                }

                // Tạo mật khẩu mới ngẫu nhiên gồm 6 chữ số
                Random random = new Random();
                string newPassword = random.Next(100000, 999999).ToString();

                // Cập nhật mật khẩu mới cho người dùng
                user.Password = newPassword; 
                db.SaveChanges(); // Lưu mật khẩu mới vào cơ sở dữ liệu

                // Gửi email chứa mật khẩu mới
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("luutrungnghi269@gmail.com"); // Email của bạn
                mail.To.Add(userEmail); // Gửi email tới người dùng
                mail.Subject = "Mật khẩu mới của bạn";
                mail.Body = $"Xin chào {user.Username},\n\n" +
                            $"Mật khẩu mới của bạn là: {newPassword}\n\n" +
                            "Vui lòng đăng nhập và thay đổi mật khẩu sau khi đăng nhập.";
                mail.IsBodyHtml = false;

                // Cấu hình SMTP
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587); // Sử dụng Gmail
                smtpClient.Credentials = new NetworkCredential("luutrungnghi269@gmail.com", "vlnd erpg soxe jwsr"); // Thông tin đăng nhập Gmail
                smtpClient.EnableSsl = true;

                // Gửi email
                smtpClient.Send(mail);

                ViewBag.Message = "Mật khẩu mới đã được gửi tới email của bạn!";
            }
            catch (Exception ex)
            {
                ViewBag.Message = "Gửi email thất bại: " + ex.Message;
            }

            return View();
        }


    }
}