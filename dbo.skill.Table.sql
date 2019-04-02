USE [career]
GO
/****** Object:  Table [dbo].[skill]    Script Date: 4/2/2019 3:52:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skill](
	[skill_id] [int] NOT NULL,
	[skill] [nvarchar](255) NOT NULL,
	[category_id] [int] NULL,
 CONSTRAINT [PK_skill] PRIMARY KEY CLUSTERED 
(
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[skill]  WITH CHECK ADD  CONSTRAINT [FK_skill_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[skill] CHECK CONSTRAINT [FK_skill_category]
GO
