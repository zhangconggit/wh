-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('VsGetJoinCount_pb')


local VSGETJOINCOUNTREQ = protobuf.Descriptor();
local VSGETJOINCOUNTREQ_VSTYPE_FIELD = protobuf.FieldDescriptor();
local VSGETJOINCOUNTREQ_VSCOUNT_FIELD = protobuf.FieldDescriptor();
local VSGETJOINCOUNTRES = protobuf.Descriptor();
local VSGETJOINCOUNTRES_VSTYPE_FIELD = protobuf.FieldDescriptor();
local VSGETJOINCOUNTRES_VSCOUNT_FIELD = protobuf.FieldDescriptor();
local VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD = protobuf.FieldDescriptor();

VSGETJOINCOUNTREQ_VSTYPE_FIELD.name = "vsType"
VSGETJOINCOUNTREQ_VSTYPE_FIELD.full_name = ".VsGetJoinCountReq.vsType"
VSGETJOINCOUNTREQ_VSTYPE_FIELD.number = 1
VSGETJOINCOUNTREQ_VSTYPE_FIELD.index = 0
VSGETJOINCOUNTREQ_VSTYPE_FIELD.label = 1
VSGETJOINCOUNTREQ_VSTYPE_FIELD.has_default_value = false
VSGETJOINCOUNTREQ_VSTYPE_FIELD.default_value = 0
VSGETJOINCOUNTREQ_VSTYPE_FIELD.type = 5
VSGETJOINCOUNTREQ_VSTYPE_FIELD.cpp_type = 1

VSGETJOINCOUNTREQ_VSCOUNT_FIELD.name = "vsCount"
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.full_name = ".VsGetJoinCountReq.vsCount"
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.number = 2
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.index = 1
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.label = 1
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.has_default_value = false
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.default_value = 0
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.type = 5
VSGETJOINCOUNTREQ_VSCOUNT_FIELD.cpp_type = 1

VSGETJOINCOUNTREQ.name = "VsGetJoinCountReq"
VSGETJOINCOUNTREQ.full_name = ".VsGetJoinCountReq"
VSGETJOINCOUNTREQ.nested_types = {}
VSGETJOINCOUNTREQ.enum_types = {}
VSGETJOINCOUNTREQ.fields = {VSGETJOINCOUNTREQ_VSTYPE_FIELD, VSGETJOINCOUNTREQ_VSCOUNT_FIELD}
VSGETJOINCOUNTREQ.is_extendable = false
VSGETJOINCOUNTREQ.extensions = {}
VSGETJOINCOUNTRES_VSTYPE_FIELD.name = "vsType"
VSGETJOINCOUNTRES_VSTYPE_FIELD.full_name = ".VsGetJoinCountRes.vsType"
VSGETJOINCOUNTRES_VSTYPE_FIELD.number = 1
VSGETJOINCOUNTRES_VSTYPE_FIELD.index = 0
VSGETJOINCOUNTRES_VSTYPE_FIELD.label = 1
VSGETJOINCOUNTRES_VSTYPE_FIELD.has_default_value = false
VSGETJOINCOUNTRES_VSTYPE_FIELD.default_value = 0
VSGETJOINCOUNTRES_VSTYPE_FIELD.type = 5
VSGETJOINCOUNTRES_VSTYPE_FIELD.cpp_type = 1

VSGETJOINCOUNTRES_VSCOUNT_FIELD.name = "vsCount"
VSGETJOINCOUNTRES_VSCOUNT_FIELD.full_name = ".VsGetJoinCountRes.vsCount"
VSGETJOINCOUNTRES_VSCOUNT_FIELD.number = 2
VSGETJOINCOUNTRES_VSCOUNT_FIELD.index = 1
VSGETJOINCOUNTRES_VSCOUNT_FIELD.label = 1
VSGETJOINCOUNTRES_VSCOUNT_FIELD.has_default_value = false
VSGETJOINCOUNTRES_VSCOUNT_FIELD.default_value = 0
VSGETJOINCOUNTRES_VSCOUNT_FIELD.type = 5
VSGETJOINCOUNTRES_VSCOUNT_FIELD.cpp_type = 1

VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.name = "vsJoinCount"
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.full_name = ".VsGetJoinCountRes.vsJoinCount"
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.number = 3
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.index = 2
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.label = 1
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.has_default_value = false
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.default_value = 0
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.type = 5
VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD.cpp_type = 1

VSGETJOINCOUNTRES.name = "VsGetJoinCountRes"
VSGETJOINCOUNTRES.full_name = ".VsGetJoinCountRes"
VSGETJOINCOUNTRES.nested_types = {}
VSGETJOINCOUNTRES.enum_types = {}
VSGETJOINCOUNTRES.fields = {VSGETJOINCOUNTRES_VSTYPE_FIELD, VSGETJOINCOUNTRES_VSCOUNT_FIELD, VSGETJOINCOUNTRES_VSJOINCOUNT_FIELD}
VSGETJOINCOUNTRES.is_extendable = false
VSGETJOINCOUNTRES.extensions = {}

VsGetJoinCountReq = protobuf.Message(VSGETJOINCOUNTREQ)
VsGetJoinCountRes = protobuf.Message(VSGETJOINCOUNTRES)

