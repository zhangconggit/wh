-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('CreateDouDiZhuRoom_pb')


local CREATEDOUDIZHUROOMREQ = protobuf.Descriptor();
local CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMRES = protobuf.Descriptor();
local CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMRES_BASENUM_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD = protobuf.FieldDescriptor();
local CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD = protobuf.FieldDescriptor();

CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.name = "douDiZhuTotal"
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.full_name = ".CreateDouDiZhuRoomReq.douDiZhuTotal"
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.number = 1
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.index = 0
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.label = 2
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.has_default_value = false
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.default_value = 0
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.type = 5
CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.name = "wanfaType"
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.full_name = ".CreateDouDiZhuRoomReq.wanfaType"
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.number = 2
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.index = 1
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.label = 2
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.has_default_value = false
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.default_value = 0
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.type = 5
CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.name = "modeType"
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.full_name = ".CreateDouDiZhuRoomReq.modeType"
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.number = 3
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.index = 2
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.label = 2
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.has_default_value = false
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.default_value = 0
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.type = 5
CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.name = "landlord"
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.full_name = ".CreateDouDiZhuRoomReq.landlord"
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.number = 4
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.index = 3
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.label = 2
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.has_default_value = false
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.default_value = 0
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.type = 5
CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.name = "maxMultiple"
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.full_name = ".CreateDouDiZhuRoomReq.maxMultiple"
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.number = 5
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.index = 4
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.label = 2
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.has_default_value = false
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.default_value = 0
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.type = 5
CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMREQ.name = "CreateDouDiZhuRoomReq"
CREATEDOUDIZHUROOMREQ.full_name = ".CreateDouDiZhuRoomReq"
CREATEDOUDIZHUROOMREQ.nested_types = {}
CREATEDOUDIZHUROOMREQ.enum_types = {}
CREATEDOUDIZHUROOMREQ.fields = {CREATEDOUDIZHUROOMREQ_DOUDIZHUTOTAL_FIELD, CREATEDOUDIZHUROOMREQ_WANFATYPE_FIELD, CREATEDOUDIZHUROOMREQ_MODETYPE_FIELD, CREATEDOUDIZHUROOMREQ_LANDLORD_FIELD, CREATEDOUDIZHUROOMREQ_MAXMULTIPLE_FIELD}
CREATEDOUDIZHUROOMREQ.is_extendable = false
CREATEDOUDIZHUROOMREQ.extensions = {}
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.name = "roomNum"
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.full_name = ".CreateDouDiZhuRoomRes.roomNum"
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.number = 1
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.index = 0
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.label = 1
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.has_default_value = false
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.default_value = 0
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.type = 5
CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMRES_BASENUM_FIELD.name = "baseNum"
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.full_name = ".CreateDouDiZhuRoomRes.baseNum"
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.number = 2
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.index = 1
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.label = 1
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.has_default_value = false
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.default_value = 0
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.type = 5
CREATEDOUDIZHUROOMRES_BASENUM_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.name = "qualified"
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.full_name = ".CreateDouDiZhuRoomRes.qualified"
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.number = 3
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.index = 2
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.label = 1
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.has_default_value = false
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.default_value = 0
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.type = 5
CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.name = "moneyType"
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.full_name = ".CreateDouDiZhuRoomRes.moneyType"
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.number = 4
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.index = 3
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.label = 1
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.has_default_value = false
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.default_value = 0
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.type = 5
CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.name = "mcreenings"
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.full_name = ".CreateDouDiZhuRoomRes.mcreenings"
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.number = 5
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.index = 4
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.label = 1
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.has_default_value = false
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.default_value = 0
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.type = 5
CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD.cpp_type = 1

CREATEDOUDIZHUROOMRES.name = "CreateDouDiZhuRoomRes"
CREATEDOUDIZHUROOMRES.full_name = ".CreateDouDiZhuRoomRes"
CREATEDOUDIZHUROOMRES.nested_types = {}
CREATEDOUDIZHUROOMRES.enum_types = {}
CREATEDOUDIZHUROOMRES.fields = {CREATEDOUDIZHUROOMRES_ROOMNUM_FIELD, CREATEDOUDIZHUROOMRES_BASENUM_FIELD, CREATEDOUDIZHUROOMRES_QUALIFIED_FIELD, CREATEDOUDIZHUROOMRES_MONEYTYPE_FIELD, CREATEDOUDIZHUROOMRES_MCREENINGS_FIELD}
CREATEDOUDIZHUROOMRES.is_extendable = false
CREATEDOUDIZHUROOMRES.extensions = {}

CreateDouDiZhuRoomReq = protobuf.Message(CREATEDOUDIZHUROOMREQ)
CreateDouDiZhuRoomRes = protobuf.Message(CREATEDOUDIZHUROOMRES)

