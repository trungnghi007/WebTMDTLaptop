@model IEnumerable<TMDTLaptop.Models.SanPham>

@{
    ViewBag.Title = "Quản Lý Tồn Kho";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4">@ViewBag.Title</h2>

    <form method="get" action="@Url.Action("QuanLyTonKho", "Admin")">
        <div class="input-group mb-3">
            <input type="text" name="searchString" value="@ViewBag.SearchString" class="form-control" placeholder="Tìm kiếm sản phẩm" />
            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
        </div>
    </form>
    @if (Session["Quyen"] != null && Int32.TryParse(Session["Quyen"].ToString(), out int quyenadmin) && quyenadmin == 1)
    {
        <div class="text-center mb-4">
            <a href="@Url.Action("InExcelHangTonKho", "Admin")" class="btn btn-warning">
                In những sản phẩm hết hàng ra Excel
            </a>
            <a href="@Url.Action("QuanLyPhieuNhapKho", "Admin")" class="btn btn-info">
                Quản Lý Phiếu Nhập Kho
            </a>
        </div>
    }
    @if (Session["Quyen"] != null && Int32.TryParse(Session["Quyen"].ToString(), out int quyennv) && quyennv == 2)
    {
        <div class="text-center mb-4">
            <a href="@Url.Action("QuanLyPhieuNhapKho", "Admin")" class="btn btn-info">
                Quản Lý Phiếu Nhập Kho
            </a>
        </div>
    }

    <div class="card">
        <div class="card-body">
            <table class="table">
                <thead>
                    <tr>
                        <th>Tên Sản Phẩm</th>
                        <th>Số Lượng</th>
                        <th>Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var product in Model)
                    {
                        <tr>
                            <td>@product.TenSanPham</td>
                            <td>@product.SoLuong</td>
                            <td>
                                @if (product.SoLuong == 0)
                                {
                                    <span class="text-danger">Hết hàng</span>
                                }
                                else
                                {
                                    <span class="text-success">Còn hàng</span>
                                }
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
                    <a class="page-link" href="@Url.Action("QuanLyTonKho", new { page = i, searchString = ViewBag.SearchString })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
