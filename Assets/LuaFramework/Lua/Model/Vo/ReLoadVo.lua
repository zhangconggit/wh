
ReLoadType = {

	NetOut 		= false;		--网络异常重连
	heartOut 	= false;		--心跳异常重连
	TimeOut 	= false;		--客户端超时重连

	NetState    = 0;			--0:网络不可用，1：网络可用
	NetType		= 0;			--0:无线网，1:3G网
	NetStrength = 0;			--网络信号强度

	ReLoadNum	= 0;			--重连次数

	ReloadInfo = {
		roomNum 	 = 0;
		zimohu 		 = true;
		feng 		 = true;
		hongzhong    = true;
		yu		  	 = 0;
		jushu 		 = 0;
		alreadyJuShu = 0;
		curIndex 	 = 0;
		zhuang 		 = 0;
		zhuaIndex 	 = 0;
		shaiziMin 	 = 0;
		shaiziMax 	 = 0;
		beforeChess  = 0;
		lastChess 	 = 0;
		roles 		 = 
		{
			{
				roleIndex 		= 0;
				roleId 			= 0;
				name			= '';
				ip              = 0;
				headImg			= 'http';
				jifen			= 0;
				chessCount		= 0;
				roleChess		= {};		--自己牌的列表（其他玩家这里存放的是已经被用过的牌）
				outChess		= {};		--打出来的牌
			}
		};
	}	
}


ReLoadType.__index = ReLoadType

function ReLoadType:New() 
    local self = {};    
    setmetatable(self, ReLoadType); 
    return self;  
end