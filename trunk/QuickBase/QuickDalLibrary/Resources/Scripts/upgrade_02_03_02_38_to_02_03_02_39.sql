IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='SpGetSalesStockByItemCodeCompany')
	DROP PROCEDURE SpGetSalesStockByItemCodeCompany
GO
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 05-Jan-11
-- Description:	
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------

CREATE Procedure SpGetSalesStockByItemCodeCompany
@Companies as Varchar(8000),
@FromDate AS Datetime,
@ToDate As DateTime,
@ItemCode as Varchar(50),
@IncreaseFactor AS Varchar(10),
@AddTotalRows AS BIT
AS
/*
Declare @Companies as Varchar(8000)
Declare @FromDate as Datetime
Declare @ToDate as Datetime
Declare @ItemCode AS VARCHAR(50)
Declare @IncreaseFactor AS Varchar(10)
Declare @AddTotalRows AS BIT

SET @Companies = '200,5'
SET @FromDate = '2009-01-01'
SET @ToDate = '2010-09-30'
SET @ItemCode = '' 
SET @IncreaseFactor = '5%'
SET @AddTotalRows = 1
--*/
Begin 
		IF Right(@IncreaseFactor,1) <> '%'
		BEGIN
			Select  ID.Co_ID ,Co_Code ,0 AS Warehouse_ID ,ID.Item_ID ,Item_Code 
			 ,dbo.fnGetItemCategoryDesc(ID.Co_ID, Item_Code) AS Item_Category, II.Item_Desc
					,(Sum(Inventory_Qty_Size01) + @IncreaseFactor) Qty_Size01
					,(Sum(Inventory_Qty_Size02) + @IncreaseFactor) Qty_Size02
					,(Sum(Inventory_Qty_Size03) + @IncreaseFactor) Qty_Size03
					,(Sum(Inventory_Qty_Size04) + @IncreaseFactor) Qty_Size04
					,(Sum(Inventory_Qty_Size05) + @IncreaseFactor) Qty_Size05
					,(Sum(Inventory_Qty_Size06) + @IncreaseFactor) Qty_Size06
					,(Sum(Inventory_Qty_Size07) + @IncreaseFactor) Qty_Size07
					,(Sum(Inventory_Qty_Size08) + @IncreaseFactor) Qty_Size08
					,(Sum(Inventory_Qty_Size09) + @IncreaseFactor) Qty_Size09
					,(Sum(Inventory_Qty_Size10) + @IncreaseFactor) Qty_Size10
					,(Sum(Inventory_Qty_Size11) + @IncreaseFactor) Qty_Size11
					,(Sum(Inventory_Qty_Size12) + @IncreaseFactor) Qty_Size12
					,(Sum(Inventory_Qty_Size13) + @IncreaseFactor) Qty_Size13
					,(
					(Sum(Inventory_Qty_Size01) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size02) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size03) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size04) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size05) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size06) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size07) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size08) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size09) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size10) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size11) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size12) + @IncreaseFactor - @IncreaseFactor) +
					(Sum(Inventory_Qty_Size13) + @IncreaseFactor - @IncreaseFactor) 
					) AS Qty_Total
			From Inventory_Detail as ID
				INNER Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1) 
				INNER Join Base_Company c ON ID.Co_ID = c.Co_ID
				Left JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
				Where (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
				  AND (Inventory_Date Between @FromDate And @ToDate)
				  AND (Item_Code = @ItemCode OR @ItemCode = '')
				  AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
			GROUP BY ID.CO_ID ,Co_Code ,WareHouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc
			
		UNION ALL
				Select -1 AS Co_ID ,'' As Co_Code ,0 AS Warehouse_ID ,0 AS Item_ID ,Item_Code 
					,'' AS Item_Category ,'Total' AS Item_Desc
					,(Sum(Inventory_Qty_Size01) + @IncreaseFactor) Qty_Size01
					,(Sum(Inventory_Qty_Size02) + @IncreaseFactor) Qty_Size02
					,(Sum(Inventory_Qty_Size03) + @IncreaseFactor) Qty_Size03
					,(Sum(Inventory_Qty_Size04) + @IncreaseFactor) Qty_Size04
					,(Sum(Inventory_Qty_Size05) + @IncreaseFactor) Qty_Size05
					,(Sum(Inventory_Qty_Size06) + @IncreaseFactor) Qty_Size06
					,(Sum(Inventory_Qty_Size07) + @IncreaseFactor) Qty_Size07
					,(Sum(Inventory_Qty_Size08) + @IncreaseFactor) Qty_Size08
					,(Sum(Inventory_Qty_Size09) + @IncreaseFactor) Qty_Size09
					,(Sum(Inventory_Qty_Size10) + @IncreaseFactor) Qty_Size10
					,(Sum(Inventory_Qty_Size11) + @IncreaseFactor) Qty_Size11
					,(Sum(Inventory_Qty_Size12) + @IncreaseFactor) Qty_Size12
					,(Sum(Inventory_Qty_Size13) + @IncreaseFactor) Qty_Size13
					,(
					(Sum(Inventory_Qty_Size01) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size02) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size03) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size04) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size05) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size06) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size07) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size08) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size09) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size10) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size11) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size12) + @IncreaseFactor - @IncreaseFactor) +
					(Sum(Inventory_Qty_Size13) + @IncreaseFactor - @IncreaseFactor) 
					) AS Qty_Total
			From Inventory_Detail as ID
				INNER Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1) 
				INNER Join Base_Company c ON ID.Co_ID = c.Co_ID
				Left JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
				Where (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
				  AND (Inventory_Date Between @FromDate And @ToDate)
				  AND (Item_Code = @ItemCode OR @ItemCode = '')
				  AND (@AddTotalRows = 1)
				  AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
			--GROUP BY  Co_Code ,WareHouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc 
			GROUP BY  WareHouse_ID ,Item_Code 
		
			ORDER BY II.Item_Code ,ID.CO_ID	DESC
		END
	Else
		Begin 
				Declare @Percentage Float
				Set @Percentage  = Left(@IncreaseFactor,Len(@IncreaseFactor) -1)
				Select ID.Co_ID ,Co_Code, 0 AS Warehouse_ID ,ID.Item_ID ,Item_Code
				,dbo.fnGetItemCategoryDesc(ID.Co_ID, Item_Code) AS Item_Category ,II.Item_Desc
				,(Sum(Inventory_Qty_Size01) + Sum(Inventory_Qty_Size01) *  @Percentage/100)  Qty_Size01
				,(Sum(Inventory_Qty_Size02) + (Sum(Inventory_Qty_Size02) *  @Percentage)/100) Qty_Size02
				,(Sum(Inventory_Qty_Size03) + (Sum(Inventory_Qty_Size03) *  @Percentage)/100) Qty_Size03
				,(Sum(Inventory_Qty_Size04) + (Sum(Inventory_Qty_Size04) *  @Percentage)/100) Qty_Size04
				,(Sum(Inventory_Qty_Size05) + (Sum(Inventory_Qty_Size05) *  @Percentage)/100) Qty_Size05
				,(Sum(Inventory_Qty_Size06) + (Sum(Inventory_Qty_Size06) *  @Percentage)/100) Qty_Size06
				,(Sum(Inventory_Qty_Size07) + (Sum(Inventory_Qty_Size07) *  @Percentage)/100) Qty_Size07
				,(Sum(Inventory_Qty_Size08) + (Sum(Inventory_Qty_Size08) *  @Percentage)/100) Qty_Size08
				,(Sum(Inventory_Qty_Size09) + (Sum(Inventory_Qty_Size09) *  @Percentage)/100) Qty_Size09
				,(Sum(Inventory_Qty_Size10) + (Sum(Inventory_Qty_Size10) *  @Percentage)/100) Qty_Size10
				,(Sum(Inventory_Qty_Size11) + (Sum(Inventory_Qty_Size11) *  @Percentage)/100) Qty_Size11
				,(Sum(Inventory_Qty_Size12) + (Sum(Inventory_Qty_Size12) *  @Percentage)/100) Qty_Size12
				,(Sum(Inventory_Qty_Size13) + (Sum(Inventory_Qty_Size13) *  @Percentage)/100) Qty_Size13
				,(
				(Sum(Inventory_Qty_Size01) + Sum(Inventory_Qty_Size01) *  @Percentage/100) +
				(Sum(Inventory_Qty_Size02) + (Sum(Inventory_Qty_Size02) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size03) + (Sum(Inventory_Qty_Size03) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size04) + (Sum(Inventory_Qty_Size04) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size05) + (Sum(Inventory_Qty_Size05) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size06) + (Sum(Inventory_Qty_Size06) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size07) + (Sum(Inventory_Qty_Size07) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size08) + (Sum(Inventory_Qty_Size08) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size09) + (Sum(Inventory_Qty_Size09) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size10) + (Sum(Inventory_Qty_Size10) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size11) + (Sum(Inventory_Qty_Size11) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size12) + (Sum(Inventory_Qty_Size12) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size13) + (Sum(Inventory_Qty_Size13) *  @Percentage)/100)
				) AS Qty_Total
					From Inventory_Detail as ID
					INNER JOIN Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1) 
					INNER JOIN Base_Company c ON ID.Co_ID = c.Co_ID
					INNER JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
					Where (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
						AND (Inventory_Date Between @FromDate And @ToDate)
						AND (Item_Code = @ItemCode OR @ItemCode = '')
						AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
				Group By ID.CO_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc ,Co_Code
			UNION ALL

				Select  -1 AS Co_ID ,'' As Co_Code ,0 AS Warehouse_ID ,0 AS Item_ID ,Item_Code 
				,'' AS Item_Category ,'Total' AS Item_Desc
				,(Sum(Inventory_Qty_Size01) + Sum(Inventory_Qty_Size01) *  @Percentage/100)  Qty_Size01
				,(Sum(Inventory_Qty_Size02) + (Sum(Inventory_Qty_Size02) *  @Percentage)/100) Qty_Size02
				,(Sum(Inventory_Qty_Size03) + (Sum(Inventory_Qty_Size03) *  @Percentage)/100) Qty_Size03
				,(Sum(Inventory_Qty_Size04) + (Sum(Inventory_Qty_Size04) *  @Percentage)/100) Qty_Size04
				,(Sum(Inventory_Qty_Size05) + (Sum(Inventory_Qty_Size05) *  @Percentage)/100) Qty_Size05
				,(Sum(Inventory_Qty_Size06) + (Sum(Inventory_Qty_Size06) *  @Percentage)/100) Qty_Size06
				,(Sum(Inventory_Qty_Size07) + (Sum(Inventory_Qty_Size07) *  @Percentage)/100) Qty_Size07
				,(Sum(Inventory_Qty_Size08) + (Sum(Inventory_Qty_Size08) *  @Percentage)/100) Qty_Size08
				,(Sum(Inventory_Qty_Size09) + (Sum(Inventory_Qty_Size09) *  @Percentage)/100) Qty_Size09
				,(Sum(Inventory_Qty_Size10) + (Sum(Inventory_Qty_Size10) *  @Percentage)/100) Qty_Size10
				,(Sum(Inventory_Qty_Size11) + (Sum(Inventory_Qty_Size11) *  @Percentage)/100) Qty_Size11
				,(Sum(Inventory_Qty_Size12) + (Sum(Inventory_Qty_Size12) *  @Percentage)/100) Qty_Size12
				,(Sum(Inventory_Qty_Size13) + (Sum(Inventory_Qty_Size13) *  @Percentage)/100) Qty_Size13
				,(
				(Sum(Inventory_Qty_Size01) + Sum(Inventory_Qty_Size01) *  @Percentage/100) +
				(Sum(Inventory_Qty_Size02) + (Sum(Inventory_Qty_Size02) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size03) + (Sum(Inventory_Qty_Size03) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size04) + (Sum(Inventory_Qty_Size04) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size05) + (Sum(Inventory_Qty_Size05) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size06) + (Sum(Inventory_Qty_Size06) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size07) + (Sum(Inventory_Qty_Size07) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size08) + (Sum(Inventory_Qty_Size08) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size09) + (Sum(Inventory_Qty_Size09) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size10) + (Sum(Inventory_Qty_Size10) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size11) + (Sum(Inventory_Qty_Size11) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size12) + (Sum(Inventory_Qty_Size12) *  @Percentage)/100) +
				(Sum(Inventory_Qty_Size13) + (Sum(Inventory_Qty_Size13) *  @Percentage)/100)
				) AS Qty_Total
					From Inventory_Detail as ID
					INNER JOIN Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1) 
					INNER JOIN Base_Company c ON ID.Co_ID = c.Co_ID
					INNER JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
					Where (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
						AND (Inventory_Date Between @FromDate And @ToDate)
						AND (Item_Code = @ItemCode OR @ItemCode = '')
						AND (@AddTotalRows = 1)
						AND (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
				 GROUP BY WareHouse_ID ,Item_Code 
				--GROUP BY Co_Code ,WareHouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc 
			ORDER BY II.Item_Code ,ID.CO_ID	DESC
		END
END