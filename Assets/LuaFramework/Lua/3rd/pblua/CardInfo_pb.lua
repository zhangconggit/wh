-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('CardInfo_pb')


CARDINFO = protobuf.Descriptor();
local CARDINFO_ID_FIELD = protobuf.FieldDescriptor();
local CARDINFO_COLOR_FIELD = protobuf.FieldDescriptor();
local CARDINFO_NUM_FIELD = protobuf.FieldDescriptor();

CARDINFO_ID_FIELD.name = "id"
CARDINFO_ID_FIELD.full_name = ".CardInfo.id"
CARDINFO_ID_FIELD.number = 1
CARDINFO_ID_FIELD.index = 0
CARDINFO_ID_FIELD.label = 1
CARDINFO_ID_FIELD.has_default_value = false
CARDINFO_ID_FIELD.default_value = 0
CARDINFO_ID_FIELD.type = 5
CARDINFO_ID_FIELD.cpp_type = 1

CARDINFO_COLOR_FIELD.name = "color"
CARDINFO_COLOR_FIELD.full_name = ".CardInfo.color"
CARDINFO_COLOR_FIELD.number = 2
CARDINFO_COLOR_FIELD.index = 1
CARDINFO_COLOR_FIELD.label = 1
CARDINFO_COLOR_FIELD.has_default_value = false
CARDINFO_COLOR_FIELD.default_value = 0
CARDINFO_COLOR_FIELD.type = 5
CARDINFO_COLOR_FIELD.cpp_type = 1

CARDINFO_NUM_FIELD.name = "num"
CARDINFO_NUM_FIELD.full_name = ".CardInfo.num"
CARDINFO_NUM_FIELD.number = 3
CARDINFO_NUM_FIELD.index = 2
CARDINFO_NUM_FIELD.label = 1
CARDINFO_NUM_FIELD.has_default_value = false
CARDINFO_NUM_FIELD.default_value = 0
CARDINFO_NUM_FIELD.type = 5
CARDINFO_NUM_FIELD.cpp_type = 1

CARDINFO.name = "CardInfo"
CARDINFO.full_name = ".CardInfo"
CARDINFO.nested_types = {}
CARDINFO.enum_types = {}
CARDINFO.fields = {CARDINFO_ID_FIELD, CARDINFO_COLOR_FIELD, CARDINFO_NUM_FIELD}
CARDINFO.is_extendable = false
CARDINFO.extensions = {}

CardInfo = protobuf.Message(CARDINFO)

