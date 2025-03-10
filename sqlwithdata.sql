USE [LaptopStore]
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[MaBanner] [int] IDENTITY(1,1) NOT NULL,
	[HinhAnh] [nvarchar](255) NOT NULL,
	[LienKet] [nvarchar](255) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBanner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaChiTiet] [int] IDENTITY(1,1) NOT NULL,
	[MaDonHang] [int] NULL,
	[MaSanPham] [int] NULL,
	[SoLuong] [int] NULL,
	[Gia] [decimal](18, 0) NULL,
	[GiaMoi] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietGioHang]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietGioHang](
	[MaChiTiet] [int] IDENTITY(1,1) NOT NULL,
	[MaGioHang] [int] NULL,
	[MaSanPham] [int] NULL,
	[SoLuong] [int] NULL,
	[Gia] [decimal](18, 0) NULL,
	[GiaMoi] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietPhieuNhapKho]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhieuNhapKho](
	[MaChiTiet] [int] IDENTITY(1,1) NOT NULL,
	[MaPhieuNhap] [int] NULL,
	[MaSanPham] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaNhap] [decimal](18, 2) NOT NULL,
	[TongTien]  AS ([SoLuong]*[GiaNhap]),
PRIMARY KEY CLUSTERED 
(
	[MaChiTiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhMucSanPham]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMucSanPham](
	[MaDanhMuc] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](100) NOT NULL,
	[TrangThai] [bit] NULL,
	[NgayTao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDanhMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDonHang] [int] IDENTITY(1,1) NOT NULL,
	[MaTaiKhoan] [int] NULL,
	[NgayDatHang] [datetime] NULL,
	[TongTien] [decimal](18, 0) NULL,
	[MaVoucher] [int] NULL,
	[DiaChiGiaoHang] [nvarchar](255) NULL,
	[SoDienThoai] [nvarchar](20) NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[MaGioHang] [int] IDENTITY(1,1) NOT NULL,
	[MaTaiKhoan] [int] NULL,
	[NgayTao] [datetime] NULL,
	[TongTien] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGioHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HangSanPham]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangSanPham](
	[MaHang] [int] IDENTITY(1,1) NOT NULL,
	[TenHang] [nvarchar](100) NOT NULL,
	[TrangThai] [bit] NULL,
	[NgayTao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SenderId] [int] NOT NULL,
	[ReceiverId] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuNhapKho]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhapKho](
	[MaPhieuNhap] [int] IDENTITY(1,1) NOT NULL,
	[NgayNhap] [datetime] NOT NULL,
	[TongTien] [decimal](18, 2) NOT NULL,
	[GhiChu] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quyen]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quyen](
	[MaQuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenQuyen] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[Gia] [decimal](18, 0) NOT NULL,
	[GiaMoi] [decimal](18, 0) NULL,
	[HinhAnh] [nvarchar](255) NULL,
	[MaHang] [int] NULL,
	[MaDanhMuc] [int] NULL,
	[NgayTao] [datetime] NULL,
	[TrangThai] [bit] NULL,
	[SoLuong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[MaQuyen] [int] NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[DiaChi] [nvarchar](255) NULL,
	[SoDienThoai] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[NgayTao] [datetime] NULL,
	[TrangThai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 05/12/2024 15:26:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[MaVoucher] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[GiamGia] [decimal](18, 0) NULL,
	[NgayBatDau] [datetime] NULL,
	[NgayKetThuc] [datetime] NULL,
	[SoLuongSuDung] [int] NOT NULL,
	[SoLuongSuDungToiDa] [int] NOT NULL,
	[TrangThai] [bit] NULL,
	[MoTa] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Banner] ON 

INSERT [dbo].[Banner] ([MaBanner], [HinhAnh], [LienKet], [MoTa]) VALUES (1, N'banner1.jpg', N'Index', NULL)
INSERT [dbo].[Banner] ([MaBanner], [HinhAnh], [LienKet], [MoTa]) VALUES (3, N'banner2.jpg', N'', N'Mô tả cho banner 2')
SET IDENTITY_INSERT [dbo].[Banner] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] ON 

INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (48, 46, 10, 1, CAST(33000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (49, 47, 4, 1, CAST(40000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (50, 48, 4, 1, CAST(40000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (51, 49, 29, 1, CAST(20000000 AS Decimal(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietGioHang] ON 

INSERT [dbo].[ChiTietGioHang] ([MaChiTiet], [MaGioHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (1085, 27, 29, 1, CAST(20000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietGioHang] ([MaChiTiet], [MaGioHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (1087, 26, 14, 1, CAST(50000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietGioHang] ([MaChiTiet], [MaGioHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (1088, 26, 8, 1, CAST(33000000 AS Decimal(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[ChiTietGioHang] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietPhieuNhapKho] ON 

INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (25, 26, 4, 10, CAST(15000000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (30, 31, 13, 4, CAST(17000000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (31, 32, 13, 4, CAST(16500000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (32, 33, 10, 5, CAST(19000000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[ChiTietPhieuNhapKho] OFF
GO
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] ON 

INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (1, N'Laptop', 1, CAST(N'2024-10-04T19:35:03.260' AS DateTime))
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (2, N'Linh kiện', 1, CAST(N'2024-10-04T19:35:08.977' AS DateTime))
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (4, N'Phụ kiện', 1, CAST(N'2024-10-14T20:57:35.970' AS DateTime))
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (5, N'Điện thoại', 1, CAST(N'2024-10-15T10:47:18.170' AS DateTime))
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (6, N'Tai nghe', 1, CAST(N'2024-11-20T18:57:50.933' AS DateTime))
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (46, 1014, CAST(N'2024-11-15T16:14:05.087' AS DateTime), CAST(33000000 AS Decimal(18, 0)), NULL, N'Ninh Kiều, Cần Thơ', N'0945852696', N'Đã Giao')
INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (47, 1014, CAST(N'2024-11-15T16:25:51.573' AS DateTime), CAST(36000000 AS Decimal(18, 0)), 12, N'Ninh Kiều, Cần Thơ', N'0945852696', N'Đã Hủy')
INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (48, 1014, CAST(N'2024-11-15T16:27:02.380' AS DateTime), CAST(40000000 AS Decimal(18, 0)), NULL, N'Ninh Kiều, Cần Thơ', N'0945852696', N'Đã Duyệt')
INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (49, 1014, CAST(N'2024-11-26T22:06:37.637' AS DateTime), CAST(20000000 AS Decimal(18, 0)), NULL, N'Ninh Kiều, Cần Thơ', N'0945852696', N'Đang chờ xử lý')
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[GioHang] ON 

INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (25, 1014, NULL, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (26, 1015, NULL, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (27, 1017, NULL, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (28, 1018, NULL, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (29, 1019, NULL, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (30, 1020, NULL, CAST(0 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[GioHang] OFF
GO
SET IDENTITY_INSERT [dbo].[HangSanPham] ON 

INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (1, N'ASUS', 1, CAST(N'2024-10-04T19:35:35.627' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (2, N'DELL', 1, CAST(N'2024-10-04T19:35:40.307' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (3, N'HP', 1, CAST(N'2024-10-04T19:35:42.320' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (4, N'Lenovo', 1, CAST(N'2024-10-12T12:11:48.837' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (5, N'Samsung', 1, CAST(N'2024-10-26T02:30:51.253' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (7, N'APPLE', 1, CAST(N'2024-11-20T11:31:24.263' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (8, N'RECA', 1, CAST(N'2024-11-26T22:28:56.430' AS DateTime))
SET IDENTITY_INSERT [dbo].[HangSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1039, 1015, 2, N'Xin chào, bạn có thể tư vấn cho tôi chứ', CAST(N'2024-11-24T00:26:56.250' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1040, 2, 1015, N'Vâng, bạn cần hỗ trợ gì ạ', CAST(N'2024-11-24T00:27:11.853' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1041, 1014, 2, N'Xin chào, bạn có thể giải đáp thắc mắc của tôi không ?', CAST(N'2024-11-26T22:11:26.883' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1042, 2, 1014, N'Vâng, mình có thể giúp gì cho bạn', CAST(N'2024-11-26T23:52:15.620' AS DateTime))
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuNhapKho] ON 

INSERT [dbo].[PhieuNhapKho] ([MaPhieuNhap], [NgayNhap], [TongTien], [GhiChu]) VALUES (26, CAST(N'2024-11-15T16:22:51.627' AS DateTime), CAST(150000000.00 AS Decimal(18, 2)), N'Nhập kho Strix G15')
INSERT [dbo].[PhieuNhapKho] ([MaPhieuNhap], [NgayNhap], [TongTien], [GhiChu]) VALUES (31, CAST(N'2024-11-22T01:50:44.867' AS DateTime), CAST(68000000.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PhieuNhapKho] ([MaPhieuNhap], [NgayNhap], [TongTien], [GhiChu]) VALUES (32, CAST(N'2024-11-22T01:51:33.653' AS DateTime), CAST(66000000.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PhieuNhapKho] ([MaPhieuNhap], [NgayNhap], [TongTien], [GhiChu]) VALUES (33, CAST(N'2024-11-22T01:52:28.590' AS DateTime), CAST(95000000.00 AS Decimal(18, 2)), N'Admin nhập kho test')
SET IDENTITY_INSERT [dbo].[PhieuNhapKho] OFF
GO
SET IDENTITY_INSERT [dbo].[Quyen] ON 

INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (1, N'Admin')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (2, N'Nhân viên')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (3, N'Khách hàng')
INSERT [dbo].[Quyen] ([MaQuyen], [TenQuyen]) VALUES (4, N'Chăm sóc khách hàng')
SET IDENTITY_INSERT [dbo].[Quyen] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (1, N'Laptop ASUS ZenBook 145', N'<p>Laptop mỏng nhẹ, hiệu năng mạnh mẽ với bộ vi xử l&yacute; Intel mới nhất.</p>

<p>Th&iacute;ch hợp cho c&ocirc;ng việc v&agrave; giải tr&iacute;.</p>
', CAST(25000000 AS Decimal(18, 0)), CAST(22000000 AS Decimal(18, 0)), N'asus1.png', 1, 6, CAST(N'2024-11-20T22:50:33.930' AS DateTime), 1, 27)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (2, N'Laptop Dell XPS 13', N'<p>Laptop mỏng nhẹ với thiết kế đẹp và hiệu năng vượt trội.</p><p>Thích hợp cho dân văn phòng.</p>', CAST(30000000 AS Decimal(18, 0)), NULL, N'laptop2.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 22)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (3, N'Laptop HP Spectre x360', N'<p>Thiết kế gập 360 độ, đa năng.</p><p>Phù hợp cho những ai cần tính linh hoạt.</p>', CAST(32000000 AS Decimal(18, 0)), NULL, N'hp1.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 3)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (4, N'Laptop ASUS ROG Strix G15', N'<p>Cấu hình gaming cao cấp, đáp ứng mọi nhu cầu chơi game.</p><p>Lý tưởng cho game thủ.</p>', CAST(40000000 AS Decimal(18, 0)), NULL, N'asus2.png', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 11)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (5, N'Laptop Dell Inspiron 15', N'<p>Máy tính xách tay đáng tin cậy với hiệu năng tốt cho học sinh, sinh viên.</p>', CAST(28000000 AS Decimal(18, 0)), NULL, N'laptop3.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 5)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (6, N'Laptop HP Omen 15', N'<p>Gaming laptop mạnh mẽ với thiết kế đẹp và hiệu năng cao.</p><p>Trải nghiệm chơi game tuyệt vời.</p>', CAST(36000000 AS Decimal(18, 0)), CAST(34000000 AS Decimal(18, 0)), N'laptop1.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 15)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (7, N'Laptop ASUS VivoBook 15', N'<p>Laptop đa năng, thiết kế trẻ trung và hiệu năng tốt.</p><p>Phù hợp cho sinh viên.</p>', CAST(22000000 AS Decimal(18, 0)), NULL, N'laptop5.png', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 8)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (8, N'Laptop Dell G5 15', N'<p>Cấu hình gaming tốt với giá cả hợp lý.</p><p>Lựa chọn hoàn hảo cho game thủ mới.</p>', CAST(33000000 AS Decimal(18, 0)), NULL, N'laptop4.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 14)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (9, N'Laptop HP Pavilion 14', N'<p>Laptop mỏng nhẹ, thiết kế hiện đại.</p><p>Phù hợp cho công việc văn phòng.</p>', CAST(25000000 AS Decimal(18, 0)), NULL, N'laptop5.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 15)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (10, N'Laptop ASUS TUF Gaming A15', N'<p>Gaming laptop bền bỉ với hiệu suất vượt trội.</p><p>Trải nghiệm chơi game đỉnh cao.</p>', CAST(35000000 AS Decimal(18, 0)), CAST(33000000 AS Decimal(18, 0)), N'laptop7.png', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 7)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (11, N'Laptop Dell Latitude 5420', N'<p>Laptop doanh nhân với hiệu suất tốt và thiết kế bền bỉ.</p>', CAST(40000000 AS Decimal(18, 0)), NULL, N'laptop7.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 8)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (12, N'Laptop HP EliteBook 840 G7', N'<p>Laptop cao cấp cho doanh nhân với thiết kế sang trọng.</p>', CAST(45000000 AS Decimal(18, 0)), NULL, N'laptop6.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 5)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (13, N'Laptop ASUS Chromebook Flip C434', N'<p>Máy tính xách tay đa năng với thiết kế gập 360 độ.</p>', CAST(20000000 AS Decimal(18, 0)), NULL, N'asus3.jpg', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 12)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (14, N'Laptop Dell XPS 15', N'<p>M&agrave;n h&igrave;nh 15 inch, hiệu suất tuyệt vời cho c&ocirc;ng việc s&aacute;ng tạo.</p>
', CAST(50000000 AS Decimal(18, 0)), NULL, N'dell.jpg', 2, 1, CAST(N'2024-10-14T23:24:13.233' AS DateTime), 1, 2)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (15, N'Laptop HP Envy x360', N'<p>Laptop 2 trong 1 với khả năng gập linh hoạt và hiệu suất tốt.</p>', CAST(30000000 AS Decimal(18, 0)), NULL, N'hp.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 0)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (28, N'Điện thoại Samsung Galaxy Z Fold6 5G 12GB/256GB', N'<p><strong>Galaxy Z&nbsp;Fold</strong>&nbsp;vs&nbsp;<strong>Galaxy Z&nbsp;Flip</strong>&nbsp;l&agrave; d&ograve;ng điện thoại mang xu hướng tương lai với m&agrave;n h&igrave;nh OLED gập dẻo ấn tượng của&nbsp;<a href="https://www.xtmobile.vn/samsung" target="_blank">Samsung</a>. Kh&ocirc;ng những thế, m&aacute;y c&ograve;n c&oacute; hiệu năng ấn tượng thuộc d&ograve;ng flagship để phục vụ mọi nhu cầu giải tr&iacute; hay l&agrave; c&ocirc;ng việc của người d&ugrave;ng.</p>
', CAST(15000000 AS Decimal(18, 0)), NULL, N'samsung-galaxy-z-fold6-xam-thumbn-600x600.jpg', 5, 5, CAST(N'2024-10-26T15:47:47.280' AS DateTime), 1, 10)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (29, N'Điện thoại Iphone', N'<p>Điện thoại Iphone</p>
', CAST(20000000 AS Decimal(18, 0)), NULL, N'iphone-16-pro(3).jpg', 7, 5, CAST(N'2024-11-26T23:32:37.827' AS DateTime), 1, 9)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (30, N'Laptop Acer Gaming Aspire', N'<p>Laptop cấu h&igrave;nh mạnh ph&ugrave; hợp cho chơi game v&agrave; đồ hoạ</p>
', CAST(22000000 AS Decimal(18, 0)), NULL, N'2023_11_1_638344319772930675_acer-gaming-aspire-5-a515-58gm-xam-1.jpg', 8, 1, CAST(N'2024-11-26T23:28:54.227' AS DateTime), 1, 10)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1, N'admin', N'123456', 1, N'Admin', N'TPHCM', N'123456789', N'admin@gmail.com', CAST(N'2024-10-04T20:03:23.867' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (2, N'NV1', N'123456', 4, N'Nhân viên A', N'TPHCM', N'123455678', N'nhanvien1@gmail.com', CAST(N'2024-10-04T20:03:50.780' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (6, N'NV2', N'123456', 2, N'Nhân viên B', N'TPCT', N'111111111', N'nhanvien2@gmail.com', CAST(N'2024-10-06T16:08:25.107' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1014, N'trungnghi01', N'123456', 3, N'Lưu Trung Nghị', N'Ninh Kiều, Cần Thơ', N'0945852696', N'luutrungnghi269@gmail.com', CAST(N'2024-10-16T15:21:31.600' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1015, N'trungnghi02', N'123456', 3, N'Luu Ba Nghi', N'Ninh Kiều, Cần Thơ', N'04125639877', N'luutrungnghi007@gmail.com', CAST(N'2024-10-16T15:22:33.020' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1016, N'NV3', N'123456', 2, N'Nhân viên bán hàng', N'Q. Ninh Kiều, TP. Cần Thơ', N'023666585', N'nhanvien3@gmail.com', CAST(N'2024-10-25T13:31:53.810' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1017, N'trungnghi03', N'123456', 3, N'Luu Nghi', N'Phong Điền Cần Thơ', N'0258963417', N'trungnghi03@gmail.com', CAST(N'2024-10-29T18:39:42.463' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1018, N'trungnghi04', N'123456', 3, N'Trung Nghị 68', N'365 Nguyễn Văn Cừ', N'031759842', N'reinguyen003@gmail.com', CAST(N'2024-11-01T16:49:18.867' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1019, N'trungnghi05', N'123456', 3, N'Tester Nghị', N'365 Nguyễn Văn Cừ', N'0956322222', N'testtt@gmail.com', CAST(N'2024-11-24T17:03:56.797' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1020, N'trungnghi06', N'123456', 3, N'Tester2', N'365 Nguyễn Văn Cừ', N'09563222555', N'trungnghi06@gmail.com', CAST(N'2024-11-24T17:28:20.210' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[Voucher] ON 

INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (1, N'KHUYENMAIMOSHOP', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(N'2024-10-09T00:00:00.000' AS DateTime), 4, 10, 0, N'Mừng ngày đầu tiên khai trương shop')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (2, N'GIAMGIASOC', CAST(5 AS Decimal(18, 0)), CAST(N'2024-10-12T00:00:00.000' AS DateTime), CAST(N'2024-10-13T00:00:00.000' AS DateTime), 0, 10, 0, N'voucher 2')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (3, N'HOTTREND', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-19T00:00:00.000' AS DateTime), CAST(N'2024-10-20T00:00:00.000' AS DateTime), 2, 1, 0, N'OKE')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (4, N'MUNGTET', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-19T00:00:00.000' AS DateTime), CAST(N'2024-10-19T00:00:00.000' AS DateTime), 2, 10, 0, N'kHUYẾN MÃI CỰC SỐC')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (5, N'TESTCOUPON18', CAST(20 AS Decimal(18, 0)), CAST(N'2024-10-18T00:00:00.000' AS DateTime), CAST(N'2024-10-23T00:00:00.000' AS DateTime), 3, 2, 0, N'kHUYẾN MÃI CỰC SỐC')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (6, N'QUOCKHANH', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-18T00:00:00.000' AS DateTime), CAST(N'2024-11-10T00:00:00.000' AS DateTime), 2, 1, 0, N'KHUYẾN MÃI NHÂN DỊP QUỐC KHÁNH')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (7, N'PRENIUM', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-18T00:00:00.000' AS DateTime), CAST(N'2024-10-22T00:00:00.000' AS DateTime), 0, 10, 0, N'SIÊU KHUYẾN MÃI')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (8, N'COUPONMOI', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-18T00:00:00.000' AS DateTime), CAST(N'2024-10-23T00:00:00.000' AS DateTime), 2, 1, 0, N'KHUYEN MAI')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (9, N'ASUSSALE', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-18T00:00:00.000' AS DateTime), CAST(N'2024-10-17T00:00:00.000' AS DateTime), 1, 10, 0, N'ASUSSALE')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (10, N'DNCSALES', CAST(20 AS Decimal(18, 0)), CAST(N'2024-10-16T00:00:00.000' AS DateTime), CAST(N'2024-10-20T00:00:00.000' AS DateTime), 0, 10, 0, N'TESTMA')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (11, N'SIEUSALE', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-24T00:00:00.000' AS DateTime), CAST(N'2024-10-27T00:00:00.000' AS DateTime), 0, 10, 0, N'Giảm giá đặc biệt nhân dịp siêu sale !')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (12, N'TESTMA', CAST(100 AS Decimal(18, 0)), CAST(N'2024-11-15T00:00:00.000' AS DateTime), CAST(N'2024-11-30T00:00:00.000' AS DateTime), 1, 10, 1, N'SIÊU KHUYẾN MÃI')
SET IDENTITY_INSERT [dbo].[Voucher] OFF
GO
ALTER TABLE [dbo].[DanhMucSanPham] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[DanhMucSanPham] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (getdate()) FOR [NgayDatHang]
GO
ALTER TABLE [dbo].[GioHang] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[HangSanPham] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[HangSanPham] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT ((0)) FOR [SoLuongSuDung]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD FOREIGN KEY([MaDonHang])
REFERENCES [dbo].[DonHang] ([MaDonHang])
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietGioHang]  WITH CHECK ADD FOREIGN KEY([MaGioHang])
REFERENCES [dbo].[GioHang] ([MaGioHang])
GO
ALTER TABLE [dbo].[ChiTietGioHang]  WITH CHECK ADD FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhapKho]  WITH CHECK ADD FOREIGN KEY([MaPhieuNhap])
REFERENCES [dbo].[PhieuNhapKho] ([MaPhieuNhap])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhapKho]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietPhieuNhapKho_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhapKho] CHECK CONSTRAINT [FK_ChiTietPhieuNhapKho_SanPham]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([MaVoucher])
REFERENCES [dbo].[Voucher] ([MaVoucher])
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaDanhMuc])
REFERENCES [dbo].[DanhMucSanPham] ([MaDanhMuc])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaHang])
REFERENCES [dbo].[HangSanPham] ([MaHang])
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD FOREIGN KEY([MaQuyen])
REFERENCES [dbo].[Quyen] ([MaQuyen])
GO
