IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='Sec_FormControlPermission')
	CREATE TABLE dbo.Sec_FormControlPermission(
		Co_ID SMALLINT NOT NULL,
		RoleID INT NOT NULL,
		FormID SMALLINT NOT NULL,
		ControlID SMALLINT NOT NULL,
		IsVisible BIT NOT NULL,
		IsEnabled BIT NOT NULL,
		[Stamp_UserID] INT NOT NULL,
		[Stamp_DateTime] DATETIME NOT NULL,
		[Uploaded] BIT NULL,
		[RecordStatus_ID] INT NOT NULL,
	 CONSTRAINT [PK_SecFormControlPermission] PRIMARY KEY CLUSTERED
	(
		Co_ID ASC,
		RoleID ASC,
		FormID ASC,
		ControlID ASC
	))
go
IF NOT EXISTS (SELECT o.[NAME] FROM sysobjects o WHERE o.[Name] ='FK_SecFormControlPermission_BaseSettingFormControls')
	ALTER TABLE Sec_FormControlPermission
		WITH CHECK ADD  CONSTRAINT FK_SecFormControlPermission_BaseSettingFormControls
		FOREIGN KEY(FormID, ControlID)
		REFERENCES Base_SettingFormControls (Form_ID, Control_ID)
go
IF NOT EXISTS (SELECT * FROM Base_SettingForm WHERE Form_ID = 27)
	INSERT INTO [Base_SettingForm]
		([Form_ID], [Form_Code], [Form_Name], [RecordStatus_ID]
		,[Stamp_UserID], [Stamp_DateTime], [Upload_DateTime])
	VALUES
		(27, '06-004', 'FormControlPermissionForm', 1
		,0, '2011/03/02', NULL)
go
IF NOT EXISTS (SELECT * FROM Base_Menu WHERE Menu_ID = 604)
	INSERT INTO [Base_Menu]
		([Menu_Id], [Menu_Desc], [Form_Code], [Display_Order], [Parent_Menu_Id]
		,[Stamp_UserId], [Stamp_DateTime], [Upload_DateTime], [RecordStatus_ID], [Form_ID])
	VALUES
		(604, 'Control Permissions', '06-004', 4, 600
		, 0, '2011/03/02', NULL, 1, 26)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=1)
	INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime)
	VALUES (2,1,'PartyControl1',1,0,'2011-03-06 17:53:49.843',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=2)
	INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) 
	VALUES (2,2,'PartyAddressTextBox',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=3) 
	INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) 
	VALUES (2,3,'SalesTaxTextBox',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=4) 
	INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) 
	VALUES (2,4,'DiscountTextBox',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=5) 
	INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) 
	VALUES (2,5,'LogisticServiceTextBox',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=6) 
	INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) 
	VALUES (2,6,'PartyCategoryComboBox',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=7) 
	INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (2,7,'CompanyComboBox1',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (2,8,'SourceDocumentNoTextBox',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (2,9,'RemarksTextBox',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (2,10,'uccSaleDate',1,0,'2011-03-06 17:53:49.860',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (2,11,'txtSaleNo',1,0,'2011-03-06 17:53:49.877',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=2 AND Control_ID=12) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (2,12,'grdInventory',1,0,'2011-03-06 17:53:49.877',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=1) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,1,'CashRecievedTextBox',1,0,'2011-03-06 17:48:46.767',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,2,'SalesTaxTextBox',1,0,'2011-03-06 17:48:46.767',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,3,'DiscountTextBox',1,0,'2011-03-06 17:48:46.767',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,4,'AutoPrintWithSaveCheckBox',1,0,'2011-03-06 17:48:46.780',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,5,'SalesManComboBox',1,0,'2011-03-06 17:48:46.780',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,6,'txtRemarks',1,0,'2011-03-06 17:48:46.780',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,7,'SaleDate',1,0,'2011-03-06 17:48:46.780',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=3 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (3,8,'SaleNoTextBox',1,0,'2011-03-06 17:48:46.780',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=1) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,1,'DiscountTextBox',1,0,'2011-03-06 18:06:31.360',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,2,'SalesTaxTextBox',1,0,'2011-03-06 18:06:31.360',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,3,'PartyCategoryComboBox',1,0,'2011-03-06 18:06:31.360',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,4,'CompanyComboBox1',1,0,'2011-03-06 18:06:31.360',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,5,'SourceDocumentNoTextBox',1,0,'2011-03-06 18:06:31.360',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,6,'PartyComboBox1',1,0,'2011-03-06 18:06:31.377',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,7,'txtRemarks',1,0,'2011-03-06 18:06:31.377',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,8,'uccSaleDate',1,0,'2011-03-06 18:06:31.377',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,9,'txtSaleNo',1,0,'2011-03-06 18:06:31.377',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=4 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (4,10,'grdInventory',1,0,'2011-03-06 18:06:31.377',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=1) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,1,'DiscountTextBox',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,2,'SalesTaxTextBox',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,3,'PartyCategoryComboBox',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,4,'CompanyComboBox1',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,5,'SourceDocumentNoTextBox',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,6,'PartyComboBox1',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,7,'txtRemarks',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,8,'uccSaleDate',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,9,'txtSaleNo',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=5 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (5,10,'grdInventory',1,0,'2011-03-06 18:08:00.673',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=1) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,1,'DiscountTextBox',1,0,'2011-03-06 18:11:32.923',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,2,'SalesTaxTextBox',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,3,'PartyCategoryComboBox',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,4,'CompanyComboBox1',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,5,'SourceDocumentNoTextBox',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,6,'PartyComboBox1',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,7,'txtRemarks',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,8,'uccSaleDate',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,9,'txtSaleNo',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=6 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (6,10,'grdInventory',1,0,'2011-03-06 18:11:32.937',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,4,'grdInventory',1,0,'2011-03-06 19:14:11.687',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,8,'IncreaseAmountButton',1,0,'2011-03-06 19:14:11.687',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,9,'ShowSalesButton',1,0,'2011-03-06 19:14:11.687',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,10,'DateToCalendarCombo',1,0,'2011-03-06 19:14:11.703',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,11,'DateFromCalendarCombo',1,0,'2011-03-06 19:14:11.703',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=12) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,12,'ShowExistingStockLevelButton',1,0,'2011-03-06 19:14:11.703',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=13) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,13,'IncreaseAmountTextBox',1,0,'2011-03-06 19:14:11.703',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=14) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,14,'ItemToComboBox',1,0,'2011-03-06 19:14:11.703',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=7 AND Control_ID=15) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (7,15,'ItemFromComboBox',1,0,'2011-03-06 19:14:11.703',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,6,'PartyControl1',1,0,'2011-03-06 19:14:12.280',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,8,'PartyAddressTextBox',1,0,'2011-03-06 19:14:12.297',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,9,'SalesTaxTextBox',1,0,'2011-03-06 19:14:12.297',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,10,'DiscountTextBox',1,0,'2011-03-06 19:14:12.297',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,11,'LogisticServiceTextBox',1,0,'2011-03-06 19:14:12.297',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=12) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,12,'PartyCategoryComboBox',1,0,'2011-03-06 19:14:12.313',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=13) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,13,'CompanyComboBox1',1,0,'2011-03-06 19:14:12.313',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=14) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,14,'SourceDocumentNoTextBox',1,0,'2011-03-06 19:14:12.313',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=15) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,15,'RemarksTextBox',1,0,'2011-03-06 19:14:12.313',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=16) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,16,'uccSaleDate',1,0,'2011-03-06 19:14:12.313',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=17) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,17,'txtSaleNo',1,0,'2011-03-06 19:14:12.313',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=8 AND Control_ID=18) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (8,18,'grdInventory',1,0,'2011-03-06 19:14:12.327',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=9 AND Control_ID=1) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (9,1,'PurchaseWarehouseForm',1,0,'2011-03-06 19:14:12.530',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=9 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (9,6,'PartyComboBox',1,0,'2011-03-06 19:14:12.530',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=9 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (9,7,'RemarksTextBox',1,0,'2011-03-06 19:14:12.530',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=9 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (9,8,'uccSaleDate',1,0,'2011-03-06 19:14:12.530',NULL)
go
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=9 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (9,9,'PurchaseNoTextBox',1,0,'2011-03-06 19:14:12.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=9 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (9,10,'PurchaseDetailSpread',1,0,'2011-03-06 19:14:12.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=1) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,1,'StockInquiryForm',1,0,'2011-03-06 19:14:12.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,2,'RecalculateStockButton',1,0,'2011-03-06 19:14:12.983',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,3,'ItemComboBox',1,0,'2011-03-06 19:14:12.983',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,4,'ExportToExcelButton',1,0,'2011-03-06 19:14:12.983',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,5,'CompanyCheckedListBox1',1,0,'2011-03-06 19:14:12.983',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,10,'StockTabPage',1,0,'2011-03-06 19:14:13.000',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,11,'ShowTotalRowsCheckBox',1,0,'2011-03-06 19:14:13.000',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=12) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,12,'StockQuickSpread',1,0,'2011-03-06 19:14:13.000',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=15) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,15,'MinimumLevelDeviationTabPage',1,0,'2011-03-06 19:14:13.000',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=16) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,16,'ReverseSignCheckBox',1,0,'2011-03-06 19:14:13.000',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=17) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,17,'MinimumStockLevelFilterOptionQuickUltraComboBox',1,0,'2011-03-06 19:14:13.000',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=18) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,18,'MinimumStockLevelQuickSpread',1,0,'2011-03-06 19:14:13.000',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=21) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,21,'SalesStockInquiryTabPage',1,0,'2011-03-06 19:14:13.017',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=22) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,22,'TotalRowsCheckBox',1,0,'2011-03-06 19:14:13.017',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=23) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,23,'GetSalesQuickSpread',1,0,'2011-03-06 19:14:13.017',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=26) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,26,'ShowSalesButton',1,0,'2011-03-06 19:14:13.017',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=27) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,27,'IncreaseQuantityButton',1,0,'2011-03-06 19:14:13.017',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=28) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,28,'IncreaseQuantityTextBox',1,0,'2011-03-06 19:14:13.017',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=29) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,29,'DateToCalendarCombo',1,0,'2011-03-06 19:14:13.017',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=30) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,30,'DateFromCalendarCombo',1,0,'2011-03-06 19:14:13.047',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=10 AND Control_ID=31) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (10,31,'ShowButton',1,0,'2011-03-06 19:14:13.047',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,3,'InactiveFromCalendarCombo',1,0,'2011-03-06 19:14:13.250',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,4,'InactiveToCalendarCombo',1,0,'2011-03-06 19:14:13.267',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,6,'CityTextBox',1,0,'2011-03-06 19:14:13.267',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,7,'UrlTextBox',1,0,'2011-03-06 19:14:13.267',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,8,'StateTextBox',1,0,'2011-03-06 19:14:13.267',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,9,'FaxTextBox',1,0,'2011-03-06 19:14:13.267',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,10,'CountryTextBox',1,0,'2011-03-06 19:14:13.267',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,11,'PhoneTextBox',1,0,'2011-03-06 19:14:13.267',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=12) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,12,'EmailTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=13) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,13,'ZipCodeTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=14) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,14,'AddressTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=17) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,17,'EntityTypeComboBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=18) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,18,'CommissionTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=19) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,19,'PartyCodeTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=20) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,20,'CoaComboBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=21) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,21,'PartyNameTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=22) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,22,'OpeningDebitTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=11 AND Control_ID=23) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (11,23,'OpeningCreditTextBox',1,0,'2011-03-06 19:14:13.280',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=12 AND Control_ID=1) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (12,1,'BulkTransferForm',1,0,'2011-03-06 19:14:13.377',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=12 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (12,3,'AddressComboBox',1,0,'2011-03-06 19:14:13.377',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=12 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (12,4,'PartyComboBox',1,0,'2011-03-06 19:14:13.377',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=12 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (12,5,'DateRangeToCalendarCombo',1,0,'2011-03-06 19:14:13.390',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=12 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (12,6,'DateRangeFromCalendarCombo',1,0,'2011-03-06 19:14:13.390',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=12 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (12,7,'TargetComboBox',1,0,'2011-03-06 19:14:13.390',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,2,'RolesComboBox1',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,3,'IsAdminCheckBox',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,4,'CompanyComboBox',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,5,'InactiveToCalendarCombo',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,6,'InactiveFromCalendarCombo',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,7,'PasswordTextBox',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,8,'UserDescTextBox',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=14 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (14,9,'UserNameTextBox',1,0,'2011-03-06 19:14:13.500',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,2,'WindowsSecurityCheckBox',1,0,'2011-03-06 19:14:13.517',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,3,'ConnectionTypeOptionSet',1,0,'2011-03-06 19:14:13.517',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,4,'PrimaryFilePathButton',1,0,'2011-03-06 19:14:13.517',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,5,'DatabaseNameComboBox',1,0,'2011-03-06 19:14:13.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,6,'SQLServerNameComboBox',1,0,'2011-03-06 19:14:13.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,7,'OkButton',1,0,'2011-03-06 19:14:13.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,8,'CancelButton1',1,0,'2011-03-06 19:14:13.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,9,'PasswordTextBox',1,0,'2011-03-06 19:14:13.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,10,'PrimaryFilePathTextBox',1,0,'2011-03-06 19:14:13.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=15 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (15,11,'UserNameTextBox',1,0,'2011-03-06 19:14:13.530',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=16 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (16,3,'LastTransferDateCheckBox',1,0,'2011-03-06 19:14:13.593',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=16 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (16,4,'ImportFromXML',1,0,'2011-03-06 19:14:13.593',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=16 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (16,5,'StartTransferXmlButton',1,0,'2011-03-06 19:14:13.593',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=16 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (16,6,'ShutdownCheckBox',1,0,'2011-03-06 19:14:13.593',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=16 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (16,7,'StartDateCalendarCombo',1,0,'2011-03-06 19:14:13.593',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=16 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (16,8,'DownloadCheckBox',1,0,'2011-03-06 19:14:13.593',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=16 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (16,9,'TransferStatusTextBox1',1,0,'2011-03-06 19:14:13.593',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=17 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (17,2,'CompanyComboBox1',1,0,'2011-03-06 19:14:13.657',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=17 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (17,3,'EmptyDatabaseButton',1,0,'2011-03-06 19:14:13.657',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=18 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (18,2,'AmountTextBox',1,0,'2011-03-06 19:14:13.827',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=18 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (18,3,'RemarksTextBox',1,0,'2011-03-06 19:14:13.827',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=18 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (18,4,'PartyComboBox',1,0,'2011-03-06 19:14:13.827',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=18 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (18,5,'VoucherDateCalendar',1,0,'2011-03-06 19:14:13.827',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=18 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (18,6,'VoucherNoTextBox',1,0,'2011-03-06 19:14:13.827',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=19 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (19,2,'AmountTextBox',1,0,'2011-03-06 19:14:13.877',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=19 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (19,3,'RemarksTextBox',1,0,'2011-03-06 19:14:13.877',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=19 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (19,4,'PartyComboBox',1,0,'2011-03-06 19:14:13.877',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=19 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (19,5,'VoucherDateCalendar',1,0,'2011-03-06 19:14:13.877',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=19 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (19,6,'VoucherNoTextBox',1,0,'2011-03-06 19:14:13.877',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,2,'OpeningCreditNumericEditor',1,0,'2011-03-06 19:14:13.953',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,3,'OpeningDebitNumericEditor',1,0,'2011-03-06 19:14:13.953',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,4,'COACodeTextBox',1,0,'2011-03-06 19:14:13.953',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,5,'CashFlowAccountComboBox',1,0,'2011-03-06 19:14:13.953',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,6,'FinancialAccountComboBox',1,0,'2011-03-06 19:14:13.953',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,7,'ParentCOAIDComboBox',1,0,'2011-03-06 19:14:13.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,9,'CompanyComboBox',1,0,'2011-03-06 19:14:13.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,10,'InactiveToCalendarCombo',1,0,'2011-03-06 19:14:13.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,11,'InactiveFromCalendarCombo',1,0,'2011-03-06 19:14:13.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=12) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,12,'COAIDTextBox',1,0,'2011-03-06 19:14:13.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=20 AND Control_ID=13) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (20,13,'COADescTextBox',1,0,'2011-03-06 19:14:13.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=21 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (21,2,'CompanyComboBox',1,0,'2011-03-06 19:14:14.030',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=21 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (21,3,'InactiveToCalendarCombo',1,0,'2011-03-06 19:14:14.030',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=21 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (21,4,'InactiveFromCalendarCombo',1,0,'2011-03-06 19:14:14.030',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=21 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (21,5,'VoucherTypeIDTextBox',1,0,'2011-03-06 19:14:14.030',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=21 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (21,6,'VoucherTypeDescTextBox',1,0,'2011-03-06 19:14:14.030',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=21 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (21,7,'VoucherTypeCodeTextBox',1,0,'2011-03-06 19:14:14.030',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=22 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (22,2,'PostButton',1,0,'2011-03-06 19:14:14.110',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=22 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (22,3,'VoucherDetailQuickSpread',1,0,'2011-03-06 19:14:14.110',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=22 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (22,6,'VoucherDateCalendarCombo',1,0,'2011-03-06 19:14:14.127',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=22 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (22,7,'VoucherTypeComboBox',1,0,'2011-03-06 19:14:14.127',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=22 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (22,8,'RemarksTextBox',1,0,'2011-03-06 19:14:14.127',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=22 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (22,9,'VoucherNoTextBox',1,0,'2011-03-06 19:14:14.127',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=22 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (22,10,'VoucherIDTextBox',1,0,'2011-03-06 19:14:14.127',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,2,'ItemToMultiComboBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,3,'ItemFromMultiComboBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,4,'Quick_UltraTree1',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,5,'CompanyComboBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,6,'WarehouseComboBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,7,'PartyToComboBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=8) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,8,'PartyFromComboBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=9) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,9,'AllPartiesCheckBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=10) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,10,'WithoutDateCheckBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=11) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,11,'DateToCalendarCombo',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=12) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,12,'AllItemsCheckBox',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=23 AND Control_ID=13) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (23,13,'DateFromCalendarCombo',1,0,'2011-03-06 19:14:14.780',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=24 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (24,2,'RolesComboBox1',1,0,'2011-03-06 19:14:14.843',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=24 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (24,3,'Quick_Spread1',1,0,'2011-03-06 19:14:14.843',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=24 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (24,6,'CompanyComboBox',1,0,'2011-03-06 19:14:14.843',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=26 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (26,2,'InactiveToCalendarCombo',1,0,'2011-03-06 19:14:14.890',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=26 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (26,3,'InactiveFromCalendarCombo',1,0,'2011-03-06 19:14:14.890',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=26 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (26,4,'RoleDescTextBox',1,0,'2011-03-06 19:14:14.923',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=26 AND Control_ID=5) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (26,5,'RoleIDTextBox',1,0,'2011-03-06 19:14:14.923',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=26 AND Control_ID=6) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (26,6,'CompanyComboBox',1,0,'2011-03-06 19:14:14.923',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=27 AND Control_ID=2) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (27,2,'RolesComboBox',1,0,'2011-03-06 19:14:14.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=27 AND Control_ID=3) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (27,3,'CompanyComboBox',1,0,'2011-03-06 19:14:14.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=27 AND Control_ID=4) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (27,4,'FormControlPermissionSpread',1,0,'2011-03-06 19:14:14.970',NULL)
IF NOT EXISTS(SELECT * FROM Base_SettingFormControls WHERE  Form_ID=27 AND Control_ID=7) INSERT INTO Base_SettingFormControls( Form_ID, Control_ID, Control_Name, RecordStatus_ID, Stamp_UserID, Stamp_DateTime, Upload_DateTime ) VALUES (27,7,'FormNameUltraComboBox',1,0,'2011-03-06 19:14:14.983',NULL)