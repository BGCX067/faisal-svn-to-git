USE [Quick_ERP]
GO
/****** Object:  StoredProcedure [dbo].[SpStockInSummary]    Script Date: 10/16/2010 16:41:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 29-Sep-10
-- Description:	This procedure returns the Stock In Summary.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------

CREATE Procedure [dbo].[SpStockInSummary]
@CO_ID as Smallint,
@From_Date AS Datetime,
@To_Date As DateTime,
@From_Item as Varchar(10),
@To_Item as Varchar(10),
@From_Party as Varchar(50),
@To_Party as VArchar(50)
AS

/*
Declare @Co_ID as Smallint
Declare @From_Date as Datetime
Declare @To_Date as Datetime
Declare @From_Item as Varchar(50)
Declare @To_Item as varchar(50)
Declare @From_Party as Varchar(50)
Declare @To_Party as Varchar(50)
Set @CO_ID = 200
Set @From_Date = '1900-09-16'
Set @To_Date = '2010-10-30'
Set @From_Item = ''
Set @To_Item = ''
Set @From_Party = ''
Set @To_Party = ''
--*/

Select ID.Co_ID  ,(Item_Code + ' In') ItemCode
		,Sum(Inventory_Qty_Size01) '100'  ,Sum(Inventory_Qty_Size02) '110'  ,Sum(Inventory_Qty_Size03) '120'
		,Sum(Inventory_Qty_Size04) '130'  ,Sum(Inventory_Qty_Size05) '140'  ,Sum(Inventory_Qty_Size06) '150'
		,Sum(Inventory_Qty_Size07) '160'  ,Sum(Inventory_Qty_Size08) '170'
		,Sum(Inventory_Qty_Size09) '180'  ,Sum(Inventory_Qty_Size10) '190' ,Sum(Inventory_Qty_Size11) 'CM'

From Inventory_Detail as ID
	Inner Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (2,3,18) 
	Inner Join Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = @CO_ID
	Inner Join Party AS P On P.Party_ID = I.Party_ID And P.CO_ID = @CO_ID
Where ID.CO_ID = @CO_ID And (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
	  And (Inventory_Date Between @From_Date And @To_Date)
	  And (Item_Code >= @From_Item OR @From_Item = '')
	  And  (Item_Code <=@To_Item Or @To_Item = '')
	  And (Party_Code >= @From_Party OR @From_Party = '')
	  And (Party_Code <=@To_Party OR @To_Party = '')
Group By ID.CO_ID ,Item_Code ,ID.RecordStatus_ID 
ORder By II.Item_Code