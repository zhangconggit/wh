-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('WuziqiPlayChess_pb')


local WUZIQIPLAYCHESSREQ = protobuf.Descriptor();
local WUZIQIPLAYCHESSREQ_XCHESS_FIELD = protobuf.FieldDescriptor();
local WUZIQIPLAYCHESSREQ_YCHESS_FIELD = protobuf.FieldDescriptor();
local WUZIQIBETRES = protobuf.Descriptor();
local WUZIQIBETRES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local WUZIQIBETRES_XCHESS_FIELD = protobuf.FieldDescriptor();
local WUZIQIBETRES_YCHESS_FIELD = protobuf.FieldDescriptor();

WUZIQIPLAYCHESSREQ_XCHESS_FIELD.name = "xChess"
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.full_name = ".WuziqiPlayChessReq.xChess"
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.number = 1
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.index = 0
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.label = 2
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.has_default_value = false
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.default_value = 0
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.type = 5
WUZIQIPLAYCHESSREQ_XCHESS_FIELD.cpp_type = 1

WUZIQIPLAYCHESSREQ_YCHESS_FIELD.name = "yChess"
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.full_name = ".WuziqiPlayChessReq.yChess"
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.number = 2
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.index = 1
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.label = 2
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.has_default_value = false
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.default_value = 0
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.type = 5
WUZIQIPLAYCHESSREQ_YCHESS_FIELD.cpp_type = 1

WUZIQIPLAYCHESSREQ.name = "WuziqiPlayChessReq"
WUZIQIPLAYCHESSREQ.full_name = ".WuziqiPlayChessReq"
WUZIQIPLAYCHESSREQ.nested_types = {}
WUZIQIPLAYCHESSREQ.enum_types = {}
WUZIQIPLAYCHESSREQ.fields = {WUZIQIPLAYCHESSREQ_XCHESS_FIELD, WUZIQIPLAYCHESSREQ_YCHESS_FIELD}
WUZIQIPLAYCHESSREQ.is_extendable = false
WUZIQIPLAYCHESSREQ.extensions = {}
WUZIQIBETRES_ROLEINDEX_FIELD.name = "roleIndex"
WUZIQIBETRES_ROLEINDEX_FIELD.full_name = ".WuziqiBetRes.roleIndex"
WUZIQIBETRES_ROLEINDEX_FIELD.number = 1
WUZIQIBETRES_ROLEINDEX_FIELD.index = 0
WUZIQIBETRES_ROLEINDEX_FIELD.label = 1
WUZIQIBETRES_ROLEINDEX_FIELD.has_default_value = false
WUZIQIBETRES_ROLEINDEX_FIELD.default_value = 0
WUZIQIBETRES_ROLEINDEX_FIELD.type = 5
WUZIQIBETRES_ROLEINDEX_FIELD.cpp_type = 1

WUZIQIBETRES_XCHESS_FIELD.name = "xChess"
WUZIQIBETRES_XCHESS_FIELD.full_name = ".WuziqiBetRes.xChess"
WUZIQIBETRES_XCHESS_FIELD.number = 2
WUZIQIBETRES_XCHESS_FIELD.index = 1
WUZIQIBETRES_XCHESS_FIELD.label = 2
WUZIQIBETRES_XCHESS_FIELD.has_default_value = false
WUZIQIBETRES_XCHESS_FIELD.default_value = 0
WUZIQIBETRES_XCHESS_FIELD.type = 5
WUZIQIBETRES_XCHESS_FIELD.cpp_type = 1

WUZIQIBETRES_YCHESS_FIELD.name = "yChess"
WUZIQIBETRES_YCHESS_FIELD.full_name = ".WuziqiBetRes.yChess"
WUZIQIBETRES_YCHESS_FIELD.number = 3
WUZIQIBETRES_YCHESS_FIELD.index = 2
WUZIQIBETRES_YCHESS_FIELD.label = 2
WUZIQIBETRES_YCHESS_FIELD.has_default_value = false
WUZIQIBETRES_YCHESS_FIELD.default_value = 0
WUZIQIBETRES_YCHESS_FIELD.type = 5
WUZIQIBETRES_YCHESS_FIELD.cpp_type = 1

WUZIQIBETRES.name = "WuziqiBetRes"
WUZIQIBETRES.full_name = ".WuziqiBetRes"
WUZIQIBETRES.nested_types = {}
WUZIQIBETRES.enum_types = {}
WUZIQIBETRES.fields = {WUZIQIBETRES_ROLEINDEX_FIELD, WUZIQIBETRES_XCHESS_FIELD, WUZIQIBETRES_YCHESS_FIELD}
WUZIQIBETRES.is_extendable = false
WUZIQIBETRES.extensions = {}

WuziqiBetRes = protobuf.Message(WUZIQIBETRES)
WuziqiPlayChessReq = protobuf.Message(WUZIQIPLAYCHESSREQ)

