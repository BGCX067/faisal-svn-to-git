USE [Quick_ERP]
GO
/****** Object:  StoredProcedure [dbo].[SpStockInSummary]    Script Date: 11/03/2010 11:03:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SpStockInSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SpStockInSummary]