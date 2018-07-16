using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace  LuaFramework 
{
    /// <summary>
    /// 牌的花色；
    /// </summary>
    public class CardColorConst
    {
        /** 1 代表筒，2 代表条， 3 代表 万  4代表风 5代表赖子*/
	    public  const int MAHJONG_TONG    = 1;
	    public  const int MAHJONG_TIAO    = 2;
	    public  const int MAHJONG_WAN     = 3;
	    public  const int MAHJONG_FENG    = 4;
	    public  const int MAHJONG_LZ      = 5;

        /** 依次代表 东西南北中发白*/
	    public  const int FENG_TYPE_DONG  = 10;
	    public  const int FENG_TYPE_XI    = 11;
	    public  const int FENG_TYPE_NAN   = 12;
	    public  const int FENG_TYPE_BEI   = 13;
	    public  const int FENG_TYPE_ZHONG = 14;
	    public  const int FENG_TYPE_FA    = 15;
        public  const int FENG_TYPE_BAI   = 16;

        /** 赖子的值*/
	    public  const int FENG_TYPE_LZ    = 17;

    }
}
