-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('BloodFightPushSign_pb')


local BLOODPUSHSIGNRES = protobuf.Descriptor();
local BLOODPUSHSIGNRES_SIGNS_FIELD = protobuf.FieldDescriptor();
local BLOODPUSHSIGNRES_ROLEINDEX_FIELD = protobuf.FieldDescriptor();

BLOODPUSHSIGNRES_SIGNS_FIELD.name = "signs"
BLOODPUSHSIGNRES_SIGNS_FIELD.full_name = ".BloodPushSignRes.signs"
BLOODPUSHSIGNRES_SIGNS_FIELD.number = 1
BLOODPUSHSIGNRES_SIGNS_FIELD.index = 0
BLOODPUSHSIGNRES_SIGNS_FIELD.label = 3
BLOODPUSHSIGNRES_SIGNS_FIELD.has_default_value = false
BLOODPUSHSIGNRES_SIGNS_FIELD.default_value = {}
BLOODPUSHSIGNRES_SIGNS_FIELD.type = 5
BLOODPUSHSIGNRES_SIGNS_FIELD.cpp_type = 1

BLOODPUSHSIGNRES_ROLEINDEX_FIELD.name = "roleIndex"
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.full_name = ".BloodPushSignRes.roleIndex"
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.number = 2
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.index = 1
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.label = 1
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.has_default_value = false
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.default_value = 0
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.type = 5
BLOODPUSHSIGNRES_ROLEINDEX_FIELD.cpp_type = 1

BLOODPUSHSIGNRES.name = "BloodPushSignRes"
BLOODPUSHSIGNRES.full_name = ".BloodPushSignRes"
BLOODPUSHSIGNRES.nested_types = {}
BLOODPUSHSIGNRES.enum_types = {}
BLOODPUSHSIGNRES.fields = {BLOODPUSHSIGNRES_SIGNS_FIELD, BLOODPUSHSIGNRES_ROLEINDEX_FIELD}
BLOODPUSHSIGNRES.is_extendable = false
BLOODPUSHSIGNRES.extensions = {}

BloodPushSignRes = protobuf.Message(BLOODPUSHSIGNRES)
