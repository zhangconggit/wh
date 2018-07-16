--输出日志--
function log(str)
    Util.Log(str)
end

--错误日志--
function logError(str) 
	Util.LogError(str);
end

--警告日志--
function logWarn(str) 
	Util.LogWarning(str);
end

--查找对象--
function find(str)
	return GameObject.Find(str);
end

function destroy(obj)
	GameObject.Destroy(obj);
end

function newObject(prefab)
	return GameObject.Instantiate(prefab);
end

--创建面板--
function createPanel(name)
	panelMgr:CreatePanel(name);
end

function child(str)
	return transform:FindChild(str);
end

function subGet(childNode, typeName)		
	return child(childNode):GetComponent(typeName);
end

function findPanel(str) 
	local obj = find(str);
	if obj == nil then
		error(str.." is null");
		return nil;
	end
	return obj:GetComponent("BaseLua");
end

--删除table数据  
function removeTableData(dataTabel)  
    -- body  
    if dataTabel ~= nil then  
        --todo  
        for i = #dataTabel, 1, -1 do  
            if dataTabel[i] ~= nil then  
                --todo  
                table.remove(self._publicCard, i)  
            end  
        end  
    end  
end 

function table_is_empty(t)
	return _G.next(t) == nil
end

function super(k, list)
    for i, v in ipairs(list) do
        local ret = v[k]
        if ret then
            return ret
        end
    end
end

function setbaseclass(tb, list)
    if #list == 1 then
        setmetatable(tb, {__index = list[1]})
    else
        setmetatable(tb, {__index = function(t,k) return super(k, list) end})
    end
end

function to_time_format(n)
    local h = math.floor(n / 3600)
    local m = math.floor((n % 3600) / 60)
    local s = math.floor(n % 60)
    local str
    if h > 0 then
        str = string.format("%d:%02d:%02d", h, m, s)
    else
        str = string.format("%d:%02d", m, s)
    end
    return str
end

-- 数组操作
function array_equal(t, t2)
    for i, v in ipairs(t) do
        if v ~= t2[i] then return false end
    end
    return true
end

function array_merge(array1, array2)
    local ret = {}
    for i = 1, #array1 do
        table.insert(ret, array1[i])
    end
    for i = 1, #array2 do
        table.insert(ret, array2[i])
    end
    return ret
end

function array_copy(ar)
    return array_merge({}, ar)
end

function array_sub(ar, st, ed)
    local r = {}
    for i = st, ed do
        table.insert(r, ar[i])
    end
    return r
end

function array_unique(array)
    local r = {}
    local s = {}
    for _, v in ipairs(array) do
        if not s[v] then
            s[v] = true
            table.insert(r, v)
        end
    end
    return r
end

function array_new(len, val)
    local r = {}
    for i = 1, len do
        table.insert(r, val)
    end
    return r
end

function array_number(len)
    local r = {}
    for i = 1, len do
        table.insert(r, i)
    end
    return r
end

function array_find(t, val)
    for i, v in ipairs(t) do
        if val == v then return i end
    end
    return -1
end

function array_insert(t, val)
    if array_find(t, val) == -1 then
        table.insert(t, val)
    end
end

function array_delete(t, val)
    local ix = array_find(t, val)
    if ix > -1 then
        table.remove(t, ix)
    end
end

function array_find_in_field(t, field, val)
     for i, v in ipairs(t) do
        if val == v[field] then return i end
    end
    return -1
end

function array_find_obj_in_field(t, field, val)
    for i, v in ipairs(t) do
        if val == v[field] then return v end
    end
    return nil
end

function array_reverse(t)
    local ret = {}
    for i= #t, 1, -1  do
        table.insert(ret, t[i])
    end
    return ret
end

function array_random(t, num)
    if num >= #t then return array_copy(t) end
    local ret = {}
    local ixs = {}
    for i = 1, num do
        local r = math.random(#t)
        while array_find(ixs, r) > -1 do
            r = math.random(#t)
        end
        table.insert(ixs, r)
        table.insert(ret, t[r])
    end
    return ret
end

function array_resort(t)
    for i = 1, #t do
        local r = math.random(#t)
        t[i], t[r] = t[r], t[i]
    end
end

function array_compare(t1, t2)
    local n = 0
    for _, v1 in ipairs(t1) do
        for _, v2 in ipairs(t2) do
            if v1 == v2 then
                n = n + 1
                break
            end
        end
    end
    return n
end

-- 表格操作
function table_size(t)
    local r = 0
    for _, _ in pairs(t) do r = r + 1 end
    return r
end

function table_empty(t)
    return not next(t)
end

function table_merge(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
    return dest
end

function table_find(t, val)
    for k, v in pairs(t) do
        if val == v then return k end
    end
    return nil
end

function table_remove(t, val)
    local k = table_find(t, val)
    if k then
        t[k] = nil
    end
end

function table_equal(t, t2)
    local n = 0
    for k, v in pairs(t) do
        if v ~= t2[k] then return false end
        n = n + 1
    end
    return n == table_size(t2)
end

function table_copy(t)
    return table_merge({}, t)
end

function table_keys(t)
    local r = {}
    for k, _ in pairs(t) do
        table.insert(r, k)
    end
    return r
end

function table_values(t)
    local r = {}
    for _, v in pairs(t) do
        table.insert(r, v)
    end
    return r
end

function table_filter(t, func)
    local r = {}
    for k, v in pairs(t) do
        if func(k, v) then r[k] = v end
    end
    return r
end

function table_random(t, num)
    local ar = table_values(t)
    return array_random(ar, num)
end

function table_from_key(t, key, value)
    local r = {}
    for k, v in pairs(t) do
        if v[key] == value then table.insert(r, v) end
    end
    return r
end

function table_map(t, func)
    local r = {}
    for k, v in pairs(t) do
        local nk, nv = func(k, v)
        r[nk] = nv
    end
    return r
end

function table_requal(t, t2)
    local n = 0
    for k, v in pairs(t) do
        if type(v) == 'table' then
            local v2 = t2[k]
            if type(v2) ~= 'table' then return false end
            if not table_requal(v, v2) then return false end
        else
            if v ~= t2[k] then return false end
        end
        n = n + 1
    end
    return n == table_size(t2)
end

function table_rcopy(t)
    local r = {}
    for k, v in pairs(t) do
        if type(v) == 'table' then
            r[k] = table_rcopy(v)
        else
            r[k] = v
        end
    end
    return r
end

function table_filt_array(t)
    local ar = {}
    for i, v in pairs(t) do
        i = tonumber(i)
        if i then
            ar[i] = v
        end
    end
    return ar
end

-- 字符串
function string_split(str, delim, maxNb)      
    if string.find(str, delim) == nil then  
        return { str }  
    end  
    if maxNb == nil or maxNb < 1 then  
        maxNb = 0    -- No limit   
    end  
    local result = {}  
    local pat = "(.-)" .. delim .. "()"   
    local nb = 0  
    local lastPos   
    for part, pos in string.gfind(str, pat) do  
        nb = nb + 1  
        result[nb] = part   
        lastPos = pos   
        if nb == maxNb then break end  
    end  
    -- Handle the last field   
    if nb ~= maxNb then  
        result[nb + 1] = string.sub(str, lastPos)   
    end  
    return result   
end  

function string_startswith(str, prefix)
    return string.find(str, prefix) == 1
end

function string_endswith(str, suffix)
    return string_startswith(string.reverse(str), string.reverse(suffix))
end

function string_trim(s)
    local first = string.find(s, '%S')
    if not first then return '' end
    local last = string.find(string.reverse(s), '%S')
    return string.sub(s, first, #s + 1 - last)
end

local earthRadius = 6378.137;						--地球半径 

function GetRad(d)
	return d * math.pi / 180;  
end  
 
--根据经纬度 
function GetDistance(lat1, lng1, lat2, lng2)  
 
   local radLat1 = GetRad(lat1);  
   local radLat2 = GetRad(lat2);  
   local a = radLat1 - radLat2;  
   local b = GetRad(lng1) - GetRad(lng2);  
  
   local distance = 2 * math.asin(math.sqrt(math.pow(math.sin(a/2),2) +  
   math.cos(radLat1)*math.cos(radLat2)*math.pow(math.sin(b/2),2)));  
   distance = distance * earthRadius;  
   distance = math.ceil(distance * 10000) / 10000;  
   distance = math.floor(distance * 100) / 100
   return distance;  
end

--@brief 切割字符串，并用“...”替换尾部
 --@param sName:要切割的字符串
 --@return nMaxCount，字符串上限,中文字为2的倍数
 --@param nShowCount：显示英文字个数，中文字为2的倍数,可为空
 --@note         函数实现：截取字符串一部分，剩余用“...”替换
function GetShortName(sName)
	local nMaxCount = 8
	local nShowCount = 8
     if sName == nil or nMaxCount == nil then
         return
     end
     local sStr = sName
     local tCode = {}
     local tName = {}
     local nLenInByte = #sStr
     local nWidth = 0
     if nShowCount == nil then
        nShowCount = nMaxCount - 3
     end
     for i=1,nLenInByte do
         local curByte = string.byte(sStr, i)
         local byteCount = 0
         if curByte>0 and curByte<=127 then
             byteCount = 1
         elseif curByte>=192 and curByte<223 then
             byteCount = 2
         elseif curByte>=224 and curByte<239 then
             byteCount = 3
         elseif curByte>=240 and curByte<=247 then
             byteCount = 4
         end
         local char = nil
         if byteCount > 0 then
             char = string.sub(sStr, i, i+byteCount-1)
             i = i + byteCount -1
         end
         if byteCount == 1 then
             nWidth = nWidth + 1
             table.insert(tName,char)
             table.insert(tCode,1)
             
        elseif byteCount > 1 then
             nWidth = nWidth + 2
             table.insert(tName,char)
             table.insert(tCode,2)
         end
     end
     
    if nWidth > nMaxCount then
         local _sN = ""
         local _len = 0
         for i=1,#tName do
             _sN = _sN .. tName[i]
             _len = _len + tCode[i]
             if _len >= nShowCount then
                 break
             end
         end
         sName = _sN .. ".."
     end
     return sName
 end