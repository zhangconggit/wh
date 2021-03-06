-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('RoleReady_pb')


local ROLEREADYRES = protobuf.Descriptor();
local ROLEREADYRES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local ROLEREADYRES_LEADERINDEX_FIELD = protobuf.FieldDescriptor();
local ROLEREADYRES_ALLREADY_FIELD = protobuf.FieldDescriptor();
local ROLEREADYRES_ALREADYINDEX_FIELD = protobuf.FieldDescriptor();

ROLEREADYRES_ROLEINDEX_FIELD.name = "roleIndex"
ROLEREADYRES_ROLEINDEX_FIELD.full_name = ".RoleReadyRes.roleIndex"
ROLEREADYRES_ROLEINDEX_FIELD.number = 1
ROLEREADYRES_ROLEINDEX_FIELD.index = 0
ROLEREADYRES_ROLEINDEX_FIELD.label = 1
ROLEREADYRES_ROLEINDEX_FIELD.has_default_value = false
ROLEREADYRES_ROLEINDEX_FIELD.default_value = 0
ROLEREADYRES_ROLEINDEX_FIELD.type = 5
ROLEREADYRES_ROLEINDEX_FIELD.cpp_type = 1

ROLEREADYRES_LEADERINDEX_FIELD.name = "leaderIndex"
ROLEREADYRES_LEADERINDEX_FIELD.full_name = ".RoleReadyRes.leaderIndex"
ROLEREADYRES_LEADERINDEX_FIELD.number = 2
ROLEREADYRES_LEADERINDEX_FIELD.index = 1
ROLEREADYRES_LEADERINDEX_FIELD.label = 1
ROLEREADYRES_LEADERINDEX_FIELD.has_default_value = false
ROLEREADYRES_LEADERINDEX_FIELD.default_value = 0
ROLEREADYRES_LEADERINDEX_FIELD.type = 5
ROLEREADYRES_LEADERINDEX_FIELD.cpp_type = 1

ROLEREADYRES_ALLREADY_FIELD.name = "allReady"
ROLEREADYRES_ALLREADY_FIELD.full_name = ".RoleReadyRes.allReady"
ROLEREADYRES_ALLREADY_FIELD.number = 3
ROLEREADYRES_ALLREADY_FIELD.index = 2
ROLEREADYRES_ALLREADY_FIELD.label = 1
ROLEREADYRES_ALLREADY_FIELD.has_default_value = false
ROLEREADYRES_ALLREADY_FIELD.default_value = false
ROLEREADYRES_ALLREADY_FIELD.type = 8
ROLEREADYRES_ALLREADY_FIELD.cpp_type = 7

ROLEREADYRES_ALREADYINDEX_FIELD.name = "alreadyIndex"
ROLEREADYRES_ALREADYINDEX_FIELD.full_name = ".RoleReadyRes.alreadyIndex"
ROLEREADYRES_ALREADYINDEX_FIELD.number = 4
ROLEREADYRES_ALREADYINDEX_FIELD.index = 3
ROLEREADYRES_ALREADYINDEX_FIELD.label = 3
ROLEREADYRES_ALREADYINDEX_FIELD.has_default_value = false
ROLEREADYRES_ALREADYINDEX_FIELD.default_value = {}
ROLEREADYRES_ALREADYINDEX_FIELD.type = 5
ROLEREADYRES_ALREADYINDEX_FIELD.cpp_type = 1

ROLEREADYRES.name = "RoleReadyRes"
ROLEREADYRES.full_name = ".RoleReadyRes"
ROLEREADYRES.nested_types = {}
ROLEREADYRES.enum_types = {}
ROLEREADYRES.fields = {ROLEREADYRES_ROLEINDEX_FIELD, ROLEREADYRES_LEADERINDEX_FIELD, ROLEREADYRES_ALLREADY_FIELD, ROLEREADYRES_ALREADYINDEX_FIELD}
ROLEREADYRES.is_extendable = false
ROLEREADYRES.extensions = {}

RoleReadyRes = protobuf.Message(ROLEREADYRES)

