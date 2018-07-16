-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
local CardInfo_pb = require("CardInfo_pb")
module('TenHalfSingleSettlement_pb')


local TENHALFSINGLESETTLEMENTRES = protobuf.Descriptor();
local TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO = protobuf.Descriptor();
local SETTLEMENTINFO_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_CURJIFEN_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_JIFEN_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_CARDINFO_FIELD = protobuf.FieldDescriptor();
local SETTLEMENTINFO_CARDTYPE_FIELD = protobuf.FieldDescriptor();

TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.name = "settlementInfo"
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.full_name = ".TenHalfSingleSettlementRes.settlementInfo"
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.number = 1
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.index = 0
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.label = 3
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.has_default_value = false
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.default_value = {}
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.message_type = SETTLEMENTINFO
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.type = 11
TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD.cpp_type = 10

TENHALFSINGLESETTLEMENTRES.name = "TenHalfSingleSettlementRes"
TENHALFSINGLESETTLEMENTRES.full_name = ".TenHalfSingleSettlementRes"
TENHALFSINGLESETTLEMENTRES.nested_types = {}
TENHALFSINGLESETTLEMENTRES.enum_types = {}
TENHALFSINGLESETTLEMENTRES.fields = {TENHALFSINGLESETTLEMENTRES_SETTLEMENTINFO_FIELD}
TENHALFSINGLESETTLEMENTRES.is_extendable = false
TENHALFSINGLESETTLEMENTRES.extensions = {}
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

SettlementInfo = protobuf.Message(SETTLEMENTINFO)
TenHalfSingleSettlementRes = protobuf.Message(TENHALFSINGLESETTLEMENTRES)

