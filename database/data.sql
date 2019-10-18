CREATE DATABASE [suinos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'suinos', FILENAME = N'D:\rdsdbdata\DATA\suinos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'suinos_log', FILENAME = N'D:\rdsdbdata\DATA\suinos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [suinos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [suinos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [suinos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [suinos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [suinos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [suinos] SET ARITHABORT OFF 
GO
ALTER DATABASE [suinos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [suinos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [suinos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [suinos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [suinos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [suinos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [suinos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [suinos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [suinos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [suinos] SET  ENABLE_BROKER 
GO
ALTER DATABASE [suinos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [suinos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [suinos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [suinos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [suinos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [suinos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [suinos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [suinos] SET RECOVERY FULL 
GO
ALTER DATABASE [suinos] SET  MULTI_USER 
GO
ALTER DATABASE [suinos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [suinos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [suinos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [suinos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [suinos] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [suinos] SET QUERY_STORE = OFF
GO
USE [suinos]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
CREATE USER [ti_jose] FOR LOGIN [ti_jose] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ti_jose]
GO
ALTER ROLE [db_datareader] ADD MEMBER [ti_jose]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [ti_jose]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
CREATE SCHEMA [base]
GO
CREATE SCHEMA [controle]
GO
CREATE SCHEMA [rlc]
GO
CREATE SCHEMA [users]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [rlc].[loteSuinos](
	[idLoteSuino] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [int] NOT NULL,
	[idSuino] [int] NOT NULL,
	[dtEntradaSuino] [datetime] NOT NULL,
	[dtSaidaSuino] [datetime] NULL,
 CONSTRAINT [PK__loteSuin__C54B8A172299F20F] PRIMARY KEY CLUSTERED 
(
	[idLoteSuino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[viewResumoDaQuantidadeSuinosPorLote]
AS
SELECT l.idLote, COUNT(*) qtdSuino
FROM 
	rlc.loteSuinos AS l
	WHERE l.dtSaidaSuino IS NULL
GROUP BY l.idLote
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [base].[operacoesEstoque](
	[idOperacao] [int] NOT NULL,
	[operador] [int] NOT NULL,
	[descOperacao] [varchar](50) NOT NULL,
 CONSTRAINT [PK__operacoe__D91CE08D41350954] PRIMARY KEY CLUSTERED 
(
	[idOperacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [base].[estoques](
	[idEstoque] [int] IDENTITY(1,1) NOT NULL,
	[idProduto] [int] NOT NULL,
	[idOperacao] [int] NOT NULL,
	[quantidade] [int] NOT NULL,
	[dtLancamento] [datetime] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[unidade] [nchar](10) NOT NULL,
	[custo] [float] NOT NULL,
 CONSTRAINT [PK__estoques__F90B4083A062AA0B] PRIMARY KEY CLUSTERED 
(
	[idEstoque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [base].[produtos](
	[idProduto] [int] IDENTITY(1,1) NOT NULL,
	[dtCadastro] [datetime] NOT NULL,
	[nomeProduto] [varchar](200) NOT NULL,
	[localAplicacao] [varchar](50) NULL,
	[fabricante] [varchar](50) NULL,
	[validade] [datetime] NULL,
	[descricao] [varchar](500) NULL,
	[unidade] [varchar](10) NOT NULL,
	[ganhoPeso] [numeric](4, 0) NULL,
 CONSTRAINT [PK__produtos__5EEDF7C36DDD3B5E] PRIMARY KEY CLUSTERED 
(
	[idProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [base].[usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](15) NOT NULL,
	[senha] [varchar](30) NOT NULL,
	[dtCadastro] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[viewLancamentosEstoque]
as

	select e.idProduto,
	p.nomeProduto,
	oe.descOperacao,
	e.quantidade,
	e.unidade,
	e.custo,
	e.dtLancamento,
	u.usuario
	from base.estoques e
		inner join base.produtos p on p.idProduto = e.idProduto
		inner join base.operacoesEstoque oe on oe.idOperacao = e.idOperacao
		inner join base.usuarios as u on u.idUsuario = e.idUsuario 

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[viewSaldoAtualProduto]
AS
SELECT idProduto, 
	   nomeProduto,
	   SUM(quantidade * (IIF(descOperacao = 'ENTRADA',1,-1))) qtdDisponivel
FROM viewLancamentosEstoque
GROUP BY idProduto, nomeProduto
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [base].[suinos](
	[idSuino] [int] IDENTITY(1,1) NOT NULL,
	[dtNascimento] [datetime] NOT NULL,
	[sexo] [bit] NOT NULL,
	[idSituacaoVida] [smallint] NOT NULL,
	[peso] [numeric](14, 2) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idMae] [int] NULL,
	[valorAquisicao] [float] NULL,
 CONSTRAINT [PK__suinos__0C37FF501EBE4FA9] PRIMARY KEY CLUSTERED 
(
	[idSuino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewEstoqueSuinos] AS 
SELECT COUNT(S.idSuino) AS Qtd,
       CASE
           WHEN S.sexo = 0
           THEN 'Feminino'
           ELSE 'Masculino'
       END AS Sexo
FROM [suinos].[base].[suinos] AS S
     LEFT JOIN [suinos].[rlc].loteSuinos AS L ON(L.idSuino = S.idSuino)
WHERE l.idSuino IS NULL 
	AND S.idSituacaoVida = 1
GROUP BY S.sexo;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewEstoqueSuinosPivotada] AS 
SELECT 
ISNULL((SELECT TOP 1 qtd FROM viewEstoqueSuinos WHERE sexo = 'Masculino'), 0) As qtdMacho,
ISNULL((SELECT TOP 1 qtd FROM viewEstoqueSuinos WHERE sexo = 'Feminino'),0)As qtdFemea 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [controle].[vendasLote](
	[idVendaLote] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [int] NOT NULL,
	[dtVenda] [datetime] NOT NULL,
	[valor] [numeric](13, 2) NOT NULL,
	[cliente] [varchar](100) NULL,
 CONSTRAINT [PK__vendasLo__C0AAC7218D72ECBD] PRIMARY KEY CLUSTERED 
(
	[idVendaLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewVendas] AS
	SELECT idvendaLote "ID Venda Lote", 
	(SELECT COUNT(*) FROM rlc.loteSuinos WHERE idLote = controle.vendasLote.idLote) AS 
	"Qtd Suinos Vendidos",
	DtVenda, 
	convert(money,valor) AS Valor, 
	Cliente, idLote 
	FROM 
	controle.vendasLote 

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [controle].[tiposLote](
	[idTipoLote] [int] NOT NULL,
	[descTipoLote] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [controle].[lotes](
	[idLote] [int] IDENTITY(1,1) NOT NULL,
	[idTipoLote] [int] NOT NULL,
	[dtCriacaoLote] [datetime] NOT NULL,
	[dtVencimentoLote] [datetime] NULL,
	[nome] [varchar](100) NOT NULL,
	[descricao] [varchar](200) NOT NULL,
	[idStatusLote] [int] NOT NULL,
 CONSTRAINT [PK_lotes] PRIMARY KEY CLUSTERED 
(
	[idLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[viewLotes]
AS
SELECT DISTINCT 
	L.idLote, 
	CONCAT(CTL.descTipoLote,' - ',L.nome) nomeLote
FROM [controle].lotes as L	
	INNER JOIN controle.tiposLote AS CTL on ctl.idTipoLote = L.idTipoLote
WHERE L.idTipoLote <> 5
AND 
(SELECT COUNT(*) FROM rlc.loteSuinos 
 WHERE idLote = L.idLote AND dtSaidaSuino IS NULL) > 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewQtdRecriasPorMae]
AS
SELECT LS.idLote "Id Lote", 
S.idMae "Id Mãe", 
COUNT(DISTINCT S.dtNascimento) as "Qtd. Recria",
CONCAT(CTL.descTipoLote, ' | ', CL.nome) as "Nome Lote"
FROM base.suinos S
	LEFT JOIN rlc.loteSuinos LS on LS.idSuino = S.idMae
	LEFT JOIN controle.lotes CL on CL.idLote = LS.idLote
	LEFT JOIN controle.tiposLote CTL on CTL.idTipoLote = CL.idTipoLote
WHERE S.idMae IS NOT NULL
GROUP BY S.idMae, LS.idLote, CTL.descTipoLote, CL.nome
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [controle].[tiposTratamentoLote](
	[idTipoTratamento] [int] IDENTITY(1,1) NOT NULL,
	[descTipoTratamento] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoTratamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [controle].[tratamentosLote](
	[idTratamentoLote] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [int] NOT NULL,
	[idProduto] [int] NOT NULL,
	[idTipoTratamento] [int] NOT NULL,
	[dtInicioAplicacao] [datetime] NOT NULL,
	[dtFimAplicacao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idTratamentoLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[viewTratamentos] AS
SELECT c.idLote, 
       c.idProduto, 
       p.nomeProduto, 
       ct.descTipoTratamento, 
       dtInicioAplicacao, 
       dtFimAplicacao
FROM controle.tratamentosLote c
     INNER JOIN controle.tiposTratamentoLote ct ON ct.idTipoTratamento = c.idTipoTratamento
     INNER JOIN base.produtos p ON c.idProduto = p.idProduto;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewTodosOsLotesNaoVendidos] AS
SELECT DISTINCT 
	L.idLote, 
	CONCAT(CTL.descTipoLote,' - ',L.nome) nomeLote
FROM [controle].lotes as L	
	INNER JOIN controle.tiposLote AS CTL on ctl.idTipoLote = L.idTipoLote
WHERE L.idTipoLote <> 5
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewSuinosDisponiveis]
-- Os suinos disponíveis para ser inseridos em lotes são
-- os que estão vivos e não estão em nenhum lote.
AS
SELECT s.idSuino, s.sexo, s.peso
FROM base.suinos s
WHERE NOT EXISTS
(
    SELECT TOP 1 1
    FROM rlc.loteSuinos
    WHERE idSuino = s.idSuino
)
AND s.idSituacaoVida = 1;

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewSuinosPorLote] AS
SELECT  
	   L.idLote,
	   COUNT(S.idSuino) AS Qtd,
       CASE
           WHEN S.sexo = 0
           THEN 'Feminino'
           ELSE 'Masculino'
       END AS Sexo
FROM [suinos].[base].[suinos] AS S
     INNER JOIN [suinos].[rlc].[loteSuinos] AS L ON(L.idSuino = S.idSuino)
GROUP BY S.sexo, L.idLote;
;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [controle].[pesosLote](
	[idPesagemLote] [int] IDENTITY(1,1) NOT NULL,
	[idLote] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[dtPesagem] [datetime] NOT NULL,
	[pesoG] [numeric](14, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idPesagemLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[viewResumoDosLotes]
AS
     SELECT DISTINCT l.idLote, 
            lo.nome AS nomeLote, 
            lo.descricao AS descLote, 
            lo.dtCriacaoLote AS dtCadastroInfo, 
            prod.nomeProduto AS nomeTratamento,
            l.dtInicioAplicacao, 
            l.dtFimAplicacao, 
            ttl.descTipoTratamento, 
            ttl.idTipoTratamento,
			tipoDoLote.nome, 
            lo.dtVencimentoLote, 
            macho.qtd AS QtdMachos, 
            femea.qtd AS QtdFemeas, 
            peso.valor AS pesoLote

     FROM controle.lotes lo
          LEFT JOIN controle.tratamentosLote l ON l.idLote = lo.idLote
          LEFT JOIN base.produtos prod ON prod.idProduto = l.idProduto
          LEFT JOIN controle.tiposTratamentoLote ttl ON ttl.idTipoTratamento = l.idTipoTratamento
          OUTER APPLY
     (
         SELECT TOP 1 ctl.descTipoLote AS nome
         FROM controle.lotes cl
              INNER JOIN controle.tiposLote ctl ON ctl.idTipoLote = cl.idTipoLote
                                                   AND cl.idLote = l.idLote 
														ORDER BY dtInicioAplicacao DESC
     ) tipoDoLote
          OUTER APPLY
     (
         SELECT QTD
         FROM viewSuinosPorLote
         WHERE idLote = l.idLote
               AND Sexo = 'Masculino'
     ) macho
          OUTER APPLY
     (
         SELECT QTD
         FROM viewSuinosPorLote
         WHERE idLote = l.idLote
               AND Sexo = 'Feminino'
     ) femea
          OUTER APPLY
     (
         SELECT TOP 1 pesoG AS Valor
         FROM [controle].pesosLote AS pl
         WHERE pl.idLote = lo.idLote
         ORDER BY dtPesagem DESC
     ) peso;

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewResumoDaAlocacaoDosPorcos]
AS
     SELECT qtdSuinos = COUNT(*), tl.descTipoLote, tl.idTipoLote
     FROM rlc.loteSuinos l
          INNER JOIN controle.lotes cl ON cl.idLote = l.idLote
          INNER JOIN controle.tiposLote tl ON tl.idTipoLote = cl.idTipoLote
		  INNER JOIN base.suinos s on s.idSuino = l.idSuino
	 WHERE s.idSituacaoVida = 1
	 GROUP BY tl.descTipoLote, tl.idTipoLote;


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewResumoDaAlocacaoDosPorcosPivotada]
AS
SELECT qtdEngorda = ISNULL(
(
    SELECT qtdSuinos
    FROM dbo.viewResumoDaAlocacaoDosPorcos
    WHERE idTipoLote = 1
), 0), 
       qtdRecria = ISNULL(
(
    SELECT qtdSuinos
    FROM dbo.viewResumoDaAlocacaoDosPorcos
    WHERE idTipoLote = 2
), 0), 
       qtdPosDesmama = ISNULL(
(
    SELECT qtdSuinos
    FROM dbo.viewResumoDaAlocacaoDosPorcos
    WHERE idTipoLote = 3
), 0), 
       qtdPreAbate = ISNULL(
(
    SELECT qtdSuinos
    FROM dbo.viewResumoDaAlocacaoDosPorcos
    WHERE idTipoLote = 4
), 0);
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [base].[informacoesSuino](
	[idInformacoesSuino] [int] IDENTITY(1,1) NOT NULL,
	[idSuino] [int] NOT NULL,
	[obs] [varchar](300) NOT NULL,
	[dtObs] [datetime] NOT NULL,
 CONSTRAINT [PK__informac__3674A8DAAC38B826] PRIMARY KEY CLUSTERED 
(
	[idInformacoesSuino] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [base].[situacaoVidaSuinos](
	[idSituacaoVida] [smallint] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idSituacaoVida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [controle].[statusLote](
	[idStatusLote] [int] IDENTITY(1,1) NOT NULL,
	[descStatusLote] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idStatusLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [base].[estoques] ON 

INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (1, 12, 2, 1500, CAST(N'2019-09-12T18:53:44.740' AS DateTime), 1, N'kg        ', 1500)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (2, 12, 2, 1500, CAST(N'2019-09-12T18:56:00.710' AS DateTime), 1, N'kg        ', 1500)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (3, 8, 2, 1500, CAST(N'2019-09-12T18:59:50.313' AS DateTime), 1, N'ml        ', 123)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (4, 36, 2, 60, CAST(N'2019-09-12T19:00:32.090' AS DateTime), 1, N'ds        ', 1500)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (5, 42, 2, 4, CAST(N'2019-09-20T00:42:54.343' AS DateTime), 1, N'kg        ', 8000)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (6, 12, 2, 200, CAST(N'2019-10-10T23:01:41.583' AS DateTime), 1, N'ml        ', 15000)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (7, 36, 2, 2000000, CAST(N'2019-10-10T23:02:56.237' AS DateTime), 1, N'ds        ', 15000)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (8, 8, 2, 13, CAST(N'2019-10-10T23:21:20.313' AS DateTime), 1, N'ml        ', 100)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (9, 8, 2, 13, CAST(N'2019-10-10T23:24:17.840' AS DateTime), 1, N'ml        ', 100)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (10, 48, 2, 100000, CAST(N'2019-10-10T23:24:54.930' AS DateTime), 1, N'kg        ', 100)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (11, 8, 1, 1000, CAST(N'2019-10-11T13:08:46.190' AS DateTime), 1, N'kg        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (12, 12, 1, 3200, CAST(N'2019-10-14T11:43:51.423' AS DateTime), 1, N'tonelada  ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (13, 12, 1, 0, CAST(N'2019-10-14T11:44:45.483' AS DateTime), 1, N'tonelada  ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (14, 48, 1, 100000, CAST(N'2019-10-14T11:54:55.993' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (15, 36, 1, 3, CAST(N'2019-10-16T23:31:42.567' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (16, 36, 1, 5, CAST(N'2019-10-18T13:53:48.477' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (17, 36, 1, 5, CAST(N'2019-10-18T13:55:08.717' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (18, 36, 1, 1500, CAST(N'2019-10-18T13:55:48.550' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (19, 36, 1, 3, CAST(N'2019-10-18T13:59:32.077' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (20, 42, 1, 3, CAST(N'2019-10-18T14:11:09.260' AS DateTime), 1, N'kg        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (21, 36, 1, 222, CAST(N'2019-10-18T14:11:39.510' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (22, 36, 1, 222, CAST(N'2019-10-18T14:20:57.760' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (23, 36, 1, 222, CAST(N'2019-10-18T14:21:36.940' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (24, 36, 1, 78, CAST(N'2019-10-18T14:22:04.927' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (25, 36, 1, 1, CAST(N'2019-10-18T14:25:10.610' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (26, 36, 1, 3, CAST(N'2019-10-18T15:47:04.337' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (27, 36, 1, 1, CAST(N'2019-10-18T15:49:48.193' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (28, 36, 1, 1, CAST(N'2019-10-18T15:50:54.990' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (29, 36, 1, 1, CAST(N'2019-10-18T15:52:41.580' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (30, 36, 1, 1, CAST(N'2019-10-18T15:53:35.970' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (31, 36, 1, 10, CAST(N'2019-10-18T15:55:06.107' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (32, 36, 1, 2, CAST(N'2019-10-18T15:58:43.060' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (33, 36, 1, 10, CAST(N'2019-10-18T15:59:46.120' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (34, 36, 1, 10, CAST(N'2019-10-18T16:05:23.943' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (35, 36, 1, 10, CAST(N'2019-10-18T16:05:52.670' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (36, 36, 1, 10, CAST(N'2019-10-18T16:08:43.470' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (37, 36, 1, 10, CAST(N'2019-10-18T16:09:46.933' AS DateTime), 1, N'ds        ', 0)
INSERT [base].[estoques] ([idEstoque], [idProduto], [idOperacao], [quantidade], [dtLancamento], [idUsuario], [unidade], [custo]) VALUES (38, 36, 1, 10, CAST(N'2019-10-18T16:13:16.533' AS DateTime), 1, N'ds        ', 0)
SET IDENTITY_INSERT [base].[estoques] OFF
SET IDENTITY_INSERT [base].[informacoesSuino] ON 

INSERT [base].[informacoesSuino] ([idInformacoesSuino], [idSuino], [obs], [dtObs]) VALUES (1, 41, N'Peidou tão forte que expulsou os orgãos.', CAST(N'2019-09-10T00:00:00.000' AS DateTime))
INSERT [base].[informacoesSuino] ([idInformacoesSuino], [idSuino], [obs], [dtObs]) VALUES (2, 148, N'Testando morte Banco', CAST(N'2019-10-10T00:00:00.000' AS DateTime))
INSERT [base].[informacoesSuino] ([idInformacoesSuino], [idSuino], [obs], [dtObs]) VALUES (6, 45, N'Testando moree', CAST(N'2019-10-10T00:00:00.000' AS DateTime))
INSERT [base].[informacoesSuino] ([idInformacoesSuino], [idSuino], [obs], [dtObs]) VALUES (7, 42, N'Testando Outra Morte', CAST(N'2019-10-10T00:00:00.000' AS DateTime))
INSERT [base].[informacoesSuino] ([idInformacoesSuino], [idSuino], [obs], [dtObs]) VALUES (8, 43, N'Morte pela Doença X', CAST(N'2019-10-14T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [base].[informacoesSuino] OFF
INSERT [base].[operacoesEstoque] ([idOperacao], [operador], [descOperacao]) VALUES (1, 1, N'SAIDA')
INSERT [base].[operacoesEstoque] ([idOperacao], [operador], [descOperacao]) VALUES (2, 1, N'ENTRADA')
SET IDENTITY_INSERT [base].[produtos] ON 

INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (8, CAST(N'2019-09-12T11:09:30.697' AS DateTime), N'Ração Inicial', NULL, N'Próprio', CAST(N'2019-04-15T00:00:00.000' AS DateTime), N'dsdsd', N'kg', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (9, CAST(N'2019-09-12T11:13:00.650' AS DateTime), N'Ração Inicial', NULL, N'Propria', CAST(N'2021-05-15T00:00:00.000' AS DateTime), N'Ela é composta por milho, farelo de algodão', N'kg', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (12, CAST(N'2019-09-12T16:56:49.960' AS DateTime), N'Ração 07', NULL, N'AgroFerrari', CAST(N'2021-02-03T00:00:00.000' AS DateTime), N'dsdsdsdsds', N'tonelada', CAST(2 AS Numeric(4, 0)))
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (36, CAST(N'2019-09-20T00:30:49.323' AS DateTime), N'Botulimax', N'Pescoço', N'Zoetis', CAST(N'2018-11-29T00:00:00.000' AS DateTime), N'TESTE!1_ALTERANDO_COM_GUILHERME', N'ds', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (37, CAST(N'2019-09-12T17:13:10.090' AS DateTime), N'Racao 07', NULL, N'Próprio', CAST(N'2017-11-30T00:00:00.000' AS DateTime), N'dsdsd', N'tonelada', CAST(2 AS Numeric(4, 0)))
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (38, CAST(N'2019-09-12T18:53:31.600' AS DateTime), N'Racao 07', NULL, N'Próprio', CAST(N'2017-11-30T00:00:00.000' AS DateTime), N'dsdsd', N'tonelada', CAST(2 AS Numeric(4, 0)))
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (39, CAST(N'2019-09-12T19:13:12.950' AS DateTime), N'Racao 07', NULL, N'Próprio', CAST(N'2017-11-30T00:00:00.000' AS DateTime), N'dsdsd', N'tonelada', CAST(2 AS Numeric(4, 0)))
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (40, CAST(N'2019-09-13T00:48:46.520' AS DateTime), N'Dipirona', N'Oral', N'Drogasil', CAST(N'2020-03-02T00:00:00.000' AS DateTime), N'Para uso de dores musculares e enxaqueca', N'ml', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (41, CAST(N'2019-09-13T00:47:32.377' AS DateTime), N'Ração Final', NULL, N'Próprio', CAST(N'2020-03-02T00:00:00.000' AS DateTime), N'Composta por milho e soja ', N'kg', CAST(2 AS Numeric(4, 0)))
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (42, CAST(N'2019-09-20T00:42:23.533' AS DateTime), N'DIETA INICIAL', NULL, N'PROPRIO', CAST(N'2022-12-20T00:00:00.000' AS DateTime), N'Essa ração aqui é boa cheira bem.', N'kg', CAST(2 AS Numeric(4, 0)))
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (43, CAST(N'2019-09-27T16:28:19.183' AS DateTime), N'', N'', N'', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'', N'', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (44, CAST(N'2019-09-27T16:29:05.947' AS DateTime), N'', N'', N'', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'', N'', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (45, CAST(N'2019-09-27T16:29:35.663' AS DateTime), N'', N'', N'', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'', N'', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (46, CAST(N'2019-10-03T19:50:49.477' AS DateTime), N'Teste', N'Cabeça', N'Zoetis', CAST(N'2019-11-30T00:00:00.000' AS DateTime), N'testando Data de Validade Datetime', N'ml', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (47, CAST(N'2019-10-03T20:12:36.260' AS DateTime), N'Racao DateTime', NULL, N'Propria', CAST(N'2019-01-25T00:00:00.000' AS DateTime), N'Teste', N'kg', CAST(15 AS Numeric(4, 0)))
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (48, CAST(N'2019-10-09T00:06:52.570' AS DateTime), N'Vacina Teste Gabriel', N'PERNA', N'Zoetis LTDA', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'PIPIPI POPOPO', N'ds', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (49, CAST(N'2019-10-18T13:51:12.930' AS DateTime), N'final', N'pescoço', N'zoetis', CAST(N'2020-05-31T00:00:00.000' AS DateTime), N'dsds', N'ml', NULL)
INSERT [base].[produtos] ([idProduto], [dtCadastro], [nomeProduto], [localAplicacao], [fabricante], [validade], [descricao], [unidade], [ganhoPeso]) VALUES (50, CAST(N'2019-10-18T13:51:52.183' AS DateTime), N'FInal teste', NULL, N'Zoetis', CAST(N'2020-12-25T00:00:00.000' AS DateTime), N'final', N'tonelada', CAST(2 AS Numeric(4, 0)))
SET IDENTITY_INSERT [base].[produtos] OFF
SET IDENTITY_INSERT [base].[situacaoVidaSuinos] ON 

INSERT [base].[situacaoVidaSuinos] ([idSituacaoVida], [descricao]) VALUES (1, N'Vivo')
INSERT [base].[situacaoVidaSuinos] ([idSituacaoVida], [descricao]) VALUES (2, N'Abatido')
INSERT [base].[situacaoVidaSuinos] ([idSituacaoVida], [descricao]) VALUES (3, N'Morto')
INSERT [base].[situacaoVidaSuinos] ([idSituacaoVida], [descricao]) VALUES (4, N'Infância')
SET IDENTITY_INSERT [base].[situacaoVidaSuinos] OFF
SET IDENTITY_INSERT [base].[suinos] ON 

INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (41, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (42, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (43, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (44, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (45, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (46, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (47, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (48, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (49, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (50, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (51, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (52, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (53, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (54, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (55, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (56, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (57, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (58, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (59, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (60, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (61, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (62, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (63, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (64, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (65, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (66, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (67, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (68, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (69, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (70, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (71, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (72, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (73, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (74, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (75, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (76, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (77, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (78, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (79, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (80, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (81, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (82, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (83, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (84, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (85, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (86, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (87, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (88, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (89, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (90, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (91, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (92, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (93, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (94, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (95, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (96, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (97, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (98, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (99, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (100, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (101, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (102, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (103, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (104, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (105, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (106, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (107, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (108, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (109, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (110, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (111, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (112, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (113, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (114, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (115, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (116, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (117, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (118, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (119, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (120, CAST(N'1999-06-25T00:00:00.000' AS DateTime), 0, 2, CAST(1500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (121, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (122, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (123, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (124, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (125, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (126, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (127, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (128, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (129, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (130, CAST(N'1998-12-25T00:00:00.000' AS DateTime), 0, 2, CAST(555.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (131, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (132, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (133, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (134, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (135, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (136, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (137, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (138, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (139, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
GO
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (140, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (141, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (142, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (143, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (144, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (145, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (146, CAST(N'2002-04-25T00:00:00.000' AS DateTime), 1, 2, CAST(150.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (147, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (148, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (149, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (150, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (151, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (152, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (153, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (154, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (155, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (156, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (157, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (158, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (159, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (160, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (161, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (162, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (163, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (164, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (165, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (166, CAST(N'2019-10-08T00:00:00.000' AS DateTime), 1, 2, CAST(1200.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (167, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (168, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (169, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (170, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (171, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (172, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (173, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (174, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (175, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (176, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (177, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (178, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (179, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (180, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (181, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (182, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (183, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (184, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (185, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (186, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (187, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (188, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (189, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (190, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (191, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (192, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (193, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (194, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (195, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (196, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (197, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (198, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (199, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (200, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (201, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (202, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (203, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (204, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (205, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (206, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (207, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (208, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (209, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (210, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (211, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (212, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (213, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (214, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (215, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (216, CAST(N'1998-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(500.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (217, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (218, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (219, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (220, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (221, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (222, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (223, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (224, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (225, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (226, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (227, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (228, CAST(N'2019-10-12T00:00:00.000' AS DateTime), 0, 2, CAST(750.00 AS Numeric(14, 2)), 2, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (229, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (230, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (231, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (232, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (233, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (234, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (235, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (236, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (237, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (238, CAST(N'1999-05-31T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (239, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
GO
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (240, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (241, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (242, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (243, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (244, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (245, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (246, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (247, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (248, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (249, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (250, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (251, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (252, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (253, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (254, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (255, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (256, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (257, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (258, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (259, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (260, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (261, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (262, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (263, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (264, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (265, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (266, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (267, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (268, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (269, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (270, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (271, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (272, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (273, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (274, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (275, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (276, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (277, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (278, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (279, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (280, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (281, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (282, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (283, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (284, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (285, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (286, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (287, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (288, CAST(N'2019-05-05T00:00:00.000' AS DateTime), 1, 2, CAST(50.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (289, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (290, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (291, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (292, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (293, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (294, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (295, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (296, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (297, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (298, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (299, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (300, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (301, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (302, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (303, CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, 2, CAST(2.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (304, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (305, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (306, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (307, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (308, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (309, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (310, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (311, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (312, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (313, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (314, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (315, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (316, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (317, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (318, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (319, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (320, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (321, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (322, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (323, CAST(N'2019-10-10T00:00:00.000' AS DateTime), 0, 2, CAST(2000.00 AS Numeric(14, 2)), 1, NULL, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (324, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (325, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (326, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (327, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (328, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (329, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (330, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (331, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (332, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (333, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (334, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (335, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (336, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (337, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (338, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (339, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
GO
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (340, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (341, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (342, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (343, CAST(N'2019-10-16T00:00:00.000' AS DateTime), 1, 1, CAST(5.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (344, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (345, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (346, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (347, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (348, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (349, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (350, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (351, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (352, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (353, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (354, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (355, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (356, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (357, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (358, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (359, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (360, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (361, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (362, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (363, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (364, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (365, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (366, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (367, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (368, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (369, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (370, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (371, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (372, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (373, CAST(N'2001-01-25T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (374, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (375, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (376, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (377, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (378, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (379, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (380, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (381, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (382, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (383, CAST(N'2002-02-02T00:00:00.000' AS DateTime), 0, 1, CAST(15.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (384, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (385, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (386, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (387, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (388, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (389, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (390, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (391, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (392, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (393, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (394, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (395, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (396, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (397, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (398, CAST(N'1800-12-31T00:00:00.000' AS DateTime), 0, 1, CAST(9.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (399, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (400, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (401, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (402, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (403, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (404, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (405, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (406, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (407, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (408, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (409, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (410, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (411, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (412, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (413, CAST(N'2019-05-22T00:00:00.000' AS DateTime), 0, 1, CAST(10.00 AS Numeric(14, 2)), 1, 114, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (414, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (415, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (416, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (417, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (418, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (419, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (420, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (421, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (422, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (423, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (424, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (425, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (426, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (427, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
INSERT [base].[suinos] ([idSuino], [dtNascimento], [sexo], [idSituacaoVida], [peso], [idUsuario], [idMae], [valorAquisicao]) VALUES (428, CAST(N'2019-10-18T00:00:00.000' AS DateTime), 0, 1, CAST(212.00 AS Numeric(14, 2)), 1, 117, NULL)
SET IDENTITY_INSERT [base].[suinos] OFF
SET IDENTITY_INSERT [base].[usuarios] ON 

INSERT [base].[usuarios] ([idUsuario], [usuario], [senha], [dtCadastro]) VALUES (1, N'admin', N'4321', CAST(N'2019-09-12T00:49:34.867' AS DateTime))
INSERT [base].[usuarios] ([idUsuario], [usuario], [senha], [dtCadastro]) VALUES (2, N'luis', N'1q1q2w2w', CAST(N'2019-10-10T19:46:32.680' AS DateTime))
SET IDENTITY_INSERT [base].[usuarios] OFF
SET IDENTITY_INSERT [controle].[lotes] ON 

INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (2, 1, CAST(N'2019-10-03T15:51:33.070' AS DateTime), CAST(N'2019-12-01T00:00:00.000' AS DateTime), N'Teste Lote Luis', N'Testando nova proc por causa da modificação no BD', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (3, 1, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-12-01T00:00:00.000' AS DateTime), N'Teste Lote Luis', N'Testando nova proc por causa da modificação no BD', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (4, 1, CAST(N'2019-10-03T22:34:34.680' AS DateTime), CAST(N'2020-01-25T12:01:00.000' AS DateTime), N'Lote 03', N'Teste', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (5, 1, CAST(N'2019-10-03T22:59:10.640' AS DateTime), CAST(N'2020-01-25T12:01:00.000' AS DateTime), N'Lote 03', N'tetste', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (6, 2, CAST(N'2019-10-06T17:53:02.057' AS DateTime), CAST(N'2019-11-24T12:11:00.000' AS DateTime), N'Lote Lotudo Lotunense', N'Um lote top!', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (7, 4, CAST(N'2019-10-06T17:53:42.227' AS DateTime), CAST(N'2020-01-20T12:01:00.000' AS DateTime), N'Lotinho teste Luisinho 2', N'hehe pipipi popopo', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (8, 5, CAST(N'2019-10-07T16:05:25.450' AS DateTime), CAST(N'2019-10-07T16:05:25.450' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (9, 5, CAST(N'2019-10-07T16:05:53.620' AS DateTime), CAST(N'2019-10-07T16:05:53.620' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (10, 5, CAST(N'2019-10-07T16:07:42.667' AS DateTime), CAST(N'2019-10-07T16:07:42.667' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (11, 5, CAST(N'2019-10-07T16:08:21.620' AS DateTime), CAST(N'2019-10-07T16:08:21.620' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (12, 4, CAST(N'2019-10-08T19:00:01.190' AS DateTime), CAST(N'2020-12-22T12:12:00.000' AS DateTime), N'Teste Pre Abate', N'Testando Venda', 2)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (13, 1, CAST(N'2019-10-09T00:13:05.820' AS DateTime), CAST(N'2019-10-20T12:10:00.000' AS DateTime), N'Lote teste gabriel', N'Lote de teste com GAbriel ao lado.', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (14, 5, CAST(N'2019-10-11T23:33:36.620' AS DateTime), CAST(N'2019-10-11T23:33:36.620' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (15, 5, CAST(N'2019-10-11T23:37:09.017' AS DateTime), CAST(N'2019-10-11T23:37:09.017' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (16, 5, CAST(N'2019-10-14T14:26:04.787' AS DateTime), CAST(N'2019-10-14T14:26:04.787' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (17, 5, CAST(N'2019-10-14T14:27:38.293' AS DateTime), CAST(N'2019-10-14T14:27:38.293' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (18, 5, CAST(N'2019-10-14T15:44:18.760' AS DateTime), CAST(N'2019-10-14T15:44:18.760' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (19, 5, CAST(N'2019-10-14T15:47:27.443' AS DateTime), CAST(N'2019-10-14T15:47:27.443' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (20, 5, CAST(N'2019-10-14T16:13:00.020' AS DateTime), CAST(N'2019-10-14T16:13:00.020' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (21, 1, CAST(N'2019-10-15T23:25:15.117' AS DateTime), CAST(N'2019-10-17T12:10:00.000' AS DateTime), N'Recria do Verão', N'Inserindo 30 machos para uma nova engorda.', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (22, 2, CAST(N'2019-10-15T23:27:53.010' AS DateTime), CAST(N'2019-11-15T12:11:00.000' AS DateTime), N'Recria para 2020', N'Esse lote será uma um investimento para janeiro de 2020.', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (23, 3, CAST(N'2019-10-15T23:29:31.107' AS DateTime), CAST(N'2019-12-10T12:12:00.000' AS DateTime), N'Desmama para vender no Natal', N'', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (24, 5, CAST(N'2019-10-16T15:53:12.323' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime), N'VENDA > SISTEMA FINALIZA LOTE', N'VENDA > SISTEMA FINALIZA LOTE', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (25, 4, CAST(N'2019-10-16T23:31:42.477' AS DateTime), CAST(N'2019-02-15T12:02:00.000' AS DateTime), N'Teste', N'Teste', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (26, 4, CAST(N'2019-10-18T13:53:48.460' AS DateTime), CAST(N'2021-12-31T12:12:00.000' AS DateTime), N'Teste Finaaal', N'', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (27, 4, CAST(N'2019-10-18T13:55:08.583' AS DateTime), CAST(N'2020-12-31T12:12:00.000' AS DateTime), N'Teste Finaal', N'dsds', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (28, 1, CAST(N'2019-10-18T13:59:32.047' AS DateTime), CAST(N'2020-05-31T12:05:00.000' AS DateTime), N'testetetste', N'dsdsd', 1)
INSERT [controle].[lotes] ([idLote], [idTipoLote], [dtCriacaoLote], [dtVencimentoLote], [nome], [descricao], [idStatusLote]) VALUES (29, 1, CAST(N'2019-10-18T14:25:10.597' AS DateTime), CAST(N'2020-05-05T12:05:00.000' AS DateTime), N'testtetetetee', N'dsdsds', 1)
SET IDENTITY_INSERT [controle].[lotes] OFF
SET IDENTITY_INSERT [controle].[pesosLote] ON 

INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (3, 2, 1, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(1200.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (4, 3, 1, CAST(N'2019-10-03T15:56:20.523' AS DateTime), CAST(1200.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (5, 3, 1, CAST(N'2019-10-03T17:55:45.830' AS DateTime), CAST(500.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (6, 3, 1, CAST(N'2019-10-03T17:56:02.840' AS DateTime), CAST(500.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (7, 3, 1, CAST(N'2019-10-03T17:56:12.277' AS DateTime), CAST(5000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (8, 3, 1, CAST(N'2019-10-03T18:18:15.547' AS DateTime), CAST(5000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (9, 4, 1, CAST(N'2019-10-03T22:34:34.710' AS DateTime), CAST(1500.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (10, 5, 1, CAST(N'2019-10-03T22:59:10.653' AS DateTime), CAST(1500.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (11, 2, 1, CAST(N'2019-10-04T18:35:53.870' AS DateTime), CAST(5000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (12, 6, 1, CAST(N'2019-10-06T17:53:02.087' AS DateTime), CAST(2000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (13, 7, 1, CAST(N'2019-10-06T17:53:42.257' AS DateTime), CAST(1200.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (14, 12, 1, CAST(N'2019-10-08T19:00:01.190' AS DateTime), CAST(1000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (15, 13, 1, CAST(N'2019-10-09T00:13:05.857' AS DateTime), CAST(1000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (16, 13, 1, CAST(N'2019-10-09T00:20:37.307' AS DateTime), CAST(1000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (17, 13, 1, CAST(N'2019-10-09T00:20:45.090' AS DateTime), CAST(1000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (18, 13, 1, CAST(N'2019-10-09T00:20:55.727' AS DateTime), CAST(1050.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (19, 13, 1, CAST(N'2019-10-09T00:22:50.083' AS DateTime), CAST(1050.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (20, 21, 1, CAST(N'2019-10-15T23:25:15.153' AS DateTime), CAST(1200.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (21, 22, 1, CAST(N'2019-10-15T23:27:53.027' AS DateTime), CAST(900.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (22, 23, 1, CAST(N'2019-10-15T23:29:31.123' AS DateTime), CAST(1400.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (23, 25, 1, CAST(N'2019-10-16T23:31:42.567' AS DateTime), CAST(5000.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (24, 27, 1, CAST(N'2019-10-18T13:55:08.700' AS DateTime), CAST(150.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (25, 28, 1, CAST(N'2019-10-18T13:59:32.063' AS DateTime), CAST(15.00 AS Numeric(14, 2)))
INSERT [controle].[pesosLote] ([idPesagemLote], [idLote], [idUsuario], [dtPesagem], [pesoG]) VALUES (26, 29, 1, CAST(N'2019-10-18T14:25:10.597' AS DateTime), CAST(15.00 AS Numeric(14, 2)))
SET IDENTITY_INSERT [controle].[pesosLote] OFF
SET IDENTITY_INSERT [controle].[statusLote] ON 

INSERT [controle].[statusLote] ([idStatusLote], [descStatusLote]) VALUES (1, N'Ativo')
INSERT [controle].[statusLote] ([idStatusLote], [descStatusLote]) VALUES (2, N'Inativo')
SET IDENTITY_INSERT [controle].[statusLote] OFF
INSERT [controle].[tiposLote] ([idTipoLote], [descTipoLote]) VALUES (1, N'Engorda')
INSERT [controle].[tiposLote] ([idTipoLote], [descTipoLote]) VALUES (2, N'Recria')
INSERT [controle].[tiposLote] ([idTipoLote], [descTipoLote]) VALUES (3, N'Pós-Desmama')
INSERT [controle].[tiposLote] ([idTipoLote], [descTipoLote]) VALUES (4, N'Pré-abate')
INSERT [controle].[tiposLote] ([idTipoLote], [descTipoLote]) VALUES (5, N'Finalizado')
SET IDENTITY_INSERT [controle].[tiposTratamentoLote] ON 

INSERT [controle].[tiposTratamentoLote] ([idTipoTratamento], [descTipoTratamento]) VALUES (1, N'Dieta')
INSERT [controle].[tiposTratamentoLote] ([idTipoTratamento], [descTipoTratamento]) VALUES (2, N'Vacina')
SET IDENTITY_INSERT [controle].[tiposTratamentoLote] OFF
SET IDENTITY_INSERT [controle].[tratamentosLote] ON 

INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (5, 2, 8, 1, CAST(N'2019-10-03T00:00:00.000' AS DateTime), CAST(N'2020-02-01T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (6, 2, 9, 2, CAST(N'2019-10-03T00:00:00.000' AS DateTime), CAST(N'2019-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (7, 3, 8, 1, CAST(N'2019-10-03T00:00:00.000' AS DateTime), CAST(N'2020-02-01T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (8, 3, 9, 2, CAST(N'2019-10-03T00:00:00.000' AS DateTime), CAST(N'2019-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (19, 3, 38, 1, CAST(N'2019-10-03T18:40:17.300' AS DateTime), CAST(N'2019-10-03T18:40:17.300' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (20, 3, 12, 1, CAST(N'2019-10-03T18:41:46.057' AS DateTime), CAST(N'2019-10-03T18:41:46.057' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (21, 3, 12, 1, CAST(N'2019-10-03T18:42:30.363' AS DateTime), CAST(N'2019-10-03T18:42:30.363' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (22, 3, 12, 1, CAST(N'2019-10-03T18:42:44.570' AS DateTime), CAST(N'2019-10-03T18:42:44.570' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (23, 2, 37, 2, CAST(N'2019-10-03T19:21:59.530' AS DateTime), CAST(N'1905-05-31T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (26, 2, 40, 2, CAST(N'2019-10-03T19:24:50.240' AS DateTime), CAST(N'1905-07-09T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (27, 2, 36, 2, CAST(N'2019-10-03T19:29:20.293' AS DateTime), CAST(N'1905-06-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (28, 2, 42, 2, CAST(N'2019-10-03T19:37:08.680' AS DateTime), CAST(N'1905-06-14T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (29, 2, 36, 2, CAST(N'2019-10-03T19:53:10.470' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (30, 2, 46, 2, CAST(N'2019-10-03T19:53:31.743' AS DateTime), CAST(N'2019-11-30T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (31, 2, 46, 2, CAST(N'2019-10-03T19:57:13.920' AS DateTime), CAST(N'2019-11-30T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (32, 4, 47, 1, CAST(N'2020-01-25T12:01:00.000' AS DateTime), CAST(N'2019-01-25T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (33, 4, 46, 2, CAST(N'2020-01-25T12:01:00.000' AS DateTime), CAST(N'2019-11-30T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (34, 5, 47, 1, CAST(N'2019-10-03T00:00:00.000' AS DateTime), CAST(N'2019-01-25T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (35, 5, 46, 2, CAST(N'2019-10-03T00:00:00.000' AS DateTime), CAST(N'2019-11-30T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (36, 2, 40, 2, CAST(N'2019-10-03T23:31:05.927' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (37, 2, 40, 2, CAST(N'2019-10-03T23:31:36.750' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (38, 2, 40, 2, CAST(N'2019-10-03T23:32:03.987' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (39, 2, 36, 2, CAST(N'2019-10-04T18:35:11.810' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (40, 2, 36, 2, CAST(N'2019-10-04T18:35:43.713' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (41, 2, 41, 1, CAST(N'2019-10-04T18:36:08.293' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (42, 2, 41, 1, CAST(N'2019-10-04T18:37:51.453' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (43, 2, 41, 1, CAST(N'2019-10-04T18:37:54.213' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (44, 2, 37, 1, CAST(N'2019-10-04T22:56:40.003' AS DateTime), CAST(N'2017-11-30T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (45, 6, 42, 1, CAST(N'2019-10-06T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (46, 6, 40, 2, CAST(N'2019-10-06T00:00:00.000' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (47, 7, 42, 1, CAST(N'2019-10-06T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (48, 7, 40, 2, CAST(N'2019-10-06T00:00:00.000' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (49, 12, 12, 1, CAST(N'2019-10-08T00:00:00.000' AS DateTime), CAST(N'2021-02-03T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (50, 12, 36, 2, CAST(N'2019-10-08T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (51, 13, 39, 1, CAST(N'2019-10-09T00:00:00.000' AS DateTime), CAST(N'2017-11-30T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (52, 13, 48, 2, CAST(N'2019-10-09T00:00:00.000' AS DateTime), CAST(N'1900-01-01T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (53, 13, 42, 1, CAST(N'2019-10-09T00:20:14.937' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (54, 13, 40, 2, CAST(N'2019-10-09T00:20:28.850' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (55, 3, 42, 1, CAST(N'2019-10-11T12:27:28.560' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (56, 3, 42, 1, CAST(N'2019-10-11T12:30:13.847' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (57, 3, 42, 1, CAST(N'2019-10-11T12:30:40.680' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (58, 3, 42, 1, CAST(N'2019-10-11T12:34:07.607' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (59, 3, 42, 1, CAST(N'2019-10-11T12:35:31.287' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (60, 3, 42, 1, CAST(N'2019-10-11T12:36:19.720' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (61, 3, 42, 1, CAST(N'2019-10-11T12:44:52.353' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (62, 13, 12, 1, CAST(N'2019-10-14T11:43:51.243' AS DateTime), CAST(N'2021-02-03T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (63, 2, 12, 1, CAST(N'2019-10-14T11:44:45.333' AS DateTime), CAST(N'2021-02-03T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (64, 2, 48, 2, CAST(N'2019-10-14T11:53:54.540' AS DateTime), CAST(N'1900-01-01T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (65, 2, 48, 2, CAST(N'2019-10-14T11:54:55.830' AS DateTime), CAST(N'1900-01-01T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (66, 21, 41, 1, CAST(N'2019-10-15T00:00:00.000' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (67, 21, 40, 2, CAST(N'2019-10-15T00:00:00.000' AS DateTime), CAST(N'2020-03-02T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (68, 22, 12, 1, CAST(N'2019-10-15T00:00:00.000' AS DateTime), CAST(N'2021-02-03T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (69, 22, 36, 2, CAST(N'2019-10-15T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (70, 23, 42, 1, CAST(N'2019-10-15T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (71, 23, 36, 2, CAST(N'2019-10-15T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (72, 25, 42, 1, CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (73, 25, 36, 2, CAST(N'2019-10-16T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (74, 26, 42, 1, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (75, 26, 36, 2, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (76, 27, 42, 1, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (77, 27, 36, 2, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (78, 27, 36, 2, CAST(N'2019-10-18T13:55:45.597' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (79, 28, 42, 1, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (80, 28, 36, 2, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (81, 28, 42, 1, CAST(N'2019-10-18T14:08:04.953' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (82, 27, 42, 1, CAST(N'2019-10-18T14:08:48.590' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (83, 27, 42, 1, CAST(N'2019-10-18T14:11:09.083' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (84, 27, 36, 2, CAST(N'2019-10-18T14:11:39.360' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (85, 3, 36, 2, CAST(N'2019-10-18T14:20:57.610' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (86, 3, 36, 2, CAST(N'2019-10-18T14:21:36.790' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (87, 3, 36, 2, CAST(N'2019-10-18T14:22:04.777' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (88, 29, 42, 1, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2022-12-20T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (89, 29, 36, 2, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (90, 29, 36, 2, CAST(N'2019-10-18T15:47:04.140' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (91, 3, 36, 2, CAST(N'2019-10-18T15:49:48.043' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (92, 3, 36, 2, CAST(N'2019-10-18T15:50:54.797' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (93, 3, 36, 2, CAST(N'2019-10-18T15:52:41.417' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (94, 3, 36, 2, CAST(N'2019-10-18T15:53:35.803' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (95, 22, 36, 2, CAST(N'2019-10-18T15:55:05.953' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (96, 3, 36, 2, CAST(N'2019-10-18T15:58:42.910' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (97, 3, 36, 2, CAST(N'2019-10-18T15:59:45.957' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (98, 3, 36, 2, CAST(N'2019-10-18T16:05:23.780' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (99, 3, 36, 2, CAST(N'2019-10-18T16:05:52.473' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (100, 3, 36, 2, CAST(N'2019-10-18T16:08:43.320' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (101, 3, 36, 2, CAST(N'2019-10-18T16:09:46.783' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
INSERT [controle].[tratamentosLote] ([idTratamentoLote], [idLote], [idProduto], [idTipoTratamento], [dtInicioAplicacao], [dtFimAplicacao]) VALUES (102, 3, 36, 2, CAST(N'2019-10-18T16:13:16.373' AS DateTime), CAST(N'2018-11-29T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [controle].[tratamentosLote] OFF
SET IDENTITY_INSERT [controle].[vendasLote] ON 

INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (5, 14, CAST(N'2019-10-11T23:33:36.620' AS DateTime), CAST(696969.00 AS Numeric(13, 2)), N'SAFADAO')
INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (6, 15, CAST(N'2019-10-11T23:37:09.017' AS DateTime), CAST(2121.00 AS Numeric(13, 2)), N'teste com ze botando defeito')
INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (7, 16, CAST(N'2019-10-14T14:26:04.787' AS DateTime), CAST(1500.00 AS Numeric(13, 2)), N'1')
INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (8, 17, CAST(N'2019-10-14T14:27:38.293' AS DateTime), CAST(3000.00 AS Numeric(13, 2)), N'1')
INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (9, 18, CAST(N'2019-10-14T15:44:18.760' AS DateTime), CAST(3000.00 AS Numeric(13, 2)), N'1')
INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (10, 19, CAST(N'2019-10-14T15:47:27.443' AS DateTime), CAST(5.00 AS Numeric(13, 2)), N'Joaaao')
INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (11, 20, CAST(N'2019-10-14T16:13:00.020' AS DateTime), CAST(65000.00 AS Numeric(13, 2)), N'José Carlos')
INSERT [controle].[vendasLote] ([idVendaLote], [idLote], [dtVenda], [valor], [cliente]) VALUES (12, 24, CAST(N'2019-10-16T15:53:12.323' AS DateTime), CAST(55555.00 AS Numeric(13, 2)), N'Teste Relatório')
SET IDENTITY_INSERT [controle].[vendasLote] OFF
SET IDENTITY_INSERT [rlc].[loteSuinos] ON 

INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (70, 2, 41, CAST(N'2019-10-03T15:51:33.070' AS DateTime), CAST(N'2019-09-10T00:00:00.000' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (71, 2, 42, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-10T14:10:03.033' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (72, 2, 43, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-14T00:00:00.000' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (73, 2, 44, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-14T14:14:27.143' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (74, 2, 45, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-10T00:00:00.000' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (75, 2, 71, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-07T14:30:35.773' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (76, 2, 72, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-14T14:14:27.143' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (77, 2, 73, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-14T14:14:27.143' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (78, 2, 74, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-14T14:14:27.143' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (79, 2, 75, CAST(N'2019-10-03T15:51:33.083' AS DateTime), CAST(N'2019-10-14T14:14:27.143' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (80, 3, 46, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (81, 3, 47, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (82, 3, 48, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (83, 3, 49, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (84, 3, 50, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (85, 3, 76, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (86, 3, 77, CAST(N'2019-10-03T15:56:20.510' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (87, 3, 78, CAST(N'2019-10-03T15:56:20.523' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (88, 3, 79, CAST(N'2019-10-03T15:56:20.523' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (89, 3, 80, CAST(N'2019-10-03T15:56:20.523' AS DateTime), CAST(N'2019-10-14T15:42:44.830' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (90, 4, 51, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (91, 4, 52, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (92, 4, 53, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (93, 4, 54, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (94, 4, 55, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (95, 4, 56, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (96, 4, 57, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (97, 4, 58, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (98, 4, 59, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (99, 4, 60, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (100, 4, 81, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (101, 4, 82, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (102, 4, 83, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (103, 4, 84, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (104, 4, 85, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (105, 4, 86, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (106, 4, 87, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (107, 4, 88, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (108, 4, 89, CAST(N'2019-10-03T22:34:34.697' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (109, 4, 90, CAST(N'2019-10-03T22:34:34.710' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (110, 4, 91, CAST(N'2019-10-03T22:34:34.710' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (111, 4, 92, CAST(N'2019-10-03T22:34:34.710' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (112, 4, 93, CAST(N'2019-10-03T22:34:34.710' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (113, 4, 94, CAST(N'2019-10-03T22:34:34.710' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (114, 4, 95, CAST(N'2019-10-03T22:34:34.710' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (115, 5, 61, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (116, 5, 62, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (117, 5, 63, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (118, 5, 64, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (119, 5, 65, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (120, 5, 66, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (121, 5, 67, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (122, 5, 68, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (123, 5, 69, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (124, 5, 70, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (125, 5, 96, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (126, 5, 97, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (127, 5, 98, CAST(N'2019-10-03T22:59:10.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (128, 5, 99, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (129, 5, 100, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (130, 5, 101, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (131, 5, 102, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (132, 5, 103, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (133, 5, 104, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (134, 5, 105, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (135, 5, 106, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (136, 5, 107, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (137, 5, 108, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (138, 5, 109, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (139, 5, 110, CAST(N'2019-10-03T22:59:10.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (140, 6, 131, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (141, 6, 132, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (142, 6, 133, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (143, 6, 134, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (144, 6, 135, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (145, 6, 136, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (146, 6, 137, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (147, 6, 138, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (148, 6, 139, CAST(N'2019-10-06T17:53:02.057' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (149, 6, 140, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (150, 6, 111, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (151, 6, 112, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (152, 6, 113, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (153, 6, 114, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (154, 6, 115, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (155, 6, 116, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (156, 6, 117, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (157, 6, 118, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (158, 6, 119, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (159, 6, 120, CAST(N'2019-10-06T17:53:02.070' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (160, 7, 141, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (161, 7, 142, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (162, 7, 143, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (163, 7, 144, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (164, 7, 121, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (165, 7, 122, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (166, 7, 123, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (167, 7, 124, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (168, 7, 125, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
GO
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (169, 7, 126, CAST(N'2019-10-06T17:53:42.240' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (170, 7, 127, CAST(N'2019-10-06T17:53:42.257' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (171, 7, 128, CAST(N'2019-10-06T17:53:42.257' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (172, 7, 129, CAST(N'2019-10-06T17:53:42.257' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (173, 7, 130, CAST(N'2019-10-06T17:53:42.257' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (174, 5, 71, CAST(N'2019-10-07T14:30:35.773' AS DateTime), CAST(N'2019-10-07T15:47:12.047' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (175, 5, 71, CAST(N'2019-10-07T15:45:19.013' AS DateTime), CAST(N'2019-10-07T15:47:12.047' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (176, 5, 71, CAST(N'2019-10-07T15:45:36.787' AS DateTime), CAST(N'2019-10-07T15:47:12.047' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (177, 5, 71, CAST(N'2019-10-07T15:47:12.047' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (178, 12, 145, CAST(N'2019-10-08T19:00:01.190' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (179, 12, 146, CAST(N'2019-10-08T19:00:01.190' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (180, 13, 147, CAST(N'2019-10-09T00:13:05.823' AS DateTime), CAST(N'2019-10-09T00:27:05.033' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (181, 13, 148, CAST(N'2019-10-09T00:13:05.823' AS DateTime), CAST(N'2019-10-10T13:23:41.540' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (182, 13, 149, CAST(N'2019-10-09T00:13:05.823' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (183, 13, 150, CAST(N'2019-10-09T00:13:05.827' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (184, 13, 151, CAST(N'2019-10-09T00:13:05.827' AS DateTime), CAST(N'2019-10-09T13:38:28.093' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (185, 13, 152, CAST(N'2019-10-09T00:13:05.830' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (186, 13, 153, CAST(N'2019-10-09T00:13:05.830' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (187, 13, 154, CAST(N'2019-10-09T00:13:05.833' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (188, 13, 155, CAST(N'2019-10-09T00:13:05.833' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (189, 13, 156, CAST(N'2019-10-09T00:13:05.837' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (190, 13, 157, CAST(N'2019-10-09T00:13:05.837' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (191, 13, 158, CAST(N'2019-10-09T00:13:05.840' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (192, 13, 159, CAST(N'2019-10-09T00:13:05.840' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (193, 13, 160, CAST(N'2019-10-09T00:13:05.843' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (194, 13, 161, CAST(N'2019-10-09T00:13:05.843' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (195, 13, 162, CAST(N'2019-10-09T00:13:05.847' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (196, 13, 163, CAST(N'2019-10-09T00:13:05.850' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (197, 13, 164, CAST(N'2019-10-09T00:13:05.850' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (198, 13, 165, CAST(N'2019-10-09T00:13:05.853' AS DateTime), CAST(N'2019-10-14T15:47:01.267' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (199, 13, 166, CAST(N'2019-10-09T00:13:05.853' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (200, 12, 147, CAST(N'2019-10-09T00:27:05.033' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (206, 13, 42, CAST(N'2019-10-10T14:10:03.033' AS DateTime), CAST(N'2019-10-10T00:00:00.000' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (207, 13, 42, CAST(N'2019-10-10T14:17:19.573' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (208, 14, 145, CAST(N'2019-10-11T23:33:36.620' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (209, 14, 146, CAST(N'2019-10-11T23:33:36.620' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (210, 14, 147, CAST(N'2019-10-11T23:33:36.620' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (211, 15, 145, CAST(N'2019-10-11T23:37:09.017' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (212, 15, 146, CAST(N'2019-10-11T23:37:09.017' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (213, 15, 147, CAST(N'2019-10-11T23:37:09.017' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (214, 4, 44, CAST(N'2019-10-14T14:14:27.143' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (215, 4, 72, CAST(N'2019-10-14T14:14:27.143' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (216, 4, 73, CAST(N'2019-10-14T14:14:27.143' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (217, 4, 74, CAST(N'2019-10-14T14:14:27.143' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (218, 4, 75, CAST(N'2019-10-14T14:14:27.143' AS DateTime), CAST(N'2019-10-14T14:14:55.913' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (219, 13, 51, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (220, 13, 52, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (221, 13, 53, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (222, 13, 54, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (223, 13, 55, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (224, 13, 56, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (225, 13, 57, CAST(N'2019-10-14T14:14:55.913' AS DateTime), CAST(N'2019-10-14T15:49:17.167' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (226, 13, 58, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (227, 13, 59, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (228, 13, 60, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (229, 13, 81, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (230, 13, 82, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (231, 13, 83, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (232, 13, 84, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (233, 13, 85, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (234, 13, 86, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (235, 13, 87, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (236, 13, 88, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (237, 13, 89, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (238, 13, 90, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (239, 13, 91, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (240, 13, 92, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (241, 13, 93, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (242, 13, 94, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (243, 13, 95, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (244, 13, 44, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (245, 13, 72, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (246, 13, 73, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (247, 13, 74, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (248, 13, 75, CAST(N'2019-10-14T14:14:55.913' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (249, 16, 145, CAST(N'2019-10-14T14:26:04.787' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (250, 16, 146, CAST(N'2019-10-14T14:26:04.787' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (251, 16, 147, CAST(N'2019-10-14T14:26:04.787' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (252, 17, 145, CAST(N'2019-10-14T14:27:38.293' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (253, 17, 146, CAST(N'2019-10-14T14:27:38.293' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (254, 17, 147, CAST(N'2019-10-14T14:27:38.293' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (255, 12, 46, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (256, 12, 47, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (257, 12, 48, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (258, 12, 49, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (259, 12, 50, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (260, 12, 76, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (261, 12, 77, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (262, 12, 78, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (263, 12, 79, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (264, 12, 80, CAST(N'2019-10-14T15:42:44.847' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (265, 18, 145, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (266, 18, 146, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (267, 18, 147, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (268, 18, 46, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (269, 18, 47, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (270, 18, 48, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (271, 18, 49, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (272, 18, 50, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (273, 18, 76, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
GO
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (274, 18, 77, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (275, 18, 78, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (276, 18, 79, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (277, 18, 80, CAST(N'2019-10-14T15:44:18.760' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (278, 12, 165, CAST(N'2019-10-14T15:47:01.267' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (279, 12, 57, CAST(N'2019-10-14T15:49:17.167' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (280, 20, 145, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (281, 20, 146, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (282, 20, 147, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (283, 20, 46, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (284, 20, 47, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (285, 20, 48, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (286, 20, 49, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (287, 20, 50, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (288, 20, 76, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (289, 20, 77, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (290, 20, 78, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (291, 20, 79, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (292, 20, 80, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (293, 20, 165, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (294, 20, 57, CAST(N'2019-10-14T16:13:00.020' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (295, 12, 289, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (296, 12, 290, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (297, 12, 291, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (298, 12, 292, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (299, 12, 293, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (300, 12, 294, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (301, 12, 295, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (302, 12, 296, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (303, 12, 297, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (304, 12, 298, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (305, 12, 299, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (306, 12, 300, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (307, 12, 301, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (308, 12, 302, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (309, 12, 303, CAST(N'2019-10-14T17:11:08.630' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (310, 21, 229, CAST(N'2019-10-15T23:25:15.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (311, 21, 230, CAST(N'2019-10-15T23:25:15.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (312, 21, 231, CAST(N'2019-10-15T23:25:15.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (313, 21, 232, CAST(N'2019-10-15T23:25:15.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (314, 21, 233, CAST(N'2019-10-15T23:25:15.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (315, 21, 234, CAST(N'2019-10-15T23:25:15.123' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (316, 21, 235, CAST(N'2019-10-15T23:25:15.123' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (317, 21, 236, CAST(N'2019-10-15T23:25:15.123' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (318, 21, 237, CAST(N'2019-10-15T23:25:15.127' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (319, 21, 238, CAST(N'2019-10-15T23:25:15.127' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (320, 21, 239, CAST(N'2019-10-15T23:25:15.127' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (321, 21, 240, CAST(N'2019-10-15T23:25:15.127' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (322, 21, 241, CAST(N'2019-10-15T23:25:15.130' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (323, 21, 242, CAST(N'2019-10-15T23:25:15.130' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (324, 21, 243, CAST(N'2019-10-15T23:25:15.130' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (325, 21, 244, CAST(N'2019-10-15T23:25:15.133' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (326, 21, 245, CAST(N'2019-10-15T23:25:15.133' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (327, 21, 246, CAST(N'2019-10-15T23:25:15.133' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (328, 21, 247, CAST(N'2019-10-15T23:25:15.137' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (329, 21, 248, CAST(N'2019-10-15T23:25:15.137' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (330, 21, 249, CAST(N'2019-10-15T23:25:15.137' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (331, 21, 250, CAST(N'2019-10-15T23:25:15.140' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (332, 21, 251, CAST(N'2019-10-15T23:25:15.140' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (333, 21, 252, CAST(N'2019-10-15T23:25:15.140' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (334, 21, 253, CAST(N'2019-10-15T23:25:15.143' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (335, 21, 254, CAST(N'2019-10-15T23:25:15.143' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (336, 21, 255, CAST(N'2019-10-15T23:25:15.147' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (337, 21, 256, CAST(N'2019-10-15T23:25:15.147' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (338, 21, 257, CAST(N'2019-10-15T23:25:15.147' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (339, 21, 258, CAST(N'2019-10-15T23:25:15.150' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (340, 22, 304, CAST(N'2019-10-15T23:27:53.010' AS DateTime), CAST(N'2019-10-15T23:34:56.623' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (341, 22, 305, CAST(N'2019-10-15T23:27:53.010' AS DateTime), CAST(N'2019-10-15T23:37:33.910' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (342, 22, 306, CAST(N'2019-10-15T23:27:53.010' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (343, 22, 307, CAST(N'2019-10-15T23:27:53.010' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (344, 22, 308, CAST(N'2019-10-15T23:27:53.010' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (345, 22, 309, CAST(N'2019-10-15T23:27:53.010' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (346, 22, 310, CAST(N'2019-10-15T23:27:53.010' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (347, 22, 311, CAST(N'2019-10-15T23:27:53.027' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (348, 23, 259, CAST(N'2019-10-15T23:29:31.110' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (349, 23, 260, CAST(N'2019-10-15T23:29:31.110' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (350, 23, 261, CAST(N'2019-10-15T23:29:31.110' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (351, 23, 262, CAST(N'2019-10-15T23:29:31.113' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (352, 23, 263, CAST(N'2019-10-15T23:29:31.113' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (353, 23, 312, CAST(N'2019-10-15T23:29:31.117' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (354, 23, 313, CAST(N'2019-10-15T23:29:31.117' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (355, 23, 314, CAST(N'2019-10-15T23:29:31.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (356, 23, 315, CAST(N'2019-10-15T23:29:31.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (357, 23, 316, CAST(N'2019-10-15T23:29:31.120' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (358, 12, 304, CAST(N'2019-10-15T23:34:56.623' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (359, 12, 304, CAST(N'2019-10-15T23:34:58.680' AS DateTime), CAST(N'2019-10-16T15:53:12.323' AS DateTime))
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (360, 23, 305, CAST(N'2019-10-15T23:37:33.910' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (361, 24, 145, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (362, 24, 146, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (363, 24, 147, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (364, 24, 46, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (365, 24, 47, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (366, 24, 48, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (367, 24, 49, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (368, 24, 50, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (369, 24, 76, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (370, 24, 77, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (371, 24, 78, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (372, 24, 79, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (373, 24, 80, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
GO
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (374, 24, 165, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (375, 24, 57, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (376, 24, 289, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (377, 24, 290, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (378, 24, 291, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (379, 24, 292, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (380, 24, 293, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (381, 24, 294, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (382, 24, 295, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (383, 24, 296, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (384, 24, 297, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (385, 24, 298, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (386, 24, 299, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (387, 24, 300, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (388, 24, 301, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (389, 24, 302, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (390, 24, 303, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (391, 24, 304, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (392, 24, 304, CAST(N'2019-10-16T15:53:12.323' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (393, 25, 324, CAST(N'2019-10-16T23:31:42.477' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (394, 25, 325, CAST(N'2019-10-16T23:31:42.477' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (395, 25, 326, CAST(N'2019-10-16T23:31:42.477' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (396, 25, 327, CAST(N'2019-10-16T23:31:42.477' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (397, 25, 328, CAST(N'2019-10-16T23:31:42.477' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (398, 25, 329, CAST(N'2019-10-16T23:31:42.477' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (399, 25, 330, CAST(N'2019-10-16T23:31:42.477' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (400, 25, 331, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (401, 25, 332, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (402, 25, 333, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (403, 25, 334, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (404, 25, 335, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (405, 25, 336, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (406, 25, 337, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (407, 25, 338, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (408, 25, 344, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (409, 25, 345, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (410, 25, 346, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (411, 25, 347, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (412, 25, 348, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (413, 25, 349, CAST(N'2019-10-16T23:31:42.490' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (414, 25, 350, CAST(N'2019-10-16T23:31:42.507' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (415, 25, 351, CAST(N'2019-10-16T23:31:42.507' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (416, 25, 352, CAST(N'2019-10-16T23:31:42.507' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (417, 25, 353, CAST(N'2019-10-16T23:31:42.507' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (418, 25, 354, CAST(N'2019-10-16T23:31:42.507' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (419, 25, 355, CAST(N'2019-10-16T23:31:42.507' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (420, 25, 356, CAST(N'2019-10-16T23:31:42.507' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (421, 25, 357, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (422, 25, 358, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (423, 25, 359, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (424, 25, 360, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (425, 25, 361, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (426, 25, 362, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (427, 25, 363, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (428, 25, 364, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (429, 25, 365, CAST(N'2019-10-16T23:31:42.520' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (430, 25, 366, CAST(N'2019-10-16T23:31:42.537' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (431, 25, 367, CAST(N'2019-10-16T23:31:42.537' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (432, 25, 368, CAST(N'2019-10-16T23:31:42.537' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (433, 25, 369, CAST(N'2019-10-16T23:31:42.537' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (434, 25, 370, CAST(N'2019-10-16T23:31:42.537' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (435, 25, 371, CAST(N'2019-10-16T23:31:42.537' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (436, 25, 372, CAST(N'2019-10-16T23:31:42.537' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (437, 25, 373, CAST(N'2019-10-16T23:31:42.550' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (438, 25, 374, CAST(N'2019-10-16T23:31:42.550' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (439, 25, 375, CAST(N'2019-10-16T23:31:42.550' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (440, 25, 376, CAST(N'2019-10-16T23:31:42.550' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (441, 25, 377, CAST(N'2019-10-16T23:31:42.550' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (442, 25, 378, CAST(N'2019-10-16T23:31:42.550' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (443, 3, 414, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (444, 3, 415, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (445, 3, 416, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (446, 3, 417, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (447, 3, 418, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (448, 3, 419, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (449, 3, 420, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (450, 3, 421, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (451, 3, 422, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (452, 3, 423, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (453, 3, 424, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (454, 3, 425, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (455, 3, 426, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (456, 3, 427, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (457, 3, 428, CAST(N'2019-10-18T13:53:09.220' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (458, 27, 339, CAST(N'2019-10-18T13:55:08.587' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (459, 27, 340, CAST(N'2019-10-18T13:55:08.587' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (460, 27, 341, CAST(N'2019-10-18T13:55:08.590' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (461, 27, 342, CAST(N'2019-10-18T13:55:08.590' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (462, 27, 379, CAST(N'2019-10-18T13:55:08.593' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (463, 27, 380, CAST(N'2019-10-18T13:55:08.597' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (464, 27, 381, CAST(N'2019-10-18T13:55:08.600' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (465, 27, 382, CAST(N'2019-10-18T13:55:08.603' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (466, 27, 383, CAST(N'2019-10-18T13:55:08.607' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (467, 27, 384, CAST(N'2019-10-18T13:55:08.610' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (468, 27, 385, CAST(N'2019-10-18T13:55:08.610' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (469, 27, 386, CAST(N'2019-10-18T13:55:08.613' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (470, 27, 387, CAST(N'2019-10-18T13:55:08.617' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (471, 27, 388, CAST(N'2019-10-18T13:55:08.620' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (472, 27, 389, CAST(N'2019-10-18T13:55:08.623' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (473, 27, 390, CAST(N'2019-10-18T13:55:08.627' AS DateTime), NULL)
GO
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (474, 27, 391, CAST(N'2019-10-18T13:55:08.630' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (475, 27, 392, CAST(N'2019-10-18T13:55:08.633' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (476, 27, 393, CAST(N'2019-10-18T13:55:08.637' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (477, 27, 394, CAST(N'2019-10-18T13:55:08.640' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (478, 27, 395, CAST(N'2019-10-18T13:55:08.643' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (479, 27, 396, CAST(N'2019-10-18T13:55:08.650' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (480, 27, 397, CAST(N'2019-10-18T13:55:08.653' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (481, 27, 398, CAST(N'2019-10-18T13:55:08.657' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (482, 27, 399, CAST(N'2019-10-18T13:55:08.660' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (483, 27, 400, CAST(N'2019-10-18T13:55:08.663' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (484, 27, 401, CAST(N'2019-10-18T13:55:08.670' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (485, 27, 402, CAST(N'2019-10-18T13:55:08.673' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (486, 27, 403, CAST(N'2019-10-18T13:55:08.677' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (487, 27, 404, CAST(N'2019-10-18T13:55:08.680' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (488, 27, 405, CAST(N'2019-10-18T13:55:08.683' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (489, 27, 406, CAST(N'2019-10-18T13:55:08.690' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (490, 27, 407, CAST(N'2019-10-18T13:55:08.693' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (491, 27, 408, CAST(N'2019-10-18T13:55:08.700' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (492, 28, 409, CAST(N'2019-10-18T13:59:32.047' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (493, 28, 410, CAST(N'2019-10-18T13:59:32.063' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (494, 28, 411, CAST(N'2019-10-18T13:59:32.063' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (495, 28, 412, CAST(N'2019-10-18T13:59:32.063' AS DateTime), NULL)
INSERT [rlc].[loteSuinos] ([idLoteSuino], [idLote], [idSuino], [dtEntradaSuino], [dtSaidaSuino]) VALUES (496, 29, 413, CAST(N'2019-10-18T14:25:10.597' AS DateTime), NULL)
SET IDENTITY_INSERT [rlc].[loteSuinos] OFF
ALTER TABLE [base].[estoques]  WITH CHECK ADD  CONSTRAINT [FK__estoques__idOper__5FB337D6] FOREIGN KEY([idOperacao])
REFERENCES [base].[operacoesEstoque] ([idOperacao])
GO
ALTER TABLE [base].[estoques] CHECK CONSTRAINT [FK__estoques__idOper__5FB337D6]
GO
ALTER TABLE [base].[estoques]  WITH CHECK ADD  CONSTRAINT [FK__estoques__idProd__628FA481] FOREIGN KEY([idProduto])
REFERENCES [base].[produtos] ([idProduto])
GO
ALTER TABLE [base].[estoques] CHECK CONSTRAINT [FK__estoques__idProd__628FA481]
GO
ALTER TABLE [base].[estoques]  WITH CHECK ADD  CONSTRAINT [FK__estoques__idUsua__7C4F7684] FOREIGN KEY([idUsuario])
REFERENCES [base].[usuarios] ([idUsuario])
GO
ALTER TABLE [base].[estoques] CHECK CONSTRAINT [FK__estoques__idUsua__7C4F7684]
GO
ALTER TABLE [base].[informacoesSuino]  WITH CHECK ADD  CONSTRAINT [FK__informaco__dtObs__3B40CD36] FOREIGN KEY([idSuino])
REFERENCES [base].[suinos] ([idSuino])
GO
ALTER TABLE [base].[informacoesSuino] CHECK CONSTRAINT [FK__informaco__dtObs__3B40CD36]
GO
ALTER TABLE [base].[suinos]  WITH CHECK ADD  CONSTRAINT [FK__suinos__id_situa__5070F446] FOREIGN KEY([idSituacaoVida])
REFERENCES [base].[situacaoVidaSuinos] ([idSituacaoVida])
GO
ALTER TABLE [base].[suinos] CHECK CONSTRAINT [FK__suinos__id_situa__5070F446]
GO
ALTER TABLE [base].[suinos]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [base].[usuarios] ([idUsuario])
GO
ALTER TABLE [controle].[lotes]  WITH CHECK ADD  CONSTRAINT [FK__lotes__idStatusL__46B27FE2] FOREIGN KEY([idStatusLote])
REFERENCES [controle].[statusLote] ([idStatusLote])
GO
ALTER TABLE [controle].[lotes] CHECK CONSTRAINT [FK__lotes__idStatusL__46B27FE2]
GO
ALTER TABLE [controle].[lotes]  WITH CHECK ADD  CONSTRAINT [FK__lotes__idTipoLot__6D0D32F4] FOREIGN KEY([idTipoLote])
REFERENCES [controle].[tiposLote] ([idTipoLote])
GO
ALTER TABLE [controle].[lotes] CHECK CONSTRAINT [FK__lotes__idTipoLot__6D0D32F4]
GO
ALTER TABLE [controle].[pesosLote]  WITH CHECK ADD  CONSTRAINT [FK__pesosLote__pesoG__5D95E53A] FOREIGN KEY([idLote])
REFERENCES [controle].[lotes] ([idLote])
GO
ALTER TABLE [controle].[pesosLote] CHECK CONSTRAINT [FK__pesosLote__pesoG__5D95E53A]
GO
ALTER TABLE [controle].[tratamentosLote]  WITH CHECK ADD  CONSTRAINT [FK__tratament__idLot__625A9A57] FOREIGN KEY([idLote])
REFERENCES [controle].[lotes] ([idLote])
GO
ALTER TABLE [controle].[tratamentosLote] CHECK CONSTRAINT [FK__tratament__idLot__625A9A57]
GO
ALTER TABLE [controle].[tratamentosLote]  WITH CHECK ADD  CONSTRAINT [FK__tratament__idPro__634EBE90] FOREIGN KEY([idProduto])
REFERENCES [base].[produtos] ([idProduto])
GO
ALTER TABLE [controle].[tratamentosLote] CHECK CONSTRAINT [FK__tratament__idPro__634EBE90]
GO
ALTER TABLE [controle].[tratamentosLote]  WITH CHECK ADD FOREIGN KEY([idTipoTratamento])
REFERENCES [controle].[tiposTratamentoLote] ([idTipoTratamento])
GO
ALTER TABLE [controle].[vendasLote]  WITH CHECK ADD  CONSTRAINT [FK__vendasLot__idLot__7D0E9093] FOREIGN KEY([idLote])
REFERENCES [controle].[lotes] ([idLote])
GO
ALTER TABLE [controle].[vendasLote] CHECK CONSTRAINT [FK__vendasLot__idLot__7D0E9093]
GO
ALTER TABLE [rlc].[loteSuinos]  WITH CHECK ADD  CONSTRAINT [FK__loteSuino__dtSai__51300E55] FOREIGN KEY([idLote])
REFERENCES [controle].[lotes] ([idLote])
GO
ALTER TABLE [rlc].[loteSuinos] CHECK CONSTRAINT [FK__loteSuino__dtSai__51300E55]
GO
ALTER TABLE [rlc].[loteSuinos]  WITH CHECK ADD  CONSTRAINT [FK__loteSuino__idSui__5224328E] FOREIGN KEY([idSuino])
REFERENCES [base].[suinos] ([idSuino])
GO
ALTER TABLE [rlc].[loteSuinos] CHECK CONSTRAINT [FK__loteSuino__idSui__5224328E]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cadastrarLote]
(@Nome                    VARCHAR(100), 
 @idTipoLote              INT, 
 @dtVencimentoLote		  DATETIME,
 @idProdutoDieta          INT, 
 @idProdutoVacina         INT, 
 @dtInicioAplicacaoDieta  DATETIME, 
 @dtFimAplicacaoDieta     DATETIME, 
 @dtInicioAplicacaoVacina DATETIME, 
 @dtFimAplicacaoVacina    DATETIME, 
 @qtdMacho                INT, 
 @qtdFemea                INT, 
 @desc                    VARCHAR(200), 
 @idUsuario               INT, 
 @peso                    NUMERIC(14, 2)  = 0,
 @qtdVacina INT = 0,
 @qtdDieta INT = 0
)

--Exec sp_cadastrarLote 
--@nome = 'Teste Lote Luis', 
--@idTipoLote = 1, 
--@dtVencimentoLote = '2019-12-01',
--@idProdutoDieta = 8, 
--@idProdutoVacina = 9, 
--@dtInicioAplicacaoDieta = '2019-10-03',
--@dtInicioAplicacaoVacina = '2019-10-03',
--@dtFimAplicacaoDieta = '2020-02-1',
--@dtFimAplicacaoVacina = '2019-12-20',
--@qtdMacho = 5, 
--@qtdFemea = 5, 
--@desc = 'Testando nova proc por causa da modificação no BD',
--@idusuario = 1,
--@peso = 1200


/* CADASTRAR OS PORCOS E CRIAR O LOTE */

AS
     SELECT @qtdFemea = ISNULL(NULLIF(@qtdFemea, ''), 0);
     SELECT @qtdMacho = ISNULL(NULLIF(@qtdMacho, ''), 0);

     /* Validar se há porcos disponíveis */

     IF
     (
         SELECT COUNT(*)
         FROM dbo.viewSuinosDisponiveis
         WHERE sexo = 0
     ) < @qtdFemea
     OR
     (
         SELECT COUNT(*)
         FROM dbo.viewSuinosDisponiveis
         WHERE sexo = 1
     ) < @qtdMacho
         BEGIN
             SELECT 'Quantidade de porcos solicitada é menor que a quantidade disponível no sistema';
             RETURN;
     END;

     /* Novo IdLote */

     INSERT INTO controle.lotes
     (idTipoLote, 
      dtCriacaoLote, 
      idStatusLote, 
      nome, 
      descricao,
	  dtVencimentoLote
     )
     VALUES
     (@idTipoLote, 
      GETDATE(), 
      1, 
      @Nome, 
      @desc,
	  @dtVencimentoLote
     );
     DECLARE @NewID INT= SCOPE_IDENTITY();

     --(
     --    SELECT ISNULL(MAX(idLote),0) + 1
     --    FROM controle.lotes
     --);
     DECLARE @IdSuino INT;

     /* Inserir machos */

     WHILE @qtdMacho > 0
         BEGIN
             SELECT TOP 1 @IdSuino = idSuino
             FROM dbo.viewSuinosDisponiveis
             WHERE sexo = 1;
             INSERT INTO rlc.loteSuinos
             (idLote, 
              idSuino, 
              dtEntradaSuino
             )
                    SELECT @NewID, 
                           @IdSuino, 
                           GETDATE();
             SELECT @qtdMacho-=1;
         END;

     /* Inserir fêmeas */

     WHILE @qtdFemea > 0
         BEGIN
             SELECT TOP 1 @IdSuino = idSuino
             FROM dbo.viewSuinosDisponiveis
             WHERE sexo = 0;
             INSERT INTO rlc.loteSuinos
             (idLote, 
              idSuino, 
              dtEntradaSuino
             )
                    SELECT @NewID, 
                           @IdSuino, 
                           GETDATE();
             SELECT @qtdFemea-=1;
         END;

     /* Cadastrar informações de tratamento*/

     IF @idProdutoDieta IS NOT NULL
         INSERT INTO controle.tratamentosLote
         (idLote, 
          idProduto, 
          idTipoTratamento, 
          dtInicioAplicacao, 
          dtFimAplicacao
         )
                SELECT @NewID, 
                       @idProdutoDieta, 
                       1, 
                       @dtInicioAplicacaoDieta, 
                       @dtFimAplicacaoDieta;
     IF @idProdutoVacina IS NOT NULL
         INSERT INTO controle.tratamentosLote
         (idLote, 
          idProduto, 
          idTipoTratamento, 
          dtInicioAplicacao, 
          dtFimAplicacao
         )
                SELECT @NewID, 
                       @idProdutoVacina, 
                       2, 
                       @dtInicioAplicacaoVacina, 
       @dtFimAplicacaoVacina;

     /* Cadastrar peso inicial */

     IF @peso > 0
         BEGIN
   INSERT INTO controle.pesosLote
             (idLote, 
              idUsuario, 
              dtPesagem, 
              pesoG
             )
                    SELECT @NewID, 
                           @idUsuario, 
                           GETDATE(), 
                           @peso;
     END;


	 IF @qtdDieta > 0
		EXEC sp_lancarSaidaNoEstoque @idProdutoDieta, @qtdDieta, @idUsuario
	 
	 IF @qtdVacina > 0
		EXEC sp_lancarSaidaNoEstoque @idProdutoVacina, @qtdVacina, @idUsuario
	 -- ZERAR BASE: 
	 --DELETE FROM rlc.loteSuinos
	 --DELETE FROM controle.pesosLote
	 --DELETE FROM controle.tratamentosLote
	 --DELETE FROM controle.lotes



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cadastrarSuino] @Qtd          INT, 
                                  @Peso         INT, 
                                  @IdUsuario    INT, 
                                  @sexo         BIT, 
                                  @dtNascimento DATETIME = NULL, 
                                  @idMae        INT      = NULL, 
                                  @idLote       INT      = NULL

/* Cadastrar a quantidade de suinos solicitada na aplicação. */

AS 
     -- Tabela que irá guardar os porcos cadastrados
     CREATE TABLE #novosPorcos
     (idSuino INT
     );

     -- Se não for lançado dtNascimento, guarda data de lançamento.
     SELECT @dtNascimento = CASE @dtNascimento
                                WHEN NULL
                                THEN GETDATE()
                                WHEN ''
                                THEN GETDATE()
                                ELSE @dtNascimento
                            END;
     WHILE @Qtd > 0
         BEGIN
             INSERT INTO base.suinos
             (dtNascimento, 
              sexo, 
              idSituacaoVida, 
              peso, 
              idUsuario, 
              idMae
             )
                    SELECT @dtNascimento, 
                           @Sexo, 
                           1, -- Só lança vivo.
                           @Peso, 
                           @idUsuario, 
                           @idMae;
             INSERT INTO #novosPorcos(idSuino)
                    SELECT SCOPE_IDENTITY();
             SELECT @Qtd-=1;
         END;

     -- Coloca os porcos em um lote se existir parâmetro
     IF @idLote IS NOT NULL
         BEGIN
             IF EXISTS
             (
                 SELECT TOP 1 1
                 FROM #novosPorcos
             )
                 BEGIN
                     INSERT INTO rlc.loteSuinos
                     (idLote, 
                      idSuino, 
                      dtEntradaSuino
                     )
                            SELECT @idLote, 
                                   idSuino, 
                                   GETDATE()
                            FROM #novosPorcos;
             END;
     END;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_finalizarLoteCompleto]  
(@idLote  INT,   
 @valor   NUMERIC(13, 2),   
 @cliente VARCHAR(100)  
)  
AS  
     SET NOCOUNT ON;  
    
     /* Valida se o lote que será vendido está em pré abate */  
  
     IF EXISTS  
     (  
         SELECT TOP 1 1  
         FROM controle.lotes  
         WHERE idLote = @idLote  
               AND idTipoLote <> 4  
     )  
         BEGIN  
             SELECT 'Operação cancelada, somente podem ser vendidos lotes em pré-abate.' AS MSG;  
             RETURN;  
     END;  

     DECLARE @dtVenda DATETIME= GETDATE(), @NewId INT;  
     SELECT *  
     INTO #SuinosParaVender  
     FROM rlc.loteSuinos  
     WHERE idLote = @idLote;  
  
     /* Registra saída dos Suinos em pré abate*/  
  
     UPDATE rlc.loteSuinos  
       SET   
           dtSaidaSuino = @dtVenda  
     WHERE idLote = @idLote;  
  
     /* Cria lote finalizado */  
  
     INSERT INTO controle.lotes  
     (idTipoLote,   
      dtCriacaoLote,   
      dtVencimentoLote,   
      nome,   
      descricao,   
      idStatusLote  
     )  
     VALUES  
     (5,   
      @dtVenda,   
      @dtVenda,   
      'VENDA > SISTEMA FINALIZA LOTE',   
      'VENDA > SISTEMA FINALIZA LOTE',   
      1  
     );  
  
	SELECT @NewId = SCOPE_IDENTITY()   
  
     /* Insere registros dos suinos vendidos em novo lote finalizado */  
  
     INSERT INTO rlc.loteSuinos  
     (idLote,   
      idSuino,   
      dtEntradaSuino,   
      dtSaidaSuino  
     )  
            SELECT @NewId,   
                   idSuino,   
                   @dtVenda,   
                   NULL  
            FROM #SuinosParaVender;  
  
     /* Registra tabela de vendas */  
  
     INSERT INTO controle.vendasLote  
     (idLote,   
      dtVenda,   
      valor,   
      cliente  
     )  
            SELECT @NewId,   
                   @dtVenda,   
                   @valor,   
                   @cliente;  

	
	/* Abater porcos */
	UPDATE s SET s.idSituacaoVida = 2
	FROM base.suinos AS s
		WHERE idSuino IN (SELECT idSuino  FROM controle.lotes WHERE idLote = @idLote)

	UPDATE controle.lotes 
		SET idStatusLote = 2
	WHERE  idLote = @idLote;


	SELECT @NewId;  
  
/*  
EXEC sp_finalizarLoteCompleto   
     @idLote = '12',   
     @valor = '2121',   
     @cliente = 'teste com ze botando defeito'  
*/


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_informarMorteSuino]
(@idSuino   INT, 
 @dataObito DATETIME, 
 @msg       VARCHAR(100)
)
AS
     SET NOCOUNT ON;

	 IF EXISTS(SELECT TOP 1 1 FROM base.suinos WHERE idSuino = @idSuino AND idSituacaoVida = 3)
	 BEGIN
		SELECT 'OPERAÇÂO CANCELADA! PROCEDIMENTO JÁ FOI EXECUTADO ANTERIORMENTE MOTIVO:' + (SELECT TOP 1 OBS FROM base.informacoesSuino WHERE idSuino = @idSuino ORDER BY dtObs DESC) AS MSG
		RETURN
	 END

     UPDATE rlc.loteSuinos
       SET 
           dtSaidaSuino = @dataObito
     WHERE idSuino = @idSuino
           AND dtSaidaSuino IS NULL;
     UPDATE base.suinos
       SET 
           idSituacaoVida = 3
     WHERE idSuino = @idSuino;
     INSERT INTO base.informacoesSuino
     (idSuino, 
      obs, 
      dtObs
     )
     VALUES
     (@idSuino, 
      @msg, 
      @dataObito
     );

/* EXEC sp_informarMorteSuino 
     @idSuino = '41', 
     @dataObito = '2019-09-10', 
     @msg = 'Motivo da morte..';
*/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_lancarSaidaNoEstoque]
(@idProduto INT, 
 @Qtd       INT, 
 @idUsuario INT
)
AS
     SET NOCOUNT ON;
	 DECLARE @Limite INT = ( SELECT qtdDisponivel FROM dbo.viewSaldoAtualProduto WHERE idProduto = @idProduto )

	 IF @Qtd > @Limite
	 BEGIN
		SELECT CONCAT('Saldo insuficiente! QTD EM ESTOQUE: ', @Limite) AS MSG RETURN
	 END


     INSERT INTO base.estoques
     (idProduto, 
      idOperacao, 
      quantidade, 
      dtLancamento, 
      idUsuario, 
      unidade, 
      custo
     )
            SELECT idProduto, 
                   1, 
                   @Qtd, 
                   GETDATE(), 
                   @idUsuario, 
                   unidade, 
                   0.00
            FROM base.produtos
            WHERE idProduto = @idProduto;

/*
EXEC sp_lancarSaidaNoEstoque 
     @idProduto = 8, 
     @Qtd = 1000, 
     @idUsuario = 1;
*/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_resumoDoLote](@idLote INT)
AS SET NOCOUNT ON


	 /*
	 Veriricar se algum suino morreu
	 */
	 DECLARE @qtdMortos INT = (
	 SELECT COUNT(DISTINCT L.idSuino)
	 FROM rlc.loteSuinos R
		INNER JOIN base.suinos L on L.idSuino = R.idSuino
	 WHERE idLote = @idLote
	 AND L.idSituacaoVida = 3 
	 )

     SELECT DISTINCT 
            lo.idLote, 
            lo.nome AS nomeLote, 
            lo.descricao AS descLote, 
            lo.dtCriacaoLote AS dtCadastroInfo, 
            tipoDoLote.nome, 
            lo.dtVencimentoLote, 
            macho.qtd AS QtdMachos, 
            femea.qtd AS QtdFemeas, 
            peso.valor AS pesoLote
     INTO #Resumo
     FROM controle.lotes lo
          OUTER APPLY
     (
         SELECT TOP 1 ctl.descTipoLote AS nome
         FROM controle.lotes cl
              INNER JOIN controle.tiposLote ctl ON ctl.idTipoLote = cl.idTipoLote
                                                   AND cl.idLote = lo.idLote
     ) tipoDoLote
          OUTER APPLY
     (
         SELECT QTD
         FROM viewSuinosPorLote
         WHERE idLote = lo.idLote
               AND Sexo = 'Masculino'
     ) macho
          OUTER APPLY
     (
         SELECT QTD
         FROM viewSuinosPorLote
         WHERE idLote = lo.idLote
               AND Sexo = 'Feminino'
     ) femea
          OUTER APPLY
     (
         SELECT TOP 1 pesoG AS Valor
         FROM [controle].pesosLote AS pl
         WHERE pl.idLote = lo.idLote
         ORDER BY dtPesagem DESC
     ) peso
     WHERE lo.idLote = @idLote;
     SELECT TOP 1 l.idLote, 
                  prod.nomeProduto, 
                  dtInicioAplicacao, 
                  dtFimAplicacao, 
                  ttl.descTipoTratamento,
				  l.idTipoTratamento
     INTO #Dietas
     FROM controle.tratamentosLote l
          LEFT JOIN base.produtos prod ON prod.idProduto = l.idProduto
          LEFT JOIN controle.tiposTratamentoLote ttl ON ttl.idTipoTratamento = l.idTipoTratamento
     WHERE idLote = @idLote
           AND l.idTipoTratamento = 1
     ORDER BY l.dtInicioAplicacao DESC;
     SELECT TOP 1 l.idLote, 
                  prod.nomeProduto, 
                  dtInicioAplicacao, 
                  dtFimAplicacao, 
                  ttl.descTipoTratamento,
				  l.idTipoTratamento
     INTO #Vacinas
     FROM controle.tratamentosLote l
          LEFT JOIN base.produtos prod ON prod.idProduto = l.idProduto
          LEFT JOIN controle.tiposTratamentoLote ttl ON ttl.idTipoTratamento = l.idTipoTratamento
     WHERE idLote = @idLote
           AND l.idTipoTratamento = 2
     ORDER BY l.dtInicioAplicacao DESC;
     
	 SELECT *
     INTO #Tratamentos
     FROM #Dietas
     UNION ALL
     SELECT *
     FROM #Vacinas;

     SELECT #Resumo.*, 
            #Tratamentos.nomeProduto, 
            #Tratamentos.dtInicioAplicacao, 
            #Tratamentos.dtFimAplicacao, 
            #Tratamentos.descTipoTratamento,
			#Tratamentos.idTipoTratamento,
			@qtdMortos qtdMortos
     FROM #Resumo, 
          #Tratamentos
     WHERE #Resumo.idLote = #Tratamentos.idLote;


-- EXEC sp_resumoDoLote 13


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_transferirLote]
(@idLoteOrigem INT, @idLoteDestino INT)
AS SET NOCOUNT ON

	/* Salva ids dos suinos a serem transferidos */
	SELECT idSuino INTO #SuinosParaTransferir
	FROM rlc.loteSuinos WHERE idLote = @idLoteOrigem AND dtSaidaSuino IS NULL

	/* Dá saída em todos os suinos do lote de origem */
	UPDATE
	rlc.loteSuinos SET dtSaidaSuino = GETDATE()
	WHERE idLote = @idLoteOrigem
	AND dtSaidaSuino IS NULL

	/* Dá entrada em todos os suínos para lote de destino */
	INSERT INTO rlc.loteSuinos(idLote, idSuino, dtEntradaSuino)
	SELECT @idLoteDestino, idSuino, GETDATE()
	FROM #SuinosParaTransferir




	

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_transferirLoteSuino_sp]
(@idSuino           INT, 
 @idLoteDestino INT
) -- Pra onde ele vai
AS
     DECLARE @idLoteOrigem INT=
     (
         SELECT TOP 1 idLote
         FROM rlc.loteSuinos
         WHERE idSuino = @idSuino AND dtSaidaSuino IS NULL
		 ORDER BY dtEntradaSuino DESC
     );

     IF @idLoteOrigem IS NOT NULL
         BEGIN
             -- saída do suino do lote
             UPDATE lotes
               SET 
                   lotes.dtSaidaSuino = GETDATE()
             FROM rlc.loteSuinos lotes
             WHERE idLote = @idLoteOrigem
                   AND idSuino = @idSuino;
     END;


     INSERT INTO rlc.loteSuinos
     (idLote, 
      idSuino, 
      dtEntradaSuino
	  )
     VALUES
     (@idLoteDestino, 
      @idSuino, 
      GETDATE()
     );

     IF @@ERROR = 0
         SELECT CONCAT('Suino id:', @idSuino, ' transferido com sucesso do lote: ', @idLoteOrigem, ' para: ', @idLoteDestino) AS RESULTADO;

     --EXEC sp_transferirLoteSuino_sp 
     --     @idSuino = 'AquiVaiOIdDoPorco', 
     --     @idLoteFullDestino = 'AquiVaiOidDoLoteDestino';

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spc] (@name varchar(100))
as

	select * from sys.procedures where name like '%'+@name+'%'
GO
ALTER DATABASE [suinos] SET  READ_WRITE 
GO
