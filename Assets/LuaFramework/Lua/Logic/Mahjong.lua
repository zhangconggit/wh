Mahjong = {}

function Mahjong:Start()
	Util.ClearMemory()
	gameRoom = GameRoom.New()
    -- Event.AddListener(Protocal.Card_Init  ,GameRoom.OnInitRes);
    -- Event.AddListener(Protocal.Card_Get   ,GameRoom.OnCardGet);
    -- Event.AddListener(Protocal.Card_Play,RoomRunStatic.OnCardPlay);
    -- Event.AddListener(Protocal.Card_PushSign,RoomRunStatic.OnCardPushSign);
    -- Event.AddListener(Protocal.Card_PushSignOperate,RoomRunStatic.OnCardPushSignOperate);
    TalkCtrl:Open("Talk", function()
        TalkCtrl:Close()
        if gameRoom.resCount < gameRoom.needResCount then
            BlockLayerCtrl:UsualOpen("BlockLayer")
        end
    end)

    if self.reloadData then
        gameRoom.Reload(self.reloadData)
        self.reloadData = nil
    end
    NoticeTipsCtrl:Open("NoticeTips")
end

function Mahjong:Update()
	if gameRoom then
		gameRoom.Update()
	end
end