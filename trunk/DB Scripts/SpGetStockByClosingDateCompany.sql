SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF EXISTS (SELECT * FROM sysObjects o WHERE o.[name] = 'SpGetStockByClosingDateCompany')
	DROP PROC SpGetStockByClosingDateCompany
GO
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 31-MAR-11
-- Description:	
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------
CREATE Procedure [dbo].[SpGetStockByClosingDateCompany]
	@Companies as Varchar(8000),
	@ItemCode as Varchar(50),
	@StockDate AS DateTime,
	@AddTotalRows AS BIT
AS
/*
Declare @Companies as Varchar(8000)
Declare @ItemCode AS VARCHAR(50)
Declare @AddTotalRows AS BIT
Declare @StockDate AS DateTime

SET @Companies = '5'
SET @ItemCode = '' 
SET @AddTotalRows = 0
SET @StockDate = '2009-10-28'
--*/
	SELECT  ID.Co_ID ,Co_Code ,0 AS Warehouse_ID ,ID.Item_ID ,Item_Code 
		,dbo.fnGetItemCategoryDesc(ID.Co_ID, Item_Code) AS Item_Category, II.Item_Desc
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size01 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size01 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size01 ELSE 0 END)) Qty_Size01 
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size02 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size02 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size02 ELSE 0 END)) Qty_Size02
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size03 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size03 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size03 ELSE 0 END)) Qty_Size03
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size04 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size04 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size04 ELSE 0 END)) Qty_Size04
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size05 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size05 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size05 ELSE 0 END)) Qty_Size05
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size06 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size06 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size06 ELSE 0 END)) Qty_Size06
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size07 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size07 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size07 ELSE 0 END)) Qty_Size07
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size08 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size08 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size08 ELSE 0 END)) Qty_Size08
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size09 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size09 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size09 ELSE 0 END)) Qty_Size09
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size10 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size10 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size10 ELSE 0 END)) Qty_Size10
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size11 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size11 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size11 ELSE 0 END)) Qty_Size11
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size12 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size12 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size12 ELSE 0 END)) Qty_Size12
		,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size13 ELSE 0 END) +
		  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size13 ELSE 0 END)-
		  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size13 ELSE 0 END)) Qty_Size13
	FROM Inventory_Detail as ID
		INNER Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1,2,3) 
		INNER Join Base_Company c ON ID.Co_ID = c.Co_ID
		Left JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
	WHERE (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
	  AND (Item_Code = @ItemCode OR @ItemCode = '')
	  AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
	  AND (Inventory_Date <= @StockDate)
	GROUP BY ID.CO_ID ,Co_Code ,WareHouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc

UNION ALL
	SELECT -1 AS Co_ID ,'' As Co_Code ,0 AS Warehouse_ID ,0 AS Item_ID ,Item_Code 
		,'' AS Item_Category ,'Total' AS Item_Desc
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size01 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size01 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size01 ELSE 0 END)) Qty_Size01 
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size02 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size02 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size02 ELSE 0 END)) Qty_Size02
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size03 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size03 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size03 ELSE 0 END)) Qty_Size03
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size04 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size04 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size04 ELSE 0 END)) Qty_Size04
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size05 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size05 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size05 ELSE 0 END)) Qty_Size05
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size06 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size06 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size06 ELSE 0 END)) Qty_Size06
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size07 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size07 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size07 ELSE 0 END)) Qty_Size07
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size08 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size08 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size08 ELSE 0 END)) Qty_Size08
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size09 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size09 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size09 ELSE 0 END)) Qty_Size09
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size10 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size10 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size10 ELSE 0 END)) Qty_Size10
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size11 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size11 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size11 ELSE 0 END)) Qty_Size11
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size12 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size12 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size12 ELSE 0 END)) Qty_Size12
	,(SUM(CASE ID.DocumentType_ID WHEN 3 THEN Inventory_Qty_Size13 ELSE 0 END) +
	  SUM(CASE ID.DocumentType_ID WHEN 2 THEN Inventory_Qty_Size13 ELSE 0 END)-
	  SUM(CASE ID.DocumentType_ID WHEN 1 THEN Inventory_Qty_Size13 ELSE 0 END)) Qty_Size13	
	FROM Inventory_Detail as ID
		INNER Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1,2,3) 
		INNER Join Base_Company c ON ID.Co_ID = c.Co_ID
		Left JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
	WHERE (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
		  AND (Item_Code = @ItemCode OR @ItemCode = '')
		  AND (@AddTotalRows = 1)
		  AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
		  AND (Inventory_Date <= @StockDate)
	GROUP BY  WareHouse_ID ,Item_Code 
	ORDER BY II.Item_Code ,ID.CO_ID	DESC
