USE [career]
GO
/****** Object:  Table [dbo].[contact]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contact](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[email_id] [int] NULL,
	[url_id] [int] NULL,
	[phone_id] [int] NULL,
	[address_id] [int] NULL,
	[temp_id] [int] NULL,
 CONSTRAINT [PK_contact] PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address] ([address_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_address]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_email] FOREIGN KEY([email_id])
REFERENCES [dbo].[email] ([email_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_email]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_phone] FOREIGN KEY([phone_id])
REFERENCES [dbo].[phone] ([phone_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_phone]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_url] FOREIGN KEY([url_id])
REFERENCES [dbo].[url] ([url_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_url]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [CK_contact] CHECK  (([email_id] IS NOT NULL OR [url_id] IS NOT NULL OR [phone_id] IS NOT NULL OR [address_id] IS NOT NULL))
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [CK_contact]
GO
/****** Object:  Trigger [dbo].[new_contact]    Script Date: 4/2/2019 7:47:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[new_contact]
   ON  [dbo].[contact]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO contact (temp_id, address_id,email_id,phone_id,url_id)
	SELECT i.temp_id, i.address_id, i.email_id, i.phone_id, i.url_id
	FROM dbo.contact c right outer join
		inserted i on isnull(c.address_id,-1) = isnull(i.address_id,-1) and isnull(c.email_id,-1) =isnull(i.email_id,-1) and isnull(c.phone_id,-1) = isnull(i.phone_id,-1) and isnull(c.url_id,-1) =isnull(i.url_id,-1)
	WHERE c.contact_id is null and (i.address_id is not null or i.email_id is not null or i.phone_id is not null or i.url_id is not null)
END
GO
ALTER TABLE [dbo].[contact] ENABLE TRIGGER [new_contact]
GO
