using System;

/// <summary>
/// 玩家信息
/// </summary>
public class ClientUser
{
    //用户属性
    public ushort       wFaceID;							// 头像索引
    public uint         dwUserID;							// 用户 ID
    public uint         dwGameID;							// 游戏 ID
    public uint         dwGroupID;							// 社团索引
    public uint         dwUserRight;						// 用户等级
    public int          lLoveliness;						// 用户魅力
    public uint         dwMasterRight;						// 管理权限

    //用户属性
    public byte         cbGender;							// 用户性别
    public byte         cbMemberOrder;						// 会员等级
    public byte         cbMasterOrder;						// 管理等级

    //用户状态
    public ushort       wTableID;							// 桌子号码
    public ushort       wChairID;							// 椅子位置
    public byte         cbUserStatus;						// 用户状态

    //用户积分
    // public tagUserScore UserScoreInfo;				        // 积分信息

    public string       szAccounts;                         // 用户帐号
}
	