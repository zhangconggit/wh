-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
local CardInfo_pb = require("CardInfo_pb")
module('OpenCard_pb')


local OPENCARDREQ = protobuf.Descriptor();
local OPENCARDREQ_OPEN_FIELD = protobuf.FieldDescriptor();
local OPENCARDREQ_OPENMULTIPLE_FIELD = protobuf.FieldDescriptor();
local OPENCARDRES = protobuf.Descriptor();
local OPENCARDRES_OPENUSERINDEX_FIELD = protobuf.FieldDescriptor();
local OPENCARDRES_CURRENTMULTIPLE_FIELD = protobuf.FieldDescriptor();
local OPENCARDRES_OPEN_FIELD = protobuf.FieldDescriptor();
local OPENCARDRES_CARDINFO_FIELD = protobuf.FieldDescriptor();

OPENCARDREQ_OPEN_FIELD.name = "open"
OPENCARDREQ_OPEN_FIELD.full_name = ".openCardReq.open"
OPENCARDREQ_OPEN_FIELD.number = 1
OPENCARDREQ_OPEN_FIELD.index = 0
OPENCARDREQ_OPEN_FIELD.label = 1
OPENCARDREQ_OPEN_FIELD.has_default_value = false
OPENCARDREQ_OPEN_FIELD.default_value = false
OPENCARDREQ_OPEN_FIELD.type = 8
OPENCARDREQ_OPEN_FIELD.cpp_type = 7

OPENCARDREQ_OPENMULTIPLE_FIELD.name = "openMultiple"
OPENCARDREQ_OPENMULTIPLE_FIELD.full_name = ".openCardReq.openMultiple"
OPENCARDREQ_OPENMULTIPLE_FIELD.number = 2
OPENCARDREQ_OPENMULTIPLE_FIELD.index = 1
OPENCARDREQ_OPENMULTIPLE_FIELD.label = 1
OPENCARDREQ_OPENMULTIPLE_FIELD.has_default_value = false
OPENCARDREQ_OPENMULTIPLE_FIELD.default_value = 0
OPENCARDREQ_OPENMULTIPLE_FIELD.type = 5
OPENCARDREQ_OPENMULTIPLE_FIELD.cpp_type = 1

OPENCARDREQ.name = "openCardReq"
OPENCARDREQ.full_name = ".openCardReq"
OPENCARDREQ.nested_types = {}
OPENCARDREQ.enum_types = {}
OPENCARDREQ.fields = {OPENCARDREQ_OPEN_FIELD, OPENCARDREQ_OPENMULTIPLE_FIELD}
OPENCARDREQ.is_extendable = false
OPENCARDREQ.extensions = {}
OPENCARDRES_OPENUSERINDEX_FIELD.name = "openUserIndex"
OPENCARDRES_OPENUSERINDEX_FIELD.full_name = ".openCardRes.openUserIndex"
OPENCARDRES_OPENUSERINDEX_FIELD.number = 1
OPENCARDRES_OPENUSERINDEX_FIELD.index = 0
OPENCARDRES_OPENUSERINDEX_FIELD.label = 1
OPENCARDRES_OPENUSERINDEX_FIELD.has_default_value = false
OPENCARDRES_OPENUSERINDEX_FIELD.default_value = 0
OPENCARDRES_OPENUSERINDEX_FIELD.type = 5
OPENCARDRES_OPENUSERINDEX_FIELD.cpp_type = 1

OPENCARDRES_CURRENTMULTIPLE_FIELD.name = "currentMultiple"
OPENCARDRES_CURRENTMULTIPLE_FIELD.full_name = ".openCardRes.currentMultiple"
OPENCARDRES_CURRENTMULTIPLE_FIELD.number = 2
OPENCARDRES_CURRENTMULTIPLE_FIELD.index = 1
OPENCARDRES_CURRENTMULTIPLE_FIELD.label = 1
OPENCARDRES_CURRENTMULTIPLE_FIELD.has_default_value = false
OPENCARDRES_CURRENTMULTIPLE_FIELD.default_value = 0
OPENCARDRES_CURRENTMULTIPLE_FIELD.type = 5
OPENCARDRES_CURRENTMULTIPLE_FIELD.cpp_type = 1

OPENCARDRES_OPEN_FIELD.name = "open"
OPENCARDRES_OPEN_FIELD.full_name = ".openCardRes.open"
OPENCARDRES_OPEN_FIELD.number = 3
OPENCARDRES_OPEN_FIELD.index = 2
OPENCARDRES_OPEN_FIELD.label = 1
OPENCARDRES_OPEN_FIELD.has_default_value = false
OPENCARDRES_OPEN_FIELD.default_value = false
OPENCARDRES_OPEN_FIELD.type = 8
OPENCARDRES_OPEN_FIELD.cpp_type = 7

OPENCARDRES_CARDINFO_FIELD.name = "cardInfo"
OPENCARDRES_CARDINFO_FIELD.full_name = ".openCardRes.cardInfo"
OPENCARDRES_CARDINFO_FIELD.number = 4
OPENCARDRES_CARDINFO_FIELD.index = 3
OPENCARDRES_CARDINFO_FIELD.label = 3
OPENCARDRES_CARDINFO_FIELD.has_default_value = false
OPENCARDRES_CARDINFO_FIELD.default_value = {}
OPENCARDRES_CARDINFO_FIELD.message_type = CARDINFO_PB_CARDINFO
OPENCARDRES_CARDINFO_FIELD.type = 11
OPENCARDRES_CARDINFO_FIELD.cpp_type = 10

OPENCARDRES.name = "openCardRes"
OPENCARDRES.full_name = ".openCardRes"
OPENCARDRES.nested_types = {}
OPENCARDRES.enum_types = {}
OPENCARDRES.fields = {OPENCARDRES_OPENUSERINDEX_FIELD, OPENCARDRES_CURRENTMULTIPLE_FIELD, OPENCARDRES_OPEN_FIELD, OPENCARDRES_CARDINFO_FIELD}
OPENCARDRES.is_extendable = false
OPENCARDRES.extensions = {}

openCardReq = protobuf.Message(OPENCARDREQ)
openCardRes = protobuf.Message(OPENCARDRES)

