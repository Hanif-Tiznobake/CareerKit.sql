USE [career]
GO
/****** Object:  Table [dbo].[category]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category] [varchar](50) NOT NULL,
	[temp_id] [int] NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Trigger [dbo].[new_category]    Script Date: 4/2/2019 7:47:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[new_category]
   ON  [dbo].[category]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	insert into category(category)
	select c.category
	from inserted i left outer join category c on i.category = c.category
	where c.category_id is null and i.category is not null
END
GO
ALTER TABLE [dbo].[category] ENABLE TRIGGER [new_category]
GO
