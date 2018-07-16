WuZiQiPlayer = {}

setbaseclass(WuZiQiPlayer, {PlayerObject})

--初始化重写
function WuZiQiPlayer:Init(data,obj)
	PlayerObject.Init(self, data, obj)
	self.obj = obj.gameObject
	local clicp = string.sub(obj.gameObject.name,-1)
	self.imgHead 		= BasePanel:GOChild(obj,"imgHead")
	self.imgOffLine 	= BasePanel:GOChild(obj,"ImgOffine")
	self.imgOK 			= BasePanel:GOChild(obj,"imgOK")
	self.imgfangzhu     = BasePanel:GOChild(obj,"imgfangzhu")
	self.txtName 		= BasePanel:GOChild(obj,"txtName")
	self.txtID			= BasePanel:GOChild(obj,"txtID")
	self.txtYuanBaoShu	= BasePanel:GOChild(obj,"txtYuanBaoShu")
	self.imgDaoJiShi1	= BasePanel:GOChild(obj,"imgDaoJiShi1")
	self.txtDaoJiShi 	= BasePanel:GOChild(obj,"txtDaoJiShi")
    self.btnExit		= BasePanel:GOChild(obj,"btnExit")
    self.txtRoomNum		= BasePanel:GOChild(obj,"WuZiQiTable/imgQiPanBG/txtRoomNum")  

	self.index 			= data.index
	self.sitIndex		= CatchPockRoom:GetRoomIndexByIndex(self.index)
	self.id 			= tostring(data.roleId)
	self.name 			= data.name
	self.ip 			= data.ip
	self.score          = tostring(data.jifen)
	self.url 			= data.headImg
	self.gender 		= data.gender
	self.diamond 		= data.diamond
	self.jifen			= data.jifen
	self.isOnline		= data.isOnline
	print("------------------PlayerName--------------",self.name)
	if self.imgHead then
		self.imgHead.name   = self.id
		if url ~= "" then
			weChatFunction.SetPic(self.imgHead,self.id,self.url)
		end
	else
		self.imgHead = BasePanel:GOChild(obj,"Mask/"..self.id)
	end

	-- if self.imgOK then
	-- 	self.imgOK.name = self.id.."imgOK"
	-- 	self.imgOK.transform:SetParent(self.obj.transform.parent)
	-- 	self.imgOK = BasePanel:GOChild(obj.transform.parent,self.id.."imgOK")
	-- else
	-- 	self.imgOK = BasePanel:GOChild(obj.transform.parent,self.id.."imgOK")
	-- end

	if self.imgAnim then
		self.imgAnim.name = self.id.."imgAnim"
		self.imgAnim.transform:SetParent(self.obj.transform.parent)
		self.imgAnim = BasePanel:GOChild(obj.transform.parent,self.id.."imgAnim")
	else
		self.imgAnim = BasePanel:GOChild(obj.transform.parent,self.id.."imgAnim")
	end

	--断线
	if not self.isOnline then
		self.imgOffLine:SetActive(true)
	else
		self.imgOffLine:SetActive(false)
	end
end