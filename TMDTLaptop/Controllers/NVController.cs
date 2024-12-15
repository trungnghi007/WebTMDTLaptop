using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TMDTLaptop.Models;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using iText.IO.Font;
using iText.IO.Font.Constants;
using iText.Kernel.Font;
using iText.Layout.Properties;
namespace TMDTLaptop.Controllers
{
    public class NVController : Controller
    {
        LaptopStoreEntities db = new LaptopStoreEntities();
        public bool check()
        {
            if (Session["Admin"] == null) { return false; }
            return true;
        }
        // GET: NV
        public ActionResult Index()
        {
            if (!check()) { return RedirectToAction("Loi404", "ChamSocKH"); }
            // Ngày hiện tại
            var currentDate = DateTime.Now.Date;

            // Lấy danh sách mã voucher hợp lệ
            var validVouchers = db.Voucher.ToList(); // Giả sử bạn có bảng Vouchers trong DB

            // Doanh thu theo sản phẩm
            var revenueByProduct = db.ChiTietDonHang
                .Where(c => DbFunctions.TruncateTime(c.DonHang.NgayDatHang) == currentDate)
                .GroupBy(c => c.MaSanPham)
                .Select(g => new RevenueByProductViewModel // Sử dụng lớp dữ liệu mới
                {
                    TenSanPham = db.SanPham.FirstOrDefault(p => p.MaSanPham == g.Key).TenSanPham ?? "Không xác định",
                    DoanhThu = g.Sum(c => c.Gia) ?? 0
                })
                .ToList();


            // Doanh thu theo danh mục
            var revenueByCategory = db.ChiTietDonHang
                .Where(c => DbFunctions.TruncateTime(c.DonHang.NgayDatHang) == currentDate)
                .GroupBy(c => db.SanPham.FirstOrDefault(p => p.MaSanPham == c.MaSanPham).MaDanhMuc)
                .Select(g => new RevenueByCategoryViewModel
                {
                    TenDanhMuc = db.DanhMucSanPham.FirstOrDefault(d => d.MaDanhMuc == g.Key).TenDanhMuc ?? "Không xác định",
                    DoanhThu = g.Sum(c => c.Gia) ?? 0
                })
                .ToList();

            // Gán vào ViewBag
            ViewBag.RevenueByProduct = revenueByProduct;
            ViewBag.RevenueByCategory = revenueByCategory;

            return View();
        }
        // Thêm action xuất file Excel
        public ActionResult ExportToExcelBaoCao()
        {
            // Ngày hiện tại
            var currentDate = DateTime.Now.Date;
            // Tạo một file Excel mới
            using (var package = new ExcelPackage())
            {
                // Tạo worksheet
                var worksheet = package.Workbook.Worksheets.Add("Doanh thu theo sản phẩm");

                // Đặt tiêu đề cột
                worksheet.Cells[1, 1].Value = "Tên sản phẩm";
                worksheet.Cells[1, 2].Value = "Doanh thu";

                // Lấy dữ liệu doanh thu theo sản phẩm
                var revenueByProduct = db.ChiTietDonHang
                    .Where(c => DbFunctions.TruncateTime(c.DonHang.NgayDatHang) == currentDate)
                    .GroupBy(c => c.MaSanPham)
                    .Select(g => new RevenueByProductViewModel // Sử dụng lớp dữ liệu mới
                    {
                        TenSanPham = db.SanPham.FirstOrDefault(p => p.MaSanPham == g.Key).TenSanPham ?? "Không xác định",
                        DoanhThu = g.Sum(c => c.Gia) ?? 0
                    })
                    .ToList();

                // Điền dữ liệu vào worksheet
                int row = 2;
                foreach (var product in revenueByProduct)
                {
                    worksheet.Cells[row, 1].Value = product.TenSanPham;
                    worksheet.Cells[row, 2].Value = product.DoanhThu;
                    row++;
                }

                // Định dạng cột doanh thu
                worksheet.Column(2).Style.Numberformat.Format = "#,##0.00";

                // Trả về file Excel
                var stream = new MemoryStream();
                package.SaveAs(stream);
                stream.Position = 0;

                var fileName = "Doanh_Thu_Theo_San_Pham_" + DateTime.Now.ToString("ddMMyyyy") + ".xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }
        public ActionResult DuyetDonHang(int id)
        {
            var donHang = db.DonHang.Find(id);
            if (donHang == null)
            {
                return HttpNotFound();
            }

            // Cập nhật trạng thái đơn hàng
            donHang.TrangThai = "Đã Giao";
            db.SaveChanges();

            return RedirectToAction("QuanLyDonHang", "Admin");
        }
        public ActionResult ExportToExcel(int id)
        {
            var donHang = db.DonHang.Find(id); // Hàm lấy thông tin đơn hàng theo ID
            var chiTietDonHang = db.ChiTietDonHang.Where(u => u.MaDonHang == id); // Lấy chi tiết đơn hàng theo ID

            if (donHang == null || chiTietDonHang == null)
            {
                return HttpNotFound();
            }

            using (ExcelPackage excel = new ExcelPackage())
            {
                var workSheet = excel.Workbook.Worksheets.Add("Hóa Đơn");
                workSheet.Cells[1, 1].Value = "Mã Đơn Hàng";
                workSheet.Cells[1, 2].Value = "Ngày Đặt";
                workSheet.Cells[1, 3].Value = "Tổng Tiền";
                workSheet.Cells[1, 4].Value = "Trạng Thái";

                // Điền dữ liệu cho hóa đơn
                workSheet.Cells[2, 1].Value = donHang.MaDonHang;
                workSheet.Cells[2, 2].Value = donHang.NgayDatHang.Value.ToString("dd/MM/yyyy");
                workSheet.Cells[2, 3].Value = donHang.TongTien;
                workSheet.Cells[2, 4].Value = donHang.TrangThai;

                // Thêm tiêu đề cho chi tiết đơn hàng
                workSheet.Cells[4, 1].Value = "Tên Sản Phẩm";
                workSheet.Cells[4, 2].Value = "Số Lượng";
                workSheet.Cells[4, 3].Value = "Giá";

                int row = 5; // Bắt đầu từ hàng thứ 5 cho chi tiết sản phẩm

                // Điền dữ liệu cho chi tiết đơn hàng
                foreach (var item in chiTietDonHang)
                {
                    workSheet.Cells[row, 1].Value = item.SanPham.TenSanPham; // Tên sản phẩm
                    workSheet.Cells[row, 2].Value = item.SoLuong; // Số lượng
                    workSheet.Cells[row, 3].Value = item.Gia; // Giá
                    row++;
                }

                // Xuất file Excel
                var stream = new MemoryStream();
                excel.SaveAs(stream);
                var fileName = "HoaDon_" + donHang.MaDonHang + ".xlsx"; // Tên file dựa trên mã đơn hàng
                return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }


        public ActionResult ExportToPdf(int id)
        {
            var donHang = db.DonHang.Find(id); // Lấy thông tin đơn hàng theo ID
            var chiTietDonHang = db.ChiTietDonHang.Where(u => u.MaDonHang == id).ToList(); // Lấy chi tiết đơn hàng theo ID

            if (donHang == null || chiTietDonHang == null)
            {
                return HttpNotFound();
            }

            using (var memoryStream = new MemoryStream())
            {
                var writer = new PdfWriter(memoryStream);
                var pdf = new PdfDocument(writer);
                var document = new Document(pdf);

                // Thiết lập lề cho tài liệu
                document.SetMargins(30, 30, 30, 30);

                // Sử dụng font tiếng Việt từ tệp .ttf
                string fontPath = Path.Combine(Server.MapPath("~/Content/"), "arial.ttf");
                PdfFont font = PdfFontFactory.CreateFont(fontPath, PdfEncodings.IDENTITY_H);

                // Tiêu đề hóa đơn
                var title = new Paragraph("HÓA ĐƠN")
                                .SetFont(font)
                                .SetFontSize(18)
                                .SetBold()
                                .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                                .SetMarginBottom(20);
                document.Add(title);

                // Thông tin đơn hàng
                var orderInfo = new Paragraph("Mã Đơn Hàng: " + donHang.MaDonHang + "\n" +
                                              "Ngày Đặt: " + donHang.NgayDatHang.Value.ToString("dd/MM/yyyy") + "\n" +
                                              "Tổng Tiền: " + donHang.TongTien.Value.ToString("N0") + " VNĐ\n" +
                                              "Trạng Thái: " + donHang.TrangThai)
                                .SetFont(font)
                                .SetFontSize(12)
                                .SetMarginBottom(20);
                document.Add(orderInfo);

                // Tiêu đề chi tiết đơn hàng
                var detailTitle = new Paragraph("Chi Tiết Đơn Hàng")
                                      .SetFont(font)
                                      .SetFontSize(14)
                                      .SetBold()
                                      .SetMarginBottom(10);
                document.Add(detailTitle);

                // Tạo bảng cho chi tiết sản phẩm
                Table table = new Table(3); // 3 cột: Tên sản phẩm, Số lượng, Giá
                table.SetWidth(UnitValue.CreatePercentValue(100)); // Chiều rộng 100%

                // Thêm tiêu đề cho các cột
                table.AddHeaderCell(new Cell().Add(new Paragraph("Tên Sản Phẩm").SetFont(font).SetBold()));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Số Lượng").SetFont(font).SetBold()));
                table.AddHeaderCell(new Cell().Add(new Paragraph("Giá (VNĐ)").SetFont(font).SetBold()));

                // Điền chi tiết đơn hàng vào bảng
                foreach (var item in chiTietDonHang)
                {
                    table.AddCell(new Paragraph(item.SanPham.TenSanPham).SetFont(font));
                    table.AddCell(new Paragraph(item.SoLuong.ToString()).SetFont(font));
                    table.AddCell(new Paragraph(item.Gia.Value.ToString("N0")).SetFont(font));
                }

                // Thêm bảng vào tài liệu
                document.Add(table);

                // Cảm ơn
                var thanks = new Paragraph("Cảm ơn bạn đã mua sắm tại cửa hàng chúng tôi!")
                                .SetFont(font)
                                .SetFontSize(12)
                                .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                                .SetMarginTop(20);
                document.Add(thanks);

                // Đóng tài liệu
                document.Close();

                // Trả về file PDF
                return File(memoryStream.ToArray(), "application/pdf", "HoaDon_" + donHang.MaDonHang + ".pdf");
            }
        }

    }
}