-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
local CardInfo_pb = require("CardInfo_pb")
module('NiuNiuSingleSettlement_pb')


local NIUNIUSINGLESETTLEMENTRES = protobuf.Descriptor();
local NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD = protobuf.FieldDescriptor();
local NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD = protobuf.FieldDescriptor();
local NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO = protobuf.Descriptor();
local SETTLEMENTINFO_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_CURJIFEN_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_JIFEN_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_CARDINFO_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_CARDTYPE_FIELD = protobuf.FieldDescriptor();

NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.name = "settlementInfo"
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.full_name = ".NiuNiuSingleSettlementRes.settlementInfo"
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.number = 1
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.index = 0
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.label = 3
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.has_default_value = false
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.default_value = {}
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.message_type = SETTLEMENTINFO
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.type = 11
NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.cpp_type = 10

NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.name = "currJu"
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.full_name = ".NiuNiuSingleSettlementRes.currJu"
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.number = 2
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.index = 1
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.label = 1
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.has_default_value = false
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.default_value = 0
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.type = 5
NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD.cpp_type = 1

NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.name = "zhuangIndex"
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.full_name = ".NiuNiuSingleSettlementRes.zhuangIndex"
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.number = 3
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.index = 2
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.label = 1
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.has_default_value = false
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.default_value = 0
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.type = 5
NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD.cpp_type = 1

NIUNIUSINGLESETTLEMENTRES.name = "NiuNiuSingleSettlementRes"
NIUNIUSINGLESETTLEMENTRES.full_name = ".NiuNiuSingleSettlementRes"
NIUNIUSINGLESETTLEMENTRES.nested_types = {}
NIUNIUSINGLESETTLEMENTRES.enum_types = {}
NIUNIUSINGLESETTLEMENTRES.fields = {NIUNIUSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD, NIUNIUSINGLESETTLEMENTRES_CURRJU_FIELD, NIUNIUSINGLESETTLEMENTRES_ZHUANGINDEX_FIELD}
NIUNIUSINGLESETTLEMENTRES.is_extendable = false
NIUNIUSINGLESETTLEMENTRES.extensions = {}
SETTLEMENTINFO_ROLEINDEX_FIELD.name = "roleIndex"
SETTLEMENTINFO_ROLEINDEX_FIELD.full_name = ".SettlementInfo.roleIndex"
SETTLEMENTINFO_ROLEINDEX_FIELD.number = 1
SETTLEMENTINFO_ROLEINDEX_FIELD.index = 0
SETTLEMENTINFO_ROLEINDEX_FIELD.label = 1
SETTLEMENTINFO_ROLEINDEX_FIELD.has_default_value = false
SETTLEMENTINFO_ROLEINDEX_FIELD.default_value = 0
SETTLEMENTINFO_ROLEINDEX_FIELD.type = 5
SETTLEMENTINFO_ROLEINDEX_FIELD.cpp_type = 1

SETTLEMENTINFO_CURJIFEN_FIELD.name = "curJiFen"
SETTLEMENTINFO_CURJIFEN_FIELD.full_name = ".SettlementInfo.curJiFen"
SETTLEMENTINFO_CURJIFEN_FIELD.number = 2
SETTLEMENTINFO_CURJIFEN_FIELD.index = 1
SETTLEMENTINFO_CURJIFEN_FIELD.label = 1
SETTLEMENTINFO_CURJIFEN_FIELD.has_default_value = false
SETTLEMENTINFO_CURJIFEN_FIELD.default_value = 0
SETTLEMENTINFO_CURJIFEN_FIELD.type = 5
SETTLEMENTINFO_CURJIFEN_FIELD.cpp_type = 1

SETTLEMENTINFO_JIFEN_FIELD.name = "jiFen"
SETTLEMENTINFO_JIFEN_FIELD.full_name = ".SettlementInfo.jiFen"
SETTLEMENTINFO_JIFEN_FIELD.number = 3
SETTLEMENTINFO_JIFEN_FIELD.index = 2
SETTLEMENTINFO_JIFEN_FIELD.label = 1
SETTLEMENTINFO_JIFEN_FIELD.has_default_value = false
SETTLEMENTINFO_JIFEN_FIELD.default_value = 0
SETTLEMENTINFO_JIFEN_FIELD.type = 5
SETTLEMENTINFO_JIFEN_FIELD.cpp_type = 1

SETTLEMENTINFO_CARDINFO_FIELD.name = "cardInfo"
SETTLEMENTINFO_CARDINFO_FIELD.full_name = ".SettlementInfo.cardInfo"
SETTLEMENTINFO_CARDINFO_FIELD.number = 4
SETTLEMENTINFO_CARDINFO_FIELD.index = 3
SETTLEMENTINFO_CARDINFO_FIELD.label = 3
SETTLEMENTINFO_CARDINFO_FIELD.has_default_value = false
SETTLEMENTINFO_CARDINFO_FIELD.default_value = {}
SETTLEMENTINFO_CARDINFO_FIELD.message_type = CardInfo_pb.CARDINFO
SETTLEMENTINFO_CARDINFO_FIELD.type = 11
SETTLEMENTINFO_CARDINFO_FIELD.cpp_type = 10

SETTLEMENTINFO_CARDTYPE_FIELD.name = "cardType"
SETTLEMENTINFO_CARDTYPE_FIELD.full_name = ".SettlementInfo.cardType"
SETTLEMENTINFO_CARDTYPE_FIELD.number = 5
SETTLEMENTINFO_CARDTYPE_FIELD.index = 4
SETTLEMENTINFO_CARDTYPE_FIELD.label = 1
SETTLEMENTINFO_CARDTYPE_FIELD.has_default_value = false
SETTLEMENTINFO_CARDTYPE_FIELD.default_value = 0
SETTLEMENTINFO_CARDTYPE_FIELD.type = 5
SETTLEMENTINFO_CARDTYPE_FIELD.cpp_type = 1

SETTLEMENTINFO.name = "SettlementInfo"
SETTLEMENTINFO.full_name = ".SettlementInfo"
SETTLEMENTINFO.nested_types = {}
SETTLEMENTINFO.enum_types = {}
SETTLEMENTINFO.fields = {SETTLEMENTINFO_ROLEINDEX_FIELD, SETTLEMENTINFO_CURJIFEN_FIELD, SETTLEMENTINFO_JIFEN_FIELD, SETTLEMENTINFO_CARDINFO_FIELD, SETTLEMENTINFO_CARDTYPE_FIELD}
SETTLEMENTINFO.is_extendable = false
SETTLEMENTINFO.extensions = {}

NiuNiuSingleSettlementRes = protobuf.Message(NIUNIUSINGLESETTLEMENTRES)
SettlementInfo = protobuf.Message(SETTLEMENTINFO)

