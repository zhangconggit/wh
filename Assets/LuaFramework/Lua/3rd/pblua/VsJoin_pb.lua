-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('VsJoin_pb')


local VSJOINREQ = protobuf.Descriptor();
local VSJOINREQ_VSTYPE_FIELD = protobuf.FieldDescriptor();
local VSJOINREQ_VSCOUNT_FIELD = protobuf.FieldDescriptor();
local VSJOINREQ_ISROBOT_FIELD = protobuf.FieldDescriptor();
local VSJOINRES = protobuf.Descriptor();
local VSJOINRES_VSTYPE_FIELD = protobuf.FieldDescriptor();
local VSJOINRES_VSCOUNT_FIELD = protobuf.FieldDescriptor();
local VSJOINRES_ROLEID_FIELD = protobuf.FieldDescriptor();
local VSJOINRES_JOINCOUNT_FIELD = protobuf.FieldDescriptor();

VSJOINREQ_VSTYPE_FIELD.name = "vsType"
VSJOINREQ_VSTYPE_FIELD.full_name = ".VsJoinReq.vsType"
VSJOINREQ_VSTYPE_FIELD.number = 1
VSJOINREQ_VSTYPE_FIELD.index = 0
VSJOINREQ_VSTYPE_FIELD.label = 1
VSJOINREQ_VSTYPE_FIELD.has_default_value = false
VSJOINREQ_VSTYPE_FIELD.default_value = 0
VSJOINREQ_VSTYPE_FIELD.type = 5
VSJOINREQ_VSTYPE_FIELD.cpp_type = 1

VSJOINREQ_VSCOUNT_FIELD.name = "vsCount"
VSJOINREQ_VSCOUNT_FIELD.full_name = ".VsJoinReq.vsCount"
VSJOINREQ_VSCOUNT_FIELD.number = 2
VSJOINREQ_VSCOUNT_FIELD.index = 1
VSJOINREQ_VSCOUNT_FIELD.label = 1
VSJOINREQ_VSCOUNT_FIELD.has_default_value = false
VSJOINREQ_VSCOUNT_FIELD.default_value = 0
VSJOINREQ_VSCOUNT_FIELD.type = 5
VSJOINREQ_VSCOUNT_FIELD.cpp_type = 1

VSJOINREQ_ISROBOT_FIELD.name = "isRobot"
VSJOINREQ_ISROBOT_FIELD.full_name = ".VsJoinReq.isRobot"
VSJOINREQ_ISROBOT_FIELD.number = 3
VSJOINREQ_ISROBOT_FIELD.index = 2
VSJOINREQ_ISROBOT_FIELD.label = 1
VSJOINREQ_ISROBOT_FIELD.has_default_value = false
VSJOINREQ_ISROBOT_FIELD.default_value = false
VSJOINREQ_ISROBOT_FIELD.type = 8
VSJOINREQ_ISROBOT_FIELD.cpp_type = 7

VSJOINREQ.name = "VsJoinReq"
VSJOINREQ.full_name = ".VsJoinReq"
VSJOINREQ.nested_types = {}
VSJOINREQ.enum_types = {}
VSJOINREQ.fields = {VSJOINREQ_VSTYPE_FIELD, VSJOINREQ_VSCOUNT_FIELD, VSJOINREQ_ISROBOT_FIELD}
VSJOINREQ.is_extendable = false
VSJOINREQ.extensions = {}
VSJOINRES_VSTYPE_FIELD.name = "vsType"
VSJOINRES_VSTYPE_FIELD.full_name = ".VsJoinRes.vsType"
VSJOINRES_VSTYPE_FIELD.number = 1
VSJOINRES_VSTYPE_FIELD.index = 0
VSJOINRES_VSTYPE_FIELD.label = 1
VSJOINRES_VSTYPE_FIELD.has_default_value = false
VSJOINRES_VSTYPE_FIELD.default_value = 0
VSJOINRES_VSTYPE_FIELD.type = 5
VSJOINRES_VSTYPE_FIELD.cpp_type = 1

VSJOINRES_VSCOUNT_FIELD.name = "vsCount"
VSJOINRES_VSCOUNT_FIELD.full_name = ".VsJoinRes.vsCount"
VSJOINRES_VSCOUNT_FIELD.number = 2
VSJOINRES_VSCOUNT_FIELD.index = 1
VSJOINRES_VSCOUNT_FIELD.label = 1
VSJOINRES_VSCOUNT_FIELD.has_default_value = false
VSJOINRES_VSCOUNT_FIELD.default_value = 0
VSJOINRES_VSCOUNT_FIELD.type = 5
VSJOINRES_VSCOUNT_FIELD.cpp_type = 1

VSJOINRES_ROLEID_FIELD.name = "roleId"
VSJOINRES_ROLEID_FIELD.full_name = ".VsJoinRes.roleId"
VSJOINRES_ROLEID_FIELD.number = 3
VSJOINRES_ROLEID_FIELD.index = 2
VSJOINRES_ROLEID_FIELD.label = 1
VSJOINRES_ROLEID_FIELD.has_default_value = false
VSJOINRES_ROLEID_FIELD.default_value = 0
VSJOINRES_ROLEID_FIELD.type = 3
VSJOINRES_ROLEID_FIELD.cpp_type = 2

VSJOINRES_JOINCOUNT_FIELD.name = "joinCount"
VSJOINRES_JOINCOUNT_FIELD.full_name = ".VsJoinRes.joinCount"
VSJOINRES_JOINCOUNT_FIELD.number = 4
VSJOINRES_JOINCOUNT_FIELD.index = 3
VSJOINRES_JOINCOUNT_FIELD.label = 1
VSJOINRES_JOINCOUNT_FIELD.has_default_value = false
VSJOINRES_JOINCOUNT_FIELD.default_value = 0
VSJOINRES_JOINCOUNT_FIELD.type = 5
VSJOINRES_JOINCOUNT_FIELD.cpp_type = 1

VSJOINRES.name = "VsJoinRes"
VSJOINRES.full_name = ".VsJoinRes"
VSJOINRES.nested_types = {}
VSJOINRES.enum_types = {}
VSJOINRES.fields = {VSJOINRES_VSTYPE_FIELD, VSJOINRES_VSCOUNT_FIELD, VSJOINRES_ROLEID_FIELD, VSJOINRES_JOINCOUNT_FIELD}
VSJOINRES.is_extendable = false
VSJOINRES.extensions = {}

VsJoinReq = protobuf.Message(VSJOINREQ)
VsJoinRes = protobuf.Message(VSJOINRES)
