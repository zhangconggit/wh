-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('NiuNiuBet_pb')


local NIUNIUBETREQ = protobuf.Descriptor();
local NIUNIUBETREQ_BETCONUT_FIELD = protobuf.FieldDescriptor();
local NIUNIUBETRES = protobuf.Descriptor();
local NIUNIUBETRES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local NIUNIUBETRES_BETCONUT_FIELD = protobuf.FieldDescriptor();

NIUNIUBETREQ_BETCONUT_FIELD.name = "betConut"
NIUNIUBETREQ_BETCONUT_FIELD.full_name = ".NiuNiuBetReq.betConut"
NIUNIUBETREQ_BETCONUT_FIELD.number = 1
NIUNIUBETREQ_BETCONUT_FIELD.index = 0
NIUNIUBETREQ_BETCONUT_FIELD.label = 1
NIUNIUBETREQ_BETCONUT_FIELD.has_default_value = false
NIUNIUBETREQ_BETCONUT_FIELD.default_value = 0
NIUNIUBETREQ_BETCONUT_FIELD.type = 5
NIUNIUBETREQ_BETCONUT_FIELD.cpp_type = 1

NIUNIUBETREQ.name = "NiuNiuBetReq"
NIUNIUBETREQ.full_name = ".NiuNiuBetReq"
NIUNIUBETREQ.nested_types = {}
NIUNIUBETREQ.enum_types = {}
NIUNIUBETREQ.fields = {NIUNIUBETREQ_BETCONUT_FIELD}
NIUNIUBETREQ.is_extendable = false
NIUNIUBETREQ.extensions = {}
NIUNIUBETRES_ROLEINDEX_FIELD.name = "roleIndex"
NIUNIUBETRES_ROLEINDEX_FIELD.full_name = ".NiuNiuBetRes.roleIndex"
NIUNIUBETRES_ROLEINDEX_FIELD.number = 1
NIUNIUBETRES_ROLEINDEX_FIELD.index = 0
NIUNIUBETRES_ROLEINDEX_FIELD.label = 1
NIUNIUBETRES_ROLEINDEX_FIELD.has_default_value = false
NIUNIUBETRES_ROLEINDEX_FIELD.default_value = 0
NIUNIUBETRES_ROLEINDEX_FIELD.type = 5
NIUNIUBETRES_ROLEINDEX_FIELD.cpp_type = 1

NIUNIUBETRES_BETCONUT_FIELD.name = "betConut"
NIUNIUBETRES_BETCONUT_FIELD.full_name = ".NiuNiuBetRes.betConut"
NIUNIUBETRES_BETCONUT_FIELD.number = 2
NIUNIUBETRES_BETCONUT_FIELD.index = 1
NIUNIUBETRES_BETCONUT_FIELD.label = 1
NIUNIUBETRES_BETCONUT_FIELD.has_default_value = false
NIUNIUBETRES_BETCONUT_FIELD.default_value = 0
NIUNIUBETRES_BETCONUT_FIELD.type = 5
NIUNIUBETRES_BETCONUT_FIELD.cpp_type = 1

NIUNIUBETRES.name = "NiuNiuBetRes"
NIUNIUBETRES.full_name = ".NiuNiuBetRes"
NIUNIUBETRES.nested_types = {}
NIUNIUBETRES.enum_types = {}
NIUNIUBETRES.fields = {NIUNIUBETRES_ROLEINDEX_FIELD, NIUNIUBETRES_BETCONUT_FIELD}
NIUNIUBETRES.is_extendable = false
NIUNIUBETRES.extensions = {}

NiuNiuBetReq = protobuf.Message(NIUNIUBETREQ)
NiuNiuBetRes = protobuf.Message(NIUNIUBETRES)
