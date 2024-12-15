@model IEnumerable<TMDTLaptop.Models.TaiKhoan>

@{
    ViewBag.Title = "Quản Lý Nhân Viên";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}
@if (TempData["SuccessMessage"] != null)
{
    <script>
        alert('@Html.Raw(TempData["SuccessMessage"])');
    </script>
}
<div class="container">
    <h2 class="mt-4 mb-4">Quản Lý Nhân Viên</h2>

    <a href="@Url.Action("ThemNhanVien")" class="btn btn-primary mb-3">Thêm Nhân Viên Mới</a>

    <form method="get" action="@Url.Action("QuanLyNhanVien")" class="form-inline mb-3">
        <input type="text" name="searchTerm" value="@ViewBag.SearchTerm" class="form-control" placeholder="Tìm kiếm...">
        <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
    </form>

    <div class="card">
        <div class="card-body">
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Mã Tài Khoản</th>
                        <th scope="col">Username</th>
                        <th scope="col">Họ Tên</th>
                        <th scope="col">Email</th>
                        <th scope="col">Số Điện Thoại</th>
                        <th scope="col">Trạng Thái</th>
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
                            <td>@item.Email</td>
                            <td>@item.SoDienThoai</td>
                            <td>@(item.TrangThai == true ? "Đang hoạt động" : "Đã khóa")</td>
                            <td>
                                @if (item.TrangThai == true)
                                {
                                    <a href="@Url.Action("KhoaTaiKhoan", new { id = item.MaTaiKhoan })" class="btn btn-danger btn-sm">Khóa</a>
                                }
                                else
                                {
                                    <a href="@Url.Action("MoKhoaTaiKhoan", new { id = item.MaTaiKhoan })" class="btn btn-success btn-sm">Mở tài khoản</a>
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
        <ul class="pagination justify-content-center mt-4">
            @for (int i = 1; i <= ViewBag.TotalPages; i++)
            {
                <li class="page-item @(ViewBag.CurrentPage == i ? "active" : "")">
                    <a class="page-link" href="@Url.Action("QuanLyNhanVien", new { page = i, searchTerm = ViewBag.SearchTerm })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
