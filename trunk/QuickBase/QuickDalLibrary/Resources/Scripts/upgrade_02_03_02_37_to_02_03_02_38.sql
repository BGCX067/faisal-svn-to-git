IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='spAddCreateContact')
	DROP PROCEDURE spAddCreateContact
GO
-- ======================================================================
-- Author:		Faisal Saleem
-- Create date: 28-Dec-10
-- Description:	This procedure will create/add records in all related
--				tables in order to add contact.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------
CREATE Procedure spAddCreateContact
	@COID as Smallint,
	@UserID AS INT,
	@FirstName AS VARCHAR(50),
	@LastName AS VARCHAR(50),
	@MobileNumber AS VARCHAR(50),
	@EmailAddress AS VARCHAR(50)
AS

	DECLARE @AddressBookID INT
	DECLARE @PersonID INT
	SET @PersonID = 0

	--********** Address Book **********

	IF EXISTS (SELECT * FROM Common_AddressBook WHERE Co_ID = @CoID AND Owner_Person_ID = @UserID)

		SELECT @AddressBookID = AddressBook_ID FROM Common_AddressBook WHERE Co_ID = @CoID AND Owner_Person_ID = @UserID

	ELSE
		BEGIN

		SELECT @AddressBookID = ISNULL( MAX(AddressBook_ID), 0) + 1 FROM Common_AddressBook WHERE Co_ID = @CoID

		INSERT INTO [Common_AddressBook]
           ([Co_ID]
           ,[AddressBook_ID]
           ,[Owner_Person_ID]
           ,[Stamp_UserID]
           ,[Stamp_DateTime]
           ,[Upload_DateTime]
           ,[RecordStatus_ID]
           ,[DocumentStatus_ID])
		VALUES
           (@CoID
           ,@AddressBookID
           ,@UserID
           ,@UserID
           ,GetUtcDate()
           ,NULL
           ,1
           ,0)
		END

	--********** Address Book Detail **********

	SELECT @PersonID = a.Person_ID FROM Common_AddressBook c INNER JOIN Common_AddressBook_Detail a ON c.Co_ID = a.Co_ID AND c.AddressBook_ID = a.AddressBook_ID INNER JOIN Common_Person b ON a.Co_ID = b.Co_ID AND a.Person_ID = b.Person_ID WHERE a.Co_ID = @CoID AND b.Mobile_Number = @MobileNumber AND c.Owner_Person_ID = @UserID
	
	IF @PersonID > 0
		BEGIN

		--SELECT @PersonID = a.Person_ID FROM Common_AddressBook_Detail a INNER JOIN Common_Person b ON a.Co_ID = b.Co_ID AND a.Person_ID = b.Person_ID WHERE a.Co_ID = @CoID AND b.Mobile_Number = @MobileNumber AND a.Owner_Person_ID = @UserID
		UPDATE [Common_Person]
			SET [First_Name] = @FirstName
			,[Second_Name] = @LastName
			,[Email_Address] = @EmailAddress
			,[Stamp_UserID] = @UserID
			,[Stamp_DateTime] = GetUtcDate()
			,[RecordStatus_ID] = 2
		WHERE [Co_ID] = @CoID AND Person_ID = @PersonID

		END
	ELSE
		BEGIN

		SELECT @PersonID = ISNULL( MAX(Person_ID), 0) + 1 FROM Common_Person WHERE Co_ID = @CoID

		INSERT INTO [Common_Person]
			([Co_ID]
			,[Person_ID]
			,[First_Name]
			,[Second_Name]
			,[Nick_Name]
			,[Mobile_Number]
			,[Email_Address]
			,[Country_ID]
			,[City_ID]
			,[Stamp_UserID]
			,[Stamp_DateTime]
			,[Upload_DateTime]
			,[RecordStatus_ID]
			,[DocumentStatus_ID])
		VALUES
           (@CoID
           ,@PersonID
           ,@FirstName
           ,@LastName
           ,NULL
           ,@MobileNumber
           ,@EmailAddress
           ,NULL
           ,NULL
           ,@UserID
           ,GetUtcDate()
           ,NULL
           ,1
           ,0)

		INSERT INTO [Common_AddressBook_Detail]
           ([Co_ID]
           ,[AddressBook_ID]
           ,[Person_ID]
           ,[Stamp_UserID]
           ,[Stamp_DateTime]
           ,[Upload_DateTime]
           ,[RecordStatus_ID]
           ,[DocumentStatus_ID])
		VALUES
           (@CoID
           ,@AddressBookID
           ,@PersonID
           ,@UserID
           ,GetUtcDate()
           ,NULL
           ,1
           ,0)
		END
GO
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='spGetContactsByCoIDUserID')
	DROP PROCEDURE spGetContactsByCoIDUserID
GO
-- ======================================================================
-- Author:		Faisal Saleem
-- Create date: 28-Dec-10
-- Description:	This procedure will all contacts of the user.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------
CREATE Procedure spGetContactsByCoIDUserID
	@COID as Smallint,
	@UserID AS INT
AS
	SELECT c.[Co_ID]
		,c.[Person_ID]
		,c.[First_Name]
		,c.[Second_Name]
		,c.[Nick_Name]
		,c.[Mobile_Number]
		,c.[Email_Address]
		,c.[Country_ID]
		,c.[City_ID]
		,c.[Stamp_UserID]
		,c.[Stamp_DateTime]
		,c.[Upload_DateTime]
		,c.[RecordStatus_ID]
		,c.[DocumentStatus_ID]
	FROM Common_AddressBook a
		INNER JOIN Common_AddressBook_Detail b ON a.Co_ID = b.Co_ID AND a.AddressBook_ID = b.AddressBook_ID
		INNER JOIN [Common_Person] c ON b.Co_ID = c.Co_ID AND b.Person_ID = c.Person_ID
	WHERE c.Co_ID = @CoID AND a.Owner_Person_ID = @UserID
go
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='spDeleteContact')
	DROP PROCEDURE spDeleteContact
GO
-- ======================================================================
-- Author:		Faisal Saleem
-- Create date: 28-Dec-10
-- Description:	This procedure will delete contact having given mobile.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------
CREATE Procedure spDeleteContact
	@COID as Smallint,
	@MobileNumber AS VARCHAR(50),
	@UserID AS INT
AS

	DECLARE @PersonID INT

	--********** Address Book Detail **********
	SET @PersonID = 0

	SELECT @PersonID = b.Person_ID 
	FROM Common_AddressBook c 
		INNER JOIN Common_AddressBook_Detail a ON c.Co_ID = a.Co_ID AND c.AddressBook_ID = a.AddressBook_ID 
		INNER JOIN Common_Person b ON a.Co_ID = b.Co_ID AND a.Person_ID = b.Person_ID 
	WHERE a.Co_ID = @CoID AND b.Mobile_Number = @MobileNumber AND Owner_Person_ID = @UserID
	
	IF @PersonID > 0
		BEGIN

		--SELECT @PersonID = a.Person_ID FROM Common_AddressBook_Detail a INNER JOIN Common_Person b ON a.Co_ID = b.Co_ID AND a.Person_ID = b.Person_ID WHERE a.Co_ID = @CoID AND b.Mobile_Number = @MobileNumber
		
		DELETE FROM Common_Person
			WHERE Co_ID = @CoID AND Person_ID = @PersonID

		DELETE FROM Common_AddressBook_Detail 
			WHERE Co_ID = @CoID AND Person_ID = @PersonID

		END
GO
IF EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='spGetContactByCoIDPersonID')
	DROP PROCEDURE spGetContactByCoIDPersonID
GO
-- ======================================================================
-- Author:		Faisal Saleem
-- Create date: 28-Dec-10
-- Description:	This procedure will one contact based on person id.
-- ======================================================================
-- ------------ Modification History ------------------------------------
-- Author	Date		Details
-- ------   ----        -------
-- ----------------------------------------------------------------------
CREATE Procedure spGetContactByCoIDPersonID
	@COID as Smallint,
	@PersonID AS INT
AS
	SELECT c.[Co_ID]
		,c.[Person_ID]
		,c.[First_Name]
		,c.[Second_Name]
		,c.[Nick_Name]
		,c.[Mobile_Number]
		,c.[Email_Address]
		,c.[Country_ID]
		,c.[City_ID]
		,c.[Stamp_UserID]
		,c.[Stamp_DateTime]
		,c.[Upload_DateTime]
		,c.[RecordStatus_ID]
		,c.[DocumentStatus_ID]
	FROM Common_AddressBook a
		INNER JOIN Common_AddressBook_Detail b ON a.Co_ID = b.Co_ID AND a.AddressBook_ID = b.AddressBook_ID
		INNER JOIN [Common_Person] c ON b.Co_ID = c.Co_ID AND b.Person_ID = c.Person_ID
	WHERE c.Co_ID = @CoID AND c.Person_ID = @PersonID
go
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

SET @Companies = '200'
SET @FromDate = '1900-01-01'
SET @ToDate = '2010-09-30'
SET @ItemCode = '' 
SET @IncreaseFactor = '5%'
SET @AddTotalRows = 1
--*/
Begin 
		IF Right(@IncreaseFactor,1) <> '%'
		BEGIN
			Select  ID.Co_ID ,Co_Code ,0 AS Warehouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc
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
					(Sum(Inventory_Qty_Size12) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size13) + @IncreaseFactor) 
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
					,'Total' AS Item_Desc
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
					(Sum(Inventory_Qty_Size12) + @IncreaseFactor) +
					(Sum(Inventory_Qty_Size13) + @IncreaseFactor) 
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
			GROUP BY Co_Code ,WareHouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc 
			ORDER BY II.Item_Code ,ID.CO_ID	DESC
		END
	Else
		Begin 
				Declare @Percentage Float
				Set @Percentage  = Left(@IncreaseFactor,Len(@IncreaseFactor) -1)
				Select ID.Co_ID ,Co_Code, 0 AS Warehouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc
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
				(Sum(Inventory_Qty_Size01) + @Percentage) +
				(Sum(Inventory_Qty_Size02) + @Percentage) +
				(Sum(Inventory_Qty_Size03) + @Percentage) +
				(Sum(Inventory_Qty_Size04) + @Percentage) +
				(Sum(Inventory_Qty_Size05) + @Percentage) +
				(Sum(Inventory_Qty_Size06) + @Percentage) +
				(Sum(Inventory_Qty_Size07) + @Percentage) +
				(Sum(Inventory_Qty_Size08) + @Percentage) +
				(Sum(Inventory_Qty_Size09) + @Percentage) +
				(Sum(Inventory_Qty_Size10) + @Percentage) +
				(Sum(Inventory_Qty_Size11) + @Percentage) +
				(Sum(Inventory_Qty_Size12) + @Percentage) +
				(Sum(Inventory_Qty_Size13) + @Percentage) 
				) AS Qty_Total
					From Inventory_Detail as ID
					INNER JOIN Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1) 
					INNER JOIN Base_Company c ON ID.Co_ID = c.Co_ID
					INNER JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
					Where (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
						And (Inventory_Date Between @FromDate And @ToDate)
						And (Item_Code = @ItemCode OR @ItemCode = '')
						And (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
				Group By ID.CO_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc ,Co_Code
			UNION ALL

				Select  -1 AS Co_ID ,'' As Co_Code ,0 AS Warehouse_ID ,0 AS Item_ID ,Item_Code 
					,'Total' AS Item_Desc
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
				(Sum(Inventory_Qty_Size01) + @Percentage) +
				(Sum(Inventory_Qty_Size02) + @Percentage) +
				(Sum(Inventory_Qty_Size03) + @Percentage) +
				(Sum(Inventory_Qty_Size04) + @Percentage) +
				(Sum(Inventory_Qty_Size05) + @Percentage) +
				(Sum(Inventory_Qty_Size06) + @Percentage) +
				(Sum(Inventory_Qty_Size07) + @Percentage) +
				(Sum(Inventory_Qty_Size08) + @Percentage) +
				(Sum(Inventory_Qty_Size09) + @Percentage) +
				(Sum(Inventory_Qty_Size10) + @Percentage) +
				(Sum(Inventory_Qty_Size11) + @Percentage) +
				(Sum(Inventory_Qty_Size12) + @Percentage) +
				(Sum(Inventory_Qty_Size13) + @Percentage) 
				) AS Qty_Total
					From Inventory_Detail as ID
					INNER JOIN Inventory as I ON I.Inventory_ID = ID.Inventory_ID And ID.DocumentType_ID IN (1) 
					INNER JOIN Base_Company c ON ID.Co_ID = c.Co_ID
					INNER JOIN Inv_Item as II ON II.Item_ID = ID.Item_ID And II.CO_ID = ID.Co_ID
					Where (II.Co_ID IN (SELECT MyValue FROM dbo.fn_Split(@Companies, ',') AS fn_Split_4) OR @Companies = '')
						And (Inventory_Date Between @FromDate And @ToDate)
						And (Item_Code = @ItemCode OR @ItemCode = '')
						And (ID.RecordStatus_ID <> 4 Or ID.RecordStatus_ID IS Null) 
				GROUP BY Co_Code ,WareHouse_ID ,ID.Item_ID ,Item_Code ,II.Item_Desc 
			ORDER BY II.Item_Code ,ID.CO_ID	DESC

		END
END
go
IF NOT EXISTS (SELECT * FROM Base_Setting WHERE Setting_ID = 'DocumentNoFormat.PosSalesInvoice')
	INSERT INTO [Base_Setting]
		([Co_Id], [User_Id], [Setting_Id], [Setting_Desc]
		,[Setting_Value], [Stamp_User_Id], [Stamp_DateTime]
		,[Setting_Value_DataType], [Setting_Value_MinimumValue], [Setting_Value_MaximumValue]
		,[Upload_DateTime], [RecordStatus_ID])
	VALUES
		(0, 0, 'DocumentNoFormat.PosSalesInvoice'
		, 'Document No Format for pos sales invoice.'
		, 'Y/99999', 0, '2011-01-15'
		, 'String', NULL, NULL
		, NULL, 1)