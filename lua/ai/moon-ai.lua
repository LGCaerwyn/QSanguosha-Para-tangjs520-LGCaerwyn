sgs.ai_skill_invoke.LuaPiaoxian = function(self, data)
	local move = data:toMoveOneTime()
	local to
	local cur = self.room:getCurrent()
	if not move.from or move.from:objectName() ~= self.player:objectName() then return false end
	if not cur or cur:isDead() then return false end
	if not move.to then return true end
	if move.to then to = findPlayerByObjectName(self.room, move.to:objectName()) end
	if self:isFriend(to) then return false end
	return true
end

sgs.ai_skill_choice.LuaGuxi = function(self, choices, data)
	local target = data:toPlayer()
	local str = choices
	if not target or target:isDead() then return "cancel" end
	if self:isFriend(target) then 
		if self:needToThrowArmor(target) and target:getArmor() and string.find(str, "discard") then return "discard" end
		if self:needKongcheng(target, true) and self:doNotDiscard(target) and string.find(str, "discard") then return "discard" end
		if self:needKongcheng(target, true) then return "cancel" end
		return "draw" 
	else
		if self:doNotDiscard(target) then return "cancel" end
		if string.find(str, "discard") then return "discard" end
	end
	return "cancel" 
end