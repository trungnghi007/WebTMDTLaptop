@{
    ViewBag.Title = "Quản Lý Đơn Hàng";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4 mb-4">Quản Lý Đơn Hàng</h2>

    <!-- Thanh tìm kiếm -->
    <form class="form-inline mb-3" method="get" action="@Url.Action("QuanLyDonHang")">
        <input type="text" name="searchTerm" class="form-control mr-sm-2" placeholder="Tìm kiếm..." value="@ViewBag.SearchTerm" />
        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
    </form>

    <div class="card">
        <div class="card-body">
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Mã Đơn Hàng</th>
                        <th scope="col">Ngày Đặt</th>
                        <th scope="col">Tổng Tiền</th>
                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var item in Model)
                    {
                        <tr>
                            <td>@item.MaDonHang</td>
                            <td>@item.NgayDatHang.ToString("dd/MM/yyyy")</td>
                            <td>@item.TongTien.ToString("N0") đ</td>
                            <td>@item.TrangThai</td>
                            <td>
                                <a href="@Url.Action("ChiTietDonHang", new { id = item.MaDonHang })" class="btn btn-info btn-sm">Xem Chi Tiết</a>
                                @if (item.TrangThai == "Đang chờ xử lý")
                                {

                                    <a href="@Url.Action("DuyetDonHang", new { id = item.MaDonHang })" class="btn btn-success btn-sm">Duyệt</a>
                                    <a href="@Url.Action("HuyDonHang", new { id = item.MaDonHang })" class="btn btn-danger btn-sm">Hủy</a>
                                }
                                @{
                                    // Khai báo và khởi tạo biến quyennv với giá trị mặc định
                                    int quyennv = 0; // Gán giá trị mặc định
                                    bool hasPermission = Session["Quyen"] != null && Int32.TryParse(Session["Quyen"].ToString(), out quyennv);

                                    // Kiểm tra điều kiện
                                    if (item.TrangThai == "Đã Duyệt" && hasPermission && quyennv == 2)
                                    {
                                        <a href="@Url.Action("DuyetDonHang", "NV", new { id = item.MaDonHang })" class="btn btn-success btn-sm">Đã giao</a>
                                        <a href="@Url.Action("ExportToPDF", "NV", new { id = item.MaDonHang })" class="btn btn-success btn-sm">Xuất pdf</a>
                                    }
                                }

                            </td>

                        </tr>
                    }
                </tbody>
            </table>
        </div>
    </div>

    <!-- Phân trang -->
    <nav aria-label="Page navigation">
        <ul class="pagination">
            @for (var i = 1; i <= ViewBag.TotalPages; i++)
            {
                <li class="page-item @(i == ViewBag.CurrentPage ? "active" : "")">
                    <a class="page-link" href="@Url.Action("QuanLyDonHang", new { page = i, pageSize = 5, searchTerm = ViewBag.SearchTerm })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
