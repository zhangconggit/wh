-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
local ChessInfo_pb = require("ChessInfo_pb")
module('BloodFightPushSignOperate_pb')


local BLOODFIGHTPUSHSIGNOPERATEREQ = protobuf.Descriptor();
local BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD = protobuf.FieldDescriptor();
local BLOODFIGHTPUSHSIGNOPERATERES = protobuf.Descriptor();
local BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD = protobuf.FieldDescriptor();
local BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD = protobuf.FieldDescriptor();
local BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD = protobuf.FieldDescriptor();
local BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD = protobuf.FieldDescriptor();

BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.name = "signType"
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.full_name = ".BloodFightPushSignOperateReq.signType"
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.number = 1
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.index = 0
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.label = 2
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.has_default_value = false
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.default_value = 0
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.type = 5
BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD.cpp_type = 1

BLOODFIGHTPUSHSIGNOPERATEREQ.name = "BloodFightPushSignOperateReq"
BLOODFIGHTPUSHSIGNOPERATEREQ.full_name = ".BloodFightPushSignOperateReq"
BLOODFIGHTPUSHSIGNOPERATEREQ.nested_types = {}
BLOODFIGHTPUSHSIGNOPERATEREQ.enum_types = {}
BLOODFIGHTPUSHSIGNOPERATEREQ.fields = {BLOODFIGHTPUSHSIGNOPERATEREQ_SIGNTYPE_FIELD}
BLOODFIGHTPUSHSIGNOPERATEREQ.is_extendable = false
BLOODFIGHTPUSHSIGNOPERATEREQ.extensions = {}
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.name = "roleId"
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.full_name = ".BloodFightPushSignOperateRes.roleId"
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.number = 1
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.index = 0
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.label = 1
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.has_default_value = false
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.default_value = 0
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.type = 3
BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD.cpp_type = 2

BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.name = "roleIndex"
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.full_name = ".BloodFightPushSignOperateRes.roleIndex"
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.number = 2
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.index = 1
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.label = 1
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.has_default_value = false
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.default_value = 0
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.type = 5
BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD.cpp_type = 1

BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.name = "signType"
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.full_name = ".BloodFightPushSignOperateRes.signType"
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.number = 3
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.index = 2
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.label = 1
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.has_default_value = false
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.default_value = 0
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.type = 5
BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD.cpp_type = 1

BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.name = "chessInfo"
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.full_name = ".BloodFightPushSignOperateRes.chessInfo"
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.number = 4
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.index = 3
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.label = 3
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.has_default_value = false
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.default_value = {}
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.message_type = ChessInfo_pb.CHESSINFO
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.type = 11
BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD.cpp_type = 10

BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.name = "huTime"
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.full_name = ".BloodFightPushSignOperateRes.huTime"
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.number = 5
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.index = 4
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.label = 1
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.has_default_value = false
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.default_value = 0
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.type = 5
BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD.cpp_type = 1

BLOODFIGHTPUSHSIGNOPERATERES.name = "BloodFightPushSignOperateRes"
BLOODFIGHTPUSHSIGNOPERATERES.full_name = ".BloodFightPushSignOperateRes"
BLOODFIGHTPUSHSIGNOPERATERES.nested_types = {}
BLOODFIGHTPUSHSIGNOPERATERES.enum_types = {}
BLOODFIGHTPUSHSIGNOPERATERES.fields = {BLOODFIGHTPUSHSIGNOPERATERES_ROLEID_FIELD, BLOODFIGHTPUSHSIGNOPERATERES_ROLEINDEX_FIELD, BLOODFIGHTPUSHSIGNOPERATERES_SIGNTYPE_FIELD, BLOODFIGHTPUSHSIGNOPERATERES_CHESSINFO_FIELD, BLOODFIGHTPUSHSIGNOPERATERES_HUTIME_FIELD}
BLOODFIGHTPUSHSIGNOPERATERES.is_extendable = false
BLOODFIGHTPUSHSIGNOPERATERES.extensions = {}

BloodFightPushSignOperateReq = protobuf.Message(BLOODFIGHTPUSHSIGNOPERATEREQ)
BloodFightPushSignOperateRes = protobuf.Message(BLOODFIGHTPUSHSIGNOPERATERES)

