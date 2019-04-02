USE [career]
GO
/****** Object:  Table [dbo].[position_detail]    Script Date: 4/2/2019 3:52:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[position_detail](
	[position_id] [int] NOT NULL,
	[detail_id] [int] NOT NULL,
	[category_id] [int] NULL,
 CONSTRAINT [PK_position_detail] PRIMARY KEY CLUSTERED 
(
	[position_id] ASC,
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[position_detail]  WITH CHECK ADD  CONSTRAINT [FK_position_detail_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[position_detail] CHECK CONSTRAINT [FK_position_detail_category]
GO
ALTER TABLE [dbo].[position_detail]  WITH CHECK ADD  CONSTRAINT [FK_position_detail_detail] FOREIGN KEY([detail_id])
REFERENCES [dbo].[detail] ([detail_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[position_detail] CHECK CONSTRAINT [FK_position_detail_detail]
GO
ALTER TABLE [dbo].[position_detail]  WITH CHECK ADD  CONSTRAINT [FK_position_detail_position] FOREIGN KEY([position_id])
REFERENCES [dbo].[position] ([position_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[position_detail] CHECK CONSTRAINT [FK_position_detail_position]
GO
