--俱乐部

MyClubPanel = {}
setbaseclass(MyClubPanel, {BasePanel})

function MyClubPanel:InitPanel()
	self.btnBack = self:Child("btnBack")	--退出
	self.btnxx = self:Child("havejlb/btnxx")	--消息
	self.btnyq = self:Child("havejlb/btnyq")	--邀请
	self.btnjj = self:Child("havejlb/btnjj")	--基金
	self.btnsz = self:Child("havejlb/btnsz")	--设置
	self.btncy = self:Child("havejlb/btncy")	--成员
	self.txtID = self:Child("havejlb/txtID")	--俱乐部ID
	self.txtname = self:Child("havejlb/txtname")	--俱乐部名字
	self.btnCreateCulbRoom = self:Child("havejlb/btnCreateCulbRoom")	--俱乐部创建房间
	self.txtweijia = self:Child("txtweijia")	--提示创建或加入俱乐部

	self.imgshuou = self:Child("imgLeftKuang1/imgLeftkuang2/imgshuou")	--没有俱乐部的时候显示出来提示加入俱乐部

	self.btnjiahao = self:Child("imgLeftKuang1/imgLeftkuang2/btnjiahao")	---加入俱乐部

	self.imgwdjlb2 = self:Child("imgwdjlb2") --点击加号弹出的页面
	self.btncj = self:Child("imgwdjlb2/btncj") --创建俱乐部
	self.btnjr = self:Child("imgwdjlb2/btnjr")	--加入俱乐部
	self.btnjrfj = self:Child("imgwdjlb2/btnjrfj") --加入房间

	self.wdjlbcj = self:Child("wdjlbcj")	--创建俱乐部具体内容
	self.txtClubName = self:Child("wdjlbcj/InputFieldsrk1/txtClubName")	--输入的俱乐部名字
	self.btnCreateClubyes = self:Child("wdjlbcj/btnCreateClubyes")	--创建确认
	self.btnCreateClubno =self:Child("wdjlbcj/btnCreateClubno")		--创建取消

	self.wdjlbjr = self:Child("wdjlbjr")	--加入俱乐部具体内容
	self.txtClubID = self:Child("wdjlbjr/InputFieldsrk2/txtClubID")	--输入俱乐部ID
	self.btnJoinClubyes = self:Child("wdjlbjr/btnJoinClubyes")	--加入确认
	self.btnJoinClubno =self:Child("wdjlbjr/btnJoinClubno")		--加入取消


	self.imgxxdikuang = self:Child("imgxxdikuang")								--消息具体内容
	self.imgxxkuang = self:Child("imgxxdikuang/Panel/imgxxkuang")				--申请消息
	self.imgtouxiang = self:Child("imgxxdikuang/Panel/imgxxkuang/imgtouxiang")	--申请头像
	self.txtts = self:Child("imgxxdikuang/Panel/imgxxkuang/txtts")				--申请名字
	self.btntongyi = self:Child("imgxxdikuang/Panel/imgxxkuang/btntongyi")		--申请同意
	self.btntjujiue = self:Child("imgxxdikuang/Panel/imgxxkuang/btntjujiue")	--申请拒绝

	self.jijinclubPanel = self:Child("jijinclubPanel")	--基金具体内容
	self.txtjjshu = self:Child("jijinclubPanel/imgjjkaung/txtjjshu")	--基金具体数量
	self.btnjjcx = self:Child("jijinclubPanel/btnjjcx")	--基金查询
	self.btnjjzh =self:Child("jijinclubPanel/btnjjzh")	--基金转换
	self.btnguanbi =self:Child("jijinclubPanel/btnguanbi")	--关闭俱乐部

	self.jijinclubcxPanel = self:Child("jijinclubcxPanel")	--基金查询
	self.btnguan = self:Child("jijinclubcxPanel/btnguan")	--关闭基金查询

	self.clubSettingPanel = self:Child("clubSettingPanel")	--设置具体内容

	self.txtSettingNotic = self:Child("clubSettingPanel/imgkuang/jlbgjsz/txtjlbgg/InputField/txtSettingNotic") --修改俱乐部公告
	self.btnqueding = self:Child("clubSettingPanel/imgkuang/btnqueding") --俱乐部设置确认
	self.btnquxiao = self:Child("clubSettingPanel/imgkuang/btnquxiao") --俱乐部设置取消
	self.btnSettingguanbi = self:Child("clubSettingPanel/imgkuang/btnSettingguanbi") --俱乐部设置退出

	self.clubmemberPanel = self:Child("clubmemberPanel")	--成员具体内容
	self.btnrmgl = self:Child("clubmemberPanel/btnrmgl")	--任命管理
	self.btnsccy =self:Child("clubmemberPanel/btnsccy")		--删除管理
	self.imgmembertouxiang = self:Child("clubmemberPanel/imgdikuang/ryPanel/ryxzPanel1/imgmembertouxiang")	--成员头像
	self.txtmembername = self:Child("clubmemberPanel/imgdikuang/ryPanel/ryxzPanel1/txtmembername")			--成员名字
	self.txtmemberid = elf:Child("clubmemberPanel/imgdikuang/ryPanel/ryxzPanel1/txtmemberid")				--成员ID
	self.imgmembergl = self:Child("clubmemberPanel/imgdikuang/ryPanel/ryxzPanel1/imgmembergl")				--成员头衔 


end