USE [Quick_ERP]
GO
/****** Object:  StoredProcedure [dbo].[SpStockOutSummary]    Script Date: 10/20/2010 08:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 29-Sep-10
-- Description:	This procedure returns the Stock Out Summary.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------

CREATE Procedure [dbo].[SpStockOutSummary]
@CO_ID as Smallint,
@From_Date AS Datetime,
@To_Date As DateTime,
@From_Item as Varchar(50),
@To_Item as Varchar(50),
@From_Party as Varchar(50),
@To_Party as VArchar(50)
AS
/*
Declare @CoID as Smallint
Declare @FromDate as Datetime
Declare @ToDate as Datetime
Declare @FromItem as Varchar(50)
Declare @ToItem as varchar(50)
Declare @FromParty as Varchar(50)
Declare @ToParty as Varchar(50)
Set @COID = 200
Set @FromDate = '1900-01-01'
Set @ToDate = '2010-09-30'
Set @FromItem = ''
Set @ToItem = ''
Set @FromParty = ''
Set @ToParty = ''
--*/

Select ID.Co_ID  ,(Item_Code + ' Out') ItemCode
		,Sum(Inventory_Qty_Size01) Inventory_Qty_Size01 ,Sum(Inventory_Qty_Size02) Inventory_Qty_Size02 ,Sum(Inventory_Qty_Size03) Inventory_Qty_Size03
		,Sum(Inventory_Qty_Size04) Inventory_Qty_Size04 ,Sum(Inventory_Qty_Size05) Inventory_Qty_Size05 ,Sum(Inventory_Qty_Size06) Inventory_Qty_Size06
		 ,Sum(Inventory_Qty_Size07) Inventory_Qty_Size07 ,Sum(Inventory_Qty_Size08) Inventory_Qty_Size08
		,Sum(Inventory_Qty_Size09) Inventory_Qty_Size09 ,Sum(Inventory_Qty_Size10) Inventory_Qty_Size10  ,Sum(Inventory_Qty_Size11) Inventory_Qty_Size11

From Inventory_Detail as ID
	Inner Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1 ,4 ,17) 
	Inner Join Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = @CO_ID
	Inner Join Party AS P On P.Party_ID = I.Party_ID And P.CO_ID = @CO_ID
Where ID.CO_ID = @CO_ID And (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
	  And (Inventory_Date Between @From_Date And @To_Date)
	  And (Item_Code >= @From_Item OR @From_Item = '')
	 And  (Item_Code <=@To_Item Or @To_Item = '')
	  And (Party_Code >= @From_Party OR @From_Party = '')
	  And (Party_Code <=@To_Party OR @To_Party = '')
Group By ID.CO_ID  ,Item_Code 
ORder By II.Item_Code










