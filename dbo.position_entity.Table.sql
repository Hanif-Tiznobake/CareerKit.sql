USE [career]
GO
/****** Object:  Table [dbo].[position_entity]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[position_entity](
	[position_id] [int] NOT NULL,
	[entity_id] [int] NOT NULL,
	[category_id] [int] NULL,
	[contact_id] [int] NULL,
	[started] [datetime2](0) NULL,
	[ended] [datetime2](0) NULL,
 CONSTRAINT [PK_position_entity] PRIMARY KEY CLUSTERED 
(
	[position_id] ASC,
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[position_entity]  WITH CHECK ADD  CONSTRAINT [FK_position_entity_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[position_entity] CHECK CONSTRAINT [FK_position_entity_category]
GO
ALTER TABLE [dbo].[position_entity]  WITH NOCHECK ADD  CONSTRAINT [FK_position_entity_contact] FOREIGN KEY([contact_id])
REFERENCES [dbo].[contact] ([contact_id])
GO
ALTER TABLE [dbo].[position_entity] NOCHECK CONSTRAINT [FK_position_entity_contact]
GO
ALTER TABLE [dbo].[position_entity]  WITH CHECK ADD  CONSTRAINT [FK_position_entity_position] FOREIGN KEY([position_id])
REFERENCES [dbo].[position] ([position_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[position_entity] CHECK CONSTRAINT [FK_position_entity_position]
GO
/****** Object:  Trigger [dbo].[new_position_entity]    Script Date: 4/2/2019 7:47:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[new_position_entity]
   ON  [dbo].[position_entity]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO position_entity(position_id,entity_id,category_id,contact_id,started,ended)
	SELECT i.position_id,i.entity_id,i.category_id,i.contact_id,i.started,i.ended
	FROM dbo.position_entity pe right outer join
		inserted i on pe.position_id = i.position_id and pe.entity_id = i.entity_id
	WHERE (pe.position_id is null or pe.entity_id is null) and (i.position_id is not null) and (i.entity_id is not null)
END
GO
ALTER TABLE [dbo].[position_entity] ENABLE TRIGGER [new_position_entity]
GO
