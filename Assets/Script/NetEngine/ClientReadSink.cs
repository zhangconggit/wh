/// <summary>
/// 读取数据的钩子
/// </summary>
public interface ClientReadSink
{
    bool OnServerDataEvent(ushort nMainCmd, ushort nSubCmd, byte[] byBody);
}