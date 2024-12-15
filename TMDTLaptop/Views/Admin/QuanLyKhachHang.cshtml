@model IEnumerable<TMDTLaptop.Models.TaiKhoan>

@{
    ViewBag.Title = "Quản Lý Khách Hàng";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4 mb-4">Quản Lý Khách Hàng</h2>

    <!-- Form tìm kiếm -->
    @using (Html.BeginForm("QuanLyKhachHang", "Admin", FormMethod.Get))
    {
        <div class="input-group mb-3">
            <input type="text" name="searchTerm" class="form-control" placeholder="Tìm kiếm khách hàng..." value="@ViewBag.SearchTerm" />
            <button class="btn btn-outline-secondary" type="submit">Tìm kiếm</button>
        </div>
    }

    <div class="card">
        <div class="card-body">
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Mã Khách Hàng</th>
                        <th scope="col">Username</th>
                        <th scope="col">Họ Tên</th>
                        <th scope="col">Địa Chỉ</th>
                        <th scope="col">Số Điện Thoại</th>
                        <th scope="col">Email</th>
                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Ngày Tạo</th>
                        <th scope="col">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var item in Model)
                    {
                        <tr>
                            <td>@item.MaTaiKhoan</td>
                            <td>@item.Username</td>
                            <td>@item.HoTen</td>
                            <td>@item.DiaChi</td>
                            <td>@item.SoDienThoai</td>
                            <td>@item.Email</td>
                            <td>
                                <span class="badge @(item.TrangThai == true ? "bg-success" : "bg-danger")">
                                    @(item.TrangThai == true ? "Hoạt Động" : "Khóa")
                                </span>
                            </td>
                            <td>@item.NgayTao.Value.ToString("dd/MM/yyyy")</td>
                            <td>
                                <a href="@Url.Action("CapNhatTrangThaiKH", new { id = item.MaTaiKhoan })" class="btn btn-danger">@(item.TrangThai == true ? "Khóa" : "Mở")</a>
                            </td>
                        </tr>
                    }
                </tbody>
            </table>
        </div>
    </div>

    <!-- Phân trang -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-4">
            @for (int i = 1; i <= ViewBag.TotalPages; i++)
            {
                <li class="page-item @(ViewBag.CurrentPage == i ? "active" : "")">
                    <a class="page-link" href="@Url.Action("QuanLyKhachHang", new { page = i, searchTerm = ViewBag.SearchTerm })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
