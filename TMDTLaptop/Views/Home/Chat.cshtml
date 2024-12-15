@model List<TMDTLaptop.Models.Messages>
@{
    ViewBag.Title = "Chat với Nhân Viên";
    Layout = "~/Views/Shared/_LayoutHome.cshtml"; // Điều chỉnh theo layout của bạn
    TMDTLaptop.Models.LaptopStoreEntities db = new TMDTLaptop.Models.LaptopStoreEntities();
    var nv = db.TaiKhoan.SingleOrDefault(u => u.MaQuyen == 4 && u.TrangThai == true);
    string tennv = nv.HoTen;
    string user = Session["Username"]?.ToString();
    string username = db.TaiKhoan.SingleOrDefault(u=>u.Username.Contains(user)).HoTen;
}

<style>
    .breadcrumb-area {
        background-image: url('@Url.Content("~/assets/images/banner/banner3.jpg")'); /* Đường dẫn tới hình ảnh */
    }
</style>

<div class="breadcrumb-area">
    <div class="container">
        <div class="breadcrumb-content">
            <h2>Chat</h2>
            <ul>
                <li><a href="@Url.Action("Index", "Home")">Trang chủ</a></li>
                <li class="active">Chat</li>
            </ul>
        </div>
    </div>
</div>

<div class="container">
    <div class="chat-box" id="chatBox" style="border: 1px solid #ccc; padding: 10px; height: 400px; overflow-y: scroll;">
        @foreach (var message in Model)
        {
            var sender = db.TaiKhoan.FirstOrDefault(t => t.MaTaiKhoan == message.SenderId);
            string senderName = sender != null ? sender.HoTen : "Người gửi không xác định";
            // Định dạng thời gian trực tiếp trong Razor
            string formattedTimestamp = message.Timestamp.ToString("dd/MM/yyyy HH:mm:ss");

            <div class="message @(message.SenderId == 2 ? "customer-message" : "employee-message")">
                <strong>@senderName:</strong> @message.Content <br />
                <small>@formattedTimestamp</small> <!-- Sử dụng định dạng đã chuyển đổi -->
            </div>
        }
    </div>

    <form method="post" action="@Url.Action("SendMessage", "Home")" style="margin-top: 20px;">
        <input type="hidden" name="sender" value="@Session["Username"]" />
        <input type="hidden" name="receiver" value="Nhân Viên" />
        <div class="form-group">
            <textarea name="content" class="form-control" rows="3" placeholder="Nhập tin nhắn..."></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Gửi</button>
    </form>
</div>

<style>
    .chat-box {
        background-color: #f9f9f9;
        padding: 10px;
        border-radius: 5px;
    }

    .message {
        margin-bottom: 10px;
        padding: 5px;
        border-radius: 3px;
    }

    .customer-message {
        background-color: #e1f7d5; /* Màu nền cho tin nhắn khách hàng */
        text-align: left;
    }

    .employee-message {
        background-color: #d1e7ff; /* Màu nền cho tin nhắn nhân viên */
        text-align: right;
    }
</style>

<script>
    function updateChat() {
        $.ajax({
            url: '@Url.Action("GetMessages", "Home")', // Đường dẫn tới Action để lấy tin nhắn
            type: 'GET',
            success: function (data) {
                $('#chatBox').empty(); // Xóa nội dung cũ
                $.each(data, function (index, message) {
                   var senderName = message.SenderId == @nv.MaTaiKhoan ? "@tennv" : "@username"; // Điều chỉnh theo quy tắc của bạn

                    // Chuyển đổi Timestamp về dạng Date
                    var formattedDate = message.Timestamp;

                    $('#chatBox').append('<div class="message ' + (message.SenderId == 2 ? "customer-message" : "employee-message") + '">' +
                        '<strong>' + senderName + ':</strong> ' + message.Content + '<br />' +
                        '<small>' + formattedDate + '</small>' +
                        '</div>');
                });

                // Cuộn xuống cuối chat
                var chatBox = $('#chatBox')[0];
                if (chatBox) {
                    chatBox.scrollTop = chatBox.scrollHeight; // Cuộn xuống cuối chat
                }
            },
            error: function (xhr, status, error) {
                console.error("Error while fetching messages: ", error);
            }
        });
    }

    // Cập nhật chat mỗi 3 giây
    setInterval(updateChat, 3000);
</script>
