-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('GoldcoinChange_pb')


local GOLDCOINCHANGERES = protobuf.Descriptor();
local GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD = protobuf.FieldDescriptor();
local GOLDCOINCHANGERES_GOLDCOINVAL_FIELD = protobuf.FieldDescriptor();

GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.name = "GoldcoinType"
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.full_name = ".GoldcoinChangeRes.GoldcoinType"
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.number = 1
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.index = 0
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.label = 1
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.has_default_value = false
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.default_value = 0
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.type = 5
GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD.cpp_type = 1

GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.name = "GoldcoinVal"
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.full_name = ".GoldcoinChangeRes.GoldcoinVal"
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.number = 2
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.index = 1
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.label = 1
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.has_default_value = false
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.default_value = 0
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.type = 3
GOLDCOINCHANGERES_GOLDCOINVAL_FIELD.cpp_type = 2

GOLDCOINCHANGERES.name = "GoldcoinChangeRes"
GOLDCOINCHANGERES.full_name = ".GoldcoinChangeRes"
GOLDCOINCHANGERES.nested_types = {}
GOLDCOINCHANGERES.enum_types = {}
GOLDCOINCHANGERES.fields = {GOLDCOINCHANGERES_GOLDCOINTYPE_FIELD, GOLDCOINCHANGERES_GOLDCOINVAL_FIELD}
GOLDCOINCHANGERES.is_extendable = false
GOLDCOINCHANGERES.extensions = {}

GoldcoinChangeRes = protobuf.Message(GOLDCOINCHANGERES)

