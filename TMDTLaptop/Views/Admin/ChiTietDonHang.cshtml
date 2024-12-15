@model TMDTLaptop.Models.DonHang

@{
    ViewBag.Title = "Chi Tiết Đơn Hàng";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4 mb-4">Chi Tiết Đơn Hàng #@Model.MaDonHang</h2>

    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Thông Tin Đơn Hàng</h5>
            <p><strong>Mã Đơn Hàng:</strong> @Model.MaDonHang</p>
            <p><strong>Người đặt hàng:</strong> @Model.TaiKhoan.HoTen</p>
            <p><strong>Ngày Đặt:</strong> @Model.NgayDatHang.Value.ToString("dd/MM/yyyy")</p>
            <p><strong>Tổng Tiền:</strong> @Model.TongTien.Value.ToString("N0") đ</p>
            @if (Model.MaVoucher != null)
            {
                <p><strong>Đã áp dụng mã giảm giá giảm:</strong> @Model.Voucher.GiamGia %</p>
            }
            <p><strong>Địa Chỉ Giao Hàng:</strong> @Model.DiaChiGiaoHang</p>
            <p><strong>Số Điện Thoại:</strong> @Model.SoDienThoai</p>
            <p><strong>Trạng Thái:</strong> @Model.TrangThai</p>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Chi Tiết Sản Phẩm</h5>
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Mã Sản Phẩm</th>
                        <th scope="col">Tên Sản Phẩm</th>
                        <th scope="col">Số Lượng</th>
                        <th scope="col">Đơn Giá</th>
                        <th scope="col">Thành Tiền</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var chiTiet in Model.ChiTietDonHang)
                    {
                        <tr>
                            <td>@chiTiet.MaSanPham</td>
                            <td>@chiTiet.SanPham.TenSanPham</td>
                            <td>@chiTiet.SoLuong</td>
                            <td>@chiTiet.Gia.Value.ToString("N0") đ</td>
                            <td>@((chiTiet.SoLuong * chiTiet.Gia).Value.ToString("N0")) đ</td>

                        </tr>
                    }
                </tbody>
            </table>
        </div>
    </div>

    <a href="@Url.Action("QuanLyDonHang")" class="btn btn-secondary mt-3">Quay Lại</a>
</div>
