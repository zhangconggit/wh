-- Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf/protobuf"
module('LookSumScore_pb')


local LOOKSUMSCOREINFO = protobuf.Descriptor();
local LOOKSUMSCOREINFO_ROLEID_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_INDEX_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_NAME_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCOREINFO_JIFEN_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCORERES = protobuf.Descriptor();
local LOOKSUMSCORERES_SUMSCOREINFO_FIELD = protobuf.FieldDescriptor();
local LOOKSUMSCORERES_ENDTIME_FIELD = protobuf.FieldDescriptor();

LOOKSUMSCOREINFO_ROLEID_FIELD.name = "roleId"
LOOKSUMSCOREINFO_ROLEID_FIELD.full_name = ".LookSumScoreInfo.roleId"
LOOKSUMSCOREINFO_ROLEID_FIELD.number = 1
LOOKSUMSCOREINFO_ROLEID_FIELD.index = 0
LOOKSUMSCOREINFO_ROLEID_FIELD.label = 1
LOOKSUMSCOREINFO_ROLEID_FIELD.has_default_value = false
LOOKSUMSCOREINFO_ROLEID_FIELD.default_value = 0
LOOKSUMSCOREINFO_ROLEID_FIELD.type = 3
LOOKSUMSCOREINFO_ROLEID_FIELD.cpp_type = 2

LOOKSUMSCOREINFO_INDEX_FIELD.name = "index"
LOOKSUMSCOREINFO_INDEX_FIELD.full_name = ".LookSumScoreInfo.index"
LOOKSUMSCOREINFO_INDEX_FIELD.number = 2
LOOKSUMSCOREINFO_INDEX_FIELD.index = 1
LOOKSUMSCOREINFO_INDEX_FIELD.label = 1
LOOKSUMSCOREINFO_INDEX_FIELD.has_default_value = false
LOOKSUMSCOREINFO_INDEX_FIELD.default_value = 0
LOOKSUMSCOREINFO_INDEX_FIELD.type = 5
LOOKSUMSCOREINFO_INDEX_FIELD.cpp_type = 1

LOOKSUMSCOREINFO_NAME_FIELD.name = "name"
LOOKSUMSCOREINFO_NAME_FIELD.full_name = ".LookSumScoreInfo.name"
LOOKSUMSCOREINFO_NAME_FIELD.number = 3
LOOKSUMSCOREINFO_NAME_FIELD.index = 2
LOOKSUMSCOREINFO_NAME_FIELD.label = 1
LOOKSUMSCOREINFO_NAME_FIELD.has_default_value = false
LOOKSUMSCOREINFO_NAME_FIELD.default_value = ""
LOOKSUMSCOREINFO_NAME_FIELD.type = 9
LOOKSUMSCOREINFO_NAME_FIELD.cpp_type = 9

LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.name = "zimoCount"
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.full_name = ".LookSumScoreInfo.zimoCount"
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.number = 4
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.index = 3
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.label = 1
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.has_default_value = false
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.default_value = 0
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.type = 5
LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD.cpp_type = 1

LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.name = "jiepaoCount"
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.full_name = ".LookSumScoreInfo.jiepaoCount"
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.number = 5
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.index = 4
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.label = 1
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.has_default_value = false
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.default_value = 0
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.type = 5
LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD.cpp_type = 1

LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.name = "dianpaoCount"
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.full_name = ".LookSumScoreInfo.dianpaoCount"
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.number = 6
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.index = 5
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.label = 1
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.has_default_value = false
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.default_value = 0
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.type = 5
LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD.cpp_type = 1

LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.name = "angangCount"
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.full_name = ".LookSumScoreInfo.angangCount"
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.number = 7
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.index = 6
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.label = 1
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.has_default_value = false
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.default_value = 0
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.type = 5
LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD.cpp_type = 1

LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.name = "minggangCount"
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.full_name = ".LookSumScoreInfo.minggangCount"
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.number = 8
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.index = 7
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.label = 1
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.has_default_value = false
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.default_value = 0
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.type = 5
LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD.cpp_type = 1

LOOKSUMSCOREINFO_JIFEN_FIELD.name = "jifen"
LOOKSUMSCOREINFO_JIFEN_FIELD.full_name = ".LookSumScoreInfo.jifen"
LOOKSUMSCOREINFO_JIFEN_FIELD.number = 9
LOOKSUMSCOREINFO_JIFEN_FIELD.index = 8
LOOKSUMSCOREINFO_JIFEN_FIELD.label = 1
LOOKSUMSCOREINFO_JIFEN_FIELD.has_default_value = false
LOOKSUMSCOREINFO_JIFEN_FIELD.default_value = 0
LOOKSUMSCOREINFO_JIFEN_FIELD.type = 5
LOOKSUMSCOREINFO_JIFEN_FIELD.cpp_type = 1

LOOKSUMSCOREINFO.name = "LookSumScoreInfo"
LOOKSUMSCOREINFO.full_name = ".LookSumScoreInfo"
LOOKSUMSCOREINFO.nested_types = {}
LOOKSUMSCOREINFO.enum_types = {}
LOOKSUMSCOREINFO.fields = {LOOKSUMSCOREINFO_ROLEID_FIELD, LOOKSUMSCOREINFO_INDEX_FIELD, LOOKSUMSCOREINFO_NAME_FIELD, LOOKSUMSCOREINFO_ZIMOCOUNT_FIELD, LOOKSUMSCOREINFO_JIEPAOCOUNT_FIELD, LOOKSUMSCOREINFO_DIANPAOCOUNT_FIELD, LOOKSUMSCOREINFO_ANGANGCOUNT_FIELD, LOOKSUMSCOREINFO_MINGGANGCOUNT_FIELD, LOOKSUMSCOREINFO_JIFEN_FIELD}
LOOKSUMSCOREINFO.is_extendable = false
LOOKSUMSCOREINFO.extensions = {}
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.name = "sumScoreInfo"
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.full_name = ".LookSumScoreRes.sumScoreInfo"
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.number = 1
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.index = 0
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.label = 3
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.has_default_value = false
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.default_value = {}
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.message_type = LOOKSUMSCOREINFO
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.type = 11
LOOKSUMSCORERES_SUMSCOREINFO_FIELD.cpp_type = 10

LOOKSUMSCORERES_ENDTIME_FIELD.name = "endTime"
LOOKSUMSCORERES_ENDTIME_FIELD.full_name = ".LookSumScoreRes.endTime"
LOOKSUMSCORERES_ENDTIME_FIELD.number = 2
LOOKSUMSCORERES_ENDTIME_FIELD.index = 1
LOOKSUMSCORERES_ENDTIME_FIELD.label = 1
LOOKSUMSCORERES_ENDTIME_FIELD.has_default_value = false
LOOKSUMSCORERES_ENDTIME_FIELD.default_value = 0
LOOKSUMSCORERES_ENDTIME_FIELD.type = 3
LOOKSUMSCORERES_ENDTIME_FIELD.cpp_type = 2

LOOKSUMSCORERES.name = "LookSumScoreRes"
LOOKSUMSCORERES.full_name = ".LookSumScoreRes"
LOOKSUMSCORERES.nested_types = {}
LOOKSUMSCORERES.enum_types = {}
LOOKSUMSCORERES.fields = {LOOKSUMSCORERES_SUMSCOREINFO_FIELD, LOOKSUMSCORERES_ENDTIME_FIELD}
LOOKSUMSCORERES.is_extendable = false
LOOKSUMSCORERES.extensions = {}

LookSumScoreInfo = protobuf.Message(LOOKSUMSCOREINFO)
LookSumScoreRes = protobuf.Message(LOOKSUMSCORERES)

