use RYAccountsDB

-- 系统设置
TRUNCATE TABLE [dbo].[SystemStatusInfo]

insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'AgentBalance'	,	100	,	N'代理结算最小值'	,	N'代理结算'	,	N'键值：表示代理结算最小值'	,	900	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'AgentGrantScoreCount'	,	100000	,	N'代理推广玩家注册系统送游戏币的数目！'	,	N'代理赠送'	,	N'键值：表示赠送的游戏币数量'	,	901	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'AgentRoomCardExchRate'	,	1	,	N'代理商房卡兑换游戏币比例'	,	N'代理房卡兑换'	,	N'键值：1房卡兑换游戏币的值'	,	902	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'AuthentDisable'	,	1	,	N'用户验证开启关闭'	,	N'实名服务'	,	N'键值：0-开启，1-关闭'	,	20	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'AuthentPresent'	,	88888	,	N'用户验证赠送的数目'	,	N'实名赠送'	,	N'键值：表示用户验证后赠送的游戏币数量'	,	21	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'BankPrerequisite'	,	20	,	N'存取条件，存取游戏币必须大于此数才可操作！'	,	N'存取条件'	,	N'键值：表示存取金币数必须大于此数才可存取'	,	106	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'EducateGrantScore'	,	1000000	,	N'练习房间赠送练习币数目'	,	N'练习赠送'	,	N'键值：练习房间赠送练习币数目'	,	30	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'EnjoinInsure'	,	0	,	N'由于系统维护，暂时停止游戏系统的保险柜服务，请留意网站公告信息！'	,	N'银行服务'	,	N'键值：0-开启，1-关闭'	,	98	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'EnjoinLogon'	,	0	,	N'由于系统维护，暂时停止游戏系统的登录服务，请留意网站公告信息！'	,	N'登录服务'	,	N'键值：0-开启，1-关闭'	,	10	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'EnjoinRegister'	,	0	,	N'由于系统维护，暂时停止游戏系统的注册服务，请留意网站公告信息！'	,	N'注册服务'	,	N'键值：0-开启，1-关闭'	,	1	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'GrantAgentRoomCardCount'	,	10	,	N'代理注册赠送房卡'	,	N'代理注册赠房卡'	,	N'键值：代理注册赠送房卡'	,	701	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'GrantIPCount'	,	10	,	N'新用户注册每天赠送限制！'	,	N'注册赠送限制'	,	N'键值：表示同一个IP最多赠送的次数，超过此数将不赠送金币'	,	2	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'GrantRoomCardCount'	,	5	,	N'注册赠送房卡'	,	N'注册赠送房卡'	,	N'键值：注册赠送房卡'	,	3	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'GrantScoreCount'	,	8000000	,	N'新用户注册系统送游戏币的数目！'	,	N'注册赠送'	,	N'键值：表示赠送的游戏币数量'	,	4	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'IOSNotStorePaySwitch'	,	1	,	N'是否在IOS上开启非AppStore充值'	,	N'IOS充值开关'	,	N'键值：0 开启 1 关闭'	,	600	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'IsOpenRoomCard'	,	0	,	N'是否允许开启房卡功能'	,	N'开启房卡'	,	N'键值：0-开启，1-关闭'	,	700	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'LimitRegisterIPCount'	,	0	,	N'在24小时内，注册次数按照IP限制'	,	N'注册IP限制'	,	N'键值：0-无限制，其他值代表次数'	,	5	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'LimitRegisterMachineCount'	,	0	,	N'在24小时内，注册次数按照机器码限制'	,	N'注册机器限制'	,	N'键值：0-无限制，其他值代表次数'	,	6	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'MedalExchangeRate'	,	1000	,	N'元宝与游戏币兑换率'	,	N'元宝兑换率'	,	N'键值：1个元宝兑换多少游戏币'	,	152	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'MedalRate'	,	10	,	N'元宝系统返还比率（千分比），元宝根据玩家每局游戏税收返还给玩家！'	,	N'元宝返率'	,	N'键值：表示元宝系统返还比率值（千分比）！'	,	110	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'OpenMobileWebsite'	,	1	,	N'是否开启手机网站'	,	N'开启手机网站'	,	N'键值：0-开启，1-关闭（关闭后默认打开官网）'	,	500	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'PayConfig'	,	1	,	N'苹果手机开启第三方充值服务'	,	N'充值服务'	,	N'键值：0-开启，1-关闭'	,	130	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'PresentExchangeRate'	,	1500	,	N'魅力与游戏币兑换率'	,	N'魅力兑换率'	,	N'键值: 1点魅力兑换多少游戏币'	,	150	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'RateGold'	,	100	,	N'游戏豆与游戏币的汇率 游戏豆:游戏币'	,	N'游戏币汇率'	,	N'键值：游戏豆与游戏币的汇率'	,	151	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'RevenueRateTake'	,	10	,	N'取款操作税收比率（千分比）！'	,	N'取款税率'	,	N'键值：表示银行取款操作税收比率值（千分比）！'	,	108	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'RevenueRateTransfer'	,	10	,	N'转账操作税收比率（千分比）！'	,	N'转账税率'	,	N'键值：表示普通玩家银行转账操作税收比率值（千分比）！'	,	109	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'SharePresent'	,	1000	,	N'分享赠送'	,	N'分享赠送'	,	N'键值：分享赠送游戏币数目'	,	640	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'SignInLimitMachine'	,	0	,	N'签到每天限制机器码数量'	,	N'签到机器限制'	,	N'键值：0-无限制，其他值代表次数'	,	70	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'SubsistenceCondition'	,	5000	,	N'低保每次领取游戏币最低额'	,	N'低保领取条件'	,	N'键值：领取低保玩家金币不能低于该金币数'	,	80	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'SubsistenceGold'	,	1000	,	N'低保每次领取游戏币数量'	,	N'低保每次金额'	,	N'键值：每次低保的金币数'	,	81	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'SubsistenceLimitMachine'	,	0	,	N'低保每天限制机器码数量'	,	N'低保机器限制'	,	N'键值：0-无限制，其他值代表次数'	,	82	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'SubsistenceNumber'	,	5	,	N'低保每天领取次数'	,	N'低保每日次数'	,	N'键值：每天领取低保的最多次数'	,	83	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'TaskTakeCount'	,	5	,	N'每天可领取任务的最大数目'	,	N'领取任务数目'	,	N'键值：每天可领取任务的最大数目'	,	90	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'TransferMaxTax'	,	1000	,	N'转账封顶税收！'	,	N'转账税收封顶'	,	N'键值：银行转账封顶税收，0-不封顶'	,	100	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'TransferPower'	,	1	,	N'是否开启所有玩家转账权限'	,	N'转账所有权限'	,	N'键值：0-开启，1-关闭'	,	101	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'TransferPrerequisite'	,	10000	,	N'转账条件，转账游戏币数必须大于此数才可转账！'	,	N'转账条件'	,	N'键值：表示转账金币数必须大于此数才可转账'	,	102	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'TransferRebate'	,	1	,	N'是否允许转账返利'	,	N'转账返利'	,	N'键值：0-开启，1-关闭'	,	103	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'TransferRetention'	,	0	,	N'至少保留'	,	N'转账保留'	,	N'键值：表示转账金币数最低保留多少'	,	104	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'TransferStauts'	,	0	,	N'转账功能被关闭，请留意网站公告'	,	N'转账服务'	,	N'键值：转账是否开启，键值：0-开启，1-关闭'	,	99	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'WinExperience'	,	10	,	N'赢局奖励的经验值'	,	N'赢局经验'	,	N'键值：赢局奖励的经验值'	,	600	)
insert SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values(	N'WxLogon'	,	0	,	N'控制是否开启和关闭微信登录'	,	N'微信登录'	,	N'键值：0-开启，1-关闭'	,	660	)