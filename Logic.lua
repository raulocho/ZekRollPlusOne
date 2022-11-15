--[[ 
	Will allow us to create timers to track buff and debuff durations.
	Timers can be set to icon or timer bar mode.
--]]

----------------------
-- Namespaces
----------------------
local _, core = ...;
core.Management = {};
core.Members ={};
local Management = core.Management;

----------------------
-- Timer functions
----------------------
--[[
	Should return an instance of a Timer (using metatables).
	A "static" function.
--]]

StaticPopupDialogs["CONFIRM_RESET"] = {
	text = "Are you sure you want reset the information?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		Management.FullReset()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  
}

Management.Reset=function()
	StaticPopup_Show ("CONFIRM_RESET")
end

Management.FullReset=function()
	core.Members ={};
	for i=1, 40,1 
		do
			core.Config.UIConfig.TextsMain[i]:SetText("---");
			core.Config.UIConfig.TextsOff[i]:SetText("---");
			core.Config.UIConfig.TextsMain[i]:SetTextColor(0.85,0.82,0.30,1);
			core.Config.UIConfig.TextsOff[i]:SetTextColor(0.85,0.82,0.30,1);
			core.Config.UIConfig.TextsCounterMain[i]:SetText("0");
			core.Config.UIConfig.TextsCounterOff[i]:SetText("0");
			ZekRollPlusOneDB={};
		end
end

--[[2
	Should update the duration of the timer using events.
--]]
Management.Save= function ()
	print("hellof");
end

--[[
	Destroy the timer after it has expired (recylce it).
--]]
Management.Export=function()

end

--[[
	Import all raid members for start counting.
--]]
Management.Start=function()
	if (#ZekRollPlusOneDB==0 and #core.Members==0) then
		local numMembers = GetNumGroupMembers(1);
		local members={};
		local name, rank, subgroup, level, class, fileName,zone, online, isDead, role, isML,combatRole;
		
		for i=1, numMembers,1
		do
			local member={};
			name, rank, subgroup, level, class, fileName,zone, online, isDead, role, isML,combatRole = GetRaidRosterInfo(i);
			member.name=name;
			member.class=class;
			member.mainCount=0;
			member.offSpectCount=0;
			members[i]=member;
			core.Config.UIConfig.TextsMain[i]:SetText(name);
			core.Config.UIConfig.TextsOff[i]:SetText(name);
			core.Config:ApplyClassColor(core.Config.UIConfig.TextsMain[i],core.Config.UIConfig.TextsOff[i],class);
		end
		
		core.Members=members;
		ZekRollPlusOneDB= members;
	
	elseif (#ZekRollPlusOneDB>0 and #core.Members==0) then
		for i=1, #ZekRollPlusOneDB,1
		do
			core.Config.UIConfig.TextsMain[i]:SetText(ZekRollPlusOneDB[i].name);
			core.Config.UIConfig.TextsOff[i]:SetText(ZekRollPlusOneDB[i].name);
			core.Config.UIConfig.TextsCounterMain[i]:SetText(ZekRollPlusOneDB[i].mainCount)
			core.Config.UIConfig.TextsCounterOff[i]:SetText(ZekRollPlusOneDB[i].offSpectCount)
			core.Config:ApplyClassColor(core.Config.UIConfig.TextsMain[i],core.Config.UIConfig.TextsOff[i],ZekRollPlusOneDB[i].class);
			core.Members=ZekRollPlusOneDB;
		end

	else
		local numMembers = GetNumGroupMembers(1);
		local members=core.Members;
		local name, rank, subgroup, level, class, fileName,zone, online, isDead, role, isML,combatRole;
		
		for i=1, numMembers,1
		do
			name, rank, subgroup, level, class, fileName,zone, online, isDead, role, isML,combatRole = GetRaidRosterInfo(i);
			
			if (Exists(core.Members,name)==false) then
				print(class);
				local member={};
				member.name=name;
				member.class=class;
				member.mainCount=0;
				member.offSpectCount=0;
				members[#members+1]=member;
				core.Config.UIConfig.TextsMain[#members]:SetText(name);
				core.Config.UIConfig.TextsOff[#members]:SetText(name);
				core.Config:ApplyClassColor(core.Config.UIConfig.TextsMain[#members],core.Config.UIConfig.TextsOff[#core.Members],class);
			end

		end
		
		core.Members=members;
		ZekRollPlusOneDB= members;

	end
end

Management.AddOne=function(self)
	local index=self:GetID()

	if (self:GetAttribute("type")=="mainSpect") then
		core.Members[index].mainCount=core.Members[index].mainCount+1;
		core.Config.UIConfig.TextsCounterMain[index]:SetText(core.Members[index].mainCount);
	else
		core.Members[index].offSpectCount=core.Members[index].offSpectCount+1
		core.Config.UIConfig.TextsCounterOff[index]:SetText(core.Members[index].offSpectCount);
	end

end

Management.RemoveOne=function(self)
	local index=self:GetID();

	if (self:GetAttribute("type")=="mainSpect") then
		core.Members[index].mainCount=core.Members[index].mainCount-1;
		core.Config.UIConfig.TextsCounterMain[index]:SetText(core.Members[index].mainCount);
	else
		core.Members[index].offSpectCount=core.Members[index].offSpectCount-1
		core.Config.UIConfig.TextsCounterOff[index]:SetText(core.Members[index].offSpectCount);
	end

end

function Exists(members,member)
	for i=1, #members,1
	do
		if (members[i].name==member)
		then
			return true
		end
	end

	return false
end