using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TMDTLaptop.Models;

namespace TMDTLaptop.Controllers
{
    public class ChamSocKHController : Controller
    {
        LaptopStoreEntities db = new LaptopStoreEntities();
        public bool check()
        {
            if (Session["Admin"] == null) { return false; }
            return true;
        }
        public ActionResult Loi404()
        {
            return View();
        }
        public ActionResult Index()
        {
            if (!check()) { 
                return RedirectToAction("Loi404");
            }
            string currentUser = Session["Admin"]?.ToString(); // Lấy tên người dùng từ session
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == currentUser);

            // Lấy danh sách tin nhắn theo ID của người gửi và người nhận
            var userMessages = db.Messages
                .Where(m => m.SenderId == user.MaTaiKhoan || m.ReceiverId == user.MaTaiKhoan)
                .OrderBy(m => m.Timestamp)
                .ToList();

            // Lấy danh sách khách hàng mà nhân viên đã từng trò chuyện
            var customers = db.TaiKhoan.Where(u => u.MaQuyen == 3 &&
                (db.Messages.Any(m => m.ReceiverId == user.MaTaiKhoan && m.SenderId == u.MaTaiKhoan) ||
                db.Messages.Any(m => m.SenderId == user.MaTaiKhoan && m.ReceiverId == u.MaTaiKhoan)))
                .ToList();

            ViewBag.Customers = customers;
            ViewBag.UserMessages = userMessages;

            return View();
        }

        [HttpPost]
        public ActionResult SendMessage(int receiver, string content)
        {
            if (!check())
            {
                return RedirectToAction("Loi404");
            }
            string sender = Session["Admin"]?.ToString(); // Lấy tên người gửi từ session
            if (string.IsNullOrEmpty(sender))
            {
                return RedirectToAction("Index");
            }

            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == sender);
            var customer = db.TaiKhoan.SingleOrDefault(u => u.MaTaiKhoan == receiver);

            var message = new Messages
            {
                SenderId = user.MaTaiKhoan,
                ReceiverId = customer.MaTaiKhoan,
                Content = content,
                Timestamp = DateTime.Now
            };

            db.Messages.Add(message); // Thêm tin nhắn vào DB
            db.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

            return RedirectToAction("Index");
        }

        public JsonResult GetMessages(int receiverId)
        {

            string currentUser = Session["Admin"]?.ToString();
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == currentUser);

            var userMessages = db.Messages
                .Where(m => (m.SenderId == user.MaTaiKhoan && m.ReceiverId == receiverId) ||
                             (m.ReceiverId == user.MaTaiKhoan && m.SenderId == receiverId))
                .OrderBy(m => m.Timestamp)
                .Select(m => new
                {
                    m.Content,
                    m.SenderId,
                    m.Timestamp,
                    // Lấy tên người gửi
                    SenderName = m.SenderId == user.MaTaiKhoan ? user.HoTen : db.TaiKhoan.FirstOrDefault(c => c.MaTaiKhoan == m.SenderId).HoTen
                })
                .ToList();

            // Định dạng lại Timestamp
            var formattedMessages = userMessages.Select(m => new
            {
                m.Content,
                m.SenderId,
                m.SenderName,
                Timestamp = m.Timestamp.ToString("dd/MM/yyyy HH:mm:ss") // Định dạng ở đây
            }).ToList();

            return Json(formattedMessages, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCustomerList()
        {
            string currentUser = Session["Admin"]?.ToString();
            var user = db.TaiKhoan.SingleOrDefault(u => u.Username == currentUser);

            var customers = db.TaiKhoan.Where(u => u.MaQuyen == 3 &&
                (db.Messages.Any(m => m.ReceiverId == user.MaTaiKhoan && m.SenderId == u.MaTaiKhoan) ||
                db.Messages.Any(m => m.SenderId == user.MaTaiKhoan && m.ReceiverId == u.MaTaiKhoan)))
                .Select(u => new
                {
                    u.MaTaiKhoan,
                    u.HoTen,
                    NewMessageCount = db.Messages.Count(m => m.ReceiverId == user.MaTaiKhoan && m.SenderId == u.MaTaiKhoan),
                    // Lấy tin nhắn mới nhất giữa người dùng và khách hàng
                    LatestMessage = db.Messages
                        .Where(m => (m.SenderId == user.MaTaiKhoan && m.ReceiverId == u.MaTaiKhoan) ||
                                     (m.ReceiverId == user.MaTaiKhoan && m.SenderId == u.MaTaiKhoan))
                        .OrderByDescending(m => m.Timestamp)
                        .Select(m => m.Content)
                        .FirstOrDefault()
                })
                .ToList();

            return Json(customers, JsonRequestBehavior.AllowGet);
        }



    }
}