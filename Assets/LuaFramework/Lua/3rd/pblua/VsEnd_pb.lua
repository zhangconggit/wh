-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('VsEnd_pb')


local VSENDRES = protobuf.Descriptor();
local VSENDRES_ENDTYPE_FIELD = protobuf.FieldDescriptor();
local VSENDRES_RANK_FIELD = protobuf.FieldDescriptor();
local VSENDRES_REWARDTYPE_FIELD = protobuf.FieldDescriptor();
local VSENDRES_REWARDCOUNT_FIELD = protobuf.FieldDescriptor();

VSENDRES_ENDTYPE_FIELD.name = "endType"
VSENDRES_ENDTYPE_FIELD.full_name = ".VsEndRes.endType"
VSENDRES_ENDTYPE_FIELD.number = 1
VSENDRES_ENDTYPE_FIELD.index = 0
VSENDRES_ENDTYPE_FIELD.label = 1
VSENDRES_ENDTYPE_FIELD.has_default_value = false
VSENDRES_ENDTYPE_FIELD.default_value = 0
VSENDRES_ENDTYPE_FIELD.type = 5
VSENDRES_ENDTYPE_FIELD.cpp_type = 1

VSENDRES_RANK_FIELD.name = "rank"
VSENDRES_RANK_FIELD.full_name = ".VsEndRes.rank"
VSENDRES_RANK_FIELD.number = 2
VSENDRES_RANK_FIELD.index = 1
VSENDRES_RANK_FIELD.label = 1
VSENDRES_RANK_FIELD.has_default_value = false
VSENDRES_RANK_FIELD.default_value = 0
VSENDRES_RANK_FIELD.type = 5
VSENDRES_RANK_FIELD.cpp_type = 1

VSENDRES_REWARDTYPE_FIELD.name = "rewardType"
VSENDRES_REWARDTYPE_FIELD.full_name = ".VsEndRes.rewardType"
VSENDRES_REWARDTYPE_FIELD.number = 3
VSENDRES_REWARDTYPE_FIELD.index = 2
VSENDRES_REWARDTYPE_FIELD.label = 1
VSENDRES_REWARDTYPE_FIELD.has_default_value = false
VSENDRES_REWARDTYPE_FIELD.default_value = 0
VSENDRES_REWARDTYPE_FIELD.type = 5
VSENDRES_REWARDTYPE_FIELD.cpp_type = 1

VSENDRES_REWARDCOUNT_FIELD.name = "rewardCount"
VSENDRES_REWARDCOUNT_FIELD.full_name = ".VsEndRes.rewardCount"
VSENDRES_REWARDCOUNT_FIELD.number = 4
VSENDRES_REWARDCOUNT_FIELD.index = 3
VSENDRES_REWARDCOUNT_FIELD.label = 1
VSENDRES_REWARDCOUNT_FIELD.has_default_value = false
VSENDRES_REWARDCOUNT_FIELD.default_value = 0
VSENDRES_REWARDCOUNT_FIELD.type = 5
VSENDRES_REWARDCOUNT_FIELD.cpp_type = 1

VSENDRES.name = "VsEndRes"
VSENDRES.full_name = ".VsEndRes"
VSENDRES.nested_types = {}
VSENDRES.enum_types = {}
VSENDRES.fields = {VSENDRES_ENDTYPE_FIELD, VSENDRES_RANK_FIELD, VSENDRES_REWARDTYPE_FIELD, VSENDRES_REWARDCOUNT_FIELD}
VSENDRES.is_extendable = false
VSENDRES.extensions = {}

VsEndRes = protobuf.Message(VSENDRES)

