﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TMDTLaptop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;

    public partial class SanPham
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SanPham()
        {
            this.ChiTietDonHang = new HashSet<ChiTietDonHang>();
            this.ChiTietGioHang = new HashSet<ChiTietGioHang>();
            this.ChiTietPhieuNhapKho = new HashSet<ChiTietPhieuNhapKho>();
        }

        public int MaSanPham { get; set; }

        [Required(ErrorMessage = "Tên sản phẩm không được để trống.")]
        public string TenSanPham { get; set; }

        [AllowHtml]
        public string MoTa { get; set; }

        [Required(ErrorMessage = "Giá không được để trống.")]
        [Range(0, double.MaxValue, ErrorMessage = "Giá phải là số dương.")]
        public decimal Gia { get; set; }

        public Nullable<decimal> GiaMoi { get; set; }

        public string HinhAnh { get; set; }

        [Required(ErrorMessage = "Bạn phải chọn hãng.")]
        public Nullable<int> MaHang { get; set; }

        [Required(ErrorMessage = "Bạn phải chọn danh mục.")]
        public Nullable<int> MaDanhMuc { get; set; }

        public Nullable<System.DateTime> NgayTao { get; set; }
        public Nullable<bool> TrangThai { get; set; }

        [Required(ErrorMessage = "Số lượng không được để trống.")]
        [Range(0, int.MaxValue, ErrorMessage = "Số lượng phải là số nguyên không âm.")]
        public Nullable<int> SoLuong { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietDonHang> ChiTietDonHang { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietGioHang> ChiTietGioHang { get; set; }
        public virtual DanhMucSanPham DanhMucSanPham { get; set; }
        public virtual HangSanPham HangSanPham { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChiTietPhieuNhapKho> ChiTietPhieuNhapKho { get; set; }
    }
}
