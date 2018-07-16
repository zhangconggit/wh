GameUtil = {}

local this      = GameUtil;

--??è????ò             --μ±?°?÷òy￡?è?êy￡?ê?·??3ê±??￡?
function GameUtil.GetNext(curIndex,maxNum,isCW)
	
	if isCW == false then
		if curIndex == maxNum then
			return 1;
		end
		
		curIndex = curIndex + 1;
		return curIndex;
	end
	
	if curIndex == 1 then
		return maxNum;
	end
	
	curIndex = curIndex - 1;
	
	return curIndex;
	
end

--?3????￡?ó??òμ?????μ?????1??μ￡?
function GameUtil.getPosRelation(myIndex,targetIndex,isCW)
	if isCW == true then
		return this.getPosRelationCw(myIndex,targetIndex);
	else
		return this.getPosRelationAW(myIndex,targetIndex);
	end
end

--?3????￡?ó??òμ?????μ?????1??μ - ?3ê±???????÷òy￡?0￡??íê??òμ?????￡? 1￡?×ó±?￡?2óò±?￡?3????￡?
function GameUtil.getPosRelationCw(myIndex,targetIndex)
	
	if myIndex == targetIndex then
		return RelativePosition.Origin;
	end

	if targetIndex - myIndex == 1 then
		return RelativePosition.Left;
	end
	
	if myIndex - targetIndex == 1 then
		return RelativePosition.Right;
	end
	
	if  myIndex == 4 and targetIndex == 1 then
		return RelativePosition.Left;
	end	
	
	if myIndex == 1  and targetIndex == 4 then
		return RelativePosition.Right;
	end
	
	if math.abs(myIndex - targetIndex) == 2 then
		return RelativePosition.Opposite;
	end 
end

--?3????￡?ó??òμ?????μ?????1??μ - ??ê±???????÷òy￡?0￡??íê??òμ?????￡? 1￡?×ó±?￡?2óò±?￡?3????￡?
function GameUtil.getPosRelationAW(myIndex,targetIndex)
	
	if myIndex == targetIndex then
		return RelativePosition.Origin;
	end
	
	if myIndex == 4 and targetIndex == 1 then
		return RelativePosition.Right;
	end
	
	if myIndex == 1 and targetIndex == 4 then
		return RelativePosition.Left;
	end 
	
	if targetIndex - myIndex == 1 then
		return RelativePosition.Right;
	end
	
	if myIndex - targetIndex == 1 then
		return RelativePosition.Left;
	end
	
	if math.abs(myIndex - targetIndex) == 2 then
		return RelativePosition.Opposite;
	end 
end