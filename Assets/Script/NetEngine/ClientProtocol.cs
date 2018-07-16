using System;
using System.Runtime.InteropServices;

/////////////////////////////////////////////////////////////////////////////////////
/// <summary>
/// 网络内核
/// </summary>
[StructLayout(LayoutKind.Sequential)]
struct CMD_Info
{
    public byte     cbVersion;						// 版本标识
    public byte     cbCheckCode;					// 效验字段
    public ushort   wPacketSize;					// 数据大小
};

/// <summary>
/// 网络命令
/// </summary>
[StructLayout(LayoutKind.Sequential)]
struct CMD_Command
{
    public ushort wMainCmdID;						// 主命令码
    public ushort wSubCmdID;						// 子命令码
};

/// <summary>
/// 网络包头
/// </summary>
[StructLayout(LayoutKind.Sequential)]
struct CMD_Head
{
    public CMD_Info     CmdInfo;					// 基础结构
    public CMD_Command  CommandInfo;				// 命令信息
};

/// <summary>
/// 第一次密钥
/// </summary>
[StructLayout(LayoutKind.Sequential)]
struct XOR_KEY
{
    public uint Key;
};

/// <summary>
/// 空数据
/// </summary>
struct CMD_NULL
{
}

//////////////////////////////////////////////////////////////////////////
/// <summary>
/// 主命令
/// </summary>
enum EnRoomMainCmdID : ushort
{
    MDM_KN_COMMAND              = 0,                // 内核命令

    MDM_GR_LOGON                = 100,                // 房间登录
    MDM_GR_USER                 = 2,                // 用户信息
    MDM_GR_INFO                 = 3,                // 配置信息
    MDM_GR_STATUS               = 4,                // 房间状态
    MDM_GR_MANAGER              = 5,                // 管理命令
    MDM_GR_SYSTEM               = 10,               // 系统消息
    MDM_GR_SERVER_INFO          = 11,               // 房间信息

//    MDM_GF_GAME                 = 100,              // 游戏消息
    MDM_GF_FRAME                = 101,              // 框架消息
    MDM_GF_PRESENT		        = 102,			    // 礼物消息
    MDM_GF_BANK			        = 103,			    // 银行消息
}

/////////////////////////////////////////////////////////////////////////////////////
/// <summary>
/// 内核命令
/// </summary>
enum EnKNSubCmdID : ushort
{
    SUB_KN_DETECT_SOCKET        = 1,                // 检测命令
    SUB_KN_SHUT_DOWN_SOCKET     = 2,                // 关闭网络
}

/////////////////////////////////////////////////////////////////////////////////////
/// <summary>
/// 框架消息命令
/// </summary>
enum EnGameFrameCmd : ushort
{
    SUB_GF_INFO                 = 1,                // 游戏信息
    SUB_GF_USER_READY           = 2,                // 用户同意
    SUB_GF_LOOKON_CONTROL       = 3,                // 旁观控制
    SUB_GF_KICK_TABLE_USER      = 4,                // 踢走用户
    SUB_GF_READY                = 5,                // 自动开始

    SUB_GF_OPTION               = 100,              // 游戏配置
    SUB_GF_SCENE                = 101,              // 场景信息
    SUB_GF_USER_CHAT            = 200,              // 用户聊天
    SUB_GF_MESSAGE              = 300,              // 系统消息
}

/////////////////////////////////////////////////////////////////////////////////////
/// <summary>
/// 登录命令
/// </summary>
enum EnRoomLogonSubCmdID : ushort
{
    SUB_GR_LOGON_ACCOUNTS       = 1,                // 账号登录
    SUB_GR_LOGON_USERID         = 2,                // ID登录

    SUB_GR_LOGON_SUCCESS        = 100,              // 登录成功
    SUB_GR_LOGON_ERROR          = 101,              // 登录失败
    SUB_GR_LOGON_FINISH         = 102,              // 登录完成
}

/// <summary>
/// 登录失败
/// </summary>
struct CMD_GR_LogonError
{
    public int      lErrorCode;				        // 错误代码
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
    public string   szErrorDescribe;		        // 错误消息
};
//////////////////////////////////////////////////////////////////////////

[StructLayoutAttribute(LayoutKind.Sequential, CharSet = CharSet.Unicode, Pack = 1)]
//帐号登录
struct DBR_MB_LogonOtherPlatform
{
	public ushort wModuleID;

	public uint wPlazaVersion;

	public byte wDeviceType;

	public byte wGender;

	public byte wPlatformID;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 33)]
	public string wUserUin;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
	public string wNickName;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
	public string wCompellation;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 33)]
	public string wMachineID;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 12)]
	public string wMobilePhone;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 65)]
	public string wDeviceToken;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 500)]
	public string wFaceUrl;

};


[StructLayoutAttribute(LayoutKind.Sequential, CharSet = CharSet.Unicode, Pack = 1)]
public struct CMD_MB_LogonSuccess
{
//	{t = "word", k = "wFaceID"},								-- 头像标识
	public ushort wFaceID;

//	{t = "byte", k = "cbGender"},								-- 用户性别
	public byte cbGender;

//	{t = "dword", k = "dwCustomID"},							-- 自定头像
	public uint dwCustomID;

//	{t = "dword", k = "dwUserID"},								-- 用户 I D
	public uint dwUserID;

//	{t = "dword", k = "dwGameID"},								-- 游戏 I D
	public uint dwGameID;

//	--{t = "dword", k = "dwExperience"},							-- 经验数值
//	--{t = "score", k = "dwLoveLiness"},							-- 用户魅力
//	{t = "string", k = "szAccount", s = yl.LEN_ACCOUNTS},		-- 用户帐号
	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
	public string szAccount;

//	{t = "string", k = "szNickName", s = yl.LEN_NICKNAME},		-- 用户昵称
	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
	public string szNickName;

//	{t = "string", k = "szDynamicPass", s = yl.LEN_PASSWORD},	-- 动态密码
	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 33)]
	public string szDynamicPass;
//
//	-- 财富信息
//	{t = "score", k = "lUserScore"},							-- 用户游戏币
	public UInt64 lUserScore;

//	--{t = "score", k = "lUserIngot"},							-- 用户元宝
//	{t = "score", k = "lUserInsure"},							-- 用户银行
	public UInt64 lUserInsure;

//	--{t = "double", k = "dUserBeans"},							-- 用户游戏豆
//	{t = "score", k = "lDiamond"},								-- 用户钻石
	public UInt64 lDiamond;

//
//	-- 扩展信息
//	{t = "byte", k = "cbInsureEnabled"},						-- 使能标识
	public byte cbInsureEnabled;

//	{t = "byte", k = "cbIsAgent"},								-- 代理标识
	public byte cbIsAgent;

//	{t = "byte", k = "cbMoorMachine"},							-- 锁定机器
	public byte cbMoorMachine;
//
//	-- 约战信息
//	--{t = "score", k = "lRoomCard"},								-- 用户房卡
//	{t = "dword", k = "dwLockServerID"}, 						-- 锁定房间
	public uint dwLockServerID;

//	{t = "dword", k = "dwLockKindID"},							-- 锁定游戏
	public uint dwLockKindID;
};
public struct SYSTEMTIME {
	public ushort wYear;
	public ushort wMonth;
	public ushort wDayOfWeek;
	public ushort wDay;
	public ushort wHour;
	public ushort wMinute;
	public ushort wSecond;
	public ushort wMilliseconds;
} ;
