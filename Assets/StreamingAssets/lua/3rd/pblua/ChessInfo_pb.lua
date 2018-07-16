-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('ChessInfo_pb')


local CHESSINFO = protobuf.Descriptor();
local CHESSINFO_ID_FIELD = protobuf.FieldDescriptor();
local CHESSINFO_COLOR_FIELD = protobuf.FieldDescriptor();
local CHESSINFO_NUM_FIELD = protobuf.FieldDescriptor();
local CHESSINFO_USED_FIELD = protobuf.FieldDescriptor();

CHESSINFO_ID_FIELD.name = "id"
CHESSINFO_ID_FIELD.full_name = ".ChessInfo.id"
CHESSINFO_ID_FIELD.number = 1
CHESSINFO_ID_FIELD.index = 0
CHESSINFO_ID_FIELD.label = 1
CHESSINFO_ID_FIELD.has_default_value = false
CHESSINFO_ID_FIELD.default_value = 0
CHESSINFO_ID_FIELD.type = 5
CHESSINFO_ID_FIELD.cpp_type = 1

CHESSINFO_COLOR_FIELD.name = "color"
CHESSINFO_COLOR_FIELD.full_name = ".ChessInfo.color"
CHESSINFO_COLOR_FIELD.number = 2
CHESSINFO_COLOR_FIELD.index = 1
CHESSINFO_COLOR_FIELD.label = 1
CHESSINFO_COLOR_FIELD.has_default_value = false
CHESSINFO_COLOR_FIELD.default_value = 0
CHESSINFO_COLOR_FIELD.type = 5
CHESSINFO_COLOR_FIELD.cpp_type = 1

CHESSINFO_NUM_FIELD.name = "num"
CHESSINFO_NUM_FIELD.full_name = ".ChessInfo.num"
CHESSINFO_NUM_FIELD.number = 3
CHESSINFO_NUM_FIELD.index = 2
CHESSINFO_NUM_FIELD.label = 1
CHESSINFO_NUM_FIELD.has_default_value = false
CHESSINFO_NUM_FIELD.default_value = 0
CHESSINFO_NUM_FIELD.type = 5
CHESSINFO_NUM_FIELD.cpp_type = 1

CHESSINFO_USED_FIELD.name = "used"
CHESSINFO_USED_FIELD.full_name = ".ChessInfo.used"
CHESSINFO_USED_FIELD.number = 4
CHESSINFO_USED_FIELD.index = 3
CHESSINFO_USED_FIELD.label = 1
CHESSINFO_USED_FIELD.has_default_value = false
CHESSINFO_USED_FIELD.default_value = 0
CHESSINFO_USED_FIELD.type = 5
CHESSINFO_USED_FIELD.cpp_type = 1

CHESSINFO.name = "ChessInfo"
CHESSINFO.full_name = ".ChessInfo"
CHESSINFO.nested_types = {}
CHESSINFO.enum_types = {}
CHESSINFO.fields = {CHESSINFO_ID_FIELD, CHESSINFO_COLOR_FIELD, CHESSINFO_NUM_FIELD, CHESSINFO_USED_FIELD}
CHESSINFO.is_extendable = false
CHESSINFO.extensions = {}

ChessInfo = protobuf.Message(CHESSINFO)
