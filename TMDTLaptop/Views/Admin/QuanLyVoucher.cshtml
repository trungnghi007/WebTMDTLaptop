
@{
    ViewBag.Title = "Quản Lý Voucher";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4 mb-4">Quản Lý Voucher</h2>

    <a href="@Url.Action("ThemVoucher")" class="btn btn-primary mb-3">Thêm Voucher Mới</a>

    <!-- Form tìm kiếm -->
    @using (Html.BeginForm("QuanLyVoucher", "Admin", FormMethod.Get))
    {
        <div class="input-group mb-3">
            <input type="text" name="searchTerm" class="form-control" placeholder="Tìm kiếm voucher..." value="@ViewBag.SearchTerm" />
            <button class="btn btn-outline-secondary" type="submit">Tìm kiếm</button>
        </div>
    }

    <div class="card">
        <div class="card-body">
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Mã Voucher</th>
                        <th scope="col">Mã Giảm Giá</th>
                        <th scope="col">Giảm Giá</th>
                        <th scope="col">Ngày Bắt Đầu</th>
                        <th scope="col">Ngày Kết Thúc</th>
                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var item in Model)
                    {
                        <tr>
                            <td>@item.MaVoucher</td>
                            <td>@item.Code</td>
                            <td>@item.GiamGia %</td>
                            <td>@item.NgayBatDau.ToString("dd/MM/yyyy")</td>
                            <td>@item.NgayKetThuc.ToString("dd/MM/yyyy")</td>
                            <td>
                                <span class="badge @(item.TrangThai == true ? "bg-success" : "bg-danger")">
                                    @(item.TrangThai == true ? "Hoạt động" : "Ngừng hoạt động")
                                </span>
                            </td>
                            <td>
                                <a href="@Url.Action("SuaVoucher", new { id = item.MaVoucher })" class="btn btn-warning btn-sm">Sửa</a>
                                <form action="@Url.Action("ChuyenDoiTrangThai", new { id = item.MaVoucher })" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-secondary btn-sm" onclick="return confirm('Bạn có chắc chắn muốn thay đổi trạng thái?');">
                                        @(item.TrangThai == true ? "Ngừng hoạt động" : "Kích hoạt")
                                    </button>
                                </form>
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
                    <a class="page-link" href="@Url.Action("QuanLyVoucher", new { page = i, searchTerm = ViewBag.SearchTerm })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
