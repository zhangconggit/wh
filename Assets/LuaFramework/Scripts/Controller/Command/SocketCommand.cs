using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaFramework;
using LuaInterface;

public class SocketCommand : ControllerCommand {

    public override void Execute(IMessage message) {

        object data = message.Body;
        if (data == null) return;
        KeyValuePair<int, ByteBuffer> buffer = (KeyValuePair<int, ByteBuffer>)data;

		Util.CallMethod ("Network", "OnSocket", buffer.Key,(ByteBuffer)buffer.Value);


        //NetworkManager networkManager = AppFacade.Instance.GetManager<NetworkManager>(ManagerName.Network);
        //proto.LoginGameReq req = new proto.LoginGameReq();
        //req.name = "123";

        //ByteBuffer buffer = new ByteBuffer();

        //buffer.WriteInt(10001);
        //byte[] content =  ByteUtil.protobufSerialize<proto.LoginGameReq>(req);
        //buffer.WriteBytes(content);
        //networkManager.SendMessage(buffer);


        //收到服务器返回消息；
        //switch (buffer.Key) {
        //    case Protocal.Connect: onResult(buffer.Value); break;
        //}
	}


    //private void onResult(ByteBuffer buffer) {

    //   proto.LoginGameRes res = ProtoBuf.Serializer.Deserialize<proto.LoginGameRes>(buffer.getMemoryStream());

    //   Debug.Log(res.userId);
    //}
}
