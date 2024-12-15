using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using TMDTLaptop.Models;
using OfficeOpenXml;
namespace TMDTLaptop.Controllers
{
    public class AdminController : Controller
    {
        LaptopStoreEntities db = new LaptopStoreEntities();
        public bool check()
        {
            if (Session["Admin"] == null) { return false; }
            return true;
        }
        // GET: Admin
        public ActionResult Index()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            // Lấy danh sách đơn hàng trong tháng này
            var firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

            // Tổng số đơn hàng
            var totalOrders = db.DonHang.Count(o => o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth);

            // Đếm số lượng đơn hàng theo trạng thái
            var pendingOrders = db.DonHang.Count(o => o.TrangThai == "Đang chờ xử lý" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth);
            var approvedOrders = db.DonHang.Count(o => o.TrangThai == "Đã duyệt" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth);
            var deliveredOrders = db.DonHang.Count(o => o.TrangThai == "Đã giao" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth);
            var cancelledOrders = db.DonHang.Count(o => o.TrangThai == "Đã hủy" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth);

            // Doanh thu theo trạng thái đơn hàng
            var revenuePending = db.DonHang.Where(o => o.TrangThai == "Đang chờ xử lý" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth)
                                            .Sum(o => o.TongTien) ?? 0;

            var revenueApproved = db.DonHang.Where(o => o.TrangThai == "Đã duyệt" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth)
                                            .Sum(o => o.TongTien) ?? 0;

            var revenueDelivered = db.DonHang.Where(o => o.TrangThai == "Đã giao" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth)
                                            .Sum(o => o.TongTien) ?? 0;

            var revenueCancelled = db.DonHang.Where(o => o.TrangThai == "Đã hủy" && o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth)
                                            .Sum(o => o.TongTien) ?? 0;
            // Định dạng doanh thu thành chuỗi
            string formattedRevenuePending = revenuePending.ToString("N0") + " đ";
            string formattedRevenueApproved = revenueApproved.ToString("N0") + " đ";
            string formattedRevenueDelivered = revenueDelivered.ToString("N0") + " đ";
            string formattedRevenueCancelled = revenueCancelled.ToString("N0") + " đ";
            var totalRevenue = revenuePending + revenueApproved + revenueDelivered + revenueCancelled;

            var bestSellingProducts = db.ChiTietDonHang
                           .Where(c => c.DonHang.NgayDatHang >= firstDayOfMonth && c.DonHang.NgayDatHang <= lastDayOfMonth)
                           .GroupBy(c => c.MaSanPham)
                           .Select(g => new BestSellingProduct
                           {
                               TenSanPham = db.SanPham.FirstOrDefault(p => p.MaSanPham == g.Key).TenSanPham ?? "Không xác định",
                               SoLuong = g.Sum(c => c.SoLuong)
                           })
                           .OrderByDescending(g => g.SoLuong)
                           .Take(5)
                           .ToList();

            // Gán vào ViewBag
            ViewBag.TotalOrders = totalOrders;
            ViewBag.PendingOrders = pendingOrders;
            ViewBag.ApprovedOrders = approvedOrders;
            ViewBag.DeliveredOrders = deliveredOrders;
            ViewBag.CancelledOrders = cancelledOrders;
            ViewBag.RevenuePending = formattedRevenuePending;
            ViewBag.RevenueApproved = formattedRevenueApproved;
            ViewBag.RevenueDelivered = formattedRevenueDelivered;
            ViewBag.RevenueCancelled = formattedRevenueCancelled;
            ViewBag.TotalRevenue = totalRevenue;
            ViewBag.BestSellingProducts = bestSellingProducts;

            return View();
        }
        public ActionResult XuatBaoCaoDoanhThu()
        {
            // Lấy dữ liệu doanh thu của tháng này
            var firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

            // Lấy danh sách đơn hàng trong tháng
            var orders = db.DonHang
                .Where(o => o.NgayDatHang >= firstDayOfMonth && o.NgayDatHang <= lastDayOfMonth)
                .Select(o => new
                {
                    o.MaDonHang,
                    o.NgayDatHang,
                    o.TrangThai,
                    o.TongTien
                })
                .ToList();

            // Tạo DataTable để chứa dữ liệu đơn hàng
            DataTable dt = new DataTable("DonHang");
            dt.Columns.Add("Mã Đơn Hàng", typeof(int));
            dt.Columns.Add("Ngày Đặt Hàng", typeof(string));
            dt.Columns.Add("Trạng Thái", typeof(string));
            dt.Columns.Add("Tổng Tiền", typeof(decimal));

            // Thêm dữ liệu vào DataTable
            foreach (var order in orders)
            {
                dt.Rows.Add(order.MaDonHang, order.NgayDatHang.Value.ToString("dd/MM/yyyy"), order.TrangThai, order.TongTien);
            }

            // Tạo file Excel
            using (ExcelPackage excel = new ExcelPackage())
            {
                var excelWorksheet = excel.Workbook.Worksheets.Add("Báo Cáo Doanh Thu");

                // Đặt tiêu đề cho các cột
                excelWorksheet.Cells[1, 1].Value = "Mã Đơn Hàng";
                excelWorksheet.Cells[1, 2].Value = "Ngày Đặt Hàng";
                excelWorksheet.Cells[1, 3].Value = "Trạng Thái";
                excelWorksheet.Cells[1, 4].Value = "Tổng Tiền";

                // Đổ dữ liệu vào Excel
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        excelWorksheet.Cells[i + 2, j + 1].Value = dt.Rows[i][j];
                    }
                }

                // Định dạng cột tiền tệ
                excelWorksheet.Cells[2, 4, dt.Rows.Count + 1, 4].Style.Numberformat.Format = "#,##0.00 đ";

                // Lưu file Excel vào bộ nhớ
                var stream = new MemoryStream();
                excel.SaveAs(stream);

                // Đặt tên cho file Excel
                var fileName = $"baocaodoanhthu_{DateTime.Now:ddMMyyyy}.xlsx";

                // Trả về file Excel
                return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }


        public ActionResult QuanLyDanhMuc(int page = 1, int pageSize = 5, string searchTerm = null)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var danhMucs = db.DanhMucSanPham.AsQueryable();

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                danhMucs = danhMucs.Where(d => d.TenDanhMuc.Contains(searchTerm));
            }

            var totalItems = danhMucs.Count();
            var items = danhMucs.OrderBy(d => d.MaDanhMuc)
                                 .Skip((page - 1) * pageSize)
                                 .Take(pageSize)
                                 .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.SearchTerm = searchTerm; // Giữ từ khóa tìm kiếm

            return View(items);
        }

        public ActionResult ThemDanhMuc()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            return View();
        }

        [HttpPost]
        public ActionResult ThemDanhMuc(DanhMucSanPham model)
        {
            // Kiểm tra tên danh mục rỗng
            if (string.IsNullOrWhiteSpace(model.TenDanhMuc))
            {
                ModelState.AddModelError("TenDanhMuc", "Tên danh mục không được để trống.");
                return View(model);
            }

            // Kiểm tra tên danh mục trùng
            bool isNameExists = db.DanhMucSanPham
                .Any(d => d.TenDanhMuc.Equals(model.TenDanhMuc, StringComparison.OrdinalIgnoreCase));
            if (isNameExists)
            {
                ModelState.AddModelError("TenDanhMuc", "Tên danh mục này đã tồn tại.");
                return View(model);
            }

            if (ModelState.IsValid)
            {
                model.NgayTao = DateTime.Now; // Gán ngày tạo hiện tại
                model.TrangThai = true; // Mặc định trạng thái là hoạt động
                db.DanhMucSanPham.Add(model); // Thêm vào cơ sở dữ liệu
                db.SaveChanges(); // Lưu thay đổi
                return RedirectToAction("QuanLyDanhMuc");
            }
            return View(model);
        }

        public ActionResult SuaDanhMuc(int id)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var danhMuc = db.DanhMucSanPham.Find(id);
            if (danhMuc == null)
            {
                return HttpNotFound();
            }
            return View(danhMuc);
        }

        [HttpPost]
        public ActionResult SuaDanhMuc(DanhMucSanPham model)
        {
            if (string.IsNullOrWhiteSpace(model.TenDanhMuc))
            {
                ModelState.AddModelError("TenDanhMuc", "Tên danh mục không được để trống.");
                return View(model);
            }

            // Kiểm tra tên danh mục trùng (ngoại trừ danh mục hiện tại)
            bool isDuplicate = db.DanhMucSanPham
                .Any(d => d.TenDanhMuc.Equals(model.TenDanhMuc, StringComparison.OrdinalIgnoreCase)
                          && d.MaDanhMuc != model.MaDanhMuc);
            if (isDuplicate)
            {
                ModelState.AddModelError("TenDanhMuc", "Tên danh mục này đã tồn tại.");
                return View(model);
            }

            if (ModelState.IsValid)
            {
                var danhMuc = db.DanhMucSanPham.Find(model.MaDanhMuc);
                if (danhMuc != null)
                {
                    danhMuc.TenDanhMuc = model.TenDanhMuc;
                    db.SaveChanges(); // Lưu thay đổi
                    return RedirectToAction("QuanLyDanhMuc");
                }
            }
            return View(model);
        }

        public ActionResult CapNhatTrangThai(int id)
        {
            var danhMuc = db.DanhMucSanPham.Find(id);
            if (danhMuc != null)
            {
                danhMuc.TrangThai = !danhMuc.TrangThai; // Đảo ngược trạng thái
                db.SaveChanges();
            }
            return RedirectToAction("QuanLyDanhMuc");
        }
        // Quản lý hãng sản phẩm
        public ActionResult QuanLyHang(int page = 1, int pageSize = 5, string searchTerm = null)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var hangSanPhams = db.HangSanPham.AsQueryable();

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                hangSanPhams = hangSanPhams.Where(h => h.TenHang.Contains(searchTerm));
            }

            var totalItems = hangSanPhams.Count();
            var items = hangSanPhams.OrderBy(h => h.MaHang)
                                     .Skip((page - 1) * pageSize)
                                     .Take(pageSize)
                                     .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.SearchTerm = searchTerm; // Giữ từ khóa tìm kiếm

            return View(items);
        }

        public ActionResult ThemHang()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            return View();
        }

        [HttpPost]
        public ActionResult ThemHang(HangSanPham model)
        {
            // Kiểm tra nếu tên hãng trống
            if (string.IsNullOrWhiteSpace(model.TenHang))
            {
                ModelState.AddModelError("TenHang", "Tên hãng không được để trống.");
            }

            // Kiểm tra nếu tên hãng đã tồn tại
            if (db.HangSanPham.Any(h => h.TenHang == model.TenHang))
            {
                ModelState.AddModelError("TenHang", "Tên hãng đã tồn tại.");
            }

            if (ModelState.IsValid)
            {
                model.NgayTao = DateTime.Now; // Gán ngày tạo hiện tại
                model.TrangThai = true; // Mặc định trạng thái là hoạt động
                db.HangSanPham.Add(model); // Thêm vào cơ sở dữ liệu
                db.SaveChanges(); // Lưu thay đổi
                return RedirectToAction("QuanLyHang");
            }

            // Nếu có lỗi, trả về view kèm model để hiển thị thông báo lỗi
            return View(model);
        }


        public ActionResult SuaHang(int id)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var hang = db.HangSanPham.Find(id);
            if (hang == null)
            {
                return HttpNotFound();
            }
            return View(hang);
        }

        [HttpPost]
        public ActionResult SuaHang(HangSanPham model)
        {
            if (ModelState.IsValid)
            {
                var hang = db.HangSanPham.Find(model.MaHang);
                if (hang != null)
                {
                    // Kiểm tra tên hãng đã tồn tại trong cơ sở dữ liệu (ngoại trừ hãng hiện tại)
                    bool isNameExists = db.HangSanPham
                        .Any(h => h.TenHang.Equals(model.TenHang, StringComparison.OrdinalIgnoreCase) && h.MaHang != model.MaHang);

                    if (isNameExists)
                    {
                        // Thêm lỗi vào ModelState nếu tên trùng
                        ModelState.AddModelError("TenHang", "Tên hãng này đã tồn tại.");
                        return View(model);  // Trả về view với lỗi
                    }

                    // Nếu tên không trùng, tiến hành cập nhật
                    hang.TenHang = model.TenHang;
                    db.SaveChanges(); // Lưu thay đổi
                    return RedirectToAction("QuanLyHang");
                }
            }
            return View(model);
        }


        public ActionResult CapNhatTrangThaiHang(int id)
        {
            var hang = db.HangSanPham.Find(id);
            if (hang != null)
            {
                hang.TrangThai = !hang.TrangThai; // Đảo ngược trạng thái
                db.SaveChanges();
            }
            return RedirectToAction("QuanLyHang");
        }
        // Quản lý khách hàng
        public ActionResult QuanLyKhachHang(int page = 1, int pageSize = 5, string searchTerm = null)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var taiKhoans = db.TaiKhoan.AsQueryable().Where(u => u.MaQuyen == 3);

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                taiKhoans = taiKhoans.Where(t => t.Username.Contains(searchTerm) || t.HoTen.Contains(searchTerm) || t.Email.Contains(searchTerm));
            }

            var totalItems = taiKhoans.Count();
            var items = taiKhoans.OrderBy(t => t.MaTaiKhoan)
                                 .Skip((page - 1) * pageSize)
                                 .Take(pageSize)
                                 .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.SearchTerm = searchTerm; // Giữ từ khóa tìm kiếm

            return View(items);
        }

        public ActionResult CapNhatTrangThaiKH(int id)
        {
            var khachHang = db.TaiKhoan.Find(id);
            if (khachHang != null)
            {
                khachHang.TrangThai = !khachHang.TrangThai; // Đảo ngược trạng thái
                db.SaveChanges();
            }
            return RedirectToAction("QuanLyKhachHang");
        }
        // GET: Quản lý banner
        public ActionResult QuanLyBanner()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            return View(db.Banner.ToList());
        }

        // GET: Thêm banner
        public ActionResult ThemBanner()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            return View();
        }

        [HttpPost]
        public ActionResult ThemBanner(Banner model, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                if (HinhAnh != null && HinhAnh.ContentLength > 0)
                {
                    // Lưu hình ảnh
                    var fileName = Path.GetFileName(HinhAnh.FileName);
                    var path = Path.Combine(Server.MapPath("~/assets/images/banner/"), fileName);
                    HinhAnh.SaveAs(path);
                    model.HinhAnh =  fileName; // Đường dẫn hình ảnh
                }
                model.LienKet = "";
                db.Banner.Add(model); // Thêm vào cơ sở dữ liệu
                db.SaveChanges(); // Lưu thay đổi
                return RedirectToAction("QuanLyBanner");
            }
            return View(model);
        }

      

        // GET: Sửa banner
        public ActionResult SuaBanner(int id)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var banner = db.Banner.Find(id);
            if (banner == null)
            {
                return HttpNotFound();
            }
            return View(banner);
        }

        [HttpPost]
        public ActionResult SuaBanner(Banner model, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                var banner = db.Banner.Find(model.MaBanner);
                if (banner != null)
                {
                    if (HinhAnh != null && HinhAnh.ContentLength > 0)
                    {
                        // Lưu hình ảnh
                        var fileName = Path.GetFileName(HinhAnh.FileName);
                        var path = Path.Combine(Server.MapPath("~/assets/images/banner/"), fileName);
                        HinhAnh.SaveAs(path);
                        banner.HinhAnh =  fileName; // Cập nhật đường dẫn hình ảnh
                    }

                    
                    banner.MoTa = model.MoTa;
                    db.SaveChanges(); // Lưu thay đổi
                    return RedirectToAction("QuanLyBanner");
                }
            }
            return View(model);
        }



        public ActionResult XoaBanner(int id)
        {
            var banner = db.Banner.Find(id);
            if (banner != null)
            {
               db.Banner.Remove(banner);
               db.SaveChanges();
            }
            return RedirectToAction("QuanLyBanner");
        }
        // GET: QuanLySanPham
        public ActionResult QuanLySanPham(int page = 1, int pageSize = 5, string searchTerm = null)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var sanPhams = db.SanPham.AsQueryable();

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                sanPhams = sanPhams.Where(s => s.TenSanPham.Contains(searchTerm));
            }

            sanPhams = sanPhams.OrderBy(s => s.MaSanPham);
            var totalItems = sanPhams.Count();
            var items = sanPhams.Skip((page - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.SearchTerm = searchTerm; // Gửi từ khóa tìm kiếm về view

            return View(items);
        }


        // GET: ThemSanPham
        public ActionResult ThemSanPham()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            ViewBag.DanhMuc = db.DanhMucSanPham.ToList(); // Lấy danh mục từ cơ sở dữ liệu
            ViewBag.Hang = db.HangSanPham.ToList(); // Lấy hãng từ cơ sở dữ liệu
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ThemSanPham(SanPham model, HttpPostedFileBase HinhDaiDien, IEnumerable<HttpPostedFileBase> HinhKemTheo)
        {
            if (ModelState.IsValid)
            {
                // Gán ngày tạo hiện tại
                model.NgayTao = DateTime.Now;
                model.TrangThai = true; // Mặc định trạng thái là hoạt động

                // Lưu tên hình đại diện vào mô hình trước
                if (HinhDaiDien != null && HinhDaiDien.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(HinhDaiDien.FileName);
                    model.HinhAnh = fileName; // Lưu tên hình ảnh đại diện vào mô hình
                }

                // Thêm sản phẩm vào cơ sở dữ liệu
                db.SanPham.Add(model);
                db.SaveChanges(); // Lưu sản phẩm vào cơ sở dữ liệu trước khi lưu hình ảnh

                // Tạo đường dẫn để lưu hình ảnh
                var path = Path.Combine(Server.MapPath("~/assets/images/product/" + model.MaSanPham + "/"));

                // Tạo thư mục nếu chưa tồn tại
                Directory.CreateDirectory(path);

                // Lưu hình đại diện
                if (HinhDaiDien != null && HinhDaiDien.ContentLength > 0)
                {
                    HinhDaiDien.SaveAs(Path.Combine(path, model.HinhAnh)); // Lưu tệp vào thư mục
                }

                // Xử lý lưu hình ảnh kèm theo
                if (HinhKemTheo != null)
                {
                    foreach (var hinh in HinhKemTheo)
                    {
                        if (hinh != null && hinh.ContentLength > 0)
                        {
                            var fileName = Path.GetFileName(hinh.FileName);
                            var pathKemTheo = Path.Combine(path, fileName); // Đường dẫn cho hình kèm theo

                            // Lưu hình kèm theo
                            hinh.SaveAs(pathKemTheo);
                            // Lưu tên hình kèm theo vào bảng hình ảnh kèm theo nếu cần
                        }
                    }
                }

                // Cập nhật lại sản phẩm nếu cần
                db.Entry(model).State = EntityState.Modified;
                db.SaveChanges(); // Lưu tất cả thay đổi
                return RedirectToAction("QuanLySanPham");
            }
            ViewBag.DanhMuc = db.DanhMucSanPham.ToList(); // Lấy danh mục từ cơ sở dữ liệu
            ViewBag.Hang = db.HangSanPham.ToList(); // Lấy hãng từ cơ sở dữ liệu
            return View(model);
        }

        // GET: SuaSanPham
        [HttpGet]
        public ActionResult SuaSanPham(int id)
        {
            if (!check())
            {
                return RedirectToAction("Loi404", "ChamSocKH");
            }

            var sanPham = db.SanPham.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }

            // Gán danh sách danh mục và hãng sản phẩm vào ViewBag
            ViewBag.DanhMuc = db.DanhMucSanPham.Select(d => new { d.MaDanhMuc, d.TenDanhMuc }).ToList();
            ViewBag.Hang = db.HangSanPham.Select(h => new { h.MaHang, h.TenHang }).ToList();

            // Lấy tất cả hình kèm theo từ thư mục
            var folderPath = Path.Combine(Server.MapPath("~/assets/images/product/" + sanPham.MaSanPham + "/"));
            if (Directory.Exists(folderPath))
            {
                ViewBag.HinhKemTheo = Directory.GetFiles(folderPath)
                    .Select(Path.GetFileName)
                    .Where(file => file != sanPham.HinhAnh) // Loại bỏ hình đại diện
                    .ToList();
            }

            return View(sanPham);
        }



        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SuaSanPham(SanPham model, HttpPostedFileBase HinhDaiDien, IEnumerable<HttpPostedFileBase> HinhKemTheo)
        {
            if (ModelState.IsValid)
            {
                // Tìm sản phẩm trong cơ sở dữ liệu
                var sanPham = db.SanPham.Find(model.MaSanPham);
                if (sanPham == null)
                {
                    return HttpNotFound();
                }

                // Cập nhật thông tin sản phẩm
                sanPham.TenSanPham = model.TenSanPham;
                sanPham.MoTa = model.MoTa;
                sanPham.Gia = model.Gia;
                sanPham.MaDanhMuc = model.MaDanhMuc;
                sanPham.MaHang = model.MaHang; // Cập nhật hãng sản phẩm nếu có
                sanPham.NgayTao = DateTime.Now;

                // Đường dẫn thư mục chứa hình ảnh sản phẩm
                var folderPath = Server.MapPath("~/assets/images/product/" + sanPham.MaSanPham + "/");

                // Xử lý hình đại diện
                if (HinhDaiDien != null && HinhDaiDien.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(HinhDaiDien.FileName);
                    sanPham.HinhAnh = fileName; // Lưu tên hình ảnh đại diện vào mô hình

                    // Tạo thư mục nếu chưa tồn tại
                    Directory.CreateDirectory(folderPath);

                    // Lưu hình đại diện
                    HinhDaiDien.SaveAs(Path.Combine(folderPath, sanPham.HinhAnh));
                }

                // Xử lý hình kèm theo
                if (HinhKemTheo != null)
                {
                    // Xóa tất cả các hình kèm theo ngoại trừ hình đại diện
                    var existingFiles = Directory.GetFiles(folderPath);
                    foreach (var file in existingFiles)
                    {
                        var fileName = Path.GetFileName(file);
                        if (fileName != sanPham.HinhAnh) // Tránh xóa hình đại diện
                        {
                            System.IO.File.Delete(file);
                        }
                    }

                    foreach (var hinh in HinhKemTheo)
                    {
                        if (hinh != null && hinh.ContentLength > 0)
                        {
                            var fileName = Path.GetFileName(hinh.FileName);
                            var path = Path.Combine(folderPath, fileName);

                            // Lưu hình kèm theo
                            hinh.SaveAs(path);
                        }
                    }
                }

                db.Entry(sanPham).State = EntityState.Modified;
                db.SaveChanges(); // Lưu tất cả thay đổi

                return RedirectToAction("QuanLySanPham");
            }

            // Nếu có lỗi validate, load lại danh sách ViewBag
            ViewBag.DanhMuc = db.DanhMucSanPham.Select(d => new { d.MaDanhMuc, d.TenDanhMuc }).ToList();
            ViewBag.Hang = db.HangSanPham.Select(h => new { h.MaHang, h.TenHang }).ToList();

            return View(model); // Trả về View với dữ liệu cũ
        }

        [HttpPost]
        public ActionResult GiamGia(int maSanPham, decimal giaMoi)
        {

            var sanPham = db.SanPham.Find(maSanPham);
            if (sanPham != null)
            {
                sanPham.GiaMoi = giaMoi; // Cập nhật giá mới
                db.SaveChanges();
                return Json(new { success = true });
            }

            return Json(new { success = false });
        }
        [HttpPost]
        public ActionResult NgungGiamGia(int id)
        {
            var sanPham = db.SanPham.Find(id);
            if (sanPham != null)
            {
                sanPham.GiaMoi = null; // Đặt giá mới thành null
      
                db.SaveChanges();
            }
            return RedirectToAction("QuanLySanPham"); // Quay lại trang danh sách sản phẩm
        }


        // Cập nhật trạng thái sản phẩm
        public ActionResult CapNhatTrangThaiSP(int id)
        {
            var sanPham = db.SanPham.Find(id);
            if (sanPham != null)
            {
                sanPham.TrangThai = !sanPham.TrangThai; // Đảo ngược trạng thái
                db.SaveChanges();
            }
            return RedirectToAction("QuanLySanPham");
        }
        // GET: Voucher
        public ActionResult QuanLyVoucher(int page = 1, int pageSize = 5, string searchTerm = null)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var vouchers = db.Voucher.AsQueryable();

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                vouchers = vouchers.Where(v => v.Code.Contains(searchTerm));
            }

            var totalItems = vouchers.Count();
            var items = vouchers.OrderBy(v => v.MaVoucher)
                                .Skip((page - 1) * pageSize)
                                .Take(pageSize)
                                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.SearchTerm = searchTerm; // Giữ từ khóa tìm kiếm

            return View(items);
        }


        // GET: Voucher/Them
        public ActionResult ThemVoucher()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            return View();
        }

        // POST: Voucher/Them
        // POST: Voucher/Them
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ThemVoucher(Voucher voucher)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra ngày bắt đầu không được nhỏ hơn ngày hiện tại
                if (voucher.NgayBatDau < DateTime.Now.Date)
                {
                    ModelState.AddModelError("NgayBatDau", "Ngày bắt đầu không được nhỏ hơn ngày hiện tại.");
                    return View(voucher);
                }

                // Kiểm tra ngày kết thúc phải sau ngày bắt đầu
                if (voucher.NgayBatDau > voucher.NgayKetThuc)
                {
                    ModelState.AddModelError("NgayKetThuc", "Ngày kết thúc phải sau ngày bắt đầu.");
                    return View(voucher);
                }

                // Kiểm tra tỷ lệ giảm giá không vượt quá 100
                if (voucher.GiamGia > 100)
                {
                    ModelState.AddModelError("GiamGia", "Tỷ lệ giảm giá không được vượt quá 100%.");
                    return View(voucher);
                }

                voucher.TrangThai = true;
                voucher.SoLuongSuDung = 0;
                db.Voucher.Add(voucher);
                db.SaveChanges();
                return RedirectToAction("QuanLyVoucher");
            }
            return View(voucher);
        }


        // GET: Voucher/Sua/5
        public ActionResult SuaVoucher(int id)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var voucher = db.Voucher.Find(id);
            if (voucher == null)
            {
                return HttpNotFound();
            }
            voucher.NgayBatDau = voucher.NgayBatDau.Value.Date; // chỉ lấy phần ngày
            voucher.NgayKetThuc = voucher.NgayKetThuc.Value.Date; // chỉ lấy phần ngày
            return View(voucher);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SuaVoucher(Voucher voucher)
        {
            var existingVoucher = db.Voucher.Find(voucher.MaVoucher);
            if (existingVoucher == null)
            {
                return HttpNotFound();
            }

            if (voucher.NgayBatDau != existingVoucher.NgayBatDau && voucher.NgayBatDau < DateTime.Now.Date)
            {
                ModelState.AddModelError("NgayBatDau", "Ngày bắt đầu mới không được nhỏ hơn ngày hiện tại.");
                return View(voucher);
            }

            if (voucher.NgayBatDau > voucher.NgayKetThuc)
            {
                ModelState.AddModelError("NgayKetThuc", "Ngày kết thúc phải sau ngày bắt đầu.");
                return View(voucher);
            }

            // Kiểm tra tỷ lệ giảm giá không vượt quá 100
            if (voucher.GiamGia > 100)
            {
                ModelState.AddModelError("GiamGia", "Tỷ lệ giảm giá không được vượt quá 100%.");
                return View(voucher);
            }

            if (ModelState.IsValid)
            {
                existingVoucher.Code = voucher.Code;
                existingVoucher.GiamGia = voucher.GiamGia;
                existingVoucher.NgayBatDau = voucher.NgayBatDau;
                existingVoucher.NgayKetThuc = voucher.NgayKetThuc;
                existingVoucher.SoLuongSuDungToiDa = voucher.SoLuongSuDungToiDa;
                existingVoucher.MoTa = voucher.MoTa;

                try
                {
                    db.SaveChanges();
                    return RedirectToAction("QuanLyVoucher");
                }
                catch (DbUpdateConcurrencyException)
                {
                    ModelState.AddModelError("", "Có lỗi xảy ra trong quá trình cập nhật. Vui lòng thử lại.");
                }
            }
            return View(voucher);
        }


        // POST: Voucher/ChuyenDoiTrangThai/5
        [HttpPost]
        public ActionResult ChuyenDoiTrangThai(int id)
        {
            var voucher = db.Voucher.Find(id);
            if (voucher != null)
            {
                voucher.TrangThai = !voucher.TrangThai; // Chuyển đổi trạng thái
                db.SaveChanges();
            }
            return RedirectToAction("QuanLyVoucher");
        }
        public ActionResult QuanLyTonKho(string searchString, int page = 1, int pageSize = 10)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var products = db.SanPham.AsQueryable();

            // Nếu có thanh tìm kiếm, lọc sản phẩm theo tên
            if (!string.IsNullOrEmpty(searchString))
            {
                products = products.Where(p => p.TenSanPham.Contains(searchString));
            }

            // Lấy tổng số sản phẩm
            int totalProducts = products.Count();

            // Lấy danh sách sản phẩm với phân trang
            var pagedProducts = products.OrderBy(p => p.TenSanPham)
                                        .Skip((page - 1) * pageSize)
                                        .Take(pageSize)
                                        .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalProducts / pageSize);
            ViewBag.SearchString = searchString;

            return View(pagedProducts);
        }
        public ActionResult QuanLyPhieuNhapKho(int? searchString, int page = 1, int pageSize = 10)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var phieuNhap = db.PhieuNhapKho.AsQueryable();

            // Nếu có thanh tìm kiếm, lọc phiếu nhập kho theo nhà cung cấp
            if (searchString != 0 && searchString!=null)
            {
                phieuNhap = phieuNhap.Where(p => p.MaPhieuNhap == searchString);
            }

            // Lấy tổng số phiếu nhập
            int totalPhieuNhap = phieuNhap.Count();

            // Lấy danh sách phiếu nhập với phân trang
            var pagedPhieuNhap = phieuNhap.OrderBy(p => p.NgayNhap)
                                           .Skip((page - 1) * pageSize)
                                           .Take(pageSize)
                                           .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalPhieuNhap / pageSize);
            ViewBag.SearchString = searchString;

            return View(pagedPhieuNhap);
        }
        public ActionResult ChiTietPhieuNhapKho(int id)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var phieuNhap = db.PhieuNhapKho.Include(p => p.ChiTietPhieuNhapKho)
                                              .FirstOrDefault(p => p.MaPhieuNhap == id);
            if (phieuNhap == null)
            {
                return HttpNotFound();
            }

            return View(phieuNhap);
        }
        public ActionResult ThemPhieuNhapKho()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            ViewBag.SanPhams = db.SanPham.ToList();
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ThemPhieuNhapKho(PhieuNhapKho phieuNhapKho, List<ChiTietPhieuNhapKho> ChiTietPhieuNhaps)
        {        

            // Gán ngày nhập và thêm phiếu nhập kho vào cơ sở dữ liệu
            phieuNhapKho.NgayNhap = DateTime.Now;
            db.PhieuNhapKho.Add(phieuNhapKho);
            db.SaveChanges(); // Lưu phiếu nhập trước khi thêm chi tiết

            decimal tongtien = 0;

            // Thêm hoặc cập nhật chi tiết phiếu nhập kho
            foreach (var chiTiet in ChiTietPhieuNhaps)
            {
                // Kiểm tra xem sản phẩm này đã tồn tại trong cơ sở dữ liệu với cùng mã phiếu nhập không
                var chiTietTonTai = db.ChiTietPhieuNhapKho
                    .FirstOrDefault(c => c.MaPhieuNhap == phieuNhapKho.MaPhieuNhap && c.MaSanPham == chiTiet.MaSanPham);
              
                if (chiTietTonTai != null)
                {
                    if (chiTietTonTai.GiaNhap != chiTiet.GiaNhap)
                    {
                        ViewBag.ErrorMessage = "Giá nhập của sản phẩm trùng bạn đã nhập không trùng khớp.";
                        ViewBag.SanPhams = db.SanPham.ToList();
                        return View(phieuNhapKho);
                    }
                    tongtien -= chiTietTonTai.TongTien.Value;
                    // Nếu đã tồn tại, cập nhật số lượng
                    chiTietTonTai.SoLuong += chiTiet.SoLuong;
                    // Cập nhật tồn kho trong bảng SanPham
                    var sanPham = db.SanPham.FirstOrDefault(sp => sp.MaSanPham == chiTiet.MaSanPham);
                    if (sanPham != null)
                    {
                        sanPham.SoLuong += chiTiet.SoLuong;
                    }

                    db.SaveChanges();
                    // Cộng tổng tiền cho mỗi sản phẩm
                    tongtien += chiTietTonTai.TongTien.Value;
                }
                else
                {
                    // Nếu chưa tồn tại, thêm mới vào cơ sở dữ liệu
                    chiTiet.MaPhieuNhap = phieuNhapKho.MaPhieuNhap;
                    db.ChiTietPhieuNhapKho.Add(chiTiet);
                    // Cập nhật tồn kho trong bảng SanPham
                    var sanPham = db.SanPham.FirstOrDefault(sp => sp.MaSanPham == chiTiet.MaSanPham);
                    if (sanPham != null)
                    {
                        sanPham.SoLuong += chiTiet.SoLuong;
                    }
                    db.SaveChanges();
                    // Cộng tổng tiền cho mỗi sản phẩm
                    tongtien += chiTiet.TongTien.Value;
                }

               
            }

            // Cập nhật tổng tiền của phiếu nhập kho
            phieuNhapKho.TongTien = tongtien;
            db.SaveChanges(); // Lưu các thay đổi

            return RedirectToAction("QuanLyPhieuNhapKho");
        }


        // Action để xuất sản phẩm hết hàng
        public ActionResult InExcelHangTonKho()
        {
            var outOfStockProducts = db.SanPham.Where(p => p.SoLuong == 0 && p.TrangThai == true).ToList();

            // Tạo một file Excel
            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("Sản phẩm hết hàng");
                worksheet.Cells[1, 1].Value = "Tên Sản Phẩm";
                worksheet.Cells[1, 2].Value = "Số Lượng";

                // Thêm dữ liệu vào file Excel
                for (int i = 0; i < outOfStockProducts.Count; i++)
                {
                    worksheet.Cells[i + 2, 1].Value = outOfStockProducts[i].TenSanPham;
                    worksheet.Cells[i + 2, 2].Value = outOfStockProducts[i].SoLuong;
                }

                // Định dạng file
                var stream = new MemoryStream();
                package.SaveAs(stream);
                stream.Position = 0;

                // Trả về file Excel
                string fileName = $"SanPhamHetHang_{DateTime.Now:ddMMyyyy}.xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }
        public ActionResult QuanLyDonHang(int page = 1, int pageSize = 5, string searchTerm = null)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            // Lấy danh sách đơn hàng
            var donHangs = db.DonHang.AsQueryable();
            int? quyen = Convert.ToInt32(Session["quyen"]);
            if (quyen != null && quyen == 2)
            {
                donHangs = donHangs.Where(u=>u.TrangThai == "Đã Duyệt" || u.TrangThai == "Đã Giao");
            }
            // Kiểm tra nếu có từ khóa tìm kiếm (theo mã đơn hàng hoặc trạng thái)
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                donHangs = donHangs.Where(d => d.MaDonHang.ToString().Contains(searchTerm));
            }

            // Tính tổng số đơn hàng sau khi lọc
            var totalItems = donHangs.Count();

            // Lấy dữ liệu phân trang
            var items = donHangs.OrderBy(d => d.MaDonHang)
                                .Skip((page - 1) * pageSize)
                                .Take(pageSize)
                                .ToList();

            // Đặt các giá trị vào ViewBag để truyền ra View
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.SearchTerm = searchTerm; // Giữ từ khóa tìm kiếm

            return View(items);
        }
        public ActionResult DuyetDonHang(int id)
        {

            var donHang = db.DonHang.Find(id);
            if (donHang == null)
            {
                return HttpNotFound();
            }

            // Cập nhật trạng thái đơn hàng
            donHang.TrangThai = "Đã Duyệt";
            db.SaveChanges();

            return RedirectToAction("QuanLyDonHang");
        }

        public ActionResult HuyDonHang(int id)
        {
            // Tìm đơn hàng
            var donHang = db.DonHang.Find(id);
            if (donHang == null)
            {
                return HttpNotFound();
            }

            // Tìm danh sách chi tiết đơn hàng liên quan đến đơn hàng
            var chiTietDonHang = db.ChiTietDonHang.Where(ct => ct.MaDonHang == id).ToList();

            // Hoàn lại số lượng sản phẩm cho từng chi tiết đơn hàng
            foreach (var chiTiet in chiTietDonHang)
            {
                // Tìm sản phẩm tương ứng
                var sanPham = db.SanPham.Find(chiTiet.MaSanPham);
                if (sanPham != null)
                {
                    // Cộng lại số lượng sản phẩm
                    sanPham.SoLuong += chiTiet.SoLuong;
                }
            }

            // Cập nhật trạng thái đơn hàng
            donHang.TrangThai = "Đã Hủy";

            // Lưu các thay đổi vào database
            db.SaveChanges();

            return RedirectToAction("QuanLyDonHang");
        }

        public ActionResult ChiTietDonHang(int id)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var donHang = db.DonHang
                            .Include("ChiTietDonHang.SanPham") // Include để lấy chi tiết đơn hàng và sản phẩm
                            .FirstOrDefault(d => d.MaDonHang == id);

            if (donHang == null)
            {
                return HttpNotFound();
            }

            return View(donHang);
        }
        // Xem danh sách nhân viên
        public ActionResult QuanLyNhanVien(int page = 1, int pageSize = 5, string searchTerm = null)
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            var nhanViens = db.TaiKhoan.AsQueryable().Where(u => u.MaQuyen != 1 && u.MaQuyen == 2 || u.MaQuyen == 4);

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                nhanViens = nhanViens.Where(nv => nv.HoTen.Contains(searchTerm) || nv.Username.Contains(searchTerm));
            }

            var totalItems = nhanViens.Count();
            var items = nhanViens.OrderBy(nv => nv.MaTaiKhoan)
                                 .Skip((page - 1) * pageSize)
                                 .Take(pageSize)
                                 .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.SearchTerm = searchTerm; // Giữ từ khóa tìm kiếm

            return View(items);
        }

        // Thêm nhân viên
        public ActionResult ThemNhanVien()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ThemNhanVien(TaiKhoan taiKhoan)
        {
            // Kiểm tra các trường bắt buộc có giá trị không
            if (string.IsNullOrEmpty(taiKhoan.Username) ||
                string.IsNullOrEmpty(taiKhoan.Password) ||
                string.IsNullOrEmpty(taiKhoan.Email) ||
                string.IsNullOrEmpty(taiKhoan.SoDienThoai) ||
                taiKhoan.MaQuyen == null)
            {
                ViewBag.ErrorMessage = "Vui lòng điền đầy đủ thông tin.";
                return View(taiKhoan);
            }
            // Kiểm tra xem có nhân viên chăm sóc khách hàng đã tồn tại chưa
            var existingCustomerServiceAccount = db.TaiKhoan.FirstOrDefault(nv => nv.MaQuyen == 4 && nv.TrangThai == true);
            if (taiKhoan.MaQuyen == 4 && existingCustomerServiceAccount != null)
            {
                ViewBag.ErrorMessage = "Chỉ được phép có một tài khoản chăm sóc khách hàng.";
                return View(taiKhoan);
            }

            // Kiểm tra username đã tồn tại chưa
            if (db.TaiKhoan.Any(nv => nv.Username == taiKhoan.Username))
            {
                ViewBag.ErrorMessage = "Username đã tồn tại. Vui lòng chọn username khác.";
                return View(taiKhoan);
            }

            // Kiểm tra email đã tồn tại chưa
            if (db.TaiKhoan.Any(nv => nv.Email == taiKhoan.Email))
            {
                ViewBag.ErrorMessage = "Email đã tồn tại. Vui lòng nhập email khác.";
                return View(taiKhoan);
            }

            // Kiểm tra số điện thoại đã tồn tại chưa
            if (db.TaiKhoan.Any(nv => nv.SoDienThoai == taiKhoan.SoDienThoai))
            {
                ViewBag.ErrorMessage = "Số điện thoại đã tồn tại. Vui lòng nhập số điện thoại khác.";
                return View(taiKhoan);
            }

            // Gán quyền cho nhân viên
            if (taiKhoan.MaQuyen == 2)
            {
                taiKhoan.MaQuyen = 2; // Nhân viên thường
            }
            else if (taiKhoan.MaQuyen == 4)
            {
                taiKhoan.MaQuyen = 4; // Nhân viên chăm sóc khách hàng
            }
            taiKhoan.NgayTao = DateTime.Now;
            taiKhoan.TrangThai = true;
            // Thêm nhân viên vào cơ sở dữ liệu
            db.TaiKhoan.Add(taiKhoan);
            db.SaveChanges();

            return RedirectToAction("QuanLyNhanVien");
        }

        // Khóa tài khoản nhân viên
        public ActionResult KhoaTaiKhoan(int id)
        {
            var taiKhoan = db.TaiKhoan.Find(id);
            if (taiKhoan == null)
            {
                return HttpNotFound();
            }

            taiKhoan.TrangThai = false; // Đánh dấu tài khoản là đã khóa
            db.SaveChanges();

            return RedirectToAction("QuanLyNhanVien");
        }
        public ActionResult MoKhoaTaiKhoan(int id)
        {
            // Tìm tài khoản theo ID
            var taiKhoan = db.TaiKhoan.Find(id);
            if (taiKhoan == null)
            {
                return HttpNotFound();
            }

            // Kiểm tra quyền của tài khoản
            if (taiKhoan.MaQuyen == 4) // Nếu là nhân viên chăm sóc khách hàng
            {
                // Kiểm tra xem đã có tài khoản chăm sóc khách hàng nào tồn tại chưa
                var existingCustomerServiceAccount = db.TaiKhoan.FirstOrDefault(nv => nv.MaQuyen == 4 && nv.TrangThai == true);
                if (existingCustomerServiceAccount != null)
                {
                    TempData["SuccessMessage"] = "Đã có một tài khoản chăm sóc khách hàng tồn tại. Không thể mở thêm.";
                    return RedirectToAction("QuanLyNhanVien"); // Chuyển hướng về trang quản lý nhân viên
                }
            }

            // Mở khóa tài khoản
            taiKhoan.TrangThai = true; // Mở khóa
            db.SaveChanges();

            return RedirectToAction("QuanLyNhanVien");
        }
        public ActionResult ThongTinCaNhan()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            string TaiKhoan = (string)Session["Admin"]; // Giả sử bạn lưu MaTaiKhoan trong session
            var taiKhoan = db.TaiKhoan.SingleOrDefault(u=>u.Username == TaiKhoan);
            return View(taiKhoan);
        }

        // POST: Đổi thông tin cá nhân
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ThongTinCaNhan(TaiKhoan taiKhoan)
        {
            string TaiKhoan = (string)Session["Admin"]; // Giả sử bạn lưu MaTaiKhoan trong session
          

            if (ModelState.IsValid)
            {
                var existingAccount = db.TaiKhoan.SingleOrDefault(u => u.Username == TaiKhoan);
                if (existingAccount != null)
                {
                    existingAccount.HoTen = taiKhoan.HoTen;
                    existingAccount.DiaChi = taiKhoan.DiaChi;
                    existingAccount.SoDienThoai = taiKhoan.SoDienThoai;
                    existingAccount.Email = taiKhoan.Email;

                    db.SaveChanges();
                    ViewBag.Message = "Thông tin cá nhân đã được cập nhật!";
                }
            }
         
            return View(taiKhoan);
        }

        // GET: Đổi mật khẩu
        public ActionResult DoiMatKhau()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            return View();
        }

        // POST: Đổi mật khẩu
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DoiMatKhau(string matKhauCu, string matKhauMoi, string xacNhanMatKhau)
        {
            string TaiKhoan = (string)Session["Admin"]; // Giả sử bạn lưu MaTaiKhoan trong session
            var taiKhoan = db.TaiKhoan.SingleOrDefault(u => u.Username == TaiKhoan);

            if (taiKhoan.Password != matKhauCu)
            {
                ViewBag.Message =  "Mật khẩu cũ không chính xác.";
                return View();
            }

            if (matKhauMoi != xacNhanMatKhau)
            {
                ViewBag.Message =  "Mật khẩu mới và xác nhận không khớp.";
                return View();
            }

            taiKhoan.Password = matKhauMoi;
            db.SaveChanges();
            ViewBag.Message = "Mật khẩu đã được cập nhật!";
            return View();
        }


    }
}