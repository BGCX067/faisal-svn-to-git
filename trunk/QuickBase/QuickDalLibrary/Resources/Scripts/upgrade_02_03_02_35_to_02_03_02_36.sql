IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_Process')
	CREATE TABLE [Production_Process](
		[Co_ID] [smallint] NOT NULL,
		[Process_ID] [smallint] NOT NULL,
		[Process_Code] [varchar](50) NOT NULL,
		[Process_Desc] [varchar](250) NOT NULL,
		[Stamp_UserID] [int] NOT NULL,
		[Stamp_DateTime] [datetime] NOT NULL,
		[Upload_DateTime] [datetime] NULL,
		[RecordStatus_ID] [int] NOT NULL,
	 CONSTRAINT [PK_Production_Process] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		[Process_ID] ASC
	)
	)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_ProcessWorkFlow')
	CREATE TABLE [Production_ProcessWorkFlow](
		[Co_ID] [smallint] NOT NULL,
		[ProcessWorkFlow_ID] [int] NOT NULL,
		[Source_Process_ID] [smallint] NULL,
		[Destination_Process_ID] [smallint] NULL,
		[ProcessWorkFlow_Desc] [varchar](250) NOT NULL,
		[Stamp_UserID] [int] NOT NULL,
		[Stamp_DateTime] [datetime] NOT NULL,
		[Upload_DateTime] [datetime] NULL,
		[RecordStatus_ID] [int] NOT NULL,
	 CONSTRAINT [PK_Production_ProcessWorkFlow] PRIMARY KEY CLUSTERED 
	(
		[Co_ID] ASC,
		[ProcessWorkFlow_ID] ASC
	)
	)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Production_ProcessWorkFlow_Production_Process1')
	ALTER TABLE Production_ProcessWorkFlow
		WITH CHECK ADD  CONSTRAINT FK_Production_ProcessWorkFlow_Production_Process1
		FOREIGN KEY([Co_ID], [Source_Process_ID])
		REFERENCES Production_Process ([Co_ID], [Process_ID])
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Production_ProcessWorkFlow_Production_Process2')
	ALTER TABLE Production_ProcessWorkFlow
		WITH CHECK ADD  CONSTRAINT FK_Production_ProcessWorkFlow_Production_Process2
		FOREIGN KEY([Co_ID], [Destination_Process_ID])
		REFERENCES Production_Process ([Co_ID], [Process_ID])
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Inv_Item_Size_Association_History')
	DROP TABLE Inv_Item_Size_Association_History
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Inv_Item_Size_Association')
	DROP TABLE Inv_Item_Size_Association
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] ='Inv_ItemSize' AND c.[Name] = 'ItemSize_Code')
	ALTER TABLE Inv_ItemSize
		ADD ItemSize_Code VARCHAR(10) NOT NULL
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Common_Color')
	CREATE TABLE Common_Color(
		Co_ID SMALLINT NOT NULL,
		Color_ID SMALLINT NOT NULL,
		Color_Code VARCHAR(10) NOT NULL,
		Color_Desc VARCHAR(250) NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Common_Color] PRIMARY KEY CLUSTERED 
	(
		[Co_ID] ASC,
		[Color_ID] ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Inv_ItemGrade')
	CREATE TABLE Inv_ItemGrade(
		Co_ID SMALLINT NOT NULL,
		ItemGrade_ID SMALLINT NOT NULL,
		ItemGrade_Code VARCHAR(10) NOT NULL,
		ItemGrade_Desc VARCHAR(250) NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Inv_ItemGrade] PRIMARY KEY CLUSTERED 
	(
		[Co_ID] ASC,
		[ItemGrade_ID] ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Inv_Item_Detail')
	CREATE TABLE Inv_Item_Detail(
		Co_ID SMALLINT NOT NULL,
		Item_Detail_ID INT NOT NULL,
		Item_ID INT NOT NULL,
		Color_ID SMALLINT NULL,
		ItemGrade_ID SMALLINT NULL,
		ItemSize_ID SMALLINT NULL,
		Opening_Quantity DECIMAL NOT NULL,
		Opening_Value DECIMAL NOT NULL,
		Minimum_Quantity DECIMAL NOT NULL,
		Maximum_Quantity DECIMAL NOT NULL,
		Sale_Rate DECIMAL NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Inv_Item_Detail] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		Item_Detail_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='IX_Comapny_Color_ItemGrade_ItemSize')
	ALTER TABLE Inv_Item_Detail
		ADD CONSTRAINT [IX_Comapny_Color_ItemGrade_ItemSize] UNIQUE
		(
		Item_ID ASC,
		Co_ID ASC,
		Color_ID ASC,
		ItemGrade_ID ASC,
		ItemSize_ID ASC
		)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Inv_Item_Detail_Invs_Item')
	ALTER TABLE Inv_Item_Detail
		WITH CHECK ADD  CONSTRAINT FK_Inv_Item_Detail_Invs_Item
		FOREIGN KEY([Co_ID], Item_ID)
		REFERENCES Invs_Item ([Co_ID], Item_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Inv_Item_Detail_Common_Color')
	ALTER TABLE Inv_Item_Detail
		WITH CHECK ADD  CONSTRAINT FK_Inv_Item_Detail_Common_Color
		FOREIGN KEY([Co_ID], Color_ID)
		REFERENCES Common_Color ([Co_ID], [Color_ID])
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Inv_Item_Detail_ItemGrade')
	ALTER TABLE Inv_Item_Detail
		WITH CHECK ADD  CONSTRAINT FK_Inv_Item_Detail_ItemGrade
		FOREIGN KEY([Co_ID], ItemGrade_ID)
		REFERENCES Inv_ItemGrade ([Co_ID], ItemGrade_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Inv_Item_Detail_Inv_ItemSize')
	ALTER TABLE Inv_Item_Detail
		WITH CHECK ADD  CONSTRAINT FK_Inv_Item_Detail_Inv_ItemSize
		FOREIGN KEY([Co_ID], ItemSize_ID)
		REFERENCES Inv_ItemSize ([Co_ID], ItemSize_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_Formula')
	CREATE TABLE Production_Formula(
		Co_ID SMALLINT NOT NULL,
		Formula_ID INT NOT NULL,
		Formula_Code VARCHAR(50) NOT NULL,
		Formula_Description VARCHAR(500) NOT NULL,
		Output_Item_Detail_ID INT NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Production_Formula] PRIMARY KEY CLUSTERED
	(
		Co_ID ASC,
		Formula_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_Formula_Detail')
	CREATE TABLE Production_Formula_Detail(
		Co_ID SMALLINT NOT NULL,
		Formula_ID INT NOT NULL,
		Formula_Detail_ID INT NOT NULL,
		Remarks VARCHAR(500) NOT NULL,
		Input_Item_Detail_ID INT NOT NULL,
		Quantity DECIMAL NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Production_Formula_Detail] PRIMARY KEY CLUSTERED
	(
		Co_ID ASC,
		Formula_ID ASC,
		Formula_Detail_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Production_Formula_Formula_Detail')
	ALTER TABLE Production_Formula_Detail
		WITH CHECK ADD  CONSTRAINT FK_Production_Formula_Formula_Detail
		FOREIGN KEY(Co_ID, Formula_ID)
		REFERENCES Production_Formula (Co_ID, Formula_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_Order')
	CREATE TABLE Production_Order(
		Co_ID SMALLINT NOT NULL,
		Order_ID INT NOT NULL,
		Order_No VARCHAR(50) NOT NULL,
		Order_Date DATETIME NOT NULL,
		Remarks VARCHAR(1000) NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Production_Order] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		Order_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_Order_Detail')
	CREATE TABLE Production_Order_Detail(
		Co_ID SMALLINT NOT NULL,
		Order_ID INT NOT NULL,
		Order_Detail_ID INT NOT NULL,
		Item_Detail_ID INT NOT NULL,
		Formula_ID INT NOT NULL,
		Quantity DECIMAL NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Production_Order_Detail] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		Order_ID ASC,
		Order_Detail_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Production_Order_Order_Detail')
	ALTER TABLE Production_Order_Detail
		WITH CHECK ADD  CONSTRAINT FK_Production_Order_Order_Detail
		FOREIGN KEY(Co_ID, Order_ID)
		REFERENCES Production_Order (Co_ID, Order_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Production_Formula_Order_Detail')
	ALTER TABLE Production_Order_Detail
		WITH CHECK ADD  CONSTRAINT FK_Production_Formula_Order_Detail
		FOREIGN KEY(Co_ID, Formula_ID)
		REFERENCES Production_Formula (Co_ID, Formula_ID)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 800)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(800, 'Production', '08', 8, 0
		, 0, '2010-11-11 22:02', NULL, 1, 0)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 801)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(801, 'Process', '08-001', 1, 800
		, 0, '2010-11-11 22:02', NULL, 1, 0)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 802)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(802, 'Process Workflow', '08-002', 2, 800
		, 0, '2010-11-11 22:02', NULL, 1, 0)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 803)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(803, 'Production Order', '08-003', 3, 800
		, 0, '2010-11-11 22:02', NULL, 1, 0)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 804)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(804, 'Process Production', '08-004', 4, 800
		, 0, '2010-11-11 22:02', NULL, 1, 0)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_OrderBatch')
	CREATE TABLE Production_OrderBatch(
		Co_ID SMALLINT NOT NULL,
		Order_ID INT NOT NULL,
		OrderBatch_ID INT NOT NULL,
		OrderBatch_No VARCHAR(50) NOT NULL,
		OrderBatch_Date DATETIME NOT NULL,
		Remarks VARCHAR(1000) NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Production_OrderBatch] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		OrderBatch_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Production_Order_OrderBatch')
	ALTER TABLE Production_OrderBatch
		WITH CHECK ADD  CONSTRAINT FK_Production_Order_OrderBatch
		FOREIGN KEY(Co_ID, Order_ID)
		REFERENCES Production_Order (Co_ID, Order_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_OrderBatch_Detail')
	CREATE TABLE Production_OrderBatch_Detail(
		Co_ID SMALLINT NOT NULL,
		OrderBatch_ID INT NOT NULL,
		OrderBatch_Detail_ID INT NOT NULL,
		Item_Detail_ID INT NOT NULL,
		Quantity DECIMAL NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Production_OrderBatch_Detail] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		OrderBatch_ID ASC,
		OrderBatch_Detail_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Production_OrderBatch_OrderBatch_Detail')
	ALTER TABLE Production_OrderBatch_Detail
		WITH CHECK ADD  CONSTRAINT FK_Production_OrderBatch_OrderBatch_Detail
		FOREIGN KEY(Co_ID, OrderBatch_ID)
		REFERENCES Production_OrderBatch (Co_ID, OrderBatch_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_ProcessProduction')
	CREATE TABLE Production_ProcessProduction(
		Co_ID SMALLINT NOT NULL,
		Production_ID INT NOT NULL,
		Production_No VARCHAR(50) NOT NULL,
		Production_Date DATETIME NOT NULL,
		Vender_Party_ID INT NULL,
		Order_ID INT NULL,
		OrderBatch_ID INT NULL,
		Source_Document_ID INT NULL,
		Source_DocumentType_ID INT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Production_ProcessProduction] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		Production_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Order_ProcessProduction')
	ALTER TABLE Production_ProcessProduction
		WITH CHECK ADD  CONSTRAINT FK_Order_ProcessProduction
		FOREIGN KEY([Co_ID], Order_ID)
		REFERENCES Production_Order ([Co_ID], Order_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_OrderBatch_ProcessProduction')
	ALTER TABLE Production_ProcessProduction
		WITH CHECK ADD  CONSTRAINT FK_OrderBatch_ProcessProduction
		FOREIGN KEY([Co_ID], OrderBatch_ID)
		REFERENCES Production_OrderBatch ([Co_ID], OrderBatch_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Production_ProcessProduction_Detail')
	CREATE TABLE Production_ProcessProduction_Detail(
		Co_ID SMALLINT NOT NULL,
		Production_ID INT NOT NULL,
		Production_Detail_ID INT NOT NULL,
		Consumption_Process_ID INT NULL,
		Production_Process_ID INT NOT NULL,
		Item_Detail_ID INT NOT NULL,
		Quantity DECIMAL NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_ProcessProduction_Detail] PRIMARY KEY CLUSTERED
	(
		[Co_ID] ASC,
		Production_ID ASC,
		Production_Detail_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_ProcessProduction_ProcessProduction_Detail')
	ALTER TABLE Production_ProcessProduction_Detail
		WITH CHECK ADD  CONSTRAINT FK_ProcessProduction_ProcessProduction_Detail
		FOREIGN KEY([Co_ID], Production_ID)
		REFERENCES Production_ProcessProduction ([Co_ID], Production_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] ='Invs_Item' AND c.[Name] = 'Is_RawMaterial')
	ALTER TABLE Invs_Item
		ADD Is_RawMaterial BIT NOT NULL
go
IF NOT EXISTS (SELECT * FROM Base_Setting WHERE Setting_ID = 'DocumentNoFormat.ProductionOrder')
	INSERT INTO [Base_Setting]
		([Co_Id], [User_Id], [Setting_Id], [Setting_Desc]
		,[Setting_Value], [Stamp_User_Id], [Stamp_DateTime]
		,[Setting_Value_DataType], [Setting_Value_MinimumValue], [Setting_Value_MaximumValue]
		,[Upload_DateTime], [RecordStatus_ID])
	VALUES
		(0, 0, 'DocumentNoFormat.ProductionOrder'
		, 'Document No format used on production order form'
		, '999999', 0, '2010-11-19'
		, 'String', NULL, NULL
		, NULL, 1)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Common_Country')
	CREATE TABLE Common_Country(
		Country_ID INT NOT NULL,
		Country_Code VARCHAR(10) NOT NULL,
		Country_Desc VARCHAR(250) NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Common_Country] PRIMARY KEY CLUSTERED
	(
		Country_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Common_City')
	CREATE TABLE Common_City(
		Country_ID INT NOT NULL,
		City_ID INT NOT NULL,
		City_Code VARCHAR(10) NOT NULL,
		City_Desc VARCHAR(250) NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Common_City] PRIMARY KEY CLUSTERED
	(
		Country_ID ASC,
		City_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Country_City')
	ALTER TABLE Common_City
		WITH CHECK ADD  CONSTRAINT FK_Country_City
		FOREIGN KEY(Country_ID)
		REFERENCES Common_Country (Country_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] ='Sec_User' AND c.[Name] = 'Country_ID')
	ALTER TABLE Sec_User
		ADD Country_ID INT NULL
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] ='Sec_User' AND c.[Name] = 'City_ID')
	ALTER TABLE Sec_User
		ADD City_ID INT NULL
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_Country_Sec_User')
	ALTER TABLE Sec_User
		WITH CHECK ADD  CONSTRAINT FK_Country_Sec_User
		FOREIGN KEY(Country_ID)
		REFERENCES Common_Country (Country_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_City_Sec_User')
	ALTER TABLE Sec_User
		WITH CHECK ADD  CONSTRAINT FK_City_Sec_User
		FOREIGN KEY(Country_ID, City_ID)
		REFERENCES Common_City (Country_ID, City_ID)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] ='Sec_User' AND c.[Name] = 'Short_Name')
	ALTER TABLE Sec_User
		ADD Short_Name VARCHAR(20) NULL
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='spGetProductionByCoIDItemCode')
	DROP PROCEDURE spGetProductionByCoIDItemCode
go
CREATE PROCEDURE spGetProductionByCoIDItemCode
	@CoID SMALLINT,
	@ItemCode VARCHAR(250)
AS
	SELECT     Co_ID, Order_ID, Order_No, Order_Date, Remarks, Stamp_UserID, Stamp_DateTime, Upload_DateTime, RecordStatus_ID
	FROM         Production_Order po
	WHERE Co_ID = @CoID 
		AND Order_ID IN (SELECT Order_ID FROM Production_Order_Detail pod 
					INNER JOIN Production_Formula pf ON pod.Co_ID = pf.Co_ID AND pod.Formula_ID = pf.Formula_ID
					INNER JOIN Inv_Item_Detail iid ON pf.Co_ID = iid.Co_ID AND pf.Output_Item_Detail_ID = iid.Item_Detail_ID
					INNER JOIN Invs_Item ii ON iid.Co_ID = ii.Co_ID AND iid.Item_ID = ii.Item_ID
					WHERE pod.Co_ID = @CoID AND ii.Item_Code = @ItemCode)
go
IF NOT EXISTS (SELECT * FROM Common_DocumentType WHERE DocumentType_ID = 19)
	INSERT INTO [Common_DocumentType]
           ([DocumentType_ID]
           ,[DocumentType_Desc]
           ,[Stamp_DateTime]
           ,[Stamp_UserID]
           ,[Upload_DateTime]
           ,[RecordStatus_ID])
     VALUES
           (19
           ,'Production Order'
           ,'2010-11-28'
           ,0
           ,NULL
           ,1)
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='spGetProcessBalanceSizeWiseByCoIDProcessIDItemCode')
	DROP PROCEDURE spGetProcessBalanceSizeWiseByCoIDProcessIDItemCode
go
CREATE PROCEDURE spGetProcessBalanceSizeWiseByCoIDProcessIDItemCode
	@CoID SMALLINT,
	@ProcessID INT,
	@ItemCode VARCHAR(250)
AS
	SELECT Process_ID, Process_Code, Process_Desc, Item_ID, Item_Code, ItemSize_ID, ItemSize_Code, NULL Item_Detail_ID, SUM(Quantity) AS Quantity
	FROM
		(
		SELECT     prodproc.Process_ID, prodproc.Process_Code, prodproc.Process_Desc
			, itdet.Item_ID, it.Item_Code, itsize.ItemSize_ID, itsize.ItemSize_Code, ppd.Item_Detail_ID, ppd.Quantity
		FROM         Production_ProcessProduction_Detail AS ppd
			INNER JOIN Production_Process AS prodproc
				ON ppd.Co_ID = prodproc.Co_ID AND ppd.Production_Process_ID = prodproc.Process_ID
			INNER JOIN Inv_Item_Detail itdet
				ON ppd.Co_ID = itdet.Co_ID AND ppd.Item_Detail_ID = itdet.Item_Detail_ID
			INNER JOIN invs_Item it
				ON it.Co_ID = itdet.Co_ID AND it.Item_ID = itdet.Item_ID
			INNER JOIN inv_ItemSize itsize
				ON it.Co_ID = itsize.Co_ID AND itdet.ItemSize_ID = itsize.ItemSize_ID
		WHERE prodproc.Co_ID = @CoID 
			AND (prodproc.Process_ID = @ProcessID OR @ProcessID IS NULL) 
			AND (it.Item_Code = @ItemCode OR @ItemCode IS NULL)
		UNION ALL
		SELECT     conproc.Process_ID, conproc.Process_Code, conproc.Process_Desc
			, itdet.Item_ID, it.Item_Code, itsize.ItemSize_ID, itsize.ItemSize_Code, ppd.Item_Detail_ID, - ppd.Quantity AS Quantity
		FROM         Production_ProcessProduction_Detail AS ppd 
			INNER JOIN Production_Process AS conproc 
				ON ppd.Co_ID = conproc.Co_ID AND ppd.Consumption_Process_ID = conproc.Process_ID
			INNER JOIN Inv_Item_Detail itdet
				ON ppd.Co_ID = itdet.Co_ID AND ppd.Item_Detail_ID = itdet.Item_Detail_ID
			INNER JOIN invs_Item it
				ON it.Co_ID = itdet.Co_ID AND it.Item_ID = itdet.Item_ID
			INNER JOIN inv_ItemSize itsize
				ON it.Co_ID = itsize.Co_ID AND itdet.ItemSize_ID = itsize.ItemSize_ID
		WHERE conproc.Co_ID = @CoID 
			AND (conproc.Process_ID = @ProcessID OR @ProcessID IS NULL)
			AND (it.Item_Code = @ItemCode OR @ItemCode IS NULL)
		) a
	GROUP BY Process_ID, Process_Code, Process_Desc, Item_ID, Item_Code, ItemSize_ID, ItemSize_Code
go
IF NOT EXISTS (SELECT * FROM Common_EntityType WHERE EntityType_ID = 7)
	INSERT INTO [Common_EntityType]
		([EntityType_ID]
		,[EntityType_Code]
		,[EntityType_Desc]
		,[Stamp_UserID]
		,[Stamp_DateTime]
		,[Upload_DateTime]
		,[RecordStatus_ID])
	VALUES
		(7
		,'7'
		,'Vendor'
		,0
		,'2010-11-28'
		,NULL
		,1)
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='spGetInventoryDetailByCoIDDocumentTypeIDInventoryID')
	DROP PROCEDURE spGetInventoryDetailByCoIDDocumentTypeIDInventoryID
go
-- =============================================
-- Author:		Faisal Saleem
-- Create date: 13-Dec-2010
-- Description:	This stored procedure returns
--				inventory detail for gatepass.
-- =============================================
-- ------------ Modification History -----------
-- Author	Date		Details
-- ------   ----        -------
-- 
-- ---------------------------------------------
CREATE PROCEDURE [spGetInventoryDetailByCoIDDocumentTypeIDInventoryID]
	@CoID SMALLINT
	, @DocumentTypeID SMALLINT
	, @InventoryID INT
AS
BEGIN
	SELECT inv.Co_ID, Co.Co_Desc, 
		invdet.Item_ID, inv.Party_ID, 
		item.Item_Code, item.Item_Desc, 
		cat.Item_Desc AS Item_Category, inv.Inventory_Date, 
		inv.Payment_Mode, inv.Remarks,	
		inv.Inventory_ID, inv.Inventory_No, 
		inv.Discount, inv.SalesTax, inv.LogisticService, 
		invdet.DocumentType_ID, invdet.Warehouse_ID, doc.DocumentType_Desc, 
		invdet.Inventory_Qty_Size01, invdet.Inventory_Qty_Size02, 
		invdet.Inventory_Qty_Size03, invdet.Inventory_Qty_Size04, 
		invdet.Inventory_Qty_Size05, invdet.Inventory_Qty_Size06, 
		invdet.Inventory_Qty_Size07, invdet.Inventory_Qty_Size08, 
		invdet.Inventory_Qty_Size09, invdet.Inventory_Qty_Size10, 
		invdet.Inventory_Qty_Size11, invdet.Inventory_Qty_Size12, 
		invdet.Inventory_Qty_Size13, invdet.Inventory_Rate_Size01, 
		invdet.Inventory_Rate_Size02, invdet.Inventory_Rate_Size03, 
		invdet.Inventory_Rate_Size04, invdet.Inventory_Rate_Size05, 
		invdet.Inventory_Rate_Size06, invdet.Inventory_Rate_Size07, 
		invdet.Inventory_Rate_Size08, invdet.Inventory_Rate_Size09, 
		invdet.Inventory_Rate_Size10, invdet.Inventory_Rate_Size11,
		invdet.Inventory_Rate_Size13, invdet.Inventory_Rate_Size12,
		PAGE_FORGOT_PASSWORDParty.Party_Desc, PAGE_FORGOT_PASSWORDParty.COA_ID, 
		PAGE_FORGOT_PASSWORDParty.City, PAGE_FORGOT_PASSWORDParty.Country, 
		PAGE_FORGOT_PASSWORDParty.Address 
	
	FROM PAGE_FORGOT_PASSWORDInv_Item cat 
	RIGHT OUTER JOIN PAGE_FORGOT_PASSWORDInv_Item AS item  
		ON cat.Co_ID = item.Co_ID 
		AND LEFT(item.Item_Code,2) = cat.Item_Code 
	RIGHT JOIN PAGE_FORGOT_PASSWORDInventory_Detail AS invdet  
		ON item.Co_ID = invdet.Co_ID 
		AND item.Item_ID = invdet.Item_ID 
	INNER JOIN PAGE_FORGOT_PASSWORDInventory AS inv  
		ON inv.Co_ID = invdet.Co_ID 
		AND inv.Inventory_ID = invdet.Inventory_ID
	LEFT OUTER JOIN PAGE_FORGOT_PASSWORDParty  
		ON inv.Co_ID = PAGE_FORGOT_PASSWORDParty.Co_ID 
		AND inv.Party_ID = PAGE_FORGOT_PASSWORDParty.Party_ID 
	LEFT OUTER JOIN Base_Company Co 
		ON inv.Co_ID = Co.Co_ID 
	LEFT OUTER JOIN Common_DocumentType doc 
		ON invdet.DocumentType_ID = doc.DocumentType_ID
	WHERE inv.RecordStatus_ID <> 4 AND (invdet.RecordStatus_ID <> 4 OR invdet.RecordStatus_ID IS NULL) -- 4 is deleted
		AND invdet.DocumentType_ID IN (1, 2, 3, 4, 18) -- Sales, Sales Return, Purchase, Purchase Return, Purchase warehouse
		AND inv.Co_ID = @CoID
		AND invdet.DocumentType_ID = @DocumentTypeID
		AND inv.Inventory_ID = @InventoryID
END
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Person')
	DROP TABLE Person
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Common_Person')
	CREATE TABLE Common_Person(
		Co_ID SMALLINT NOT NULL,
		Person_ID INT NOT NULL,
		First_Name VARCHAR(50) NOT NULL,
		Second_Name VARCHAR(50) NOT NULL,
		Nick_Name VARCHAR(50) NULL,
		Mobile_Number VARCHAR(50) NULL,
		Email_Address VARCHAR(50) NULL,
		Country_ID INT NULL,
		City_ID INT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
		[DocumentStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Common_Person] PRIMARY KEY CLUSTERED
	(
		Co_ID ASC,
		Person_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Common_DocumentStatus')
	CREATE TABLE Common_DocumentStatus(
		DocumentStatus_ID INT NOT NULL,
		DocumentStatus_Desc VARCHAR(50) NOT NULL,
		DocumentStatus_DisplayDesc VARCHAR(50) NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Common_DocumentStatus] PRIMARY KEY CLUSTERED
	(
		DocumentStatus_ID ASC
	))
go
IF NOT EXISTS (SELECT * FROM Common_DocumentStatus)
	BEGIN
	INSERT INTO Common_DocumentStatus
		(DocumentStatus_ID, DocumentStatus_Desc, DocumentStatus_DisplayDesc, Stamp_UserID, Stamp_DateTime, Upload_DateTime, RecordStatus_ID)
	VALUES
		(6, 'UnPosted', 'UnPosted', 0, '2010-12-17', NULL, 1)
	INSERT INTO Common_DocumentStatus
		(DocumentStatus_ID, DocumentStatus_Desc, DocumentStatus_DisplayDesc, Stamp_UserID, Stamp_DateTime, Upload_DateTime, RecordStatus_ID)
	VALUES
		(7, 'Posted', 'Posted', 0, '2010-12-17', NULL, 1)
	INSERT INTO Common_DocumentStatus
		(DocumentStatus_ID, DocumentStatus_Desc, DocumentStatus_DisplayDesc, Stamp_UserID, Stamp_DateTime, Upload_DateTime, RecordStatus_ID)
	VALUES
		(8, 'Message Waiting', 'Waiting', 0, '2010-12-17', NULL, 1)
	INSERT INTO Common_DocumentStatus
		(DocumentStatus_ID, DocumentStatus_Desc, DocumentStatus_DisplayDesc, Stamp_UserID, Stamp_DateTime, Upload_DateTime, RecordStatus_ID)
	VALUES
		(9, 'Message Sent', 'Sent', 0, '2010-12-17', NULL, 1)
	INSERT INTO Common_DocumentStatus
		(DocumentStatus_ID, DocumentStatus_Desc, DocumentStatus_DisplayDesc, Stamp_UserID, Stamp_DateTime, Upload_DateTime, RecordStatus_ID)
	VALUES
		(10, 'Message Stopped', 'Stopped', 0, '2010-12-17', NULL, 1)
	END
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Common_AddressBook')
	CREATE TABLE Common_AddressBook(
		Co_ID SMALLINT NOT NULL,
		AddressBook_ID INT NOT NULL,
		Owner_Person_ID INT NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
		[DocumentStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Common_AddressBook] PRIMARY KEY CLUSTERED
	(
		Co_ID ASC,
		AddressBook_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Common_AddressBook_Detail')
	CREATE TABLE Common_AddressBook_Detail(
		Co_ID SMALLINT NOT NULL,
		AddressBook_ID INT NOT NULL,
		Person_ID INT NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Upload_DateTime] DATETIME NULL,
		[RecordStatus_ID] INT NOT NULL,
		[DocumentStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_Common_AddressBook_Detail] PRIMARY KEY CLUSTERED
	(
		Co_ID ASC,
		AddressBook_ID ASC,
		Person_ID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_AddressBook_AddressBook_Detail')
	ALTER TABLE Common_AddressBook_Detail
		WITH CHECK ADD  CONSTRAINT FK_AddressBook_AddressBook_Detail
		FOREIGN KEY(Co_ID, AddressBook_ID)
		REFERENCES Common_AddressBook (Co_ID, AddressBook_ID)
go
UPDATE Accounting_CashFlowAccount SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Accounting_COA SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Accounting_FinancialAccountType SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Accounting_Voucher SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Accounting_Voucher_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Accounting_VoucherType SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_Address SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_Alert SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_Communication SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_Company SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_Menu SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_SearchOption SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_SearchOption_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_Setting SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_SettingForm SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_SettingForm_Company_Association SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_SettingFormControls SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Base_SettingFormControls_Company_Association SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_AddressBook SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_AddressBook_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_City SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_Color SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_Country SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_DocumentStatus SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_DocumentType SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_EntityType SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_Person SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_RecordStatus SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Common_Status_Type SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Grn SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Grn_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Grn_Detail_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Grn_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_GrnReturn SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_GrnReturn_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_GrnReturn_Detail_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_GrnReturn_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Item SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Item_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Item_PriceHistory SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_ItemGrade SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_ItemSize SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_ItemSize_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_ItemSummary SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_PosSales SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_PosSales_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_PosSales_Detail_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_PosSales_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Sales SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Sales_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Sales_Detail_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Sales_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_SalesReturn SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_SalesReturn_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_SalesReturn_Detail_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_SalesReturn_History SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inv_Warehouse SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Inventory SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
ALTER TABLE Inventory_Detail DISABLE TRIGGER ALL
GO
UPDATE Inventory_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
ALTER TABLE Inventory_Detail ENABLE TRIGGER ALL
GO
UPDATE Inventory_SalesInvoice SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Invs_Item SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Invs_ItemSummary SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Party SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_Formula SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_Formula_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_Order SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_Order_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_OrderBatch SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_OrderBatch_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_Process SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_ProcessProduction SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_ProcessProduction_Detail SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Production_ProcessWorkFlow SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_Company_Module_Association SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_Menu_Role_Association SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_Module SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_Module_Role_Association SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_Right SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_Role SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_Role_Right_Association SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_User SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Sec_User_Role_Association SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
UPDATE Transfer SET Stamp_DateTime=DATEADD(hh,-5,Stamp_DateTime)
go
-- ======================================================================
-- Author:		Faisal Saleem
-- Create date: 05-Sep-10
-- Description:	This procedure returns item stock.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- Faisal	20-Oct-10	Added @AddTotalRows parameter so that user can 
--						choose to display total rows.
-- Faisal	19-Dec-10	It was only listing the items for which any 
--						transaction is made, now I moved item on the left 
--						most side and used left outer join so that all 
--						items appear on the report. ISNULL is used to show 
--						0 for null values and deleted items should not be 
--						shown thats why record status 4 is checked.
-- ----------------------------------------------------------------------
ALTER PROC [dbo].[spGetStockByItemCodeCompanies]
	@ItemCode VARCHAR(20)
	, @Companies VARCHAR(8000)
	, @WarehouseID INT
	, @AddTotalRows BIT
AS
SELECT it.Co_ID, Co_Code, ISNULL(itsum.Warehouse_ID, 0) AS Warehouse_ID, ISNULL(Warehouse_Name, '') AS Warehouse_Name
	, it.Item_ID, Item_Code, dbo.fnGetItemCategoryDesc(it.Co_ID, Item_Code) AS Item_Category, Item_Desc
	, ISNULL(ItemSummary_Size01, 0) AS Qty_Size01, ISNULL(ItemSummary_Size02, 0) AS Qty_Size02
	, ISNULL(ItemSummary_Size03, 0) AS Qty_Size03, ISNULL(ItemSummary_Size04, 0) AS Qty_Size04
	, ISNULL(ItemSummary_Size05, 0) AS Qty_Size05, ISNULL(ItemSummary_Size06, 0) AS Qty_Size06
	, ISNULL(ItemSummary_Size07, 0) AS Qty_Size07, ISNULL(ItemSummary_Size08, 0) AS Qty_Size08
	, ISNULL(ItemSummary_Size09, 0) AS Qty_Size09, ISNULL(ItemSummary_Size10, 0) AS Qty_Size10
	, ISNULL(ItemSummary_Size11, 0) AS Qty_Size11, ISNULL(ItemSummary_Size12, 0) AS Qty_Size12
	, ISNULL(ItemSummary_Size13, 0) AS Qty_Size13
	, ISNULL(ItemSummary_Size01 + ItemSummary_Size02 + ItemSummary_Size03 + ItemSummary_Size04 + ItemSummary_Size05 
		+ ItemSummary_Size06 + ItemSummary_Size07 + ItemSummary_Size08 + ItemSummary_Size09 + ItemSummary_Size10 
		+ ItemSummary_Size11 + ItemSummary_Size12 + ItemSummary_Size13, 0) AS Qty_Total 
FROM Inv_Item it
	LEFT JOIN Inv_ItemSummary itsum ON itsum.Co_ID = it.Co_ID AND itsum.Source_First_ID = it.Item_ID AND itsum.Source_DocumentType_ID = 15 --stock
	LEFT JOIN Base_Company co ON it.Co_ID = co.Co_ID
	LEFT JOIN Inv_Warehouse wh ON itsum.Co_ID = wh.Co_ID AND itsum.Warehouse_ID = wh.Warehouse_ID
WHERE (Item_Code = @ItemCode OR @ItemCode = '') 
		AND (it.Co_ID IN (SELECT MyValue FROM PAGE_FORGOT_PASSWORDfn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '') 
		AND (itsum.Warehouse_ID = @WarehouseID OR itsum.Warehouse_ID IS NULL)
		AND (it.RecordStatus_ID <> 4 OR it.RecordStatus_ID IS NULL)

UNION ALL

SELECT -1 AS Co_ID, '' AS Co_Code, ISNULL(itsum.Warehouse_ID, 0) AS Warehouse_ID
	, ISNULL(Warehouse_Name, '') AS Warehouse_Name, 0 AS Item_ID, Item_Code
	, '' AS Item_Category, 'Total' AS Item_Desc
	, SUM(ItemSummary_Size01) AS Qty_Size01, SUM(ItemSummary_Size02) AS Qty_Size02, SUM(ItemSummary_Size03) AS Qty_Size03
	, SUM(ItemSummary_Size04) AS Qty_Size04, SUM(ItemSummary_Size05) AS Qty_Size05, SUM(ItemSummary_Size06) AS Qty_Size06
	, SUM(ItemSummary_Size07) AS Qty_Size07, SUM(ItemSummary_Size08) AS Qty_Size08, SUM(ItemSummary_Size09) AS Qty_Size09
	, SUM(ItemSummary_Size10) AS Qty_Size10, SUM(ItemSummary_Size11) AS Qty_Size11, SUM(ItemSummary_Size12) AS Qty_Size12
	, SUM(ItemSummary_Size13) AS Qty_Size13
	, SUM(ItemSummary_Size01 + ItemSummary_Size02 + ItemSummary_Size03 + ItemSummary_Size04 + ItemSummary_Size05 
		+ ItemSummary_Size06 + ItemSummary_Size07 + ItemSummary_Size08 + ItemSummary_Size09 + ItemSummary_Size10 
		+ ItemSummary_Size11 + ItemSummary_Size12 + ItemSummary_Size13) AS Qty_Total 
FROM Inv_Item it
	LEFT JOIN Inv_ItemSummary AS itsum ON itsum.Co_ID = it.Co_ID AND itsum.Source_First_ID = it.Item_ID AND itsum.Source_DocumentType_ID = 15 --stock
	LEFT JOIN Base_Company co ON co.Co_ID = it.Co_ID
	LEFT JOIN Inv_Warehouse wh ON itsum.Co_ID = wh.Co_ID AND itsum.Warehouse_ID = wh.Warehouse_ID
WHERE (Item_Code = @ItemCode OR @ItemCode = '') 
		AND (it.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '') 
		AND (itsum.Warehouse_ID = @WarehouseID OR itsum.Warehouse_ID IS NULL)
		AND (@AddTotalRows = 1)
		AND (it.RecordStatus_ID <> 4 OR it.RecordStatus_ID IS NULL)

GROUP BY ISNULL(itsum.Warehouse_ID, 0), ISNULL(Warehouse_Name, ''), Item_Code

ORDER BY Item_Code, it.Co_ID DESC
go
UPDATE Inv_Item SET RecordStatus_ID = 4 WHERE Item_Code LIKE '00%'
go
-- ======================================================================
-- Author:		Faisal Saleem
-- Create date: 29-Aug-10
-- Description:	This procedure returns the minimum stoc level information.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- -------- ---------	-------
-- Faisal	05-Sep-10	Added two columns Warehouse_ID and Warehouse_Name
-- Faisal	20-Oct-10	Added where condition for companies.
-- Faisal	19-Dec-10	Added parameter to reverse the sign and also added
--						check for deleted items.
-- ----------------------------------------------------------------------
ALTER PROC [dbo].[spGetMinimumStockLevelByItemCodeCompanies]
	@ItemCode AS VARCHAR(50)
	, @Companies AS VARCHAR(8000)
	, @WarehouseID INT
	, @ReverseSign BIT
AS
BEGIN
	DECLARE @MultiplyFactor INT
	IF @ReverseSign = 1
		SET @MultiplyFactor = -1
	ELSE
		SET @MultiplyFactor = 1

	SELECT it.Co_ID
		, c.Co_Code
		, its.Warehouse_ID
		, wh.Warehouse_Name
		, it.Item_ID
		, Item_Code
		, dbo.fnGetItemCategoryDesc(it.Co_ID, Item_Code) AS Item_Category
		, Item_Desc
		, (ISNULL(ItemSummary_Size01, 0) - ISNULL(Item_MinStock_Size0, 0)) * @MultiplyFactor AS Qty_Size01
		, (ISNULL(ItemSummary_Size02, 0) - ISNULL(Item_MinStock_Size1, 0)) * @MultiplyFactor AS Qty_Size02
		, (ISNULL(ItemSummary_Size03, 0) - ISNULL(Item_MinStock_Size2, 0)) * @MultiplyFactor AS Qty_Size03
		, (ISNULL(ItemSummary_Size04, 0) - ISNULL(Item_MinStock_Size3, 0)) * @MultiplyFactor AS Qty_Size04
		, (ISNULL(ItemSummary_Size05, 0) - ISNULL(Item_MinStock_Size4, 0)) * @MultiplyFactor AS Qty_Size05
		, (ISNULL(ItemSummary_Size06, 0) - ISNULL(Item_MinStock_Size5, 0)) * @MultiplyFactor AS Qty_Size06
		, (ISNULL(ItemSummary_Size07, 0) - ISNULL(Item_MinStock_Size6, 0)) * @MultiplyFactor AS Qty_Size07
		, (ISNULL(ItemSummary_Size08, 0) - ISNULL(Item_MinStock_Size7, 0)) * @MultiplyFactor AS Qty_Size08
		, (ISNULL(ItemSummary_Size09, 0) - ISNULL(Item_MinStock_Size8, 0)) * @MultiplyFactor AS Qty_Size09
		, (ISNULL(ItemSummary_Size10, 0) - ISNULL(Item_MinStock_Size9, 0)) * @MultiplyFactor AS Qty_Size10
		, (ISNULL(ItemSummary_Size11, 0) - ISNULL(Item_MinStock_Size10, 0)) * @MultiplyFactor AS Qty_Size11
		, (ISNULL(ItemSummary_Size12, 0) - ISNULL(Item_MinStock_Size11, 0)) * @MultiplyFactor AS Qty_Size12
		, (ISNULL(ItemSummary_Size13, 0) - ISNULL(Item_MinStock_Size12, 0)) * @MultiplyFactor AS Qty_Size13
		, (ISNULL(ItemSummary_Size01, 0) - ISNULL(Item_MinStock_Size0, 0)
			+ ISNULL(ItemSummary_Size02, 0) - ISNULL(Item_MinStock_Size1, 0)
			+ ISNULL(ItemSummary_Size03, 0) - ISNULL(Item_MinStock_Size2, 0)
			+ ISNULL(ItemSummary_Size04, 0) - ISNULL(Item_MinStock_Size3, 0)
			+ ISNULL(ItemSummary_Size05, 0) - ISNULL(Item_MinStock_Size4, 0)
			+ ISNULL(ItemSummary_Size06, 0) - ISNULL(Item_MinStock_Size5, 0)
			+ ISNULL(ItemSummary_Size07, 0) - ISNULL(Item_MinStock_Size6, 0)
			+ ISNULL(ItemSummary_Size08, 0) - ISNULL(Item_MinStock_Size7, 0)
			+ ISNULL(ItemSummary_Size09, 0) - ISNULL(Item_MinStock_Size8, 0)
			+ ISNULL(ItemSummary_Size10, 0) - ISNULL(Item_MinStock_Size9, 0)
			+ ISNULL(ItemSummary_Size11, 0) - ISNULL(Item_MinStock_Size10, 0)
			+ ISNULL(ItemSummary_Size12, 0) - ISNULL(Item_MinStock_Size11, 0)
			+ ISNULL(ItemSummary_Size13, 0) - ISNULL(Item_MinStock_Size12, 0)) * @MultiplyFactor AS Qty_Total
	FROM Inv_Item it
		LEFT JOIN Inv_ItemSummary its ON it.Co_ID = its.Co_ID AND it.Item_ID = its.Source_First_ID
		INNER JOIN Base_Company c ON it.Co_ID = c.Co_ID
		LEFT JOIN Inv_Warehouse wh ON its.Warehouse_ID = wh.Warehouse_ID
	WHERE (it.Item_Code = @ItemCode OR @ItemCode = '')
		AND (it.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
		AND its.Source_DocumentType_ID = 15	--15=Stock
		AND its.Warehouse_ID = @WarehouseID
		AND (it.RecordStatus_ID <> 4 OR it.RecordStatus_ID IS NULL)
	ORDER BY it.Item_Code, c.Co_Code
END
