USE [master]
GO
/****** Object:  Database [LaptopStore]    Script Date: 14/10/2024 9:54:55 CH ******/
CREATE DATABASE [LaptopStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LaptopStore', FILENAME = N'D:\Program Files\MSSQL16.MSSQLSERVER\MSSQL\DATA\LaptopStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LaptopStore_log', FILENAME = N'D:\Program Files\MSSQL16.MSSQLSERVER\MSSQL\DATA\LaptopStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LaptopStore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LaptopStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LaptopStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LaptopStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LaptopStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LaptopStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LaptopStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [LaptopStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LaptopStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LaptopStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LaptopStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LaptopStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LaptopStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LaptopStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LaptopStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LaptopStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LaptopStore] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LaptopStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LaptopStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LaptopStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LaptopStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LaptopStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LaptopStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LaptopStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LaptopStore] SET RECOVERY FULL 
GO
ALTER DATABASE [LaptopStore] SET  MULTI_USER 
GO
ALTER DATABASE [LaptopStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LaptopStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LaptopStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LaptopStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LaptopStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LaptopStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LaptopStore', N'ON'
GO
ALTER DATABASE [LaptopStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [LaptopStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LaptopStore]
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 14/10/2024 9:54:55 CH ******/
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
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[ChiTietGioHang]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[ChiTietPhieuNhapKho]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[DanhMucSanPham]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[DonHang]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[GioHang]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[HangSanPham]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[Messages]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[PhieuNhapKho]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[Quyen]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[SanPham]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 14/10/2024 9:54:56 CH ******/
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
/****** Object:  Table [dbo].[Voucher]    Script Date: 14/10/2024 9:54:56 CH ******/
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

INSERT [dbo].[Banner] ([MaBanner], [HinhAnh], [LienKet], [MoTa]) VALUES (1, N'banner1.jpg', N'Index', N'Mô tả cho banner 1')
INSERT [dbo].[Banner] ([MaBanner], [HinhAnh], [LienKet], [MoTa]) VALUES (3, N'banner2.jpg', N'', N'Mô tả cho banner 2')
SET IDENTITY_INSERT [dbo].[Banner] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] ON 

INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (5, 4, 1, 1, CAST(23000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (6, 5, 14, 2, CAST(48000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (7, 6, 15, 1, CAST(30000000 AS Decimal(18, 0)), NULL)
INSERT [dbo].[ChiTietDonHang] ([MaChiTiet], [MaDonHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (8, 7, 13, 1, CAST(20000000 AS Decimal(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietGioHang] ON 

INSERT [dbo].[ChiTietGioHang] ([MaChiTiet], [MaGioHang], [MaSanPham], [SoLuong], [Gia], [GiaMoi]) VALUES (1011, 2, 13, 1, CAST(20000000 AS Decimal(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[ChiTietGioHang] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietPhieuNhapKho] ON 

INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (10, 14, 1, 10, CAST(23000000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (11, 14, 2, 5, CAST(23000000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (12, 15, 1, 5, CAST(23000000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietPhieuNhapKho] ([MaChiTiet], [MaPhieuNhap], [MaSanPham], [SoLuong], [GiaNhap]) VALUES (13, 15, 2, 4, CAST(23000000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[ChiTietPhieuNhapKho] OFF
GO
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] ON 

INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (1, N'Laptop', 1, CAST(N'2024-10-04T19:35:03.260' AS DateTime))
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (2, N'Linh kiện', 1, CAST(N'2024-10-04T19:35:08.977' AS DateTime))
INSERT [dbo].[DanhMucSanPham] ([MaDanhMuc], [TenDanhMuc], [TrangThai], [NgayTao]) VALUES (4, N'Phụ kiện', 1, CAST(N'2024-10-14T20:57:35.970' AS DateTime))
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (4, 4, CAST(N'2024-10-14T20:26:18.203' AS DateTime), CAST(20700000 AS Decimal(18, 0)), 1, N'256/A Bến Tre', N'0915456551', N'Đã Giao')
INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (5, 4, CAST(N'2024-10-14T20:26:18.203' AS DateTime), CAST(96000000 AS Decimal(18, 0)), NULL, N'256/A Bến Tre', N'0915456551', N'Đang chờ xử lý')
INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (6, 7, CAST(N'2024-10-14T20:26:18.203' AS DateTime), CAST(30000000 AS Decimal(18, 0)), NULL, N'abc ho chi minh q1', N'011111111111', N'Đã Duyệt')
INSERT [dbo].[DonHang] ([MaDonHang], [MaTaiKhoan], [NgayDatHang], [TongTien], [MaVoucher], [DiaChiGiaoHang], [SoDienThoai], [TrangThai]) VALUES (7, 4, CAST(N'2024-10-14T21:03:34.080' AS DateTime), CAST(18000000 AS Decimal(18, 0)), 3, N'256/A Bến Tre', N'0915456551', N'Đã Hủy')
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[GioHang] ON 

INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (1, 3, CAST(N'2024-10-04T20:04:49.287' AS DateTime), CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (2, 4, NULL, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[GioHang] ([MaGioHang], [MaTaiKhoan], [NgayTao], [TongTien]) VALUES (3, 7, NULL, CAST(0 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[GioHang] OFF
GO
SET IDENTITY_INSERT [dbo].[HangSanPham] ON 

INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (1, N'ASUS', 1, CAST(N'2024-10-04T19:35:35.627' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (2, N'DELL', 1, CAST(N'2024-10-04T19:35:40.307' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (3, N'HP', 1, CAST(N'2024-10-04T19:35:42.320' AS DateTime))
INSERT [dbo].[HangSanPham] ([MaHang], [TenHang], [TrangThai], [NgayTao]) VALUES (4, N'Lenovo', 1, CAST(N'2024-10-12T12:11:48.837' AS DateTime))
SET IDENTITY_INSERT [dbo].[HangSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (11, 7, 2, N'cho hỏi sản phẩm a còn không', CAST(N'2024-10-06T18:29:31.727' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (12, 2, 7, N'còn nhé bạn', CAST(N'2024-10-06T18:29:46.227' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1011, 4, 2, N'alo', CAST(N'2024-10-08T21:15:22.970' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1012, 2, 4, N'sao ạ', CAST(N'2024-10-08T21:21:40.653' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1026, 4, 2, N'cho mình hỏi sản phẩm b còn không ạ', CAST(N'2024-10-08T22:10:44.303' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1027, 2, 4, N'để mình check trong kho xem sao nhé', CAST(N'2024-10-08T22:11:01.693' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1028, 4, 2, N'oke bạn', CAST(N'2024-10-09T10:31:15.667' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1029, 2, 4, N'vẫn còn nhé bạn', CAST(N'2024-10-09T10:31:29.227' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1030, 5, 2, N'cho mình hỏi sản phẩm laptop asus còn k', CAST(N'2024-10-14T20:56:03.103' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1031, 2, 5, N'để mình check hàng tồn nhé bạn', CAST(N'2024-10-14T20:56:20.480' AS DateTime))
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [Timestamp]) VALUES (1032, 2, 5, N'vẫn còn nhé bạn', CAST(N'2024-10-14T20:56:42.130' AS DateTime))
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuNhapKho] ON 

INSERT [dbo].[PhieuNhapKho] ([MaPhieuNhap], [NgayNhap], [TongTien], [GhiChu]) VALUES (14, CAST(N'2024-10-14T20:48:53.597' AS DateTime), CAST(345000000.00 AS Decimal(18, 2)), N'ok')
INSERT [dbo].[PhieuNhapKho] ([MaPhieuNhap], [NgayNhap], [TongTien], [GhiChu]) VALUES (15, CAST(N'2024-10-14T21:10:31.060' AS DateTime), CAST(207000000.00 AS Decimal(18, 2)), N'ok')
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
', CAST(25000000 AS Decimal(18, 0)), CAST(22000000 AS Decimal(18, 0)), N'asus1.png', 1, 1, CAST(N'2024-10-12T13:22:02.253' AS DateTime), 1, 20)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (2, N'Laptop Dell XPS 13', N'<p>Laptop mỏng nhẹ với thiết kế đẹp và hiệu năng vượt trội.</p><p>Thích hợp cho dân văn phòng.</p>', CAST(30000000 AS Decimal(18, 0)), NULL, N'laptop2.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 19)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (3, N'Laptop HP Spectre x360', N'<p>Thiết kế gập 360 độ, đa năng.</p><p>Phù hợp cho những ai cần tính linh hoạt.</p>', CAST(32000000 AS Decimal(18, 0)), CAST(30000000 AS Decimal(18, 0)), N'hp1.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 3)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (4, N'Laptop ASUS ROG Strix G15', N'<p>Cấu hình gaming cao cấp, đáp ứng mọi nhu cầu chơi game.</p><p>Lý tưởng cho game thủ.</p>', CAST(40000000 AS Decimal(18, 0)), NULL, N'asus2.png', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 2)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (5, N'Laptop Dell Inspiron 15', N'<p>Máy tính xách tay đáng tin cậy với hiệu năng tốt cho học sinh, sinh viên.</p>', CAST(28000000 AS Decimal(18, 0)), NULL, N'laptop3.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 6)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (6, N'Laptop HP Omen 15', N'<p>Gaming laptop mạnh mẽ với thiết kế đẹp và hiệu năng cao.</p><p>Trải nghiệm chơi game tuyệt vời.</p>', CAST(36000000 AS Decimal(18, 0)), CAST(34000000 AS Decimal(18, 0)), N'laptop1.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 7)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (7, N'Laptop ASUS VivoBook 15', N'<p>Laptop đa năng, thiết kế trẻ trung và hiệu năng tốt.</p><p>Phù hợp cho sinh viên.</p>', CAST(22000000 AS Decimal(18, 0)), NULL, N'laptop5.png', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 8)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (8, N'Laptop Dell G5 15', N'<p>Cấu hình gaming tốt với giá cả hợp lý.</p><p>Lựa chọn hoàn hảo cho game thủ mới.</p>', CAST(33000000 AS Decimal(18, 0)), NULL, N'laptop4.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 9)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (9, N'Laptop HP Pavilion 14', N'<p>Laptop mỏng nhẹ, thiết kế hiện đại.</p><p>Phù hợp cho công việc văn phòng.</p>', CAST(25000000 AS Decimal(18, 0)), NULL, N'laptop5.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 10)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (10, N'Laptop ASUS TUF Gaming A15', N'<p>Gaming laptop bền bỉ với hiệu suất vượt trội.</p><p>Trải nghiệm chơi game đỉnh cao.</p>', CAST(35000000 AS Decimal(18, 0)), CAST(33000000 AS Decimal(18, 0)), N'laptop7.png', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 2)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (11, N'Laptop Dell Latitude 5420', N'<p>Laptop doanh nhân với hiệu suất tốt và thiết kế bền bỉ.</p>', CAST(40000000 AS Decimal(18, 0)), NULL, N'laptop7.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (12, N'Laptop HP EliteBook 840 G7', N'<p>Laptop cao cấp cho doanh nhân với thiết kế sang trọng.</p>', CAST(45000000 AS Decimal(18, 0)), NULL, N'laptop6.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 10)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (13, N'Laptop ASUS Chromebook Flip C434', N'<p>Máy tính xách tay đa năng với thiết kế gập 360 độ.</p>', CAST(20000000 AS Decimal(18, 0)), NULL, N'asus3.jpg', 1, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 3)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (14, N'Laptop Dell XPS 15', N'<p>Màn hình 15 inch, hiệu suất tuyệt vời cho công việc sáng tạo.</p>', CAST(50000000 AS Decimal(18, 0)), NULL, N'dell.jpg', 2, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 0)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MoTa], [Gia], [GiaMoi], [HinhAnh], [MaHang], [MaDanhMuc], [NgayTao], [TrangThai], [SoLuong]) VALUES (15, N'Laptop HP Envy x360', N'<p>Laptop 2 trong 1 với khả năng gập linh hoạt và hiệu suất tốt.</p>', CAST(30000000 AS Decimal(18, 0)), NULL, N'hp.jpg', 3, 1, CAST(N'2024-10-04T19:58:29.050' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1, N'admin', N'123456', 1, N'Admin', N'TPHCM', N'123456789', N'admin@gmail.com', CAST(N'2024-10-04T20:03:23.867' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (2, N'NV1', N'123456', 4, N'Nhân viên A', N'TPHCM', N'123455678', N'nhanvien1@gmail.com', CAST(N'2024-10-04T20:03:50.780' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (3, N'khachhang1', N'123456', 3, N'Khách hàng A', N'Bà rịa', N'123466111', N'khach@gmail.com', CAST(N'2024-10-04T20:04:19.923' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (4, N'trandangduc0', N'239596', 3, N'test1', N'256/A Bến Tre', N'0915456551', N'thanhtroll0915@gmail.com', CAST(N'2024-10-06T12:59:59.493' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (5, N'test123', N'123', 3, N'test123', N'256/A Bến Tre 2', N'1234567890', N'test@gmail.com', CAST(N'2024-10-06T13:49:47.503' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (6, N'NV2', N'123456', 2, N'Nhân viên B', N'TPHCM', N'111111111', N'nhanvien2@gmail.com', CAST(N'2024-10-06T16:08:25.107' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (7, N'khachabc', N'1234', 3, N'khachabc', N'abc ho chi minh q1', N'011111111111', N'khachabc@gmail.com', CAST(N'2024-10-06T18:27:51.777' AS DateTime), 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1007, N'test', N'123', 4, N'test', N'256/A Bến Tre', N'0915456552', N'test1@gmail.com', CAST(N'2024-10-06T18:27:51.777' AS DateTime), 0)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [Username], [Password], [MaQuyen], [HoTen], [DiaChi], [SoDienThoai], [Email], [NgayTao], [TrangThai]) VALUES (1008, N'nv3', N'123', 2, N'nv3', N'256/A Bến Tre', N'0915456553', N'testnv3@gmail.com', CAST(N'2024-10-14T21:01:14.677' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[Voucher] ON 

INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (1, N'KHUYENMAIMOSHOP', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(N'2024-10-09T00:00:00.000' AS DateTime), 4, 10, 1, N'Mừng ngày đầu tiên khai trương shop')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (2, N'TEST', CAST(5 AS Decimal(18, 0)), CAST(N'2024-10-12T00:00:00.000' AS DateTime), CAST(N'2024-10-13T00:00:00.000' AS DateTime), 0, 10, 1, N'voucher 2')
INSERT [dbo].[Voucher] ([MaVoucher], [Code], [GiamGia], [NgayBatDau], [NgayKetThuc], [SoLuongSuDung], [SoLuongSuDungToiDa], [TrangThai], [MoTa]) VALUES (3, N'MUNGLE14/10', CAST(10 AS Decimal(18, 0)), CAST(N'2024-10-14T00:00:00.000' AS DateTime), CAST(N'2024-10-15T00:00:00.000' AS DateTime), 1, 1, 1, N'OKE')
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
USE [master]
GO
ALTER DATABASE [LaptopStore] SET  READ_WRITE 
GO
