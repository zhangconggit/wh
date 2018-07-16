require "Common/define"
require "Common/msgDefine"
require "Common/functions"

--房间结算状态；
RoomSettlementStatic = {}
local this = RoomSettlementStatic

local uiCardProfab    = nil
local UiCardBasePos = nil --每局结算第一个人牌的基础位置
local CardInitIndex = 1   --每局结算牌的初始索引	

function RoomSettlementStatic.New() 
	return this
end


function RoomSettlementStatic.isEnter(...)
	return true
end

function RoomSettlementStatic.Enter()
	SingleSettlementCtrl:Open('SingleSettlement')
end




function RoomSettlementStatic.Update()
	
end

function RoomSettlementStatic.Exit()
 
end

--读取每局结算牌图片预制体
function RoomSettlementStatic.LoadImageUIProfab(objs)
	
	--gameRoom.cardCamera.gameObject:SetActive(true)	
	uiCardProfab = newObject(objs[0])
	
	local singleSettlementChess  = global.singleSettlementVo    
	local chessInfo =	singleSettlementChess.playerCardList
	local strNum    = ''
	
	if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
	end
	
	resMgr:LoadPrefab('MahjongCard', { 'color_'..  chessInfo.color  .. '_' ..strNum}, this.LoadCardApplySettlementPanel,CardInitIndex)	
	
end

--创建模型并且逐一拍照
function RoomSettlementStatic.LoadCardApplySettlementPanel(objs,index)
	local go 			  = newObject(objs[0])
	go.transform.parent   = gameRoom.gameObjContainer.transform
	
	local singleSettlementChess  =  global.singleSettlementVo
	local chessInfo = singleSettlementChess.playerCardList
 
	local card = MahjongCard:New()
	card.static = -1
	card.gameObject = go
	card.transform  = go.transform
	card.index      = index
	
	--拍照到UI
	local uiGo    = newObject(uiCardProfab)
	local image = uiGo.transform:GetComponent('Image')
	local mahUI = MahjongUiCard.New()
	
	mahUI.image = image
	local parent = gameRoom.canvas.transform	
	uiGo.transform:SetParent(parent)
	
	mahUI.image.rectTransform.anchoredPosition = Vector3.New(UiCardBasePos.x + 70 * index,UiCardBasePos.y,0)
	mahUI.image.rectTransform.localScale       = Vector3.New(0.8,0.8,0.8)
	mahUI.index = index
	
	mahUI.gameObject = go
	mahUI.colorType  = chessInfo.color
	mahUI.num        = chessInfo.num
	mahUI.id         = chessInfo.id
	mahUI.image.name = mahUI.colorType..'_'..mahUI.num..'_'..mahUI.id
	
	--this.Photograph(image)

	card.transform.position = Vector3.New(100,0,0)
	--gameRoom.cardCamera.gameObject:SetActive(false)
end

--拍照处理
-- function RoomSettlementStatic.Photograph(image)
-- 	local renderTexture = UnityEngine.RenderTexture.New(128,128,1)
-- 	gameRoom.cardCamera.targetTexture = renderTexture
-- 	gameRoom.cardCamera:Render()

-- 	local texture2D = UnityEngine.Texture2D.New(renderTexture.width, renderTexture.height)
-- 	local rect      = UnityEngine.Rect.New(0,0,renderTexture.width,renderTexture.height)
	
-- 	UnityEngine.RenderTexture.active = renderTexture
-- 	local nRect = UnityEngine.Rect.New(0,0,128,128)
-- 	texture2D:ReadPixels(nRect, 0, 0)
-- 	texture2D:Apply()
-- 	UnityEngine.RenderTexture.active = nil
		
-- 	local sRect  = UnityEngine.Rect.New(0,0,128,128)
-- 	local sprite = UnityEngine.Sprite.Create(texture2D,sRect,Vector2.New(-1,0))
-- 	image.sprite = sprite
-- end



 