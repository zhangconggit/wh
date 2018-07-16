CHData = {
--角色类型
CharacterType = {
    Library     = 1,
    Player      = 2,
    ComputerOne = 3,
    ComputerTwo = 4,
    Desk        = 5
},

--花色
Suits = {
    Club        = 1,
    Diamond     = 2,
    Heart       = 3,
    Spade       = 4,
    None        = 5
},

--卡牌权值
Weight = {
    Three       = 3,
    Four        = 4,
    Five        = 5,
    Six         = 6,
    Seven       = 7,
    Eight       = 8,
    Nine        = 9,
    Ten         = 10,
    Jack        = 11,
    Queen       = 12,
    King        = 13,
    One         = 14,
    Two         = 15,
},
--出牌类型
CardsType = {
    --未知类型
    None            = 1,
    --AAA炸
    AAABoom         = 2,
    --炸弹
    Boom            = 3,
    --三个不带
    OnlyThree       = 4,
    --三个带一
    ThreeAndOne     = 5,
    --三个带二
    ThreeAndTwo     = 6,
    --四带二
    FourAndTwo      = 7,
    --四带一对
    FourAndDouble   = 8,
    --顺子 五张或更多的连续单牌
    Straight        = 9,
    --连对 三对或更多的连续对牌
    DoubleStraight  = 10,
    --飞机 二个或更多的连续三张牌
    TripleStraight  = 11,
    --飞机带单牌
    TripleStraightAndOne = 12,
    --飞机带对子
    TripleStraightAndTwo = 13,
    --对子
    Double          = 14,
    --单个
    Single          = 15
},

--存储数据类型
GameData = {
    playerIntegration = 0,
    computerOneIntegration = 0,
    computerTwoIntegration = 0,
},
}

--手牌数组排序
function CHData:SortCards(listCards,ascending)
    table.sort( listCards,function(a,b)
        if not ascending then
            --先按权重降序，再按花色升序
            if a.weight == b.weight then  
                return a.color < b.color  
            end  
            
            return a.weight > b.weight 
        else
            --权重升序
            return a.weight < b.weight
        end
    end)
end


--提示算法 根据上家出的牌得到自己手上能够出的牌 
function CHData:GetTips(cards, outCards, cardsType)
  local tmpOutCards = outCards
  local playCards = {}
  if #tmpOutCards == 0 then
    playCards = self:Tips(cards)
    return playCards
  end
  local arr = self.CardsType
  if cardsType == arr.Single then
    playCards = self:SingleTip(cards, tmpOutCards)

  elseif cardsType == arr.Double then
    playCards = self:DoubleTip(cards, tmpOutCards)

  elseif cardsType == arr.OnlyThree then
    playCards = self:ThreeTip(cards, tmpOutCards)

  elseif cardsType == arr.ThreeAndTwo or cardsType == arr.ThreeAndOne then
    playCards = self:ThreeTakeTip(cards, tmpOutCards)

  elseif cardsType == arr.FourAndTwo or cardsType == arr.FourAndDouble then
   playCards =  self:TourTakeTip(cards, tmpOutCards)

  elseif cardsType == arr.Straight then
    playCards = self:ConnectTip(cards, tmpOutCards)

  elseif cardsType == arr.DoubleStraight then
    playCards = self:CompanyTip(cards, tmpOutCards)

  elseif cardsType == arr.TripleStraight then
    playCards = self:AircraftTip(cards, tmpOutCards)

  elseif cardsType == arr.TripleStraightAndOne or cardsType == arr.TripleStraightAndTwo then
    playCards = self:AircraftTakeTip(cards, tmpOutCards)

  elseif cardsType == arr.Boom then
    playCards = self:BombTip(cards, tmpOutCards)
  else 
    return {}
  end
  return playCards
end


-- 没有上家牌的时候 提示
function CHData:Tips(cards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local playCards = {}
  local tmpConnect = self:GetConnect(cards)
  for k,v in pairs(tmpConnect) do
    playCards[#playCards + 1] = v
  end
  for i = 1, #threeCards do
    playCards[#playCards + 1] = threeCards[i]
  end
  for i = 1, #twoCards do
    playCards[#playCards + 1] = twoCards[i]
  end
    for i = 1, #oneCards do
    playCards[#playCards + 1] = oneCards[i]
  end
  for i = 1, #fourCards do
    playCards[#playCards + 1] = fourCards[i]
  end
  for i = 1, #AAABomb do
    playCards[#playCards + 1] = AAABomb[i]
  end
  return  playCards
end

--将牌按 牌值分类 单牌 对子 三个 四个 分类
--return oneCards, twoCards, threeCards, fourCards
function CHData:GetAllType(cards)
  local tmpcards = self:CopyTab(cards)
  local AAABomb, fourCards, oneCards, twoCards, threeCards = {}, {}, {}, {}, {}


  if #cards >=3 then
    --将2移除
    if cards[1].weight == 15 then
        table.remove(tmpcards,1)
    end
    if cards[1].weight == 14 and cards[2] == 14 and cards[3] == 14 then
      AAABomb = {116, 117}
    end
    tmpcards = self:SubTable(cards, AAABomb)
  end
  for i = 1, #tmpcards - 4 do
    if self:GetValue(tmpcards[i]) == self:GetValue(tmpcards[i + 1]) and self:GetValue(tmpcards[i]) == self:GetValue(tmpcards[i + 2]) 
      and self:GetValue(tmpcards[i]) == self:GetValue(tmpcards[i + 3]) then
      fourCards[#fourCards + 1] = {tmpcards[i], tmpcards[i + 1], tmpcards[i + 2], tmpcards[i + 3]}
    end
  end
  for k,v in pairs(fourCards) do
    tmpcards = self:SubTable(tmpcards, v)
  end
  for i = 1, #tmpcards - 2 do
    if self:GetValue(tmpcards[i]) == self:GetValue(tmpcards[i + 1]) and self:GetValue(tmpcards[i]) == self:GetValue(tmpcards[i + 2])then
      threeCards[#threeCards + 1] = {tmpcards[i], tmpcards[i + 1], tmpcards[i + 2]}
    end
  end
  for k,v in pairs(threeCards) do
    tmpcards = self:SubTable(tmpcards, v)
  end
  for i = 1, #tmpcards - 1 do
    if self:GetValue(tmpcards[i]) == self:GetValue(tmpcards[i + 1]) then
      twoCards[#twoCards + 1] = {tmpcards[i], tmpcards[i + 1]}
    end
  end
  for k,v in pairs(twoCards) do
    tmpcards = self:SubTable(tmpcards, v)
  end
  for i = 1, #tmpcards do
    oneCards[#oneCards + 1] = {tmpcards[i]}
  end
  -- for k,v in pairs(threeCards) do
  --   for k,v in pairs(v) do
  --     print(k,v)
  --   end
  -- end
  oneCards = self:AscendingTable(oneCards)
  twoCards = self:AscendingTable(twoCards)
  threeCards = self:AscendingTable(threeCards)
  fourCards = self:AscendingTable(fourCards)
  return oneCards, twoCards, threeCards, fourCards, AAABomb
end

function CHData:SubTable(tab1, tab2)
  local tmpcards = self:CopyTab(tab1)
  for k,v in pairs(tab2) do
      for i = 1, #tmpcards do
        if tmpcards[i] == tab2[k] then
          table.remove(tmpcards, i)
        end
      end
  end
  return tmpcards
end

--将table里面的元素倒过来
function CHData:AscendingTable(table)
  local tmp = {}
  for i = #table, 1, -1 do
    tmp[#tmp + 1] = table[i]
  end
  return tmp
end

function CHData:GetCardsTabValue(cards)
  local tmp = {}
  for k, v in pairs(cards or {}) do
    print(v)
        if type(v) ~= "table" then
            tmp[k] = v % 100
        else
            tmp[k] = self:GetCardsTabValue(v)
        end
    end
  return tmp 
end

-- 自定义复制table函数
function CHData:CopyTab(st)
    local tab = {}
    for k, v in pairs(st or {}) do
        if type(v) ~= "table" then
            tab[k] = v
        else
            tab[k] = self:CopyTab(v)
        end
    end
    return tab
end

--获得扑克牌的牌值
function CHData:GetValue(card)
  return card.weight
end

-- 得到顺子
function CHData:GetConnect(cards)
  self:SortCards(cards)
  local tmpcards,playCards = {}, {}
  for i = 1, #cards - 1 do
    if i == 1 then
      tmpcards[#tmpcards + 1] = cards[i] 
    elseif i ~= 1 and self:GetValue(cards[i]) ~= self:GetValue(cards[i - 1]) then 
      tmpcards[#tmpcards + 1] = cards[i] 
    end
  end
  
  for i = #tmpcards, 5, -1 do
    for j = 1, #tmpcards - i do
      local tmp = {}
      for k = 1, i do
        tmp[#tmp + 1] = tmpcards[k + j]
      end
      if self:IsConnect(self:GetCardsTabValue(tmp)) then
          playCards[#playCards + 1] = copyTab(tmp)
      end 
    end
  end
  return playCards
end

--加入AAA炸弹
function CHData:AddBomb(playCards,fourCards,aaaBomb)
  for i = 1, #fourCards do
    playCards[#playCards + 1] = fourCards[i]
  end
  if #aaaBomb == 3 then
    playCards[#playCards + 1] = aaaBomb
  end
end

--单牌提示算法  cards 手上有的牌 outcards 已经打出的牌 playcards 要出的牌
function CHData:SingleTip(cards, outCards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local playCards = {}
  for k,v in pairs(oneCards) do
    if self:GetValue(v[1]) > self:GetValue(outCards[1]) then
      playCards[#playCards + 1] = v
    end
  end
  for k,v in pairs(twoCards) do
    if self:GetValue(v[1]) > self:GetValue(outCards[1]) then
      playCards[#playCards + 1] = {v[1]}
    end
  end
  for k,v in pairs(threeCards) do
    if self:GetValue(v[1]) > self:GetValue(outCards[1]) then
      playCards[#playCards + 1] = {v[1]}
    end
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  -- for k,v in pairs(playCards) do
  --   for k,v in pairs(v) do
  --     print(k,v)
  --   end
  -- end
  return playCards
end

--对子提示算法 cards 手上有的牌 outcards 已经打出的牌 playcards 要出的牌
function CHData:DoubleTip(cards, outCards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local playCards = {}
  for k,v in pairs(twoCards) do
    if self:GetValue(v[1]) > self:GetValue(outCards[1]) then
      playCards[#playCards + 1] = v
    end
  end
  for k,v in pairs(threeCards) do
    if self:GetValue(v[1]) > self:GetValue(outCards[1]) then
      playCards[#playCards + 1] = {v[1],v[2]}
    end
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  -- for k,v in pairs(playCards) do
  --   for k,v in pairs(v) do
  --     print(k,v)
  --   end
  -- end
  return playCards
end

--三不带提示算法 
function CHData:ThreeTip(cards, outCards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local playCards = {}
  for k,v in pairs(threeCards) do
    if self:GetValue(v[1]) > self:GetValue(outCards[1]) then
      playCards[#playCards + 1] = v
    end
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  return playCards
end

--炸弹提示算法 
function CHData:BombTip(cards, outCards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local playCards = {}
  for k,v in pairs(fourCards) do
    if self:GetValue(v[1]) > self:GetValue(outCards[1]) then
      playCards[#playCards + 1] = v
    end
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  return playCards
end

-- 先从手上的牌里面得到各种牌值的一个牌（如｛103,105, 205, 305, 106, 206, 306｝｛103，205，206，｝）
-- 再从得到的牌组合出和outcards牌数一样的牌，再判断 组合出的牌是否是顺子
function CHData:ConnectTip(cards, outCards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local j = 1
  local playCards = {}
  local len = #outCards
  local tmpcards = {}
  for i = 1, #cards do
    if i == 1 then
      tmpcards[j] = cards[i] 
      j = j + 1
    elseif self:GetValue(outCards[len]) < self:GetValue(cards[i]) and self:GetValue(cards[i]) ~= self:GetValue(cards[i - 1]) then 
      tmpcards[j] = cards[i] 
      j = j + 1
    end
  end
  
  for i = 1, #tmpcards do
    local tmp = {}
    for k = 1, len do
      if (i + len - 1) <= #tmpcards then
        tmp[k] = tmpcards[i + k - 1]
      end
    end
    -- tmp = self:GetCardsTabValue(tmp)
    if self:IsConnect(self:GetCardsTabValue(tmp)) then
      playCards[#playCards + 1] = copyTab(tmp)
    end 
  end
  playCards = self:AscendingTable(playCards)
  self:AddBomb(playCards, fourCards, AAABomb)
  -- for k,v in pairs(playCards) do
  --   for k,v in pairs(v) do
  --     print(k,v)
  --   end
  -- end
  return playCards
end

--顺子 
function CHData:IsConnect(cards)
  if 5 > #cards then 
      return false
  end
  table.sort(cards)
  --2不能加入顺子
  if cards[#cards] > 14 then
    return false
  end
  for i = 1, (#cards - 1) do
    if cards[i] ~= cards[i+1] -1 then
      return false
    end
  end
  return true
end

-- 连对
function CHData:IsCompany(cards)
  if 6 > #cards or (#cards % 2) ==1 then 
      return false
  end
  self:SortCards(cards)
  local len = #cards
  for i = 1, (len - 1) do
    if (i % 2) ==1 then
      if cards[i] ~= cards[i + 1]  then
        return false
      end 
    else
      if cards[i] ~= cards[i + 1] - 1 then
        return false
      end
    end
  end
  return true
end

-- 飞机不带  
-- 遍历到三个一组中的第一个的时候判断这组的值是否都相等
-- 遍历到三个一组中的最后一个的时候判断和下一组的数值是不是差一
function CHData:IsAircraft(cards)
    if 6 > #cards or (#cards % 3) ~=0 then 
        return false
    end 
    self:SortCards(cards)
    local len = #cards
    for i = 1, (len - 1) do
        if (i % 3) ==1 then
            if cards[i] ~= cards[i + 1] or cards[i + 1] ~= cards[i + 2] then
                return false
            end 
        elseif (i % 3) == 0 then
            if cards[i] ~= cards[i + 1] - 1 then
                return false
            end
        end
    end
    return true 
end

--对子提示算法和顺子提示算法类似
function CHData:CompanyTip(cards, outCards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local j = 1
  local playCards = {}
  local len = #outCards / 2
  local tmpcards = {}
  for i = 1, #cards - 1 do
    if i == 1 then
      if self:GetValue(cards[i]) == self:GetValue(cards[i + 1]) and self:GetValue(outCards[1]) < self:GetValue(cards[i]) then
        tmpcards[j] = {cards[i], cards[i + 1]} 
        j = j + 1
      end
    elseif self:GetValue(outCards[#outCards]) < self:GetValue(cards[i]) and self:GetValue(cards[i]) ~= self:GetValue(cards[i - 1])  
      and self:GetValue(cards[i]) == self:GetValue(cards[i + 1])   then 
      tmpcards[j] = {cards[i], cards[i + 1]} 
      j = j + 1
    end
  end
  for i = 1, #tmpcards do
    local tmp = {}
    for k = 1, len do
      if (i + len - 1) <= #tmpcards  then
        tmp[#tmp + 1] = tmpcards[i + k - 1][1]
        tmp[#tmp + 1] = tmpcards[i + k - 1][2]
      end
    end
    if self:IsCompany(self:GetCardsTabValue(tmp)) then
      playCards[#playCards + 1] = tmp
    end 
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  return playCards
end

--飞机不带提示算法 
function CHData:AircraftTip(cards, outCards)
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local j = 1
  local playCards = {}
  local len = #outCards / 3
  local tmpcards = {}
  for i = 1, #cards - 2 do
    if i == 1 then
      if self:GetValue(cards[i]) == self:GetValue(cards[i + 1]) and self:GetValue(cards[i]) == self:GetValue(cards[i + 2]) then
        tmpcards[j] = {cards[i], cards[i + 1], cards[i + 2]} 
        j = j + 1
      end
    elseif self:GetValue(outCards[#outCards]) < self:GetValue(cards[i]) and self:GetValue(cards[i]) ~= self:GetValue(cards[i - 1])  
      and self:GetValue(cards[i]) == self:GetValue(cards[i + 1]) and self:GetValue(cards[i]) == self:GetValue(cards[i + 2]) then 
      tmpcards[j] = {cards[i], cards[i + 1], cards[i + 2]} 
      j = j + 1
    end
  end
  for i = 1, #tmpcards do
    local tmp = {}
    for k = 1, len do
      if (i + len - 1) <= #tmpcards  then
        tmp[#tmp + 1] = tmpcards[i + k - 1][1]
        tmp[#tmp + 1] = tmpcards[i + k - 1][2]
        tmp[#tmp + 1] = tmpcards[i + k - 1][3]
      end
    end
    if self:IsAircraft(self:GetCardsTabValue(tmp)) then
      playCards[#playCards + 1] = tmp
    end 
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  return playCards
end

-- 三带单牌和对子提示算法 
-- self:GetValue(cards[i]) ~= self:GetValue(cards[i - 1]) 使 cards［i］是每一种牌值的第一个 103，203，204，305，105  第一个103和305
function CHData:ThreeTakeTip(cards, outCards)
  local outCardsValue = 0
  for i = 1, 3 do
    if self:GetValue(outCards[i]) == self:GetValue(outCards[i + 1])then
      outCardsValue = self:GetValue(outCards[i])
    end
  end
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local playCards = {}
  for k,v in pairs(threeCards) do
    if self:GetValue(threeCards[k][1]) > outCardsValue then
      playCards[#playCards + 1] = threeCards[k]
    end
  end
  local takeCards = {}
  for i = 1, #playCards do
    if #outCards ==4 then
      takeCards = self:GetTakeSingle(cards, playCards[i], 1)
      playCards[i][4] = takeCards[1][1]
    else 
      takeCards = self:GetTakeDoubel(cards, playCards[i], 1)
      playCards[i][4] = takeCards[1][1]
      playCards[i][5] = takeCards[1][2]
    end
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  -- for k,v in pairs(playCards) do
  --   for k,v in pairs(v) do
  --     print(k,v)
  --   end
  -- end
  return playCards
end

-- 四带单牌和对子提示算法 
-- self:GetValue(cards[i]) ~= self:GetValue(cards[i - 1]) 使 cards［i］是每一种牌值的第一个 103，203，204，305，105  第一个103和305
function CHData:FourTakeTip(cards, outCards)
  local outCardsValue = 0
  for i = 1, #outCards - 2 do
    if self:GetValue(outCards[i]) == self:GetValue(outCards[i + 1]) 
      and self:GetValue(outCards[i]) == self:GetValue(outCards[i + 2]) then
      outCardsValue = self:GetValue(outCards[i])
    end
  end
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)
  local playCards = {}
  for k,v in pairs(fourCards) do
    if self:GetValue(fourCards[k][1]) > outCardsValue then
      playCards[#playCards + 1] = copyTab(fourCards[k])
    end
  end
  local takeCard = {}
  for i = 1, #playCards do
    if #outCards ==6 then
      takeCard = self:GetTakeSingle(cards, playCards[i], 2)
      if not takeCard then
        return 
      end
      playCards[i][5] = takeCard[1][1]
      playCards[i][6] = takeCard[2][1]
    else 
      takeCard = self:GetTakeDoubel(cards, playCards[i], 2)
      if not takeCard then
        return 
      end
      playCards[i][5] = takeCard[1][1]
      playCards[i][6] = takeCard[1][2]
      playCards[i][7] = takeCard[2][1]
      playCards[i][8] = takeCard[2][2]
    end
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  return playCards
end

--飞机带牌提示算法 
function CHData:AircraftTakeTip(cards, outCards)
  local j = 1
  local playCards = {}
  local len = 0
  local isTakeSingel = true
  if #outCards % 4 == 0 then
    len = #outCards / 4
    isTakeSingel = true
  elseif #outCards % 5 == 0 then
    len = #outCards / 5 
    isTakeSingel = false
  end
  local outCardsValue = 0
  for i = 1, #outCards - 2 do
    if self:GetValue(outCards[i]) == self:GetValue(outCards[i + 1]) 
      and self:GetValue(outCards[i]) == self:GetValue(outCards[i + 2]) then
      outCardsValue = self:GetValue(outCards[i])
    end
  end
  local oneCards, twoCards, threeCards, fourCards, AAABomb = self:GetAllType(cards)

  for i = #threeCards, 1, -1 do
    local tmp = {}
    for k = 1, len do
      if (i + len - 1) <= #threeCards  then
        tmp[#tmp + 1] = threeCards[i + k - 1][1]
        tmp[#tmp + 1] = threeCards[i + k - 1][2]
        tmp[#tmp + 1] = threeCards[i + k - 1][3]
      end
    end
    if self:IsAircraft(self:GetCardsTabValue(tmp)) and outCardsValue < self:GetValue(tmp[1]) then
      playCards[#playCards + 1] = tmp
    end 
  end
local takeCard = {}
  if isTakeSingel then
    takeCards = self:GetTakeSingle(cards, playCards, len)
    if not takeCard then
      return 
    end
    for j = 1, #playCards do
      for i = 1, len do
        playCards[j][6 + i] = takeCards[i][1]
      end
    end
  else 
    takeCards = self:GetTakeDoubel(cards, playCards, len)
    if not takeCard then
      return 
    end
    for j = 1, #playCards do
      for i = 1, len do
        playCards[j][6 + i] = takeCards[i][1]
        playCards[j][8 + i] = takeCards[i][2]
      end
    end
  end
  self:AddBomb(playCards, fourCards, AAABomb)
  -- for k,v in pairs(playCards) do
  --   for k,v in pairs(v) do
  --     print(k,v)
  --   end
  -- end
  return playCards
end

--得到带的单牌 cards手上有的牌 playcards 将要出的牌
function CHData:GetTakeSingle(cards,playCards, count)
  sortPoker(cards)
  local takeCards = {}
  local oneCards, twoCards, threeCards, fourCards = getAllType(cards)
  --这里是因为不想修改原来的代码所以又倒过来一次
  oneCards = self:AscendingTable(oneCards)
  twoCards = self:AscendingTable(twoCards)
  threeCards = self:AscendingTable(threeCards)
  fourCards = self:AscendingTable(fourCards)
  if #oneCards >= count then
    for i = count , 1, -1 do
      takeCards[#takeCards + 1] = oneCards[#oneCards - i + 1]
    end
  elseif #oneCards < count and (#oneCards + #twoCards) >= count then
    for i = #oneCards, 1, -1 do
      takeCards[#takeCards + 1] = oneCards[i][1]
    end
    for i = count + #twoCards -#oneCards, 1, -1 do
      takeCards[#takeCards + 1] = twoCards[i]
      takeCards[#takeCards + 1] = twoCards[i + 1]
    end
  elseif (#oneCards + #twoCards) < count and (#oneCards + #twoCards + #threeCards) >= count then
    for i = #oneCards, 1, -1 do
      takeCards[i] = oneCards[i][1]
    end
    for i = #twoCards + #oneCards, 1, -1 do
      takeCards[#takeCards + 1] = twoCards[i]
      takeCards[#takeCards + 1] = twoCards[i + 1]
    end
    for i = count + #threeCards - #twoCards - #oneCards , 1, -1 do
      takeCards[#takeCards + 1] = threeCards[i]
      takeCards[#takeCards + 1] = threeCards[i + 1]
      takeCards[#takeCards + 1] = threeCards[i + 2]
    end
  else 
    return nil
  end
  -- for k,v in pairs(takeCards) do
  --   print(k,v)
  -- end
  local tmpTakeCards = {}
  for i = count, 1, -1 do
    tmpTakeCards[#tmpTakeCards + 1] = takeCards[i]
  end
  takeCards = tmpTakeCards
  return takeCards
end

--得到带的对子 cards手上有的牌 playcards 将要出的牌
function CHData:GetTakeDoubel(cards, playCards, count)
  sortPoker(cards)
  local takeCards = {}
  local oneCards, twoCards, threeCards, fourCards = getAllType(cards)
  oneCards = self:AscendingTable(oneCards)
  twoCards = self:AscendingTable(twoCards)
  threeCards = self:AscendingTable(threeCards)
  fourCards = self:AscendingTable(fourCards)
  if not twoCards then
    return 
  end
  if  #twoCards >= count then
    for i = #twoCards, 1, -1 do
      takeCards[#takeCards + 1] = {twoCards[i][1], twoCards[i][2]}
    end
  elseif #twoCards < count and (#twoCards + #threeCards) >= count then
    for i = #twoCards, 1, -1 do
      takeCards[#takeCards + 1] = {twoCards[i], twoCards[i + 1]}
    end
    for i = #threeCards, 1, -1 do
      takeCards[#takeCards + 1] = {threeCards[i], threeCards[i + 1]}
    end
  else 
    return nil
  end
  local tmpTakeCards = {}
  for i = count, 1, -1 do
    tmpTakeCards[#tmpTakeCards + 1] = takeCards[i]
  end
  takeCards = tmpTakeCards
  return takeCards
end