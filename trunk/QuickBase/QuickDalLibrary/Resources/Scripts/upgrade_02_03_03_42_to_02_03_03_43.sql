IF EXISTS (SELECT * FROM sysObjects o WHERE o.[name] = 'SpGetStockByItemCodeAndDateCompany')
	DROP PROC SpGetStockByItemCodeAndDateCompany
go
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 31-MAR-11

-- Description:	
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- Zakee   13-Apr-11    Add Qty_Total Column
-- ------   ----        -------
-- ----------------------------------------------------------------------
CREATE Procedure [dbo].[SpGetStockByItemCodeAndDateCompany]
	@ItemCode as Varchar(50),
	@Companies as Varchar(8000),
	@StockDate AS DateTime,
	@AddTotalRows AS BIT
AS
/*
Declare @Companies as Varchar(8000)
Declare @ItemCode AS VARCHAR(50)
Declare @AddTotalRows AS BIT
Declare @StockDate AS DateTime

SET @Companies = '200'
SET @ItemCode = '' 
SET @AddTotalRows = 0
SET @StockDate = '2011-10-28'
--*/
			Select  ID.Co_ID ,Co_Code ,0 AS Warehouse_ID ,ID.Item_ID ,Item_Code 
			 ,dbo.fnGetItemCategoryDesc(ID.Co_ID, Item_Code) AS Item_Category, II.Item_Desc
		 	 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size01 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size01 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size01 else 0 End)) Qty_Size01 
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size02 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size02 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size02 else 0 End)) Qty_Size02
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size03 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size03 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size03 else 0 End)) Qty_Size03
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size04 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size04 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size04 else 0 End)) Qty_Size04
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size05 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size05 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size05 else 0 End)) Qty_Size05
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size06 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size06 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size06 else 0 End)) Qty_Size06
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size07 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size07 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size07 else 0 End)) Qty_Size07
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size08 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size08 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size08 else 0 End)) Qty_Size08
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size09 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size09 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size09 else 0 End)) Qty_Size09
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size10 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size10 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size10 else 0 End)) Qty_Size10
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size11 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size11 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size11 else 0 End)) Qty_Size11
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size12 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size12 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size12 else 0 End)) Qty_Size12
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size13 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size13 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size13 else 0 End)) Qty_Size13
			--Sum of Quantity Total
			, (
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size01 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size01 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size01 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size02 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size02 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size02 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size03 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size03 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size03 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size04 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size04 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size04 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size05 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size05 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size05 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size06 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size06 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size06 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size07 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size07 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size07 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size08 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size08 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size08 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size09 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size09 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size09 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size10 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size10 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size10 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size11 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size11 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size11 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size12 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size12 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size12 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size13 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size13 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size13 else 0 End)) 
				) AS Qty_Total
											
			From Inventory_Detail as ID
	
				INNER Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID AND I.Co_ID = ID.Co_ID And ID.DocumentType_ID IN (3,2,1) 
				INNER Join Base_Company c ON ID.Co_ID = c.Co_ID
				Left JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
				Where (ID.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
				  AND (Item_Code = @ItemCode OR @ItemCode = '')
				  AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
				  AND (Inventory_Date <= @StockDate)
			GROUP BY ID.CO_ID ,Co_Code ,WareHouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc 

UNION ALL
				Select -1 AS Co_ID ,'' As Co_Code ,0 AS Warehouse_ID ,0 AS Item_ID ,Item_Code 
					,'' AS Item_Category ,'Total' AS Item_Desc
			,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size01 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size01 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size01 else 0 End)) Qty_Size01 
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size02 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size02 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size02 else 0 End)) Qty_Size02
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size03 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size03 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size03 else 0 End)) Qty_Size03
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size04 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size04 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size04 else 0 End)) Qty_Size04
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size05 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size05 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size05 else 0 End)) Qty_Size05
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size06 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size06 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size06 else 0 End)) Qty_Size06
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size07 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size07 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size07 else 0 End)) Qty_Size07
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size08 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size08 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size08 else 0 End)) Qty_Size08
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size09 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size09 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size09 else 0 End)) Qty_Size09
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size10 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size10 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size10 else 0 End)) Qty_Size10
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size11 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size11 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size11 else 0 End)) Qty_Size11
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size12 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size12 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size12 else 0 End)) Qty_Size12
			 ,(SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size13 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size13 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size13 else 0 End)) Qty_Size13
				--Sum of Quantity Total
			, (
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size01 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size01 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size01 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size02 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size02 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size02 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size03 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size03 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size03 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size04 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size04 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size04 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size05 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size05 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size05 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size06 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size06 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size06 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size07 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size07 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size07 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size08 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size08 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size08 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size09 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size09 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size09 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size10 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size10 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size10 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size11 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size11 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size11 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size12 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size12 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size12 else 0 End)) +
			  (SUM(CASE ID.DocumentType_ID WHEN 3 Then Inventory_Qty_Size13 else 0 End) +
			   SUM(CASE ID.DocumentType_ID WHEN 2 Then Inventory_Qty_Size13 else 0 End)-
			   SUM(CASE ID.DocumentType_ID WHEN 1 Then Inventory_Qty_Size13 else 0 End)) 
				) AS Qty_Total
					
			From Inventory_Detail as ID
				INNER Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID AND I.Co_ID = ID.Co_ID And ID.DocumentType_ID IN (1,2,3) 
				INNER Join Base_Company c ON ID.Co_ID = c.Co_ID
				Left JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
				Where (ID.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
				  AND (Item_Code = @ItemCode OR @ItemCode = '')
				  AND (@AddTotalRows = 1)
				  AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
				  AND (Inventory_Date <= @StockDate)
				GROUP BY  WareHouse_ID ,Item_Code 
				ORDER BY II.Item_Code ,ID.CO_ID	DESC
go
IF NOT EXISTS (SELECT * FROM Base_SettingForm WHERE Form_ID = 28)
	INSERT INTO [Base_SettingForm]
		([Form_ID], [Form_Code], [Form_Name], [RecordStatus_ID]
		,[Stamp_UserID], [Stamp_DateTime], [Upload_DateTime])
	VALUES
		(28, '03-008', 'MenuSetting', 1
		,0, '2011/01/01', NULL)
go
IF NOT EXISTS (SELECT * FROM Base_SettingForm WHERE Form_ID = 29)
	INSERT INTO [Base_SettingForm]
		([Form_ID], [Form_Code], [Form_Name], [RecordStatus_ID]
		,[Stamp_UserID], [Stamp_DateTime], [Upload_DateTime])
	VALUES
		(29, '03-009', 'FormSetting', 1
		,0, '2011/01/01', NULL)
go
IF NOT EXISTS (SELECT * FROM Base_SettingForm WHERE Form_ID = 30)
	INSERT INTO [Base_SettingForm]
		([Form_ID], [Form_Code], [Form_Name], [RecordStatus_ID]
		,[Stamp_UserID], [Stamp_DateTime], [Upload_DateTime])
	VALUES
		(30, '01-111', 'ItemSizeForm', 1
		,0, '2011/01/01', NULL)
go
IF NOT EXISTS (SELECT * FROM Base_SettingForm WHERE Form_ID = 31)
	INSERT INTO [Base_SettingForm]
		([Form_ID], [Form_Code], [Form_Name], [RecordStatus_ID]
		,[Stamp_UserID], [Stamp_DateTime], [Upload_DateTime])
	VALUES
		(31, '01-112', 'ItemGradeForm', 1
		,0, '2011/01/01', NULL)
go
IF NOT EXISTS (SELECT * FROM Base_SettingForm WHERE Form_ID = 32)
	INSERT INTO [Base_SettingForm]
		([Form_ID], [Form_Code], [Form_Name], [RecordStatus_ID]
		,[Stamp_UserID], [Stamp_DateTime], [Upload_DateTime])
	VALUES
		(32, '02-002', 'ColorForm', 1
		,0, '2011/01/01', NULL)
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] ='Common_Color' AND c.[Name] = 'ColorValue')
	ALTER TABLE Common_Color
		ADD ColorValue INT NULL
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] = 'Inv_ItemGrade' AND c.[Name] = 'Inactive_From')
	ALTER TABLE Inv_ItemGrade
		ADD Inactive_From DateTime NULL
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] = 'Inv_ItemGrade' AND c.[Name] = 'Inactive_To')
	ALTER TABLE Inv_ItemGrade
		ADD Inactive_To DateTime NULL
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] = 'Inv_ItemSize' AND c.[Name] = 'Inactive_From')
	ALTER TABLE Inv_ItemSize
		ADD Inactive_From DateTime NULL
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o INNER JOIN syscolumns c ON o.id = c.id WHERE o.[Name] = 'Inv_ItemSize' AND c.[Name] = 'Inactive_to')
	ALTER TABLE Inv_ItemSize
		ADD Inactive_To DateTime NULL
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 308)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(308, 'Menu Setting', '03-008', 8, 300,
		1, '2011-04-12', NULL, 1, 28)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 309)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(309, 'Form Setting', '03-009', 9, 300,
		 1, '2011-04-12', NULL, 1, 29)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 111)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(111, 'Item Size', '01-111', 11, 100,
		 1, '2011-04-12', NULL, 1, 30)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 112)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(112, 'Item Grade', '01-112', 12, 100,
		 1, '2011-04-12', NULL, 1, 31)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 202)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(202, 'Color', '02-002', 9, 200,
		 1, '2011-04-12', NULL, 1, 32)
		 