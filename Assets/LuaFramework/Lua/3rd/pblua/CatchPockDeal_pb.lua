-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
local CardInfo_pb = require("CardInfo_pb")
module('CatchPockDeal_pb')


local CATCHPOCKDEALRES = protobuf.Descriptor();
local CATCHPOCKDEALRES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local CATCHPOCKDEALRES_CARDINFO_FIELD = protobuf.FieldDescriptor();
local CATCHPOCKDEALRES_FIRSTINDEX_FIELD = protobuf.FieldDescriptor();

CATCHPOCKDEALRES_ROLEINDEX_FIELD.name = "roleIndex"
CATCHPOCKDEALRES_ROLEINDEX_FIELD.full_name = ".CatchPockDealRes.roleIndex"
CATCHPOCKDEALRES_ROLEINDEX_FIELD.number = 1
CATCHPOCKDEALRES_ROLEINDEX_FIELD.index = 0
CATCHPOCKDEALRES_ROLEINDEX_FIELD.label = 1
CATCHPOCKDEALRES_ROLEINDEX_FIELD.has_default_value = false
CATCHPOCKDEALRES_ROLEINDEX_FIELD.default_value = 0
CATCHPOCKDEALRES_ROLEINDEX_FIELD.type = 5
CATCHPOCKDEALRES_ROLEINDEX_FIELD.cpp_type = 1

CATCHPOCKDEALRES_CARDINFO_FIELD.name = "cardInfo"
CATCHPOCKDEALRES_CARDINFO_FIELD.full_name = ".CatchPockDealRes.cardInfo"
CATCHPOCKDEALRES_CARDINFO_FIELD.number = 2
CATCHPOCKDEALRES_CARDINFO_FIELD.index = 1
CATCHPOCKDEALRES_CARDINFO_FIELD.label = 3
CATCHPOCKDEALRES_CARDINFO_FIELD.has_default_value = false
CATCHPOCKDEALRES_CARDINFO_FIELD.default_value = {}
CATCHPOCKDEALRES_CARDINFO_FIELD.message_type = CardInfo_pb.CARDINFO
CATCHPOCKDEALRES_CARDINFO_FIELD.type = 11
CATCHPOCKDEALRES_CARDINFO_FIELD.cpp_type = 10

CATCHPOCKDEALRES_FIRSTINDEX_FIELD.name = "firstIndex"
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.full_name = ".CatchPockDealRes.firstIndex"
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.number = 3
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.index = 2
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.label = 1
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.has_default_value = false
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.default_value = 0
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.type = 5
CATCHPOCKDEALRES_FIRSTINDEX_FIELD.cpp_type = 1

CATCHPOCKDEALRES.name = "CatchPockDealRes"
CATCHPOCKDEALRES.full_name = ".CatchPockDealRes"
CATCHPOCKDEALRES.nested_types = {}
CATCHPOCKDEALRES.enum_types = {}
CATCHPOCKDEALRES.fields = {CATCHPOCKDEALRES_ROLEINDEX_FIELD, CATCHPOCKDEALRES_CARDINFO_FIELD, CATCHPOCKDEALRES_FIRSTINDEX_FIELD}
CATCHPOCKDEALRES.is_extendable = false
CATCHPOCKDEALRES.extensions = {}

CatchPockDealRes = protobuf.Message(CATCHPOCKDEALRES)
