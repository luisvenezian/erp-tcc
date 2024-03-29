USE [admin]
GO
/****** Object:  Schema [si]    Script Date: 23/06/2019 14:15:01 ******/
CREATE SCHEMA [si]
GO
/****** Object:  Schema [users]    Script Date: 23/06/2019 14:15:01 ******/
CREATE SCHEMA [users]
GO
/****** Object:  View [dbo].[vw_system_tables]    Script Date: 23/06/2019 14:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_system_tables]
AS
SELECT 
	   CONCAT(S.Name,'.',T.Name) AS "table_name",
	   T.create_date,
	   CONCAT('SELECT TOP 500 * FROM ',UPPER(S.Name),'.',UPPER(T.Name)) AS "speed_select"
FROM SYS.TABLES T
	JOIN SYS.SCHEMAS S ON T.schema_id = S.schema_id

GO
/****** Object:  Table [dbo].[sys_usuario]    Script Date: 23/06/2019 14:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_usuario](
	[usuario] [varchar](15) NULL,
	[senha] [varchar](35) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [si].[applications]    Script Date: 23/06/2019 14:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [si].[applications](
	[id_app] [int] IDENTITY(1,1) NOT NULL,
	[app_name] [varchar](60) NOT NULL,
	[app_name_controller] [varchar](60) NOT NULL,
	[app_create_date] [datetime] NOT NULL,
	[app_url_redirect] [varchar](100) NULL,
	[system_id] [tinyint] NOT NULL,
	[is_report] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_SI_APPLICATIONS_ID_APP] PRIMARY KEY CLUSTERED 
(
	[id_app] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [users].[concessions]    Script Date: 23/06/2019 14:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [users].[concessions](
	[user_id] [int] NOT NULL,
	[app_id] [int] NOT NULL,
	[record_concession_date] [datetime] NOT NULL,
 CONSTRAINT [PKC_USERS_CONCESSIONS_USER_ID_APP_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[app_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [users].[profiles]    Script Date: 23/06/2019 14:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [users].[profiles](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[user_first_name] [varchar](50) NOT NULL,
	[user_last_name] [varchar](50) NOT NULL,
	[user_login] [varchar](15) NOT NULL,
	[user_password] [varchar](35) NOT NULL,
	[user_email] [varchar](255) NOT NULL,
	[user_country_id] [tinyint] NOT NULL,
	[user_create_date] [datetime] NOT NULL,
	[user_phone_number] [varchar](9) NOT NULL,
	[user_phone_prefix] [varchar](3) NOT NULL,
	[user_job_role] [varchar](255) NULL,
	[user_bio] [varchar](135) NULL,
 CONSTRAINT [PK_USERS_PROFILE_ID_USER] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [users].[concessions]  WITH CHECK ADD  CONSTRAINT [FK_USERS_CONCESSIONS_APP_ID] FOREIGN KEY([app_id])
REFERENCES [si].[applications] ([id_app])
GO
ALTER TABLE [users].[concessions] CHECK CONSTRAINT [FK_USERS_CONCESSIONS_APP_ID]
GO
ALTER TABLE [users].[concessions]  WITH CHECK ADD  CONSTRAINT [FK_USERS_CONCESSIONS_USER_ID] FOREIGN KEY([user_id])
REFERENCES [users].[profiles] ([id_user])
GO
ALTER TABLE [users].[concessions] CHECK CONSTRAINT [FK_USERS_CONCESSIONS_USER_ID]
GO
