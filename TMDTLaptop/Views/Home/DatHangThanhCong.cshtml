@{
    ViewBag.Title = "DatHangThanhCong";
    Layout = "~/Views/Shared/_LayoutHome.cshtml";
}
<style>
    .breadcrumb-area {
        background-image: url('@Url.Content("~/assets/images/banner/banner3.jpg")'); /* Đường dẫn tới hình ảnh */
    }
</style>
<div class="breadcrumb-area">
    <div class="container">
        <div class="breadcrumb-content">
            <h2>Đặt hàng thành công</h2>
            <ul>
                <li><a href="@Url.Action("Index", "Home")">Trang chủ</a></li>
                <li class="active">Thành công</li>
            </ul>
        </div>
    </div>
</div>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="alert alert-success text-center" role="alert">
                <h4 class="alert-heading">Cảm ơn bạn!</h4>
                <p>Đơn hàng của bạn đã được đặt thành công. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.</p>
                <hr>
                <p class="mb-0">Mã đơn hàng của bạn là: <strong>#@ViewBag.OrderId</strong></p>
            </div>

            <div class="card mt-4">
                <div class="card-header">
                    Thông tin đơn hàng
                </div>
                <div class="card-body">
                    <h5 class="card-title">Chi tiết sản phẩm</h5>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sản phẩm</th>
                                <th scope="col">Giá</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Tổng</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if (ViewBag.OrderDetails != null)
                            {
                                var orderDetails = ViewBag.OrderDetails as List<string>;
                                foreach (var detail in orderDetails)
                                {
                                    var parts = detail.Split('|');
                                    <tr>
                                        <td>@parts[0]</td>
                                        <td>@decimal.Parse(parts[1]).ToString("N0") đ</td>
                                        <td>@parts[2]</td>
                                        <td>@decimal.Parse(parts[3]).ToString("N0") đ</td>
                                    </tr>
                                }
                            }

                            <tr>
                                <td colspan="3" class="text-right"><strong>Mã giảm giá:</strong></td>
                                <td>@ViewBag.MaVoucher</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right"><strong>Đã giảm giá:</strong></td>
                                <td>@ViewBag.phantram %</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right"><strong>Tổng cộng:</strong></td>
                                <td>@ViewBag.TotalAmount.ToString("N0") đ</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="text-center mt-4">
                <a href="@Url.Action("Index", "Home")" class="btn btn-primary">Quay lại trang chủ</a>
            </div>
        </div>
    </div>
</div>
