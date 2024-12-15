@model IEnumerable<TMDTLaptop.Models.PhieuNhapKho>

@{
    ViewBag.Title = "Quản Lý Phiếu Nhập Kho";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4">@ViewBag.Title</h2>

    <form method="get" action="@Url.Action("QuanLyPhieuNhapKho", "Admin")">
        <div class="input-group mb-3">
            <input type="text" name="searchString" value="@ViewBag.SearchString" class="form-control" placeholder="Tìm kiếm theo mã phiếu nhập" />
            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
        </div>
    </form>
    <a href="@Url.Action("ThemPhieuNhapKho", "Admin")" class="btn btn-success mb-3">Thêm Phiếu Nhập Kho</a>

    <div class="card">
        <div class="card-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>Mã Phiếu Nhập</th>
                        <th>Ngày Nhập</th>
                        <th>Tổng Tiền</th>
                        <th>Ghi Chú</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var phieuNhap in Model)
                    {
                        <tr>
                            <td>@phieuNhap.MaPhieuNhap</td>
                            <td>@phieuNhap.NgayNhap.ToString("dd/MM/yyyy")</td>
                            <td>@phieuNhap.TongTien.ToString("N0") đ</td>
                            <td>@phieuNhap.GhiChu</td>
                            <td>
                                <a href="@Url.Action("ChiTietPhieuNhapKho", "Admin", new { id = phieuNhap.MaPhieuNhap })" class="btn btn-info">Xem Chi Tiết</a>
                            </td>
                        </tr>
                    }
                </tbody>
            </table>
        </div>
    </div>

    <nav aria-label="Page navigation">
        <ul class="pagination">
            @for (int i = 1; i <= ViewBag.TotalPages; i++)
            {
                <li class="page-item @(i == ViewBag.CurrentPage ? "active" : "")">
                    <a class="page-link" href="@Url.Action("QuanLyPhieuNhapKho", new { page = i, searchString = ViewBag.SearchString })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
