-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('NiuNiuSettlementStartGame_pb')


local NIUNIUSETTLEMENTSTARTGAMERES = protobuf.Descriptor();
local NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD = protobuf.FieldDescriptor();
local NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD = protobuf.FieldDescriptor();
local NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD = protobuf.FieldDescriptor();
local NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD = protobuf.FieldDescriptor();

NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.name = "roleIndex"
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.full_name = ".NiuNiuSettlementStartGameRes.roleIndex"
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.number = 1
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.index = 0
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.label = 1
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.has_default_value = false
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.default_value = 0
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.type = 5
NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD.cpp_type = 1

NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.name = "allStart"
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.full_name = ".NiuNiuSettlementStartGameRes.allStart"
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.number = 2
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.index = 1
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.label = 1
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.has_default_value = false
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.default_value = false
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.type = 8
NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD.cpp_type = 7

NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.name = "alreadyIndex"
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.full_name = ".NiuNiuSettlementStartGameRes.alreadyIndex"
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.number = 3
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.index = 2
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.label = 3
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.has_default_value = false
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.default_value = {}
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.type = 5
NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD.cpp_type = 1

NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.name = "leaderIndex"
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.full_name = ".NiuNiuSettlementStartGameRes.leaderIndex"
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.number = 4
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.index = 3
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.label = 1
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.has_default_value = false
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.default_value = 0
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.type = 5
NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD.cpp_type = 1

NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.name = "currJu"
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.full_name = ".NiuNiuSettlementStartGameRes.currJu"
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.number = 5
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.index = 4
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.label = 1
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.has_default_value = false
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.default_value = 0
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.type = 5
NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD.cpp_type = 1

NIUNIUSETTLEMENTSTARTGAMERES.name = "NiuNiuSettlementStartGameRes"
NIUNIUSETTLEMENTSTARTGAMERES.full_name = ".NiuNiuSettlementStartGameRes"
NIUNIUSETTLEMENTSTARTGAMERES.nested_types = {}
NIUNIUSETTLEMENTSTARTGAMERES.enum_types = {}
NIUNIUSETTLEMENTSTARTGAMERES.fields = {NIUNIUSETTLEMENTSTARTGAMERES_ROLEINDEX_FIELD, NIUNIUSETTLEMENTSTARTGAMERES_ALLSTART_FIELD, NIUNIUSETTLEMENTSTARTGAMERES_ALREADYINDEX_FIELD, NIUNIUSETTLEMENTSTARTGAMERES_LEADERINDEX_FIELD, NIUNIUSETTLEMENTSTARTGAMERES_CURRJU_FIELD}
NIUNIUSETTLEMENTSTARTGAMERES.is_extendable = false
NIUNIUSETTLEMENTSTARTGAMERES.extensions = {}

NiuNiuSettlementStartGameRes = protobuf.Message(NIUNIUSETTLEMENTSTARTGAMERES)

