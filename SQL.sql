USE [master]
GO
/****** Object:  Database [Restoran]    Script Date: 12/3/2024 1:14:21 PM ******/
CREATE DATABASE [Restoran]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Restoran', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Restoran.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Restoran_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Restoran_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Restoran] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Restoran].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Restoran] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Restoran] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Restoran] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Restoran] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Restoran] SET ARITHABORT OFF 
GO
ALTER DATABASE [Restoran] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Restoran] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Restoran] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Restoran] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Restoran] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Restoran] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Restoran] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Restoran] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Restoran] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Restoran] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Restoran] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Restoran] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Restoran] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Restoran] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Restoran] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Restoran] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Restoran] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Restoran] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Restoran] SET  MULTI_USER 
GO
ALTER DATABASE [Restoran] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Restoran] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Restoran] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Restoran] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Restoran] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Restoran] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Restoran] SET QUERY_STORE = ON
GO
ALTER DATABASE [Restoran] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Restoran]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartCode] [varchar](32) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[cart_item_id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[Icon] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Position] [nvarchar](100) NOT NULL,
	[Description] [text] NULL,
	[Images] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[MemberId] [varchar](32) NOT NULL,
	[GivenName] [nvarchar](16) NOT NULL,
	[Surname] [nvarchar](32) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Email] [varchar](64) NOT NULL,
	[Password] [varchar](128) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Role] [varchar](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menus]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menus](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Country] [nvarchar](100) NOT NULL,
	[State] [nvarchar](100) NOT NULL,
	[Note] [nvarchar](500) NULL,
	[City] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [text] NULL,
	[price] [decimal](18, 2) NOT NULL,
	[Images] [nvarchar](max) NULL,
	[MenuId] [int] NULL,
	[CreateAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[Icon] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamId] [int] IDENTITY(1,1) NOT NULL,
	[Images] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Position] [nvarchar](100) NOT NULL,
	[Icon] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VnPay]    Script Date: 12/3/2024 1:14:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VnPay](
	[Amount] [bigint] NOT NULL,
	[BankCode] [varchar](32) NOT NULL,
	[BankTranNo] [varchar](32) NOT NULL,
	[CardType] [varchar](32) NOT NULL,
	[OrderInfo] [varchar](128) NOT NULL,
	[PayDate] [varchar](32) NOT NULL,
	[ResponseCode] [varchar](32) NOT NULL,
	[TmnCode] [varchar](32) NOT NULL,
	[TransactionNo] [varchar](32) NOT NULL,
	[TransactionStatus] [varchar](32) NOT NULL,
	[TxnRef] [varchar](32) NOT NULL,
	[SecureHash] [varchar](1024) NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([cart_id], [MemberId]) VALUES (5, N'bd6bd1e008a94e86b82902b7856b545a')
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([ClientId], [Icon], [Name], [Position], [Description], [Images]) VALUES (1, N'fa fa-quote-left', N'Khanh Huynh', N'New Profession', N'Bao Khanh Huynh', N'testimonial-1.jpg')
INSERT [dbo].[Client] ([ClientId], [Icon], [Name], [Position], [Description], [Images]) VALUES (15, N'fa fa-quote-left', N'Client Name', N'Profession', N'Dolor et eos labore, stet justo sed est sed. Diam sed sed dolor stet amet eirmod eos labore diam', N'testimonial-2.jpg')
INSERT [dbo].[Client] ([ClientId], [Icon], [Name], [Position], [Description], [Images]) VALUES (16, N'fa fa-quote-left', N'Client Name', N'Profession', N'Dolor et eos labore, stet justo sed est sed. Diam sed sed dolor stet amet eirmod eos labore diam', N'testimonial-3.jpg')
INSERT [dbo].[Client] ([ClientId], [Icon], [Name], [Position], [Description], [Images]) VALUES (17, N'fa fa-quote-left', N'Client Name', N'Profession', N'Dolor et eos labore, stet justo sed est sed. Diam sed sed dolor stet amet eirmod eos labore diam', N'testimonial-4.jpg')
INSERT [dbo].[Client] ([ClientId], [Icon], [Name], [Position], [Description], [Images]) VALUES (22, N'fa fa-quote-left', N'bao khanh huynh', N'khanh12@gmail.com', N'yummy', N'testimonial-1.jpg')
INSERT [dbo].[Client] ([ClientId], [Icon], [Name], [Position], [Description], [Images]) VALUES (23, N'fa fa-quote-left', N'khanh huynh', N'Admin@gmail.com', N'ko note', N'testimonial-1.jpg')
INSERT [dbo].[Client] ([ClientId], [Icon], [Name], [Position], [Description], [Images]) VALUES (24, N'fa fa-quote-left', N'bao khanh huynh ngoc', N'khanh@gmail.com', N'ko note', N'testimonial-1.jpg')
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
INSERT [dbo].[Member] ([MemberId], [GivenName], [Surname], [Name], [Email], [Password], [CreatedDate], [Role]) VALUES (N'078d6fd47bb5497c99d6afe0b346a2e5', N'Tran anh b', N'B', N'anh ', N'anhb@gmail.com', N'3C9909AFEC25354D551DAE21590BB26E38D53F2173B8D3DC3EEE4C047E7AB1C1EB8B85103E3BE7BA613B31BB5C9C36214DC9F14A42FD7A2FDB84856BCA5C44C2', CAST(N'2024-11-24T17:30:27.097' AS DateTime), N'Customer')
INSERT [dbo].[Member] ([MemberId], [GivenName], [Surname], [Name], [Email], [Password], [CreatedDate], [Role]) VALUES (N'1', N'Bao Khanh', N'Huynh', N'BKH', N'bkh@123.123', N'123123', CAST(N'2024-11-16T16:52:31.480' AS DateTime), N'Customer')
INSERT [dbo].[Member] ([MemberId], [GivenName], [Surname], [Name], [Email], [Password], [CreatedDate], [Role]) VALUES (N'112930714047161982111', N'Huỳnh Ngọc Bảo', N'Khánh', N'Huỳnh Ngọc Bảo Khánh', N'hnbaokhanh.527@gmail.com', N'2E20F8DAA33F8ECE459A756AE78C38260DF7AED319563368C0B81AE4E10BA30D99045132A00F5C86EFB0C70859A907E7379B2EA4F53DF088AD9D431BDCC83312', CAST(N'2024-11-24T00:01:24.273' AS DateTime), N'Customer')
INSERT [dbo].[Member] ([MemberId], [GivenName], [Surname], [Name], [Email], [Password], [CreatedDate], [Role]) VALUES (N'2', N'Thanh Truc', N'Nguyen', N'Nguyen Thanh Truc', N'thanhtruc@mail123', N'B40D03386FB8FD7DC6CA9C6F8D680DFC58D60FD6EA72C63F573CC5BFBB09695746A849C91517C235CDFEACA4E734208F184BC08AAE06797748988E95928F80B1', CAST(N'2024-11-19T19:08:45.673' AS DateTime), N'Customer')
INSERT [dbo].[Member] ([MemberId], [GivenName], [Surname], [Name], [Email], [Password], [CreatedDate], [Role]) VALUES (N'3', N'Van Chuong', N'Nguyen', N'Chuong', N'Chuongnguyen@gmail.com', N'B40D03386FB8FD7DC6CA9C6F8D680DFC58D60FD6EA72C63F573CC5BFBB09695746A849C91517C235CDFEACA4E734208F184BC08AAE06797748988E95928F80B1', CAST(N'2024-11-16T17:09:03.330' AS DateTime), N'Customer')
GO
SET IDENTITY_INSERT [dbo].[Menus] ON 

INSERT [dbo].[Menus] ([MenuId], [name]) VALUES (3, N'Breakfast')
INSERT [dbo].[Menus] ([MenuId], [name]) VALUES (1005, N'Launch')
INSERT [dbo].[Menus] ([MenuId], [name]) VALUES (1006, N'Dinner')
SET IDENTITY_INSERT [dbo].[Menus] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (3, 8, 1015, 1, CAST(750.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (4, 9, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (5, 10, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (6, 11, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (7, 12, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (8, 13, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (9, 14, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (10, 15, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (11, 16, 1018, 1, CAST(440.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (12, 17, 1018, 1, CAST(440.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (13, 18, 1018, 1, CAST(440.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (14, 19, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (15, 20, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (16, 20, 1021, 1, CAST(510.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (17, 21, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (18, 21, 1021, 1, CAST(510.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (19, 22, 1014, 1, CAST(340.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (20, 23, 1013, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (21, 24, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (22, 25, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (23, 26, 1016, 1, CAST(620.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (24, 27, 1016, 1, CAST(620.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (25, 28, 1016, 1, CAST(620.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (26, 29, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (27, 30, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (28, 31, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (29, 32, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (30, 33, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (31, 34, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (32, 35, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (33, 36, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (34, 37, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (35, 38, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (36, 39, 1018, 1, CAST(440.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (37, 40, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (38, 41, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (39, 41, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (40, 42, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (41, 42, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (42, 43, 1010, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (43, 43, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (44, 44, 1013, 1, CAST(380.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (45, 45, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (46, 46, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (47, 47, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (48, 48, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (49, 49, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (50, 49, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (51, 50, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (52, 51, 6, 1, CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (53, 52, 1019, 1, CAST(670.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (54, 55, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (55, 56, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (56, 57, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (57, 58, 1013, 1, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (58, 59, 1013, 1, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (59, 61, 6, 1, CAST(210000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (60, 62, 6, 1, CAST(210000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (61, 63, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (62, 64, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (63, 65, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (64, 66, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (65, 68, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (66, 69, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (67, 70, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (68, 71, 1010, 2, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (69, 72, 1010, 2, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (70, 73, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (71, 73, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (72, 74, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (73, 74, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (74, 75, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (75, 76, 1013, 1, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (76, 77, 1013, 1, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (77, 78, 1013, 1, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (78, 79, 1018, 1, CAST(440000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (79, 80, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (80, 81, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (81, 82, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (82, 83, 1015, 1, CAST(750000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (83, 84, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (84, 85, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (85, 86, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (86, 86, 1015, 1, CAST(750000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (87, 87, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (88, 87, 1015, 1, CAST(750000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (89, 87, 1013, 1, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (90, 87, 1016, 1, CAST(620000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (91, 88, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (92, 89, 1013, 1, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (93, 90, 1019, 1, CAST(670000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (94, 91, 1010, 1, CAST(380000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (95, 92, 1013, 2, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (96, 93, 1013, 2, CAST(280000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [quantity], [price]) VALUES (97, 94, 1016, 1, CAST(620000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (1, 0, CAST(670.00 AS Decimal(18, 2)), N'afaf', N'afaf', N'gagga', N'hsjks', N'jjll', N'dafga', N'ssgh', N'hagav', N'afafa', CAST(N'2024-11-21T14:59:36.110' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (2, 0, CAST(680.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'sggsgs', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T15:01:28.980' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (3, 0, CAST(660.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'ssggs', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T15:07:10.897' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (4, 0, CAST(750.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', NULL, N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T15:11:20.690' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (5, 0, CAST(750.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', NULL, N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T15:12:00.680' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (6, 0, CAST(380.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', NULL, N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T15:12:59.340' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (7, 0, CAST(380.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', NULL, N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T15:13:33.440' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (8, 0, CAST(750.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', NULL, N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T15:15:50.307' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (9, 0, CAST(250.00 AS Decimal(18, 2)), N'khanh', N'huynh', N'123ABC', N'Vietnam', N'Quan 10', N'adaghs', N'Ho Chi Minh', N'0788913311', N'hnbaokhanh', CAST(N'2024-11-21T15:21:46.423' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (10, 0, CAST(670.00 AS Decimal(18, 2)), N'khanh', N'huynh', N'123ABC', N'Vietnam', N'Quan 10', N'adaghs', N'Ho Chi Minh', N'0788913311', N'hnbaokhanh', CAST(N'2024-11-21T15:22:08.540' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (11, 0, CAST(670.00 AS Decimal(18, 2)), N'dhjsg', N'huynh', N'123ABC', N'Vietnam', N'Quan 10', N'adaa', N'Ho Chi Minh', N'0788913311', N'hnbaokhanh', CAST(N'2024-11-21T15:27:08.037' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (12, 0, CAST(670.00 AS Decimal(18, 2)), N'dhjsg', N'huynh', N'123ABC', N'Vietnam', N'Quan 10', N'sssdd', N'Ho Chi Minh', N'0788913311', N'hnbaokhanh', CAST(N'2024-11-21T15:30:24.403' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (13, 0, CAST(670.00 AS Decimal(18, 2)), N'dhjsg', N'huynh', N'123ABC', N'Vietnam', N'Quan 10', N'sssdd', N'Ho Chi Minh', N'0788913311', N'hnbaokhanh', CAST(N'2024-11-21T15:30:37.167' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (14, 0, CAST(670.00 AS Decimal(18, 2)), N'dhjsg', N'huynh', N'123ABC', N'Vietnam', N'Quan 10', N'sad', N'Ho Chi Minh', N'0788913311', N'hnbaokhanh', CAST(N'2024-11-21T15:57:36.313' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (15, 0, CAST(670.00 AS Decimal(18, 2)), N'dhjsg', N'huynh', N'123ABC', N'Vietnam', N'Quan 10', N'adaddada', N'Ho Chi Minh', N'0788913311', N'hnbaokhanh', CAST(N'2024-11-21T16:03:21.990' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (16, 0, CAST(440.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'khanhhhh', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T16:39:32.563' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (17, 0, CAST(440.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'khanhhhh', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T16:39:38.603' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (18, 0, CAST(440.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'khanhhhh', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T16:39:51.800' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (19, 0, CAST(670.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'adaa', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T17:13:52.130' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (20, 0, CAST(1180.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'áaaaaasss', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T19:13:31.470' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (21, 0, CAST(1180.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'áaaaaasss', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T19:13:45.267' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (22, 0, CAST(340.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'asd', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T19:15:45.860' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (23, 0, CAST(380.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'adđ', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-21T19:17:07.927' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (24, 0, CAST(670.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'ass', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T19:25:04.493' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (25, 0, CAST(670.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'ass', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-21T19:25:10.920' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (26, 0, CAST(620.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'asaaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T09:59:01.557' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (27, 0, CAST(620.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'asaaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T09:59:39.147' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (28, 0, CAST(620.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'asaaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:00:10.027' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (29, 0, CAST(670.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'asaaaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:03:12.323' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (30, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:04:58.747' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (31, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:05:25.967' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (32, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:06:54.287' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (33, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:07:05.053' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (34, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:07:19.270' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (35, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:12:10.313' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (36, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:12:47.893' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (37, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'sd', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:13:34.967' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (38, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'sd', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:14:50.040' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (39, 0, CAST(440.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:21:58.317' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (40, 0, CAST(380.00 AS Decimal(18, 2)), N'sahadb', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:31:25.540' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (41, 0, CAST(100380.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'asa', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T10:35:00.163' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (42, 0, CAST(100380.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', NULL, N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T10:37:43.713' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (43, 0, CAST(100380.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', NULL, N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T10:43:12.043' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (44, 0, CAST(380.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'adss', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:55:28.407' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (45, 0, CAST(100000.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'adada', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T10:56:50.517' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (46, 0, CAST(100000.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', NULL, N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T11:17:52.567' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (47, 0, CAST(100000.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'as', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T11:21:55.650' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (48, 0, CAST(100000.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'asaaa', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T11:24:40.953' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (49, 0, CAST(100670.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'asaaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T11:27:16.667' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (50, 0, CAST(100000.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'assss', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T11:38:40.927' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (51, 0, CAST(100000.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'assss', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T11:39:56.013' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (52, 0, CAST(670.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'assasa', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T12:17:08.037' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (55, 0, CAST(670000.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'aada', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T12:37:39.403' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (56, 0, CAST(670000.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'adadaaaaa', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T12:44:00.743' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (57, 0, CAST(670000.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'adadaaaaa', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-22T12:54:57.557' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (58, 0, CAST(280000.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'đaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T13:21:01.027' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (59, 0, CAST(280000.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'đaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T13:21:13.290' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (60, 0, CAST(280000.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'đaa', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-22T13:22:52.957' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (61, 0, CAST(210000.00 AS Decimal(18, 2)), N'van', N'minh', N'123as', N'Viet nam', N'q11', NULL, N'travinh', N'0788912212', N'vanminh@gmail.com', CAST(N'2024-11-22T19:42:13.533' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (62, 0, CAST(210000.00 AS Decimal(18, 2)), N'van', N'minh', N'123as', N'Viet nam', N'q11', NULL, N'travinh', N'0788912212', N'vanminh@gmail.com', CAST(N'2024-11-22T19:47:34.640' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (63, 0, CAST(380000.00 AS Decimal(18, 2)), N'Khánh', N'Huỳnh Ngọc Bảo', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'de', N'ass', N'Las Vegas', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-23T13:12:42.987' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (64, 0, CAST(670000.00 AS Decimal(18, 2)), N'khanh', N'huynh', N'124 ho chi minh', N'Vietnam', N'viet nam', N'asss', N'ho chi minh', N'0795927927', N'Admin@gmail.com', CAST(N'2024-11-23T14:16:01.917' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (65, 0, CAST(670000.00 AS Decimal(18, 2)), N'khanh', N'huynh', N'124 ho chi minh', N'Vietnam', N'viet nam', N'asss', N'ho chi minh', N'0795927927', N'Admin@gmail.com', CAST(N'2024-11-23T14:16:53.677' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (66, 0, CAST(670000.00 AS Decimal(18, 2)), N'khanh', N'huynh', N'124 ho chi minh', N'Vietnam', N'viet nam', N'asss', N'ho chi minh', N'0795927927', N'Admin@gmail.com', CAST(N'2024-11-23T14:16:57.480' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (68, 0, CAST(380000.00 AS Decimal(18, 2)), N'khanh', N'huynh', N'124 ho chi minh', N'Vietnam', N'viet nam', N'ggg', N'ho chi minh', N'0795927927', N'Admin@gmail.com', CAST(N'2024-11-23T14:30:21.837' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (69, 0, CAST(380000.00 AS Decimal(18, 2)), N'khanh', N'huynh', N'124 ho chi minh', N'Vietnam', N'viet nam', N'ggg', N'ho chi minh', N'0795927927', N'Admin@gmail.com', CAST(N'2024-11-23T14:30:30.960' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (70, 0, CAST(380000.00 AS Decimal(18, 2)), N'Hoang1', N'Hoang1', N'Hoang1', N'Hoang1', N'Hoang1', N'Hoang1', N'Hoang1', N'Hoang1', N'Hoang1', CAST(N'2024-11-23T22:08:57.210' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (71, 0, CAST(760000.00 AS Decimal(18, 2)), N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', CAST(N'2024-11-23T22:13:18.743' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (72, 0, CAST(760000.00 AS Decimal(18, 2)), N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', N'Hoang2', CAST(N'2024-11-23T22:13:25.550' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (73, 0, CAST(1050000.00 AS Decimal(18, 2)), N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'emx@gmail.com', CAST(N'2024-11-23T22:45:04.227' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (74, 0, CAST(1050000.00 AS Decimal(18, 2)), N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'Hoang3', N'emx@gmail.com', CAST(N'2024-11-23T22:45:17.910' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (75, 0, CAST(670000.00 AS Decimal(18, 2)), N'khanh', N'Bao Huynh', N'124 an nhon', N'Viet Nam', N'Go Vap', N'khong note', N'ho chi minh', N'0795928927', N'hnbaokhanh.527@gmail.com', CAST(N'2024-11-23T22:50:23.863' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (76, 0, CAST(280000.00 AS Decimal(18, 2)), N'Thanh', N'Nhan', N'124 Go Vap', N'VietNam', N'GoVap', N'khong note', N'hcm', N'0795928126', N'hnbaokhanh@gmail.com', CAST(N'2024-11-23T23:55:22.763' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (77, 0, CAST(280000.00 AS Decimal(18, 2)), N'huynh ngoc', N'bao khanh', N'Thanh Pho Ho Chi Minh', N'Vietnam', N'Quan 10', N'as', N'Ho Chi Minh', N'0795928927', N'1050070038@sv.hcmunre.edu.vn', CAST(N'2024-11-24T00:22:44.973' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (78, 0, CAST(280000.00 AS Decimal(18, 2)), N'huynh bao  ngoc', N'bao huynh khanh', N'Ho Chi Minh', N'Vietnamm', N'Quan 11', N'á', N'Ho Chi Minhh', N'0795928928', N'1050070000@sv.hcmunre.edu.vn', CAST(N'2024-11-24T00:23:27.930' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (79, 0, CAST(440000.00 AS Decimal(18, 2)), N'anh', N'the', N' Ho Chi Minh', N'Viet nam', N'Quan 3', N'ko note', N'TP. Ho Chi Minh', N'0795928999', N'anhthe@sv.hcmunre.edu.vn', CAST(N'2024-11-24T15:49:32.203' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (80, 0, CAST(380000.00 AS Decimal(18, 2)), N'khanh1', N'khanh1', N'1234AS', N'Vietnam', N'Quan 10', N'asdds', N'Ho ChiMinh', N'0788922211', N'khanhbg@gmail.com', CAST(N'2024-11-24T20:40:49.963' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (81, 0, CAST(380000.00 AS Decimal(18, 2)), N'khanh12', N'khanh12', N'1234ASaa', N'Vietnams', N'Quan 100', N'asddsas', N'Ho ChiMinhs', N'07889222112', N'khanhbasg@gmail.com', CAST(N'2024-11-24T20:41:22.870' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (82, 0, CAST(380000.00 AS Decimal(18, 2)), N'truc', N'khanh12', N'1234ASaa', N'Vietnams', N'Quan 100', N'Nguyen ', N'Ho ChiMinhs', N'1234ASaa', N'khanhbasg@gmail.com', CAST(N'2024-11-24T20:44:11.780' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (83, 0, CAST(750000.00 AS Decimal(18, 2)), N'truc', N'khanh12', N'1234ASaa', N'Vietnams', N'Quan 100', NULL, N'Ho ChiMinhs', N'1234ASaa', N'khanhbasg@gmail.com', CAST(N'2024-11-24T20:47:39.213' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (84, 0, CAST(380000.00 AS Decimal(18, 2)), N'truc', N'khanh12', N'1234ASaa', N'Vietnams', N'Quan 100', N'Note', N'Ho ChiMinhs', N'1234ASaa', N'khanhbasg@gmail.com', CAST(N'2024-11-24T20:50:42.817' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (85, 0, CAST(380000.00 AS Decimal(18, 2)), N'truc', N'khanh12', N'1234ASaa', N'Vietnams', N'Quan 100', N'Not', N'Ho ChiMinhs', N'1234ASaa', N'khanhbasg@gmail.com', CAST(N'2024-11-24T20:56:00.370' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (86, 0, CAST(1130000.00 AS Decimal(18, 2)), N'Khánh1', N'Huỳnh Ngọc Bảo1', N'Thanh Pho Ho Chi Minh1', N'Vietnam1', N'de1', N'asq', N'Las Vegas1', N'07959289271', N'hnbaokhanh.1527@gmail.com', CAST(N'2024-11-24T20:57:24.683' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (87, 0, CAST(2030000.00 AS Decimal(18, 2)), N'nguyen', N' van a', N'123aaqqd', N'Vietnam1', N'Quan 12', N'ko note', N'Ho Chi Minh1', N'079599297', N'vana@gmail.com', CAST(N'2024-11-24T21:03:50.497' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (88, 0, CAST(670000.00 AS Decimal(18, 2)), N'Thanh', N'Nhan Thach', N'123 Thu Duc', N'VN', N'Q11', N'Ko note', N'HCM', N'078871115', N'ThanhNhan@gmail.com', CAST(N'2024-11-24T23:45:39.043' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (89, 0, CAST(280000.00 AS Decimal(18, 2)), N'k', N'khanh', N'123a', N'vietnam', N'q10', N'ko', N'hcm', N'012345678', N'baokhanh@gmail.com', CAST(N'2024-11-25T08:13:35.570' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (90, 0, CAST(670000.00 AS Decimal(18, 2)), N'khanh1', N'huynh2', N'124 ho chi minh2', N'Vietnam2', N'viet nam2', N'ko note', N'ho chi minh2', N'07959279272', N'Admin2@gmail.com', CAST(N'2024-11-25T09:56:19.563' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (91, 0, CAST(380000.00 AS Decimal(18, 2)), N'khanh1', N'khanh1', N'Thanh Pho Ho Chi Minh1', N'Vietnam1', N'q11', N'ko ', N'Las Vegas1', N'khanh1', N'khanh1@gmail.com', CAST(N'2024-11-25T10:05:44.873' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (92, 0, CAST(560000.00 AS Decimal(18, 2)), N'Ngoc', N'huynh', N'987 Thu Duc', N'vietnam', N'q2', N'ko note', N'hcm', N'077889911', N'ngochuynh@gmail.com', CAST(N'2024-11-25T16:52:46.823' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (93, 0, CAST(560000.00 AS Decimal(18, 2)), N'Ngoc', N'huynh', N'987 Thu Duc', N'vietnam', N'q2', N'ko note', N'hcm', N'077889911', N'ngochuynh@gmail.com', CAST(N'2024-11-25T16:53:23.287' AS DateTime), 0)
INSERT [dbo].[Orders] ([OrderId], [MemberId], [TotalAmount], [FirstName], [LastName], [Address], [Country], [State], [Note], [City], [Phone], [Email], [OrderDate], [Status]) VALUES (94, 0, CAST(620000.00 AS Decimal(18, 2)), N'aq1', N'bk1', N'bk1', N'bk1', N'bk1', N'bk1', N'bk1', N'bk1', N'bk1@gmail.com', CAST(N'2024-11-26T20:15:39.710' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (6, N'Pasta-Spagheti', N'Long, thin noodles, often served with sauces like tomato or cream for a classic Italian dish.', CAST(210000.00 AS Decimal(18, 2)), N'/images/Spaghetti-5.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1009, N'Beef Steaks', N' Cuts of beef, like ribeye or sirloin, cooked by grilling or searing for rich, juicy flavo', CAST(430000.00 AS Decimal(18, 2)), N'/images/menu-8.jpg', 1006, CAST(N'2024-10-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1010, N'Pizza', N'Flatbread topped with sauce, cheese, and various toppings, baked to perfection', CAST(380000.00 AS Decimal(18, 2)), N'/images/menu-7.jpg', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1011, N'Salad', N'Salad is a mix of fresh ingredients, often vegetables or fruits, served with dressing', CAST(250000.00 AS Decimal(18, 2)), N'/images/cach-lam-salad-ca-ngu-dai-duong.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1012, N'Stamppot ', N' Potatoes with vegetables like kale, carrots, or sauerkraut, often served with sausage', CAST(210000.00 AS Decimal(18, 2)), N'/images/Stamppot-1.png', 1005, CAST(N'2024-01-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1013, N'Crispy Fries', N'Made with golden, crunchy potato strips, fried to perfection', CAST(280000.00 AS Decimal(18, 2)), N'/images/menu-2.jpg', 3, CAST(N'2024-02-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1014, N'Wiener Schnitzel', N' Breaded and fried veal or pork cutlet, often served with lemon and potatoes', CAST(340000.00 AS Decimal(18, 2)), N'/images/Wiener-Schnitzel-2.png', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1015, N'Bosch Soup', N'Beet-based soup with cabbage, potatoes, and sometimes meat', CAST(750000.00 AS Decimal(18, 2)), N'/images/Bosch-Soup-1.png', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1016, N'Pierogi', N'Various ingredients like potatoes, cheese, meat, or fruit, then boiled or fried', CAST(620000.00 AS Decimal(18, 2)), N'/images/Pierogi-2.png', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1017, N'Goulash', N'Typically made with beef, vegetables, and paprika, often served with bread or noodles', CAST(680000.00 AS Decimal(18, 2)), N'/images/Goulash-3.png', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1018, N'Bruschetta', N'Toasted bread topped with a mixture of tomatoes, garlic, basil, and olive oil', CAST(440000.00 AS Decimal(18, 2)), N'/images/cac-mon-an-chinh-cua-nguoi-chau-au-06-min-1024x682.jpg', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1019, N'Carbonnade Flamande', N'Cook made beer, onions, and mustard, often served with fries or bread', CAST(670000.00 AS Decimal(18, 2)), N'/images/cac-mon-an-chinh-cua-nguoi-chau-au-08-min-1024x767.jpg', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1021, N'Quinoa', N'Gluten-free seed like a grain, often used in salads, bowls, or as a side dish', CAST(500000.00 AS Decimal(18, 2)), N'/images/cac-mon-an-sang-chau-au-ban-nhat-dinh-phai-thu-am_thuc_chau_au_4.jpg', 3, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1022, N'Set Sashimi ', N'Japanese delicacy consisting of thinly sliced raw fish or seafood, served without rice', CAST(690000.00 AS Decimal(18, 2)), N'/images/sushi_plate_250.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1023, N'Luxury Sashimi', N'Paired with exclusive sake or champagne, luxury sashimi culinary experience.', CAST(990000.00 AS Decimal(18, 2)), N'/images/20150811162700_55ca76b497f33.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1024, N'Pre Sashimi', N'Premium sashimi features the highest-quality, freshest seafood, fatty tuna (otoro), king salmon, Hokkaido scallops, or amberjack', CAST(1100000.00 AS Decimal(18, 2)), N'/images/OIP.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1025, N' Premium Omakase', N'The focus is on high-quality begins with delicate appetizers and progresses to luxurious sushi and sashimi', CAST(3300000.00 AS Decimal(18, 2)), N'/images/omakashe.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1026, N'Grand Vales', N'A gold-flaked tortilla filled with Kobe beef, Langoustine lobster, black Brie cheese, Beluga Almas caviar', CAST(630000.00 AS Decimal(18, 2)), N'/images/taco-800x450.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1027, N'Beef Pie', N'Wagyu beef, black truffle, matsutake mushrooms, and Chateau Mouton Rothschild wine', CAST(710000.00 AS Decimal(18, 2)), N'/images/banhbo.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1028, N' Fleur Burger', N' Kobe beef, black truffles, foie gras, and a rich truffle sauce. It’s served with a glass of Chateau Petrus', CAST(520000.00 AS Decimal(18, 2)), N'/images/bủger.jpg', 1006, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1029, N'Caldo Verde', N'Finely sliced kale or collard greens, potatoes, olive oil, garlic, and slices of (Portuguese sausage).', CAST(750000.00 AS Decimal(18, 2)), N'/images/trua1.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1031, N'Doner Kebab', N'Marinated meat, typically lamb, chicken, or beef, cooked on a vertical rotisserie.', CAST(290000.00 AS Decimal(18, 2)), N'/images/trua2.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1032, N'Garlic soup', N'Pork fat, and crispy pork cracklings, enhanced by the distinct taste of marjoram.', CAST(440000.00 AS Decimal(18, 2)), N'/images/trua3.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1033, N'Roast turkey', N'It is marinated with ginger, sliced onions, red wine, and spices for flavor', CAST(520000.00 AS Decimal(18, 2)), N'/images/trua4.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1034, N'Rosti', N'Side dish, and is a staple in Swiss cuisine and beyond beloved for its crunchy exterior', CAST(380000.00 AS Decimal(18, 2)), N'/images/trua5.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1035, N'Duck l''Orange,', N'The dish features tender, seared duck breast paired with a tangy, slightly sweet orange sauce.', CAST(590000.00 AS Decimal(18, 2)), N'/images/trua7.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
INSERT [dbo].[Products] ([ProductId], [name], [description], [price], [Images], [MenuId], [CreateAt]) VALUES (1036, N'Escargot', N' Beyond its culinary appeal, escargot is also believed to have health benefits', CAST(220000.00 AS Decimal(18, 2)), N'/images/trua.jpg', 1005, CAST(N'2024-11-21T14:59:36.110' AS DateTime))
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([ServiceId], [Icon], [Name], [Description]) VALUES (1, N'fa fa-3x fa-user-tie', N'Master Chefs', N'qweqwewqeqweqweqw')
INSERT [dbo].[Service] ([ServiceId], [Icon], [Name], [Description]) VALUES (2, N'fa fa-3x fa-utensils', N'Quality Food', N'Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam')
INSERT [dbo].[Service] ([ServiceId], [Icon], [Name], [Description]) VALUES (3, N'fa fa-3x fa-cart-plus', N'Online Order', N'Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam')
INSERT [dbo].[Service] ([ServiceId], [Icon], [Name], [Description]) VALUES (4, N'fa fa-3x fa-headset', N'24/7 Service', N'Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam')
SET IDENTITY_INSERT [dbo].[Service] OFF
GO
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([TeamId], [Images], [Name], [Position], [Icon]) VALUES (1, N'team-1.jpg', N'Full Name', N'Designation', N'fab fa-facebook-f, fab fa-twitter, fab fa-linkedin')
INSERT [dbo].[Team] ([TeamId], [Images], [Name], [Position], [Icon]) VALUES (12, N'team-2.jpg', N'New Name', N'New Position', N'fab fa-facebook-f, fab fa-twitter, fab fa-linkedin')
INSERT [dbo].[Team] ([TeamId], [Images], [Name], [Position], [Icon]) VALUES (14, N'team-3.jpg', N'Khanh Huynh', N'New', N'fab fa-facebook-f, fab fa-twitter, fab fa-linkedin')
INSERT [dbo].[Team] ([TeamId], [Images], [Name], [Position], [Icon]) VALUES (15, N'team-4.jpg', N'Full Name', N'Designation ', N'fab fa-facebook-f, fab fa-twitter, fab fa-linkedin')
SET IDENTITY_INSERT [dbo].[Team] OFF
GO
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (10000000, N'NCB', N'VNP14689876', N'ATM', N'Thanh toán don hàng 47', N'20241122112212', N'00', N'G0NOWU5F', N'14689876', N'00', N'47', N'c482fbc1ca6ee113671722b5fc99f279f86567756ac19fca14b5889eb49fa849e22dcd707752e7ccc37c4aa86eead3b40c0c4978c8eb070a39bddd769554ec6b')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (10000000, N'NCB', N'VNP14689881', N'ATM', N'Thanh toán don hàng 48', N'20241122112453', N'00', N'G0NOWU5F', N'14689881', N'00', N'48', N'8b4a9190887c477d74b8ece9b3d3d8d0afde1cb15c50aca85d4e198ae1540212f5ca8e5f53ed1e7afe335142fe1f4101065027c9f6e779bf7d6ca0145d94b687')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (67000000, N'NCB', N'VNP14690100', N'ATM', N'Payment for 0 with 670000', N'20241122132951', N'00', N'G0NOWU5F', N'14690100', N'00', N'0', N'f6dfdd129e17ef73582674842c17cfa85733a4090b72fce67572990556496f45b508d20d826fd508546c7021d08577d2bf2dcdb14164c9fe9429554e8ef66f93')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (38000000, N'NCB', N'VNP14693080', N'ATM', N'Payment for 70 with 380000', N'20241123220942', N'00', N'G0NOWU5F', N'14693080', N'00', N'70', N'92ae0ed188d65bb12d86747ae6eef5059e46800a49d1bc444b98d2181e059443e780c2f9e106f3c7e596f3b239ec6758c511032f360ae477928d2057f22dd1d4')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (76000000, N'NCB', N'VNP14693086', N'ATM', N'Payment for 72 with 760000', N'20241123221448', N'00', N'G0NOWU5F', N'14693086', N'00', N'72', N'03de092f1dae892a4f62c9b01a82569e4ae31afbb95d868c3cbfa61fbdcde5554f8ca21004cedcb2c178186ff8b6b736ad186852ea7c40061ea45d737695ec72')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (67000000, N'NCB', N'VNP14693127', N'ATM', N'Payment for 75 with 670000', N'20241123225034', N'00', N'G0NOWU5F', N'14693127', N'00', N'75', N'7cc410ea0d7c78818e2beba0f2b36fd6e2bf5d7046dc2784380d26a750b11cfabcdd6439cfc793e2720eb135a2dd6a506d423694bc8e58a9f6d7bc68096ced29')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (28000000, N'NCB', N'VNP14693214', N'ATM', N'Payment for 76 with 280000', N'20241123235531', N'00', N'G0NOWU5F', N'14693214', N'00', N'76', N'095525dd42efc616221b6768bf72004a2e22ad8b25083fd463a33a99a69b55d784b6357f62edc686b921ac42e77130f188d97e15f3051f5dc3fda286fb78f78a')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (28000000, N'NCB', N'VNP14693264', N'ATM', N'Payment for 78 with 280000', N'20241124002345', N'00', N'G0NOWU5F', N'14693264', N'00', N'78', N'4a09b3bc19fe8529cca08d73edbaec9cf6adcf71042a70454a92ccc72b2f9742d2655bf17ee2d3ad317d30e78bd5b9c3ba0ff1319db7d6bbbcc0bc9934d7566a')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (44000000, N'NCB', N'VNP14694335', N'ATM', N'Payment for 79 with 440000', N'20241124154945', N'00', N'G0NOWU5F', N'14694335', N'00', N'79', N'58f4149ad6e134ad212afefd38a2ea9cf25d3c8329e70e6a8e480c59e441c68cbbe616105ade1b1d684afb2406237c47b43201f23484e16fb1c34cf87d2bf6c7')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (67000000, N'NCB', N'VNP14695206', N'ATM', N'Payment for 88 with 670000', N'20241124234548', N'00', N'G0NOWU5F', N'14695206', N'00', N'88 - 11/24/2024 11:45:39 PM', N'c08f03ddad2447ff438083d170cb0ef2cabf00859faf9e120cd5d560e27c552e4ba28289154e66318ac53e764dd8089b05148063c13512cdfe2a58b77784d100')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (28000000, N'NCB', N'VNP14695569', N'ATM', N'Payment for 89 with 280000', N'20241125081348', N'00', N'G0NOWU5F', N'14695569', N'00', N'89 - 11/25/2024 8:13:35 AM', N'1041530d373c5c5d3f275bf0e7acc925b42f66d0a6e19f5f3a037c057304f752ee2062e93a7eb58ff4b3c5351b1360ce3830bbd753eee31c2c96756444bf85a7')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (67000000, N'NCB', N'VNP14695716', N'ATM', N'Payment for 90 with 670000', N'20241125095730', N'00', N'G0NOWU5F', N'14695716', N'00', N'90 - 11/25/2024 9:56:19 AM', N'625972c9c501b4017e2a5154682b5b11f519ea3e090972f3eb6838e579a4f1b1707f6bfade545761f5427ba5cd08ca3060a1c4de63242ab2d6bb8e3c54e474a3')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (38000000, N'NCB', N'VNP14695740', N'ATM', N'Payment for 91 with 380000', N'20241125100553', N'00', N'G0NOWU5F', N'14695740', N'00', N'91 - 11/25/2024 10:05:44 AM', N'f75d9bdb637c4f5f1e3af80355e8ebe22080f2d92338e4081154ed421d62969fca8e203f39390169d5de5e7166cab24ae0980822a4b94289e3915c2263675976')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (56000000, N'NCB', N'VNP14696777', N'ATM', N'Payment for 93 with 560000', N'20241125165705', N'00', N'G0NOWU5F', N'14696777', N'00', N'93 - 11/25/2024 4:53:23 PM', N'37f4802cfbc3d29a2993bf05b12f4aef4b4d2fc0c80e06d8901e935783b8f575b8540a123fb07cdab9d82e2b933c6206855d747ccb21ecb4ee62c3b3d8d72297')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (105000000, N'NCB', N'VNP14693122', N'ATM', N'Payment for 74 with 1050000', N'20241123224557', N'00', N'G0NOWU5F', N'14693122', N'00', N'74', N'b830d10e56ebbc25a5dd373dfabec5499fdac7ad046f20a08ec23aa7b4b915e122d20d1e52fe93cb3b2d69524718a9849618c33d90d50008a4f5c0c735a94622')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (113000000, N'NCB', N'VNP14694829', N'ATM', N'Payment for 86 with 1130000', N'20241124205740', N'00', N'G0NOWU5F', N'14694829', N'00', N'86 - 11/24/2024 8:57:24 PM', N'4165ea7650a12a0622945f92461269c6a5ee8e03fd61ec160bdd1026e28e268774e6ba5c4ac64bdbe80b1972a912c2d1ebff61e76a94f4a6556710e89779be3d')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (203000000, N'NCB', N'VNP14694838', N'ATM', N'Payment for 87 with 2030000', N'20241124210405', N'00', N'G0NOWU5F', N'14694838', N'00', N'87 - 11/24/2024 9:03:50 PM', N'dfcbf20fef98bf6b02c1d9c79855fffb9b9271a58aceac17480d4905c0fe82ffab7ba82244b79dff0ebde3c9fa7644ef3b84f83ad135e6154f4a0120b21acab9')
INSERT [dbo].[VnPay] ([Amount], [BankCode], [BankTranNo], [CardType], [OrderInfo], [PayDate], [ResponseCode], [TmnCode], [TransactionNo], [TransactionStatus], [TxnRef], [SecureHash]) VALUES (62000000, N'NCB', N'VNP14699880', N'ATM', N'Payment for 94 with 620000', N'20241126201550', N'00', N'G0NOWU5F', N'14699880', N'00', N'94 - 11/26/2024 8:15:39 PM', N'b1cce7394e1ebac1aec955b618da9b150cdc67b76446cd4f68aa5ace18d0f4827ad602b7e1674dd442669b43804c91254ace92d6593d1efca826913aba20025d')
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Member] ADD  DEFAULT ('Customer') FOR [Role]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD FOREIGN KEY([cart_id])
REFERENCES [dbo].[Carts] ([cart_id])
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Products]
GO
/****** Object:  StoredProcedure [dbo].[AddCart]    Script Date: 12/3/2024 1:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AddCart](
	@CartCode VARCHAR(32),
	@ProductId INT,
	@Quantity SMALLINT
)
as
	IF EXISTS(SELECT * FROM Cart WHERE CartCode = @CartCode AND ProductId = @ProductId)
			UPDATE Cart SET Quantity += @Quantity WHERE CartCode = @CartCode AND ProductId = @ProductId;
	ELSE 
		INSERT INTO Cart(CartCode, ProductId, Quantity) VALUES (@CartCode, @ProductId, @Quantity);
GO
/****** Object:  StoredProcedure [dbo].[AddInvoice]    Script Date: 12/3/2024 1:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AddInvoice](
	@CartCode VARCHAR(32),
	@InvoiceId CHAR(32),
	@InvoiceDate DATETIME,
	@FirstName NVARCHAR(32),
	@LastName NVARCHAR(32),
	@Address NVARCHAR(128),
	@State NVARCHAR(32),
	@City NVARCHAR(32),
	@Country NVARCHAR(32),
	@Note NVARCHAR(128),
	@PostCode CHAR(32),
	@Email VARCHAR(32),
	@Phone VARCHAR(32)
)
AS
BEGIN
	INSERT INTO Invoice(InvoiceId, CartCode, InvoiceDate, FirstName, LastName, Address, State, City, Country, Note, PostCode, Email, Phone) VALUES
		(@InvoiceId, @CartCode, @InvoiceDate, @FirstName, @LastName, @Address, @State, @City, @Country, @Note, @PostCode, @Email, @Phone);
	INSERT INTO InvoiceDetail(InvoiceId, ProductId, Quantity, Price)
		SELECT @InvoiceId, Cart.ProductId, Cart.Quantity, Product.Price
		FROM Cart JOIN Product ON Cart.CartCode = @CartCode AND Product.ProductId = Cart.ProductId;
	DELETE FROM Cart WHERE CartCode = @CartCode;
END
GO
/****** Object:  StoredProcedure [dbo].[AddMember]    Script Date: 12/3/2024 1:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AddMember] (
@MemberId VARCHAR (32),
@Email VARCHAR (64),
@Name NVARCHAR (64),
@Password VARCHAR(128),
@GivenName NVARCHAR (16),
@Surname NVARCHAR (32)
)
AS
	IF NOT EXISTS(SELECT * FROM Member WHERE MemberId = @MemberId)
		INSERT INTO Member (MemberId, Email, Password, Name, GivenName, Surname) VALUES
			(@MemberId, @Email, @Password, @Name, @GivenName, @Surname);
GO
/****** Object:  StoredProcedure [dbo].[AddVnPay]    Script Date: 12/3/2024 1:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[AddVnPay]
(	
	@Amount BIGINT,
	@BankCode VARCHAR(32),
	@BankTranNo VARCHAR(32),
	@CardType VARCHAR(32),
	@OrderInfo VARCHAR(32),
	@PayDate VARCHAR(32),
	@ResponseCode VARCHAR(32),
	@TmnCode VARCHAR(32),
	@TransactionNo VARCHAR(32),
	@TransactionStatus VARCHAR(32),
	@TxnRef VARCHAR(32),
	@SecureHash VARCHAR(1024)
)
AS
INSERT INTO VnPay VALUES
	(@Amount, @BankCode, @BankTranNo, @CardType, @OrderInfo, @PayDate, @ResponseCode, @TmnCode, @TransactionNo, @TransactionStatus, @TxnRef, @SecureHash);
GO
/****** Object:  StoredProcedure [dbo].[DeleteCart]    Script Date: 12/3/2024 1:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DeleteCart](
	@ProductId INT
)
as
	DELETE FROM Cart WHERE ProductId = @ProductId
GO
USE [master]
GO
ALTER DATABASE [Restoran] SET  READ_WRITE 
GO
