-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('RoleLose_pb')


local ROLELOSERES = protobuf.Descriptor();
local ROLELOSERES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();
local ROLELOSERES_WININDEX_FIELD = protobuf.FieldDescriptor();
local ROLELOSERES_LOSEINDEX_FIELD = protobuf.FieldDescriptor();
local ROLELOSERES_BET_FIELD = protobuf.FieldDescriptor();

ROLELOSERES_ROLEINDEX_FIELD.name = "roleIndex"
ROLELOSERES_ROLEINDEX_FIELD.full_name = ".RoleLoseRes.roleIndex"
ROLELOSERES_ROLEINDEX_FIELD.number = 1
ROLELOSERES_ROLEINDEX_FIELD.index = 0
ROLELOSERES_ROLEINDEX_FIELD.label = 1
ROLELOSERES_ROLEINDEX_FIELD.has_default_value = false
ROLELOSERES_ROLEINDEX_FIELD.default_value = 0
ROLELOSERES_ROLEINDEX_FIELD.type = 5
ROLELOSERES_ROLEINDEX_FIELD.cpp_type = 1

ROLELOSERES_WININDEX_FIELD.name = "winIndex"
ROLELOSERES_WININDEX_FIELD.full_name = ".RoleLoseRes.winIndex"
ROLELOSERES_WININDEX_FIELD.number = 2
ROLELOSERES_WININDEX_FIELD.index = 1
ROLELOSERES_WININDEX_FIELD.label = 1
ROLELOSERES_WININDEX_FIELD.has_default_value = false
ROLELOSERES_WININDEX_FIELD.default_value = 0
ROLELOSERES_WININDEX_FIELD.type = 5
ROLELOSERES_WININDEX_FIELD.cpp_type = 1

ROLELOSERES_LOSEINDEX_FIELD.name = "loseIndex"
ROLELOSERES_LOSEINDEX_FIELD.full_name = ".RoleLoseRes.loseIndex"
ROLELOSERES_LOSEINDEX_FIELD.number = 3
ROLELOSERES_LOSEINDEX_FIELD.index = 2
ROLELOSERES_LOSEINDEX_FIELD.label = 1
ROLELOSERES_LOSEINDEX_FIELD.has_default_value = false
ROLELOSERES_LOSEINDEX_FIELD.default_value = 0
ROLELOSERES_LOSEINDEX_FIELD.type = 5
ROLELOSERES_LOSEINDEX_FIELD.cpp_type = 1

ROLELOSERES_BET_FIELD.name = "bet"
ROLELOSERES_BET_FIELD.full_name = ".RoleLoseRes.bet"
ROLELOSERES_BET_FIELD.number = 4
ROLELOSERES_BET_FIELD.index = 3
ROLELOSERES_BET_FIELD.label = 1
ROLELOSERES_BET_FIELD.has_default_value = false
ROLELOSERES_BET_FIELD.default_value = 0
ROLELOSERES_BET_FIELD.type = 3
ROLELOSERES_BET_FIELD.cpp_type = 2

ROLELOSERES.name = "RoleLoseRes"
ROLELOSERES.full_name = ".RoleLoseRes"
ROLELOSERES.nested_types = {}
ROLELOSERES.enum_types = {}
ROLELOSERES.fields = {ROLELOSERES_ROLEINDEX_FIELD, ROLELOSERES_WININDEX_FIELD, ROLELOSERES_LOSEINDEX_FIELD, ROLELOSERES_BET_FIELD}
ROLELOSERES.is_extendable = false
ROLELOSERES.extensions = {}

RoleLoseRes = protobuf.Message(ROLELOSERES)

