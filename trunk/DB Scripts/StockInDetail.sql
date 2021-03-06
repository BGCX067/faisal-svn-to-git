USE [Quick_ERP]
GO
/****** Object:  StoredProcedure [dbo].[SpStockInDetail]    Script Date: 10/20/2010 09:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 29-Sep-10
-- Description:	This procedure returns the Stock In Item and Date wise Summary.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------

CREATE Procedure [dbo].[SpStockInDetail]
@CO_ID as Smallint,
@From_Date AS Datetime,
@To_Date As DateTime,
@From_Item as Varchar(50),
@To_Item as Varchar(50),
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
Set @To_Date = '2011-09-30'
Set @From_Item = ''
Set @To_Item = ''
Set @From_Party = ''
Set @To_Party = ''
--*/
Select  Inventory_Date ,ID.Co_ID  
		,(Convert(Varchar,Item_Code) + ' In ' + Convert(Varchar,Inventory_Date,105))  ItemCode
		,Inventory_Qty_Size01  ,Inventory_Qty_Size02  ,Inventory_Qty_Size03 ,Inventory_Qty_Size04 
	    ,Inventory_Qty_Size05  ,Inventory_Qty_Size06  ,Inventory_Qty_Size07 ,Inventory_Qty_Size08
		,Inventory_Qty_Size09  ,Inventory_Qty_Size10   ,Inventory_Qty_Size11 
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
ORder By Inventory_Date



















