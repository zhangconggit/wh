-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('WuziqiBet_pb')


local WUZIQIBETREQ = protobuf.Descriptor();
local WUZIQIBETREQ_BETCONUT_FIELD = protobuf.FieldDescriptor();
local WUZIQIBETRES = protobuf.Descriptor();
local WUZIQIBETRES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local WUZIQIBETRES_BETCONUT_FIELD = protobuf.FieldDescriptor();

WUZIQIBETREQ_BETCONUT_FIELD.name = "betConut"
WUZIQIBETREQ_BETCONUT_FIELD.full_name = ".WuziqiBetReq.betConut"
WUZIQIBETREQ_BETCONUT_FIELD.number = 1
WUZIQIBETREQ_BETCONUT_FIELD.index = 0
WUZIQIBETREQ_BETCONUT_FIELD.label = 1
WUZIQIBETREQ_BETCONUT_FIELD.has_default_value = false
WUZIQIBETREQ_BETCONUT_FIELD.default_value = 0
WUZIQIBETREQ_BETCONUT_FIELD.type = 5
WUZIQIBETREQ_BETCONUT_FIELD.cpp_type = 1

WUZIQIBETREQ.name = "WuziqiBetReq"
WUZIQIBETREQ.full_name = ".WuziqiBetReq"
WUZIQIBETREQ.nested_types = {}
WUZIQIBETREQ.enum_types = {}
WUZIQIBETREQ.fields = {WUZIQIBETREQ_BETCONUT_FIELD}
WUZIQIBETREQ.is_extendable = false
WUZIQIBETREQ.extensions = {}
WUZIQIBETRES_ROLEINDEX_FIELD.name = "roleIndex"
WUZIQIBETRES_ROLEINDEX_FIELD.full_name = ".WuziqiBetRes.roleIndex"
WUZIQIBETRES_ROLEINDEX_FIELD.number = 1
WUZIQIBETRES_ROLEINDEX_FIELD.index = 0
WUZIQIBETRES_ROLEINDEX_FIELD.label = 1
WUZIQIBETRES_ROLEINDEX_FIELD.has_default_value = false
WUZIQIBETRES_ROLEINDEX_FIELD.default_value = 0
WUZIQIBETRES_ROLEINDEX_FIELD.type = 5
WUZIQIBETRES_ROLEINDEX_FIELD.cpp_type = 1

WUZIQIBETRES_BETCONUT_FIELD.name = "betConut"
WUZIQIBETRES_BETCONUT_FIELD.full_name = ".WuziqiBetRes.betConut"
WUZIQIBETRES_BETCONUT_FIELD.number = 2
WUZIQIBETRES_BETCONUT_FIELD.index = 1
WUZIQIBETRES_BETCONUT_FIELD.label = 1
WUZIQIBETRES_BETCONUT_FIELD.has_default_value = false
WUZIQIBETRES_BETCONUT_FIELD.default_value = 0
WUZIQIBETRES_BETCONUT_FIELD.type = 5
WUZIQIBETRES_BETCONUT_FIELD.cpp_type = 1

WUZIQIBETRES.name = "WuziqiBetRes"
WUZIQIBETRES.full_name = ".WuziqiBetRes"
WUZIQIBETRES.nested_types = {}
WUZIQIBETRES.enum_types = {}
WUZIQIBETRES.fields = {WUZIQIBETRES_ROLEINDEX_FIELD, WUZIQIBETRES_BETCONUT_FIELD}
WUZIQIBETRES.is_extendable = false
WUZIQIBETRES.extensions = {}

WuziqiBetReq = protobuf.Message(WUZIQIBETREQ)
WuziqiBetRes = protobuf.Message(WUZIQIBETRES)
