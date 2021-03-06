-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('ApplyDisRoom_pb')


local APPLYDISROOMINFO = protobuf.Descriptor();
local APPLYDISROOMINFO_ROLEID_FIELD = protobuf.FieldDescriptor();
local APPLYDISROOMINFO_NAME_FIELD = protobuf.FieldDescriptor();
local APPLYDISROOMINFO_STATE_FIELD = protobuf.FieldDescriptor();
local APPLYDISROOMRES = protobuf.Descriptor();
local APPLYDISROOMRES_SHOWCODE_FIELD = protobuf.FieldDescriptor();
local APPLYDISROOMRES_ROLEID_FIELD = protobuf.FieldDescriptor();
local APPLYDISROOMRES_NAME_FIELD = protobuf.FieldDescriptor();
local APPLYDISROOMRES_MS_FIELD = protobuf.FieldDescriptor();
local APPLYDISROOMRES_DISROOMINFO_FIELD = protobuf.FieldDescriptor();

APPLYDISROOMINFO_ROLEID_FIELD.name = "roleId"
APPLYDISROOMINFO_ROLEID_FIELD.full_name = ".ApplyDisRoomInfo.roleId"
APPLYDISROOMINFO_ROLEID_FIELD.number = 1
APPLYDISROOMINFO_ROLEID_FIELD.index = 0
APPLYDISROOMINFO_ROLEID_FIELD.label = 1
APPLYDISROOMINFO_ROLEID_FIELD.has_default_value = false
APPLYDISROOMINFO_ROLEID_FIELD.default_value = 0
APPLYDISROOMINFO_ROLEID_FIELD.type = 3
APPLYDISROOMINFO_ROLEID_FIELD.cpp_type = 2

APPLYDISROOMINFO_NAME_FIELD.name = "name"
APPLYDISROOMINFO_NAME_FIELD.full_name = ".ApplyDisRoomInfo.name"
APPLYDISROOMINFO_NAME_FIELD.number = 2
APPLYDISROOMINFO_NAME_FIELD.index = 1
APPLYDISROOMINFO_NAME_FIELD.label = 1
APPLYDISROOMINFO_NAME_FIELD.has_default_value = false
APPLYDISROOMINFO_NAME_FIELD.default_value = ""
APPLYDISROOMINFO_NAME_FIELD.type = 9
APPLYDISROOMINFO_NAME_FIELD.cpp_type = 9

APPLYDISROOMINFO_STATE_FIELD.name = "state"
APPLYDISROOMINFO_STATE_FIELD.full_name = ".ApplyDisRoomInfo.state"
APPLYDISROOMINFO_STATE_FIELD.number = 3
APPLYDISROOMINFO_STATE_FIELD.index = 2
APPLYDISROOMINFO_STATE_FIELD.label = 1
APPLYDISROOMINFO_STATE_FIELD.has_default_value = false
APPLYDISROOMINFO_STATE_FIELD.default_value = false
APPLYDISROOMINFO_STATE_FIELD.type = 8
APPLYDISROOMINFO_STATE_FIELD.cpp_type = 7

APPLYDISROOMINFO.name = "ApplyDisRoomInfo"
APPLYDISROOMINFO.full_name = ".ApplyDisRoomInfo"
APPLYDISROOMINFO.nested_types = {}
APPLYDISROOMINFO.enum_types = {}
APPLYDISROOMINFO.fields = {APPLYDISROOMINFO_ROLEID_FIELD, APPLYDISROOMINFO_NAME_FIELD, APPLYDISROOMINFO_STATE_FIELD}
APPLYDISROOMINFO.is_extendable = false
APPLYDISROOMINFO.extensions = {}
APPLYDISROOMRES_SHOWCODE_FIELD.name = "showCode"
APPLYDISROOMRES_SHOWCODE_FIELD.full_name = ".ApplyDisRoomRes.showCode"
APPLYDISROOMRES_SHOWCODE_FIELD.number = 1
APPLYDISROOMRES_SHOWCODE_FIELD.index = 0
APPLYDISROOMRES_SHOWCODE_FIELD.label = 1
APPLYDISROOMRES_SHOWCODE_FIELD.has_default_value = false
APPLYDISROOMRES_SHOWCODE_FIELD.default_value = 0
APPLYDISROOMRES_SHOWCODE_FIELD.type = 5
APPLYDISROOMRES_SHOWCODE_FIELD.cpp_type = 1

APPLYDISROOMRES_ROLEID_FIELD.name = "roleId"
APPLYDISROOMRES_ROLEID_FIELD.full_name = ".ApplyDisRoomRes.roleId"
APPLYDISROOMRES_ROLEID_FIELD.number = 2
APPLYDISROOMRES_ROLEID_FIELD.index = 1
APPLYDISROOMRES_ROLEID_FIELD.label = 1
APPLYDISROOMRES_ROLEID_FIELD.has_default_value = false
APPLYDISROOMRES_ROLEID_FIELD.default_value = 0
APPLYDISROOMRES_ROLEID_FIELD.type = 3
APPLYDISROOMRES_ROLEID_FIELD.cpp_type = 2

APPLYDISROOMRES_NAME_FIELD.name = "name"
APPLYDISROOMRES_NAME_FIELD.full_name = ".ApplyDisRoomRes.name"
APPLYDISROOMRES_NAME_FIELD.number = 3
APPLYDISROOMRES_NAME_FIELD.index = 2
APPLYDISROOMRES_NAME_FIELD.label = 1
APPLYDISROOMRES_NAME_FIELD.has_default_value = false
APPLYDISROOMRES_NAME_FIELD.default_value = ""
APPLYDISROOMRES_NAME_FIELD.type = 9
APPLYDISROOMRES_NAME_FIELD.cpp_type = 9

APPLYDISROOMRES_MS_FIELD.name = "ms"
APPLYDISROOMRES_MS_FIELD.full_name = ".ApplyDisRoomRes.ms"
APPLYDISROOMRES_MS_FIELD.number = 4
APPLYDISROOMRES_MS_FIELD.index = 3
APPLYDISROOMRES_MS_FIELD.label = 1
APPLYDISROOMRES_MS_FIELD.has_default_value = false
APPLYDISROOMRES_MS_FIELD.default_value = 0
APPLYDISROOMRES_MS_FIELD.type = 3
APPLYDISROOMRES_MS_FIELD.cpp_type = 2

APPLYDISROOMRES_DISROOMINFO_FIELD.name = "disRoomInfo"
APPLYDISROOMRES_DISROOMINFO_FIELD.full_name = ".ApplyDisRoomRes.disRoomInfo"
APPLYDISROOMRES_DISROOMINFO_FIELD.number = 5
APPLYDISROOMRES_DISROOMINFO_FIELD.index = 4
APPLYDISROOMRES_DISROOMINFO_FIELD.label = 3
APPLYDISROOMRES_DISROOMINFO_FIELD.has_default_value = false
APPLYDISROOMRES_DISROOMINFO_FIELD.default_value = {}
APPLYDISROOMRES_DISROOMINFO_FIELD.message_type = APPLYDISROOMINFO
APPLYDISROOMRES_DISROOMINFO_FIELD.type = 11
APPLYDISROOMRES_DISROOMINFO_FIELD.cpp_type = 10

APPLYDISROOMRES.name = "ApplyDisRoomRes"
APPLYDISROOMRES.full_name = ".ApplyDisRoomRes"
APPLYDISROOMRES.nested_types = {}
APPLYDISROOMRES.enum_types = {}
APPLYDISROOMRES.fields = {APPLYDISROOMRES_SHOWCODE_FIELD, APPLYDISROOMRES_ROLEID_FIELD, APPLYDISROOMRES_NAME_FIELD, APPLYDISROOMRES_MS_FIELD, APPLYDISROOMRES_DISROOMINFO_FIELD}
APPLYDISROOMRES.is_extendable = false
APPLYDISROOMRES.extensions = {}

ApplyDisRoomInfo = protobuf.Message(APPLYDISROOMINFO)
ApplyDisRoomRes = protobuf.Message(APPLYDISROOMRES)

