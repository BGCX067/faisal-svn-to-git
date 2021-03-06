IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='SpStockInSummary')
	DROP PROCEDURE SpStockInSummary
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
CREATE Procedure SpStockInSummary
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
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='SpStockInDetail')
	DROP PROCEDURE SpStockInDetail
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

CREATE Procedure SpStockInDetail
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
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='SpStockOutSummary')
	DROP PROCEDURE SpStockOutSummary
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
CREATE Procedure SpStockOutSummary
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
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='SpStockOutDetail')
	DROP PROCEDURE SpStockOutDetail
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
CREATE Procedure SpStockOutDetail
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
Set @To_Date = '2010-10-16'
Set @From_Item = ''
Set @To_Item = ''
Set @From_Party = ''
Set @To_Party = ''
--*/
Select  Inventory_Date ,ID.Co_ID 
		,(Convert(Varchar,Item_Code) + ' Out ' + Convert(Varchar,Inventory_Date,105))  ItemCode
		,Inventory_Qty_Size01 ,Inventory_Qty_Size02 ,Inventory_Qty_Size03 ,Inventory_Qty_Size04
		,Inventory_Qty_Size05 ,Inventory_Qty_Size06 ,Inventory_Qty_Size07 ,Inventory_Qty_Size08 
		,Inventory_Qty_Size09 ,Inventory_Qty_Size10 ,Inventory_Qty_Size11 
From Inventory_Detail as ID
	Inner Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1,4) 
	Inner Join Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = @CO_ID
	Inner Join Party AS P On P.Party_ID = I.Party_ID And P.CO_ID = @CO_ID
Where ID.CO_ID = @CO_ID And (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
	  And (Inventory_Date Between @From_Date And @To_Date)
	  And (Item_Code >= @From_Item OR @From_Item = '')
	  And  (Item_Code <=@To_Item Or @To_Item = '')
	  And (Party_Code >= @From_Party OR @From_Party = '')
	  And (Party_Code <=@To_Party OR @To_Party = '')
Order By Inventory_Date
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='SpStockInOutSummary')
	DROP PROCEDURE SpStockInOutSummary
GO
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 15-Oct-10
-- Description:	This procedure returns the Stock In And Out Summary Detail Item wise
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------

CREATE PROCEDURE SpStockInOutSummary
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
Set @FromDate = '1900-09-16'
Set @ToDate = '2010-12-30'
Set @FromItem = ''
Set @ToItem = ''
Set @FromParty = ''
Set @ToParty = ''
--*/

Select  ID.Co_ID ,Item_Code  
		,CASE ID.DocumentType_ID WHEN 1 
			THEN 
				'Out' 
			ELSE 
				CASE ID.DocumentType_ID WHEN 4 
					THEN 
						'Out' 
					ELSE
						CASE ID.DocumentType_ID WHEN 3
							THEN
								'In' 
							ELSE
								CASE ID.DocumentType_ID WHEN 18
									THEN
										'In'
									ELSE
										'Return'
								END
						END
				END 
						
			END AS MYTYPE
--*/
		,Sum(Inventory_Qty_Size01) Inventory_Qty_Size01 ,Sum(Inventory_Qty_Size02) Inventory_Qty_Size02 ,Sum(Inventory_Qty_Size03) Inventory_Qty_Size03
		,Sum(Inventory_Qty_Size04) Inventory_Qty_Size04 ,Sum(Inventory_Qty_Size05) Inventory_Qty_Size05 ,Sum(Inventory_Qty_Size06) Inventory_Qty_Size06
		,Sum(Inventory_Qty_Size07) Inventory_Qty_Size07 ,Sum(Inventory_Qty_Size08) Inventory_Qty_Size08
		,Sum(Inventory_Qty_Size09) Inventory_Qty_Size09 ,Sum(Inventory_Qty_Size10) Inventory_Qty_Size10  ,Sum(Inventory_Qty_Size11) Inventory_Qty_Size11

From Inventory_Detail as ID
	Inner Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1,2,3,4,18) 
	Inner Join Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = @CO_ID
	Inner Join Party AS P On P.Party_ID = I.Party_ID And P.CO_ID = @CO_ID

Where ID.CO_ID = @CO_ID And (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
	  And (Inventory_Date Between @From_Date And @To_Date)
	  And (Item_Code >= @From_Item OR @From_Item = '')
	 And  (Item_Code <=@To_Item Or @To_Item = '')
	  And (Party_Code >= @From_Party OR @From_Party = '')
	  And (Party_Code <=@To_Party OR @To_Party = '')


Group By ID.CO_ID ,Item_Code 
	,CASE ID.DocumentType_ID WHEN 1 
			THEN 
				'Out' 
			ELSE 
				CASE ID.DocumentType_ID WHEN 4
					THEN 
						'Out' 
					ELSE
						CASE ID.DocumentType_ID WHEN 3
							THEN
								'In' 
							ELSE
								CASE ID.DocumentType_ID WHEN 18
									THEN
										'In'
									ELSE
										'Return'
								END
						END
				END 
			END  


Order By Item_Code , MYTYPE
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='SpSourceWiseItemStock')
	DROP PROCEDURE SpSourceWiseItemStock
go
-- ======================================================================
-- Author:		Muhammad Zakee
-- Create date: 29-Sep-10
-- Description:	This procedure returns the Source Wise Item Stock
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------
CREATE Procedure SpSourceWiseItemStock
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
Set @To_Date = '2010-11-16'
Set @From_Item = ''
Set @To_Item = ''
Set @From_Party = ''
Set @To_Party = ''
--*/
 Select  Party_Desc	,Item_Code , Item_Desc ,(Item_Code +  ' '  + Item_Desc) Item
		,Sum(Inventory_Qty_Size01) Inventory_Qty_Size01 ,Sum(Inventory_Qty_Size02) Inventory_Qty_Size02 ,Sum(Inventory_Qty_Size03) Inventory_Qty_Size03 ,Sum(Inventory_Qty_Size04) Inventory_Qty_Size04
		,Sum(Inventory_Qty_Size05) Inventory_Qty_Size05 ,Sum(Inventory_Qty_Size06) Inventory_Qty_Size06 ,Sum(Inventory_Qty_Size07) Inventory_Qty_Size07 ,Sum(Inventory_Qty_Size08) Inventory_Qty_Size08
		,Sum(Inventory_Qty_Size09) Inventory_Qty_Size09 ,Sum(Inventory_Qty_Size10) Inventory_Qty_Size10 ,Sum(Inventory_Qty_Size11) Inventory_Qty_Size11
From Inventory_Detail as ID
	Inner Join Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID =18 --And i.Co_ID = 200
	Inner Join Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = @CO_ID
	Inner Join Party AS P On P.Party_ID = I.Party_ID And P.CO_ID = @CO_ID And EntityType_ID = 6
Where I.CO_ID = @CO_ID And (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
	  And (Inventory_Date Between @From_Date And @To_Date)
	  And (Item_Code >= @From_Item OR @From_Item = '')
	  And  (Item_Code <=@To_Item Or @To_Item = '')
	  And (Party_Code >= @From_Party OR @From_Party = '')
	  And (Party_Code <=@To_Party OR @To_Party = '')
Group by Party_Desc ,Item_Code ,Item_Desc
Order By Party_Desc ,Item_Code
