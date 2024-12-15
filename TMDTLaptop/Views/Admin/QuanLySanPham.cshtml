@{
    ViewBag.Title = "Quản Lý Sản Phẩm";
    Layout = "~/Views/Shared/_LayoutAdmin.cshtml";
}

<div class="container">
    <h2 class="mt-4 mb-4">Quản Lý Sản Phẩm</h2>

    <a href="@Url.Action("ThemSanPham")" class="btn btn-primary mb-3">Thêm Sản Phẩm Mới</a>

    <!-- Form tìm kiếm -->
    @using (Html.BeginForm("QuanLySanPham", "Admin", FormMethod.Get))
    {
        <div class="input-group mb-3">
            <input type="text" name="searchTerm" class="form-control" placeholder="Tìm kiếm sản phẩm..." value="@ViewBag.SearchTerm" />
            <button class="btn btn-outline-secondary" type="submit">Tìm kiếm</button>
        </div>
    }

    <div class="card">
        <div class="card-body">
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Mã Sản Phẩm</th>
                        <th scope="col">Tên Sản Phẩm</th>
                        <th scope="col">Hình Ảnh</th>
                        <th scope="col">Mô Tả</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Giá mới</th>
                        <th scope="col">Trạng thái</th>
                        <th scope="col">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach (var item in Model)
                    {
                        <tr>
                            <td>@item.MaSanPham</td>
                            <td>@item.TenSanPham</td>
                            <td>
                                <img src="~/assets/images/product/@item.MaSanPham/@item.HinhAnh" alt="Sản Phẩm" style="width: 100px; height: auto;" />
                            </td>
                            <td>@item.MoTa</td>
                            <td>@item.Gia.ToString("N0") đ</td>
                        
                                @if (item.GiaMoi != null)
                                {
                                <td>
                                    @item.GiaMoi.ToString("N0") đ
                                </td>
                            }
                            else
                            {
                                <td>
                                    <span>Không có giảm giá</span>
                                </td>
                            }
  
                                <td>
                                    <span class="badge @(item.TrangThai == true ? "bg-success" : "bg-danger")">
                                        @(item.TrangThai == true ? "Hoạt động" : "Ngừng hoạt động")
                                    </span>
                                </td>
                                <td>
                                    <a href="@Url.Action("SuaSanPham", new { id = item.MaSanPham })" class="btn btn-warning btn-sm">Sửa</a>
                                    @if (item.TrangThai == true) // Nếu sản phẩm đang mở bán
                                    {
                                        <a href="@Url.Action("CapNhatTrangThaiSP", new { id = item.MaSanPham, status = false })" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn ngưng bán sản phẩm này?');">Ngưng Bán</a>
                                    }
                                    else // Nếu sản phẩm đang ngưng bán
                                    {
                                        <a href="@Url.Action("CapNhatTrangThaiSP", new { id = item.MaSanPham, status = true })" class="btn btn-success btn-sm" onclick="return confirm('Bạn có chắc chắn muốn mở bán sản phẩm này?');">Mở Bán</a>
                                    }
                                    <form action="@Url.Action("NgungGiamGia", new { id = item.MaSanPham })" method="post" style="display:inline;">
                                        <button type="submit" class="btn btn-warning btn-sm" onclick="return confirm('Bạn có chắc chắn muốn ngưng giảm giá sản phẩm này?');">Ngưng Giảm Giá</button>
                                    </form>
                                    <!-- Thêm nút Giảm Giá -->
                                    <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#giamGiaModal" data-id="@item.MaSanPham" data-tensp="@item.TenSanPham" data-gia="@item.Gia">Giảm Giá</button>

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
                    <a class="page-link" href="@Url.Action("QuanLySanPham", new { page = i, searchTerm = ViewBag.SearchTerm })">@i</a>
                </li>
            }
        </ul>
    </nav>
</div>
<!-- Modal Giảm Giá -->
<div class="modal fade" id="giamGiaModal" tabindex="-1" role="dialog" aria-labelledby="giamGiaModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="giamGiaModalLabel">Giảm Giá Sản Phẩm</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="giamGiaForm">
                    @Html.AntiForgeryToken()
                    <input type="hidden" id="MaSanPham" name="MaSanPham" />
                    <div class="form-group">
                        <label for="TenSanPham">Tên Sản Phẩm:</label>
                        <input type="text" class="form-control" id="TenSanPham" readonly />
                    </div>
                    <div class="form-group">
                        <label for="Gia">Giá Hiện Tại:</label>
                        <input type="text" class="form-control" id="Gia" readonly />
                    </div>
                    <div class="form-group">
                        <label for="GiaMoi">Giá Mới:</label>
                        <input type="number" class="form-control" id="GiaMoi" name="GiaMoi" required />
                    </div>
                    <button type="submit" class="btn btn-primary">Cập Nhật Giá</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
        $(document).ready(function () {
            // Khi modal mở
            $('#giamGiaModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Lấy nút nhấn để mở modal
                var id = button.data('id'); // Lấy id sản phẩm
                var tenSanPham = button.data('tensp'); // Lấy tên sản phẩm
                var gia = button.data('gia'); // Lấy giá hiện tại

                // Cập nhật giá trị trong modal
                var modal = $(this);
                modal.find('#MaSanPham').val(id);
                modal.find('#TenSanPham').val(tenSanPham);
                modal.find('#Gia').val(gia.toLocaleString('vi-VN') + " đ"); // Định dạng giá
            });

            // Xử lý submit form giảm giá
            $('#giamGiaForm').submit(function (e) {
                e.preventDefault(); // Ngăn chặn reload trang
              
                var maSanPham = $('#MaSanPham').val();
               
                var giaMoi = $('#GiaMoi').val();
            
                $.ajax({
                    type: 'POST',
                    url: '@Url.Action("GiamGia", "Admin")', // Thay đổi tên controller nếu cần
                    data: { MaSanPham: maSanPham, GiaMoi: giaMoi },
                    success: function (response) {
                        alert('Cập nhật giá thành công!');
                        location.reload(); // Reload lại trang
                    },
                    error: function () {
                        alert('Cập nhật giá thất bại!');
                    }
                });
            });
        });
</script>