-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('CatchSettlementStartGame_pb')


local CATCHSETTLEMENTSTARTGAMERES = protobuf.Descriptor();
local CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD = protobuf.FieldDescriptor();
local CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD = protobuf.FieldDescriptor();

CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.name = "allStart"
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.full_name = ".CatchSettlementStartGameRes.allStart"
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.number = 1
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.index = 0
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.label = 1
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.has_default_value = false
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.default_value = false
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.type = 8
CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.cpp_type = 7

CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.name = "alreadyIndex"
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.full_name = ".CatchSettlementStartGameRes.alreadyIndex"
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.number = 2
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.index = 1
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.label = 3
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.has_default_value = false
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.default_value = {}
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.type = 5
CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.cpp_type = 1

CATCHSETTLEMENTSTARTGAMERES.name = "CatchSettlementStartGameRes"
CATCHSETTLEMENTSTARTGAMERES.full_name = ".CatchSettlementStartGameRes"
CATCHSETTLEMENTSTARTGAMERES.nested_types = {}
CATCHSETTLEMENTSTARTGAMERES.enum_types = {}
CATCHSETTLEMENTSTARTGAMERES.fields = {CATCHSETTLEMENTSTARTGAMERES_ALLSTART_FIELD, CATCHSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD}
CATCHSETTLEMENTSTARTGAMERES.is_extendable = false
CATCHSETTLEMENTSTARTGAMERES.extensions = {}

CatchSettlementStartGameRes = protobuf.Message(CATCHSETTLEMENTSTARTGAMERES)

