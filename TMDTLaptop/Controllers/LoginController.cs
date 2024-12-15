using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TMDTLaptop.Models;

namespace TMDTLaptop.Controllers
{
    public class LoginController : Controller
    {
        LaptopStoreEntities db = new LaptopStoreEntities();
        // GET: Login
        public ActionResult DangNhap()
        {
            return View();
        }
        public ActionResult DangXuat()
        {
            Session.Remove("Admin");
            return RedirectToAction("DangNhap","Login");
        }
        [HttpPost]
        public ActionResult DangNhap(string tenDangNhap, string matKhau)
        {
            // Tìm kiếm tài khoản admin với thông tin đăng nhập
            var admin = db.TaiKhoan.FirstOrDefault(a => a.Username == tenDangNhap && a.Password == matKhau );

            // Nếu tìm thấy admin, lưu thông tin vào Session và chuyển hướng đến trang Index (quản trị)
            if (admin != null)
            {
                if (admin.TrangThai == false)
                {
                    ViewBag.ErrorMessage = "Tài khoản của bạn đã bị khóa!";
                    return View();
                }
                Session["Admin"] = admin.Username; // Lưu tên đăng nhập vào Session
                Session["Quyen"] = admin.MaQuyen;
                if (admin.MaQuyen == 1)
                {
                    return RedirectToAction("Index","Admin");
                }
                else if (admin.MaQuyen == 2)
                {
                    return RedirectToAction("Index","NV");
                }
                else if (admin.MaQuyen ==4) {
                    return RedirectToAction("Index","ChamSocKH");
                }
              
               
            }

            // Nếu không tìm thấy, thông báo lỗi và hiển thị lại trang đăng nhập
            ViewBag.ErrorMessage = "Tên đăng nhập hoặc mật khẩu không đúng!";
            return View();
        }
    }
}