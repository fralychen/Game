
----------------------------------------------------------------------------------------------------

USE RYGameMatchDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MatchSignupStart]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MatchSignupStart]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MatchStart]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MatchStart]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MatchEliminate]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MatchEliminate]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MatchRecordGrades]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MatchRecordGrades]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MatchOver]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MatchOver]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_MatchCancel]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_MatchCancel]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------------------------------
-- ������ʼ
CREATE PROC GSP_GR_MatchSignupStart
	@wServerID		INT,		-- �����ʶ		
	@dwMatchID		INT,		-- ������ʶ
	@lMatchNo		BIGINT,		-- ��������
	@cbMatchType	TINYINT,	-- ��������
	@cbSignupMode	TINYINT		-- ������ʽ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN 

	-- ��ʱ���� 
	IF @cbMatchType=0
	BEGIN
		-- �������	
		IF (@cbSignupMode&0x02)<>0
		BEGIN
			-- ��������
			DECLARE @FromMatchID INT
			DECLARE @FilterType TINYINT
			DECLARE @MaxRankID SMALLINT
			DECLARE @MatchEndDate DATETIME
			DECLARE @MatchStartDate DATETIME
			
			-- ��ѯ����
			SELECT  @FromMatchID=FromMatchID, @FilterType=FilterType, @MaxRankID=MaxRankID, @MatchEndDate=MatchEndDate, @MatchStartDate=MatchStartDate FROM MatchPublic 
			WHERE MatchID=@dwMatchID
			
			-- �жϱ���
			IF @FromMatchID IS NULL RETURN 1
			
			-- ��ѯ����
			DECLARE @FromMatchType TINYINT
			SELECT @FromMatchType=MatchType FROM MatchPublic WHERE MatchID=@FromMatchID
			
			-- ��ʱ����
			IF @FromMatchType=0
			BEGIN			
				-- ��������
				IF @FilterType=1
				BEGIN
					-- ���������Ϣ
					INSERT INTO MatchPromoteInfo(UserID,MatchID,PromoteMatchID,ServerID,RankID,Score,RewardGold,RewardIngot,RewardExperience)  				
					SELECT UserID,@FromMatchID,@dwMatchID,ServerID,RankID,MatchScore,RewardGold,RewardIngot,RewardExperience FROM StreamMatchHistory
					WHERE MatchID=@FromMatchID AND RankID<=@MaxRankID				
				END				
			END 
			
			-- ��ʱ����
			IF @FromMatchType=1
			BEGIN
				-- ����������
				IF @FilterType=0
				BEGIN				
					-- ���������Ϣ
					INSERT INTO MatchPromoteInfo(UserID,MatchID,PromoteMatchID,ServerID,RankID,Score,RewardGold,RewardIngot,RewardExperience)  				
					SELECT UserID,@FromMatchID,@dwMatchID,ServerID,RankID,MatchScore,RewardGold,RewardIngot,RewardExperience FROM StreamMatchHistory
					WHERE (ID IN (SELECT MAX(ID) FROM StreamMatchHistory 
					WHERE MatchID=@FromMatchID AND RankID<=@MaxRankID AND (MatchEndTime BETWEEN @MatchStartDate AND @MatchEndDate) GROUP BY UserID))
				END											
			END
			
			-- ɾ��������Ϣ
			DELETE MatchReviveInfo WHERE MatchID=@dwMatchID
			
			-- ɾ�������ɼ�
			DELETE MatchResults WHERE MatchID=@dwMatchID AND ServerID=@wServerID 
					
			-- ɾ��������
			DELETE MatchScoreInfo WHERE MatchID=@dwMatchID AND MatchNo=@lMatchNo
			
		END
	END

	RETURN 0
END

RETURN 0
	
GO

----------------------------------------------------------------------------------------------------
-- ������ʼ
CREATE PROC GSP_GR_MatchStart
	@wServerID		INT,		-- �����ʶ		
	@dwMatchID		INT,		-- ������ʶ
	@lMatchNo		BIGINT,		-- ��������
	@cbMatchType	TINYINT		-- ��������
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN 

	-- ��ʱ���� 
	IF @cbMatchType=0
	BEGIN
		-- �������
		UPDATE 	MatchScoreInfo SET WinCount=0,LostCount=0,DrawCount=0,FleeCount=0 
		WHERE ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo
		
		-- �޸�״̬
		UPDATE MatchPublic SET MatchStatus=0x02 WHERE MatchID=@dwMatchID
	END

	RETURN 0
END

RETURN 0
	
GO

----------------------------------------------------------------------------------------------------

-- ������̭
CREATE PROC GSP_GR_MatchEliminate
	@dwUserID		INT,		-- �û���ʶ
	@wServerID		INT,		-- �����ʶ	
	@dwMatchID		INT,		-- ������ʶ
	@lMatchNo		BIGINT,		-- ��������
	@cbMatchType	TINYINT		-- ��������			
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	-- ɾ������
	DELETE MatchScoreInfo WHERE UserID=@dwUserID AND ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo	
	
END

RETURN 0
GO

----------------------------------------------------------------------------------------------------

-- ��¼�ɼ�
CREATE PROC GSP_GR_MatchRecordGrades
	@dwUserID		INT,		-- �û���ʶ
	@wServerID		INT,		-- �����ʶ	
	@dwMatchID		INT,		-- ������ʶ
	@lMatchNo		BIGINT,		-- ��������			
	@lInitScore		INT			-- ��ʼ�ɼ�
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	
	-- ��ѯ����
	DECLARE @RankingMode TINYINT
	DECLARE @CountInnings SMALLINT	
	SELECT @RankingMode=RankingMode,@CountInnings=CountInnings FROM MatchPublic WHERE MatchID=@dwMatchID	
	
	-- ��������
	IF @RankingMode IS NULL SET @RankingMode=0
	
	-- ����ģʽ
	IF @RankingMode=1
	BEGIN
		-- ����ɼ�
		INSERT INTO MatchResults(UserID,MatchID,MatchNo,ServerID,Score,WinCount,LostCount,DrawCount,FleeCount)
		SELECT @dwUserID,@dwMatchID,@lMatchNo,@wServerID,Score,WinCount,LostCount,DrawCount,FleeCount FROM MatchScoreInfo
		WHERE UserID=@dwUserID AND ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo 
		
		-- ���·���
		UPDATE MatchScoreInfo SET Score=@lInitScore,WinCount=0,LostCount=0,DrawCount=0,FleeCount=0
		WHERE UserID=@dwUserID AND ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo			
	END
		
END

RETURN 0
GO

----------------------------------------------------------------------------------------------------
-- ��������
CREATE PROC GSP_GR_MatchOver
	@wServerID		INT,		-- �����ʶ	
	@dwMatchID		INT,		-- ������ʶ
	@lMatchNo		BIGINT,		-- ��������
	@cbMatchType	TINYINT,	-- ��������
	@cbPlayCount	TINYINT,	-- ��Ϸ����
	@bMatchFinish   INT,		-- ��ɱ�ʶ
	@MatchStartTime DATETIME,	-- ����ʱ��
	@MatchEndTime	DATETIME	-- ����ʱ��		
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	
	-- ��ʱ����
	IF @cbMatchType = 0
	BEGIN
		-- ��������			
		SELECT 	MatchRank,RewardGold,RewardIngot,RewardExperience INTO #TempMatchReward FROM MatchReward(NOLOCK) 
		WHERE MatchID=@dwMatchID

		DECLARE @RankCount SMALLINT
		SET @RankCount=@@Rowcount
		
		-- ��������
		DECLARE @RankingMode TINYINT
		DECLARE @CountInnings SMALLINT
		DECLARE @FilterGradesMode TINYINT
		SELECT @RankingMode=RankingMode,@CountInnings=CountInnings,@FilterGradesMode=FilterGradesMode FROM MatchPublic WHERE MatchID=@dwMatchID
		
		-- �޸�״̬
		UPDATE MatchPublic SET MatchStatus=0x08 WHERE MatchID=@dwMatchID		

		-- ��������
		IF @RankCount > 0
		BEGIN		
			-- ��ʼ����
			SET TRANSACTION ISOLATION LEVEL REPEATABLE READ	
			BEGIN TRAN

			-- ɾ��������
			--DELETE MatchScoreInfo WHERE MatchID=@dwMatchID			
			--IF @@Rowcount > 0					
			BEGIN
						
				-- �ܳɼ�����
				IF @RankingMode=0
				BEGIN
					-- ��ѯ�������	
					SELECT MatchRank=ROW_NUMBER() OVER (ORDER BY Score DESC,WinCount DESC,SignupTime ASC ),* INTO #RankUserList FROM MatchScoreInfo(NOLOCK) 	
					WHERE MatchID=@dwMatchID AND MatchNo=@lMatchNo AND (WinCount+LostCount+FleeCount)>=@cbPlayCount
					ORDER BY Score DESC,WinCount DESC,SignupTime ASC
					
					-- �ϲ���¼
					SELECT a.*,ISNULL(b.RewardGold,0) AS RewardGold, ISNULL(b.RewardIngot,0) AS RewardIngot, ISNULL(b.RewardExperience,0) AS RewardExperience INTO #RankMatchReward
					FROM #RankUserList a LEFT JOIN #TempMatchReward b ON a.MatchRank=b.MatchRank 

					-- �����¼
					INSERT INTO StreamMatchHistory(UserID,MatchID,MatchNo,MatchType,ServerID,RankID,MatchScore,UserRight,RewardGold,RewardIngot,RewardExperience,
					WinCount,LostCount,DrawCount,FleeCount,MatchStartTime,MatchEndTime,PlayTimeCount,OnlineTime,Machine,ClientIP)
					SELECT a.UserID,@dwMatchID,@lMatchNo,0,a.ServerID,a.MatchRank,a.Score,b.UserRight,a.RewardGold,a.RewardIngot,a.RewardExperience,
					a.WinCount,a.LostCount,a.DrawCount,a.FleeCount,@MatchStartTime,@MatchEndTime,
					a.PlayTimeCount,a.OnlineTime,b.LastLogonMachine,b.LastLogonIP 
					FROM #RankMatchReward a,GameScoreInfo b WHERE a.UserID=b.UserID	
					
					-- �׳�������			
					SELECT MatchRank AS RankID,UserID,@dwMatchID AS MatchID,ServerID,Score,RewardGold,RewardIngot,RewardExperience 
					FROM #RankMatchReward WHERE MatchRank<=@RankCount
					
					IF OBJECT_ID('tempdb..#RankUserList') IS NOT NULL DROP TABLE #RankUserList
					IF OBJECT_ID('tempdb..#MatchFeeRecord') IS NOT NULL DROP TABLE #MatchFeeRecord			
					IF OBJECT_ID('tempdb..#RankMatchReward') IS NOT NULL DROP TABLE #RankMatchReward					
				END
				
				-- �ض�����
				IF @RankingMode=1
				BEGIN
			
					-- ɸѡ�û�
					SELECT UserID,
						  (
						   CASE @FilterGradesMode 
						   WHEN 0 THEN MAX(Score) 
						   WHEN 1 THEN AVG(Score) 
						   WHEN 2 THEN 
						     	  case WHEN COUNT(*)>2 THEN ((SUM(Score)-MAX(Score)-MIN(Score))/(COUNT(*)-2)) 
								  ELSE 0 END
						   ELSE MAX(Score) END
						   ) AS Score
					INTO #MatchUserResults FROM MatchResults WHERE MatchID=@dwMatchID AND MatchNo=@lMatchNo GROUP BY UserID 					

					-- ��ѯ�������	
					SELECT MatchRank=ROW_NUMBER() OVER (ORDER BY a.Score DESC,b.SignupTime ASC),a.*,b.ServerID,b.PlayTimeCount,b.OnlineTime INTO #RankUserList1 
					FROM #MatchUserResults a,MatchScoreInfo b  WHERE a.UserID=b.UserID AND b.MatchID=@dwMatchID AND b.MatchNo=@lMatchNo ORDER BY a.Score DESC,b.SignupTime ASC
					
					-- �ϲ���¼
					SELECT a.*,ISNULL(b.RewardGold,0) AS RewardGold, ISNULL(b.RewardIngot,0) AS RewardIngot, ISNULL(b.RewardExperience,0) AS RewardExperience INTO #RankMatchReward1
					FROM #RankUserList1 a LEFT JOIN #TempMatchReward b ON a.MatchRank=b.MatchRank 					
					
					-- �����¼
					INSERT INTO StreamMatchHistory(UserID,MatchID,MatchNo,MatchType,ServerID,RankID,MatchScore,UserRight,RewardGold,RewardIngot,RewardExperience,
					WinCount,LostCount,DrawCount,FleeCount,MatchStartTime,MatchEndTime,PlayTimeCount,OnlineTime,Machine,ClientIP)
					SELECT a.UserID,@dwMatchID,@lMatchNo,0,@wServerID,a.MatchRank,a.Score,b.UserRight,a.RewardGold,a.RewardIngot,a.RewardExperience,
					0,0,0,0,@MatchStartTime,@MatchEndTime,a.PlayTimeCount,a.OnlineTime,b.LastLogonMachine,b.LastLogonIP 
					FROM #RankMatchReward1 a,GameScoreInfo b WHERE a.UserID=b.UserID
					
					-- �׳�������			
					SELECT MatchRank AS RankID,UserID,@dwMatchID AS MatchID,ServerID,MatchRank,Score,RewardGold,RewardIngot,RewardExperience
					FROM #RankMatchReward1 WHERE MatchRank<=@RankCount	
					
					-- ɾ����ʱ��
					IF OBJECT_ID('tempdb..#RankUserList1') IS NOT NULL DROP TABLE #RankUserList1					
					IF OBJECT_ID('tempdb..#MatchFeeRecord1') IS NOT NULL DROP TABLE #MatchFeeRecord1			
					IF OBJECT_ID('tempdb..#RankMatchReward1') IS NOT NULL DROP TABLE #RankMatchReward1						
					IF OBJECT_ID('tempdb..#MatchUserResults') IS NOT NULL DROP TABLE #MatchUserResults					
				END						 	
			END 						

			-- ��������
			COMMIT TRAN
			SET TRANSACTION ISOLATION LEVEL READ COMMITTED	

			-- ������ʱ��			
			IF OBJECT_ID('tempdb..#TempMatchReward') IS NOT NULL DROP TABLE #TempMatchReward																		
		END
		
		-- ɾ��������
		DELETE MatchScoreInfo WHERE MatchID=@dwMatchID AND MatchNo=@lMatchNo	
		
		-- ���ñ���
		IF @bMatchFinish=1
		BEGIN
			UPDATE MatchPublic SET Nullity=1 WHERE MatchID=@dwMatchID																																																																																															
		END
	END

	-- ��ʱ����
	IF @cbMatchType = 1
	BEGIN
		-- ��ʼ����
		SET TRANSACTION ISOLATION LEVEL REPEATABLE READ	
		BEGIN TRAN	

		-- ��������			
		SELECT MatchRank,RewardGold,RewardIngot,RewardExperience INTO #TempMatchReward1 FROM MatchReward(NOLOCK) 
		WHERE MatchID=@dwMatchID

		-- ��ѯ�����	
		SELECT MatchRank=ROW_NUMBER() OVER (ORDER BY Score DESC,WinCount DESC,SignupTime ASC),* INTO #RankUserList2 FROM MatchScoreInfo(NOLOCK) 	
		WHERE ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo AND (WinCount+LostCount+FleeCount+DrawCount)>=@cbPlayCount 
		ORDER BY Score DESC,WinCount DESC,SignupTime ASC

		-- ɾ��������
		DELETE MatchScoreInfo WHERE ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo

		-- �ϲ���¼
		SELECT a.*,ISNULL(b.RewardGold,0) AS RewardGold, ISNULL(b.RewardIngot,0) AS RewardIngot, ISNULL(b.RewardExperience ,0) AS RewardExperience  INTO #RankMatchReward2
		FROM #RankUserList2 a LEFT JOIN #TempMatchReward1 b ON a.MatchRank=b.MatchRank	

		-- �����¼
		INSERT INTO StreamMatchHistory(UserID,MatchID,MatchNo,MatchType,ServerID,RankID,MatchScore,UserRight,RewardGold,RewardIngot,RewardExperience, 
		WinCount,LostCount,DrawCount,FleeCount,MatchStartTime,MatchEndTime,PlayTimeCount,OnlineTime,Machine,ClientIP)
		SELECT a.UserID,@dwMatchID,@lMatchNo,1,@wServerID,a.MatchRank,a.Score,b.UserRight,a.RewardGold,a.RewardIngot,a.RewardExperience,
		a.WinCount,a.LostCount,a.DrawCount,a.FleeCount,@MatchStartTime,@MatchEndTime,
		a.PlayTimeCount,a.OnlineTime,b.LastLogonMachine,b.LastLogonIP 
		FROM #RankMatchReward2 a,GameScoreInfo b WHERE a.UserID=b.UserID

		-- �׳�������
		SELECT MatchRank AS RankID,UserID,Score,RewardGold,RewardIngot,RewardExperience FROM #RankMatchReward2		

		-- ��������
		COMMIT TRAN
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED		

		-- ������ʱ��
		IF OBJECT_ID('tempdb..#RankUserList2') IS NOT NULL DROP TABLE #RankUserList2 
		IF OBJECT_ID('tempdb..#TempMatchReward2') IS NOT NULL DROP TABLE #TempMatchReward2 
		IF OBJECT_ID('tempdb..#RankMatchReward2') IS NOT NULL DROP TABLE #RankMatchReward2	
	END
END

RETURN 0
GO


----------------------------------------------------------------------------------------------------
-- ����ȡ��
CREATE PROC GSP_GR_MatchCancel
	@wServerID		INT,		-- �����ʶ		
	@dwMatchID		INT,		-- ������ʶ
	@lMatchNo		BIGINT,		-- ��������
	@lSafeCardFee	INT,		-- ���շ���	
	@bMatchFinish   INT			-- ��ɱ�ʶ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN 

	-- ��������
	DECLARE @FeeType SMALLINT
	DECLARE @MatchType TINYINT		
	SELECT @FeeType=FeeType,@MatchType=MatchType FROM MatchPublic WHERE MatchID=@dwMatchID
		
	-- ��ʱ���� 
	IF @MatchType=0
	BEGIN				
		-- ��ѯ����
		SELECT UserID,MatchFee INTO #MatchUserFeeInfo FROM StreamMatchFeeInfo WHERE ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo
		
		-- ɾ��������
		DELETE MatchScoreInfo WHERE ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo 	
		IF @@ROWCOUNT>0
		BEGIN
			-- �������
			IF @FeeType=0
			BEGIN
				-- �۳����
				UPDATE RYTreasureDB..GameScoreInfo SET Score=Score+(SELECT MatchFee FROM #MatchUserFeeInfo b WHERE RYTreasureDB..GameScoreInfo.UserID=b.UserID)
				WHERE UserID IN (SELECT UserID FROM #MatchUserFeeInfo)
			END
			
			-- ��������
			IF @FeeType=1
			BEGIN				
				-- ���½���
				UPDATE RYAccountsDB..AccountsInfo SET UserMedal=UserMedal+(SELECT MatchFee FROM #MatchUserFeeInfo b WHERE RYAccountsDB..AccountsInfo.UserID=b.UserID)
				WHERE UserID IN (SELECT UserID FROM #MatchUserFeeInfo)
			END
			
			-- �˻����տ�����			
			UPDATE RYTreasureDB..GameScoreInfo SET Score=Score+@lSafeCardFee WHERE UserID IN (SELECT UserID FROM MatchReviveInfo WHERE MatchID=@dwMatchID AND HoldSafeCard=1)
			
			-- ɾ��������Ϣ
			DELETE MatchReviveInfo WHERE MatchID=@dwMatchID
			
			-- ɾ����Ϣ
			DELETE StreamMatchFeeInfo WHERE ServerID=@wServerID AND MatchID=@dwMatchID AND MatchNo=@lMatchNo												
		END
		
		-- ɾ������
		DELETE MatchPromoteInfo WHERE PromoteMatchID=@dwMatchID
		
		-- ���ñ���
		IF @bMatchFinish=1
		BEGIN
			UPDATE MatchPublic SET Nullity=1 WHERE MatchID=@dwMatchID
		END
	END

	RETURN 0
END

RETURN 0
	
GO

----------------------------------------------------------------------------------------------------