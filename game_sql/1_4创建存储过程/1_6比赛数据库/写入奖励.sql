USE RYGameMatchDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MatchReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MatchReward]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- ��������
CREATE PROC GSP_GR_MatchReward
	@dwUserID INT,								-- �û� I D	
	@lRewardGold BIGINT,						-- ��ҽ���
	@lRewardIngot BIGINT,						-- Ԫ������
	@dwRewardExperience BIGINT,					-- ���ƽ���
	@wKindID INT,								-- ��Ϸ I D
	@wServerID INT,								-- ���� I D
	@strClientIP NVARCHAR(15)					-- ���ӵ�ַ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	
	-- �������
	IF @lRewardGold>0 OR @lRewardIngot>0 OR @dwRewardExperience>0
	BEGIN
		-- ��ѯ���
		DECLARE @CurrScore BIGINT
		DECLARE @CurrInsure BIGINT
		DECLARE @CurrMedal INT
		SELECT @CurrScore=Score,@CurrInsure=InsureScore FROM RYTreasureDB..GameScoreInfo WHERE UserID=@dwUserID
		SELECT @CurrMedal=UserMedal FROM RYAccountsDB..AccountsInfo WHERE UserID=@dwUserID
	
		-- �����ж�
		IF @CurrScore IS NULL OR @CurrInsure IS NULL 
		BEGIN
			-- ��������
			SELECT @CurrScore=0,@CurrInsure=0
			
			-- �����¼
			INSERT RYTreasureDB..GameScoreInfo (UserID,Score,LastLogonIP,RegisterIP) 
			VALUES(@dwUserID,@lRewardGold,@strClientIP,@strClientIP)
		END
		

		-- ����ʱ��
		DECLARE @DateID INT
		SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
		
		-- ��������
		DECLARE @TypeID INT
		SET @TypeID=18
		
		-- ���½��
		UPDATE RYTreasureDB..GameScoreInfo SET Score=Score+@lRewardGold WHERE UserID=@dwUserID
		
		-- ���½���
		UPDATE RYAccountsDB..AccountsInfo SET UserMedal=UserMedal+@lRewardIngot, Experience=Experience+@dwRewardExperience WHERE UserID=@dwUserID
		
		IF @lRewardIngot > 0
		BEGIN
			-- Ԫ����¼
			INSERT INTO RYAccountsDBLink.RYAccountsDB.dbo.RecordMedalChange(UserID,SrcMedal,TradeMedal,TypeID,ClientIP,CollectDate)	
			VALUES (@dwUserID,@CurrMedal,@lRewardIngot,1,@strClientIP,GETDATE())
		END
		
		-- ��ˮ��
		INSERT INTO RYTreasureDBLink.RYTreasureDB.dbo.RecordPresentInfo(UserID,PreScore,PreInsureScore,PresentScore,TypeID,IPAddress,CollectDate)
		VALUES (@dwUserID,@CurrScore,@CurrInsure,@lRewardGold,10,@strClientIP,GETDATE())
		
		-- ��ͳ��
		UPDATE RYTreasureDBLink.RYTreasureDB.dbo.StreamPresentInfo SET DateID=@DateID, PresentCount=PresentCount+1,PresentScore=PresentScore+@lRewardGold WHERE UserID=@dwUserID AND TypeID=10
		IF @@ROWCOUNT=0
		BEGIN
			INSERT RYTreasureDBLink.RYTreasureDB.dbo.StreamPresentInfo(DateID,UserID,TypeID,PresentCount,PresentScore) VALUES(@DateID,@dwUserID,10,1,@lRewardGold)
		END	
		
	END
	
	-- ��ѯ���
	DECLARE @CurrGold BIGINT	
	SELECT @CurrGold=Score FROM RYTreasureDB..GameScoreInfo WHERE UserID=@dwUserID

	-- ��������
	IF @CurrGold IS NULL SET @CurrGold=0		

	-- �׳�����
	SELECT @CurrGold AS Score
END

RETURN 0
GO