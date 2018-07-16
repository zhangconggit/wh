MahjongRoom = {
    RoomMsg = {},
    playersData = {},
    playerCount = {},
    players = {},
    myIndex = 0,
}
setbaseclass(MahjongRoom, {RoomObject})

function MahjongRoom:InitPlayers()
	self.players = {}
end