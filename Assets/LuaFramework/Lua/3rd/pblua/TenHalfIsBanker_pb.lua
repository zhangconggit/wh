-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('TenHalfIsBanker_pb')


local TENHALFISBANKERREQ = protobuf.Descriptor();
local TENHALFISBANKERREQ_ISBANKER_FIELD = protobuf.FieldDescriptor();
local TENHALFISBANKERRES = protobuf.Descriptor();
local TENHALFISBANKERRES_ISBANKER_FIELD = protobuf.FieldDescriptor();
local TENHALFISBANKERRES_ZHUANGINDEX_FIELD = protobuf.FieldDescriptor();

TENHALFISBANKERREQ_ISBANKER_FIELD.name = "isBanker"
TENHALFISBANKERREQ_ISBANKER_FIELD.full_name = ".TenHalfIsBankerReq.isBanker"
TENHALFISBANKERREQ_ISBANKER_FIELD.number = 1
TENHALFISBANKERREQ_ISBANKER_FIELD.index = 0
TENHALFISBANKERREQ_ISBANKER_FIELD.label = 1
TENHALFISBANKERREQ_ISBANKER_FIELD.has_default_value = false
TENHALFISBANKERREQ_ISBANKER_FIELD.default_value = false
TENHALFISBANKERREQ_ISBANKER_FIELD.type = 8
TENHALFISBANKERREQ_ISBANKER_FIELD.cpp_type = 7

TENHALFISBANKERREQ.name = "TenHalfIsBankerReq"
TENHALFISBANKERREQ.full_name = ".TenHalfIsBankerReq"
TENHALFISBANKERREQ.nested_types = {}
TENHALFISBANKERREQ.enum_types = {}
TENHALFISBANKERREQ.fields = {TENHALFISBANKERREQ_ISBANKER_FIELD}
TENHALFISBANKERREQ.is_extendable = false
TENHALFISBANKERREQ.extensions = {}
TENHALFISBANKERRES_ISBANKER_FIELD.name = "isBanker"
TENHALFISBANKERRES_ISBANKER_FIELD.full_name = ".TenHalfIsBankerRes.isBanker"
TENHALFISBANKERRES_ISBANKER_FIELD.number = 1
TENHALFISBANKERRES_ISBANKER_FIELD.index = 0
TENHALFISBANKERRES_ISBANKER_FIELD.label = 1
TENHALFISBANKERRES_ISBANKER_FIELD.has_default_value = false
TENHALFISBANKERRES_ISBANKER_FIELD.default_value = false
TENHALFISBANKERRES_ISBANKER_FIELD.type = 8
TENHALFISBANKERRES_ISBANKER_FIELD.cpp_type = 7

TENHALFISBANKERRES_ZHUANGINDEX_FIELD.name = "zhuangIndex"
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.full_name = ".TenHalfIsBankerRes.zhuangIndex"
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.number = 2
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.index = 1
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.label = 1
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.has_default_value = false
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.default_value = 0
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.type = 5
TENHALFISBANKERRES_ZHUANGINDEX_FIELD.cpp_type = 1

TENHALFISBANKERRES.name = "TenHalfIsBankerRes"
TENHALFISBANKERRES.full_name = ".TenHalfIsBankerRes"
TENHALFISBANKERRES.nested_types = {}
TENHALFISBANKERRES.enum_types = {}
TENHALFISBANKERRES.fields = {TENHALFISBANKERRES_ISBANKER_FIELD, TENHALFISBANKERRES_ZHUANGINDEX_FIELD}
TENHALFISBANKERRES.is_extendable = false
TENHALFISBANKERRES.extensions = {}

TenHalfIsBankerReq = protobuf.Message(TENHALFISBANKERREQ)
TenHalfIsBankerRes = protobuf.Message(TENHALFISBANKERRES)

