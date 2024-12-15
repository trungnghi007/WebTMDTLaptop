@{
    ViewBag.Title = "Quản Lý Danh Mục";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4 mb-4">Quản Lý Loại Hàng</h2>

    <a href="@Url.Action("ThemDanhMuc")" class="btn btn-primary mb-3">Thêm Danh Mục Mới</a>

    <!-- Form tìm kiếm -->
    @using (Html.BeginForm("QuanLyDanhMuc", "Admin", FormMethod.Get))
    {
        <div class="input-group mb-3">
            <input type="text" name="searchTerm" class="form-control" placeholder="Tìm kiếm danh mục..." value="@ViewBag.SearchTerm" />
            <button class="btn btn-outline-secondary" type="submit">Tìm kiếm</button>
        </div>
    }

    <div class="card">
        <div class="card-body">
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Mã Danh Mục</th>
                        <th scope="col">Tên Danh Mục</th>
                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Ngày Tạo</th>
                        <th scope="col">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var item in Model)
                    {
                        <tr>
                            <td>@item.MaDanhMuc</td>
                            <td>@item.TenDanhMuc</td>
                            <td>
                                <span class="badge @(item.TrangThai == true ? "bg-success" : "bg-danger")">
                                    @(item.TrangThai == true ? "Hoạt động" : "Ngừng hoạt động")
                                </span>
                            </td>
                            <td>@item.NgayTao.ToString("dd/MM/yyyy")</td>
                            <td>
                                <a href="@Url.Action("SuaDanhMuc", new { id = item.MaDanhMuc })" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="@Url.Action("CapNhatTrangThai", new { id = item.MaDanhMuc })" class="btn btn-secondary btn-sm">
                                    @(item.TrangThai == true ? "Ngừng hoạt động" : "Kích hoạt")
                                </a>
                            </td>
                        </tr>
                    }
                </tbody>
            </table>
        </div>
    </div>

    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-4">
            @for (int i = 1; i <= ViewBag.TotalPages; i++)
            {
                <li class="page-item @(ViewBag.CurrentPage == i ? "active" : "")">
                    <a class="page-link" href="@Url.Action("QuanLyDanhMuc", new { page = i, searchTerm = ViewBag.SearchTerm })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
