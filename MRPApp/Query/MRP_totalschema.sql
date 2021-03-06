USE [MRP]
GO
/****** Object:  Table [dbo].[Process]    Script Date: 2021-07-01 오후 2:02:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Process](
	[PrcIdx] [int] IDENTITY(1,1) NOT NULL,
	[SchIdx] [int] NOT NULL,
	[PrcCD] [char](14) NOT NULL,
	[PrcDate] [date] NOT NULL,
	[PrcLoadTime] [int] NULL,
	[PrcStartTime] [time](7) NULL,
	[PrcEndTime] [time](7) NULL,
	[PrcFacilityID] [char](8) NULL,
	[PrcResult] [bit] NOT NULL,
	[RegDate] [datetime] NULL,
	[RegID] [varchar](20) NULL,
	[ModDate] [datetime] NULL,
	[ModID] [varchar](20) NULL,
 CONSTRAINT [PK_Process] PRIMARY KEY CLUSTERED 
(
	[PrcIdx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedules]    Script Date: 2021-07-01 오후 2:02:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedules](
	[SchIdx] [int] IDENTITY(1,1) NOT NULL,
	[PlantCode] [char](8) NULL,
	[SchDate] [date] NOT NULL,
	[SchLoadTime] [int] NOT NULL,
	[SchStartTime] [time](7) NULL,
	[SchEndTime] [time](7) NULL,
	[SchFacilityID] [char](8) NULL,
	[SchAmount] [int] NOT NULL,
	[RegDate] [datetime] NULL,
	[RegID] [varchar](20) NULL,
	[ModDate] [datetime] NULL,
	[ModID] [varchar](20) NULL,
 CONSTRAINT [PK_Schedules] PRIMARY KEY CLUSTERED 
(
	[SchIdx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 2021-07-01 오후 2:02:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[BasicCode] [char](8) NOT NULL,
	[CodeName] [nvarchar](100) NOT NULL,
	[CodeDesc] [nvarchar](max) NULL,
	[RegDate] [datetime] NULL,
	[RegID] [varchar](20) NULL,
	[ModDate] [datetime] NULL,
	[ModID] [varchar](20) NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[BasicCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Process] ON 

INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (1, 6, N'PRC20210629001', CAST(N'2021-06-29' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-29T10:23:25.307' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (2, 6, N'PRC20210629002', CAST(N'2021-06-29' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-29T10:26:20.620' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (3, 6, N'PRC20210629003', CAST(N'2021-06-29' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-29T10:26:31.683' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (4, 6, N'PRC20210629004', CAST(N'2021-06-29' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10001', 0, CAST(N'2021-06-29T10:26:38.267' AS DateTime), N'MRP', CAST(N'2021-06-29T11:27:12.000' AS DateTime), N'SYS')
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (5, 6, N'PRC20210629005', CAST(N'2021-06-29' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-29T11:37:49.797' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (6, 6, N'PRC20210629006', CAST(N'2021-06-29' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-29T12:18:46.347' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (7, 7, N'PRC20210630001', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:20:57.567' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (8, 7, N'PRC20210630002', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:22:52.453' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (9, 7, N'PRC20210630003', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:33:05.987' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (10, 7, N'PRC20210630004', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:36:04.470' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (11, 7, N'PRC20210630005', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:36:37.687' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (12, 7, N'PRC20210630006', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:36:38.353' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (13, 7, N'PRC20210630007', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:53:55.337' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (14, 7, N'PRC20210630008', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:54:36.423' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (15, 7, N'PRC20210630009', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:56:53.613' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (16, 7, N'PRC20210630010', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T09:58:20.437' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (17, 7, N'PRC20210630011', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T10:01:26.557' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (18, 7, N'PRC20210630012', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T10:03:02.920' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (19, 7, N'PRC20210630013', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T10:03:31.657' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (20, 7, N'PRC20210630014', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T10:03:49.030' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (21, 7, N'PRC20210630015', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T10:40:19.830' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (22, 7, N'PRC20210630016', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 1, CAST(N'2021-06-30T10:40:39.570' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (23, 7, N'PRC20210630017', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 0, CAST(N'2021-06-30T10:53:47.227' AS DateTime), N'MRP', CAST(N'2021-06-30T10:54:00.000' AS DateTime), N'SYS')
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (24, 7, N'PRC20210630018', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 0, CAST(N'2021-06-30T10:54:03.913' AS DateTime), N'MRP', CAST(N'2021-06-30T10:54:16.000' AS DateTime), N'SYS')
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (25, 7, N'PRC20210630019', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 0, CAST(N'2021-06-30T10:54:22.873' AS DateTime), N'MRP', CAST(N'2021-06-30T10:54:40.000' AS DateTime), N'SYS')
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (26, 7, N'PRC20210630020', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 0, CAST(N'2021-06-30T10:54:42.460' AS DateTime), N'MRP', CAST(N'2021-06-30T10:54:47.000' AS DateTime), N'SYS')
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (27, 7, N'PRC20210630021', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 0, CAST(N'2021-06-30T10:55:01.033' AS DateTime), N'MRP', CAST(N'2021-06-30T11:07:30.000' AS DateTime), N'SYS')
INSERT [dbo].[Process] ([PrcIdx], [SchIdx], [PrcCD], [PrcDate], [PrcLoadTime], [PrcStartTime], [PrcEndTime], [PrcFacilityID], [PrcResult], [RegDate], [RegID], [ModDate], [ModID]) VALUES (28, 7, N'PRC20210630022', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 0, CAST(N'2021-06-30T11:07:33.027' AS DateTime), N'MRP', CAST(N'2021-06-30T11:07:38.000' AS DateTime), N'SYS')
SET IDENTITY_INSERT [dbo].[Process] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedules] ON 

INSERT [dbo].[Schedules] ([SchIdx], [PlantCode], [SchDate], [SchLoadTime], [SchStartTime], [SchEndTime], [SchFacilityID], [SchAmount], [RegDate], [RegID], [ModDate], [ModID]) VALUES (1, N'PC010002', CAST(N'2021-06-26' AS Date), 12, CAST(N'09:09:00' AS Time), CAST(N'17:05:00' AS Time), N'FAC10001', 21, CAST(N'2021-06-24T18:00:00.000' AS DateTime), N'SYS', CAST(N'2021-06-25T14:24:51.637' AS DateTime), N'MRP')
INSERT [dbo].[Schedules] ([SchIdx], [PlantCode], [SchDate], [SchLoadTime], [SchStartTime], [SchEndTime], [SchFacilityID], [SchAmount], [RegDate], [RegID], [ModDate], [ModID]) VALUES (2, N'PC010002', CAST(N'2021-06-28' AS Date), 10, CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), N'FAC10002', 40, CAST(N'2021-06-25T12:40:28.230' AS DateTime), N'MRP', CAST(N'2021-06-28T09:17:43.200' AS DateTime), N'MRP')
INSERT [dbo].[Schedules] ([SchIdx], [PlantCode], [SchDate], [SchLoadTime], [SchStartTime], [SchEndTime], [SchFacilityID], [SchAmount], [RegDate], [RegID], [ModDate], [ModID]) VALUES (3, N'PC010001', CAST(N'2021-06-28' AS Date), 20, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10002', 20, CAST(N'2021-06-28T09:21:39.343' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Schedules] ([SchIdx], [PlantCode], [SchDate], [SchLoadTime], [SchStartTime], [SchEndTime], [SchFacilityID], [SchAmount], [RegDate], [RegID], [ModDate], [ModID]) VALUES (4, N'PC010001', CAST(N'2021-06-04' AS Date), 222, CAST(N'08:00:00' AS Time), CAST(N'20:00:00' AS Time), N'FAC10002', 1, CAST(N'2021-06-28T09:23:55.220' AS DateTime), N'MRP', CAST(N'2021-06-28T09:27:02.610' AS DateTime), N'MRP')
INSERT [dbo].[Schedules] ([SchIdx], [PlantCode], [SchDate], [SchLoadTime], [SchStartTime], [SchEndTime], [SchFacilityID], [SchAmount], [RegDate], [RegID], [ModDate], [ModID]) VALUES (5, N'PC010002', CAST(N'2021-06-01' AS Date), 15, CAST(N'03:00:00' AS Time), CAST(N'15:00:00' AS Time), N'FAC10001', 10, CAST(N'2021-06-28T09:26:15.947' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Schedules] ([SchIdx], [PlantCode], [SchDate], [SchLoadTime], [SchStartTime], [SchEndTime], [SchFacilityID], [SchAmount], [RegDate], [RegID], [ModDate], [ModID]) VALUES (6, N'PC010002', CAST(N'2021-06-29' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'FAC10001', 30, CAST(N'2021-06-29T09:14:46.540' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Schedules] ([SchIdx], [PlantCode], [SchDate], [SchLoadTime], [SchStartTime], [SchEndTime], [SchFacilityID], [SchAmount], [RegDate], [RegID], [ModDate], [ModID]) VALUES (7, N'PC010002', CAST(N'2021-06-30' AS Date), 5, CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), N'FAC10001', 20, CAST(N'2021-06-30T09:20:47.093' AS DateTime), N'MRP', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Schedules] OFF
GO
INSERT [dbo].[Settings] ([BasicCode], [CodeName], [CodeDesc], [RegDate], [RegID], [ModDate], [ModID]) VALUES (N'FAC10001', N'설비1', N'생산설비1
확인용', CAST(N'2021-06-24T14:07:26.513' AS DateTime), N'MRP', CAST(N'2021-06-25T14:15:09.490' AS DateTime), N'MRP')
INSERT [dbo].[Settings] ([BasicCode], [CodeName], [CodeDesc], [RegDate], [RegID], [ModDate], [ModID]) VALUES (N'FAC10002', N'설비2', N'생산설비2', CAST(N'2021-06-24T14:08:45.013' AS DateTime), N'MRP', CAST(N'2021-06-24T14:25:56.223' AS DateTime), N'MRP')
INSERT [dbo].[Settings] ([BasicCode], [CodeName], [CodeDesc], [RegDate], [RegID], [ModDate], [ModID]) VALUES (N'FFF10001', N'TEST', N'TEST', CAST(N'2021-06-24T15:16:34.970' AS DateTime), N'MRP', NULL, NULL)
INSERT [dbo].[Settings] ([BasicCode], [CodeName], [CodeDesc], [RegDate], [RegID], [ModDate], [ModID]) VALUES (N'PC010001', N'수원', N'수원공장(코드)4', NULL, NULL, CAST(N'2021-06-24T13:59:26.060' AS DateTime), N'MRP')
INSERT [dbo].[Settings] ([BasicCode], [CodeName], [CodeDesc], [RegDate], [RegID], [ModDate], [ModID]) VALUES (N'PC010002', N'부산3', N'부산공장(코드)', CAST(N'2021-06-24T13:58:18.593' AS DateTime), N'MRP', CAST(N'2021-06-25T11:11:06.600' AS DateTime), N'MRP')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Process_PrcCD]    Script Date: 2021-07-01 오후 2:02:11 ******/
ALTER TABLE [dbo].[Process] ADD  CONSTRAINT [UK_Process_PrcCD] UNIQUE NONCLUSTERED 
(
	[PrcCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Process]  WITH NOCHECK ADD  CONSTRAINT [FK_Process_Schedules] FOREIGN KEY([SchIdx])
REFERENCES [dbo].[Schedules] ([SchIdx])
GO
ALTER TABLE [dbo].[Process] NOCHECK CONSTRAINT [FK_Process_Schedules]
GO
ALTER TABLE [dbo].[Process]  WITH NOCHECK ADD  CONSTRAINT [FK_Process_Settings] FOREIGN KEY([PrcFacilityID])
REFERENCES [dbo].[Settings] ([BasicCode])
GO
ALTER TABLE [dbo].[Process] NOCHECK CONSTRAINT [FK_Process_Settings]
GO
ALTER TABLE [dbo].[Schedules]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedules_Settings] FOREIGN KEY([PlantCode])
REFERENCES [dbo].[Settings] ([BasicCode])
GO
ALTER TABLE [dbo].[Schedules] NOCHECK CONSTRAINT [FK_Schedules_Settings]
GO
ALTER TABLE [dbo].[Schedules]  WITH NOCHECK ADD  CONSTRAINT [FK_Schedules_Settings1] FOREIGN KEY([SchFacilityID])
REFERENCES [dbo].[Settings] ([BasicCode])
GO
ALTER TABLE [dbo].[Schedules] NOCHECK CONSTRAINT [FK_Schedules_Settings1]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'RegDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'RegID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'ModDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Process', @level2type=N'COLUMN',@level2name=N'ModID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공정계획 순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchIdx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공장코드 (FK : Settings)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'PlantCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공정계획일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'로드타임(초)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchLoadTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작시간(계획)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'종료시간(계획)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생산설비ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchFacilityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'목표수량(계획)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'SchAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'RegDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'RegID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'ModDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Schedules', @level2type=N'COLUMN',@level2name=N'ModID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Settings', @level2type=N'COLUMN',@level2name=N'BasicCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코드명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Settings', @level2type=N'COLUMN',@level2name=N'CodeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코드설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Settings', @level2type=N'COLUMN',@level2name=N'CodeDesc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Settings', @level2type=N'COLUMN',@level2name=N'RegDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'작성자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Settings', @level2type=N'COLUMN',@level2name=N'RegID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Settings', @level2type=N'COLUMN',@level2name=N'ModDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수정자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Settings', @level2type=N'COLUMN',@level2name=N'ModID'
GO
