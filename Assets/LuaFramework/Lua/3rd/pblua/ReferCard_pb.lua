-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
local ChessInfo_pb = require("ChessInfo_pb")
module('ReferCard_pb')


local REFERCARDINFO = protobuf.Descriptor();
local REFERCARDINFO_ROLEID_FIELD = protobuf.FieldDescriptor();
local REFERCARDINFO_INDEX_FIELD = protobuf.FieldDescriptor();
local REFERCARDINFO_REFERCHESSINFO_FIELD = protobuf.FieldDescriptor();
local REFERCARDINFO_NOREFERCHESSINFO_FIELD = protobuf.FieldDescriptor();
local REFERCARDRES = protobuf.Descriptor();
local REFERCARDRES_CARDINFO_FIELD = protobuf.FieldDescriptor();

REFERCARDINFO_ROLEID_FIELD.name = "roleId"
REFERCARDINFO_ROLEID_FIELD.full_name = ".ReferCardInfo.roleId"
REFERCARDINFO_ROLEID_FIELD.number = 1
REFERCARDINFO_ROLEID_FIELD.index = 0
REFERCARDINFO_ROLEID_FIELD.label = 1
REFERCARDINFO_ROLEID_FIELD.has_default_value = false
REFERCARDINFO_ROLEID_FIELD.default_value = 0
REFERCARDINFO_ROLEID_FIELD.type = 3
REFERCARDINFO_ROLEID_FIELD.cpp_type = 2

REFERCARDINFO_INDEX_FIELD.name = "index"
REFERCARDINFO_INDEX_FIELD.full_name = ".ReferCardInfo.index"
REFERCARDINFO_INDEX_FIELD.number = 2
REFERCARDINFO_INDEX_FIELD.index = 1
REFERCARDINFO_INDEX_FIELD.label = 1
REFERCARDINFO_INDEX_FIELD.has_default_value = false
REFERCARDINFO_INDEX_FIELD.default_value = 0
REFERCARDINFO_INDEX_FIELD.type = 5
REFERCARDINFO_INDEX_FIELD.cpp_type = 1

REFERCARDINFO_REFERCHESSINFO_FIELD.name = "referChessInfo"
REFERCARDINFO_REFERCHESSINFO_FIELD.full_name = ".ReferCardInfo.referChessInfo"
REFERCARDINFO_REFERCHESSINFO_FIELD.number = 3
REFERCARDINFO_REFERCHESSINFO_FIELD.index = 2
REFERCARDINFO_REFERCHESSINFO_FIELD.label = 3
REFERCARDINFO_REFERCHESSINFO_FIELD.has_default_value = false
REFERCARDINFO_REFERCHESSINFO_FIELD.default_value = {}
REFERCARDINFO_REFERCHESSINFO_FIELD.message_type = ChessInfo_pb.CHESSINFO
REFERCARDINFO_REFERCHESSINFO_FIELD.type = 11
REFERCARDINFO_REFERCHESSINFO_FIELD.cpp_type = 10

REFERCARDINFO_NOREFERCHESSINFO_FIELD.name = "noReferChessInfo"
REFERCARDINFO_NOREFERCHESSINFO_FIELD.full_name = ".ReferCardInfo.noReferChessInfo"
REFERCARDINFO_NOREFERCHESSINFO_FIELD.number = 4
REFERCARDINFO_NOREFERCHESSINFO_FIELD.index = 3
REFERCARDINFO_NOREFERCHESSINFO_FIELD.label = 3
REFERCARDINFO_NOREFERCHESSINFO_FIELD.has_default_value = false
REFERCARDINFO_NOREFERCHESSINFO_FIELD.default_value = {}
REFERCARDINFO_NOREFERCHESSINFO_FIELD.message_type = ChessInfo_pb.CHESSINFO
REFERCARDINFO_NOREFERCHESSINFO_FIELD.type = 11
REFERCARDINFO_NOREFERCHESSINFO_FIELD.cpp_type = 10

REFERCARDINFO.name = "ReferCardInfo"
REFERCARDINFO.full_name = ".ReferCardInfo"
REFERCARDINFO.nested_types = {}
REFERCARDINFO.enum_types = {}
REFERCARDINFO.fields = {REFERCARDINFO_ROLEID_FIELD, REFERCARDINFO_INDEX_FIELD, REFERCARDINFO_REFERCHESSINFO_FIELD, REFERCARDINFO_NOREFERCHESSINFO_FIELD}
REFERCARDINFO.is_extendable = false
REFERCARDINFO.extensions = {}
REFERCARDRES_CARDINFO_FIELD.name = "cardInfo"
REFERCARDRES_CARDINFO_FIELD.full_name = ".ReferCardRes.cardInfo"
REFERCARDRES_CARDINFO_FIELD.number = 1
REFERCARDRES_CARDINFO_FIELD.index = 0
REFERCARDRES_CARDINFO_FIELD.label = 3
REFERCARDRES_CARDINFO_FIELD.has_default_value = false
REFERCARDRES_CARDINFO_FIELD.default_value = {}
REFERCARDRES_CARDINFO_FIELD.message_type = REFERCARDINFO
REFERCARDRES_CARDINFO_FIELD.type = 11
REFERCARDRES_CARDINFO_FIELD.cpp_type = 10

REFERCARDRES.name = "ReferCardRes"
REFERCARDRES.full_name = ".ReferCardRes"
REFERCARDRES.nested_types = {}
REFERCARDRES.enum_types = {}
REFERCARDRES.fields = {REFERCARDRES_CARDINFO_FIELD}
REFERCARDRES.is_extendable = false
REFERCARDRES.extensions = {}

ReferCardInfo = protobuf.Message(REFERCARDINFO)
ReferCardRes = protobuf.Message(REFERCARDRES)

