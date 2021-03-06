IF EXISTS (SELECT * FROM sysObjects o WHERE o.[name] = 'spGetInsertAndUpdateCommandQuery')
	DROP PROC spGetInsertAndUpdateCommandQuery
go
CREATE PROCEDURE dbo.spGetInsertAndUpdateCommandQuery
	(
	@TableName VARCHAR(200)
	)
AS
BEGIN
	DECLARE @PkColumnsForWhere VARCHAR(1000)
	DECLARE @PkColumns VARCHAR(1000)
	DECLARE @PkColumnsParameters VARCHAR(1000)
	DECLARE @Columns VARCHAR(2000)
	DECLARE @ValueColumns VARCHAR(MAX)
	DECLARE @UpdateSetPart VARCHAR(MAX)
	DECLARE @Query AS VARCHAR(8000)

	SET NOCOUNT ON

	SET @PkColumnsForWhere = ''
	SET @PkColumns = ''
	SET @PkColumnsParameters = ''
	SET @Columns = ''
	SET @ValueColumns = ''
	SET @UpdateSetPart = ''

	Select @Columns = @Columns + ', ' + c.[name]
		, @ValueColumns = @ValueColumns + ', @' + c.[name]
		, @UpdateSetPart = @UpdateSetPart + CASE ISNULL(pk.PkColumn,'') WHEN c.[name] THEN '' ELSE ', ' + c.[name] + '=@' + c.[name] END
		, @PkColumnsForWhere = @PkColumnsForWhere + CASE ISNULL(pk.PkColumn,'') WHEN c.[name] THEN ' AND ' + c.[name] + '=@' + c.[name] ELSE '' END
		, @PkColumns = @PkColumns + CASE ISNULL(pk.PkColumn,'') WHEN c.[name] THEN ', ' + c.[name] ELSE '' END
		, @PkColumnsParameters = @PkColumnsParameters + CASE ISNULL(pk.PkColumn,'') WHEN c.[name] THEN ', @' + c.[name] ELSE '' END

	FROM sysobjects o LEFT JOIN syscolumns c ON o.ID = c.ID LEFT JOIN systypes t ON c.[xtype] = t.[xtype]
				LEFT JOIN (select c.COLUMN_NAME AS PkColumn
							from 	INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
							where 	pk.TABLE_NAME = @TableName and	CONSTRAINT_TYPE = 'PRIMARY KEY'
									and	c.TABLE_NAME = pk.TABLE_NAME and c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME) pk ON pk.PkColumn = c.[name]
	WHERE o.[name] = @TableName
	
	SET @Columns = SUBSTRING(@Columns, 3, LEN(@Columns)-1) + ' '
	SET @ValueColumns = SUBSTRING(@ValueColumns, 3, LEN(@ValueColumns)-1) + ' '
	SET @PkColumnsForWhere = SUBSTRING(@PkColumnsForWhere, 5, LEN(@PkColumnsForWhere))
	SET @UpdateSetPart = SUBSTRING(@UpdateSetPart, 3, LEN(@UpdateSetPart))

	SELECT ('IF NOT EXISTS(SELECT * FROM ' + @TableName + ' WHERE ' + @PkColumnsForWhere + ') ' 
--		+ CHAR(10) + CHAR(13)
		+ ' INSERT INTO ' + @TableName + '(' + @Columns + ') VALUES (' + @ValueColumns + ')'
--		+ CHAR(10) + CHAR(13)
		+ ' ELSE UPDATE ' + @TableName + ' SET ' + @UpdateSetPart + ' WHERE ' + @PkColumnsForWhere)
--		+ CHAR(10) + CHAR(13)
--		+ ' INSERT INTO BaseLocationRecordsToDownload (Location_ID, TableName, IsDownloaded, UploadedAtDateTime, UploadedByUserID, UploadedByLocationID' + @PkColumns + ') VALUES(@Location_ID, @TableName, @IsDownloaded, GetUtcDate(), @UploadedByUserID, @UploadedByLocationID' + @PkColumnsParameters + ')'
END