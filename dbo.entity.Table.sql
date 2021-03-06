USE [career]
GO
/****** Object:  Table [dbo].[entity]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entity](
	[entity_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_id] [int] NULL,
	[organization] [varchar](50) NULL,
	[department] [varchar](50) NULL,
	[prefix] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[middle_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[suffix] [varchar](50) NULL,
	[birth_date] [datetime2](0) NULL,
	[temp_id] [int] NULL,
 CONSTRAINT [PK_entity] PRIMARY KEY CLUSTERED 
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_entity] UNIQUE NONCLUSTERED 
(
	[organization] ASC,
	[department] ASC,
	[last_name] ASC,
	[first_name] ASC,
	[middle_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[entity]  WITH CHECK ADD  CONSTRAINT [CK_entity] CHECK  (([organization] IS NULL OR [last_name] IS NULL))
GO
ALTER TABLE [dbo].[entity] CHECK CONSTRAINT [CK_entity]
GO
/****** Object:  Trigger [dbo].[new_entity]    Script Date: 4/2/2019 7:47:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[new_entity]
   ON  [dbo].[entity]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO entity(temp_id, birth_date,contact_id,department,first_name,last_name,middle_name,organization,prefix,suffix)
	SELECT i.temp_id, i.birth_date,i.contact_id,i.department,i.first_name,i.last_name,i.middle_name,i.organization,i.prefix,i.suffix
	FROM dbo.entity e right outer join
		inserted i on isnull(e.department,'')=isnull(i.department,'') and isnull(e.first_name,'')=isnull(i.first_name,'') and isnull(i.last_name,'') = isnull(e.last_name,'') and isnull(i.middle_name,'')=isnull(e.middle_name,'') and isnull(i.organization,'')=isnull(e.organization,'')
	WHERE e.entity_id is null
END
GO
ALTER TABLE [dbo].[entity] ENABLE TRIGGER [new_entity]
GO
