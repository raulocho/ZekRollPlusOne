--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...;
core.Config = {}; -- adds Config table to addon namespace

local Config = core.Config;
local UIConfig;

--------------------------------------
-- Defaults (usually a database!)
--------------------------------------
local defaults = {
	theme={r = 0, g = 0.8, b = 1, hex = "00ccff"},
	classColors={
			SHAMAN 		= {hex="2459FF",r=0.14,g=0.34,b=1},
			MAGE 		= {hex="69CCF0",r=0.41,g=0.8,b=0.94},
			WARLOCK 	= {hex="9482C9",r=0.58,g=0.50,b=0.78},
			HUNTER		= {hex="ABD473",r=0.67,g=0.83,b=0.45},
			ROGUE		= {hex="FFF569",r=1,g=0.96,b=0.41},
			PRIEST		= {hex="FFFFFF",r=1,g=1,b=1},
			DRUID 		= {hex="FF7D0A",r=1,g=0.49,b=0.03},
			DEATHKNIGHT = {hex="C41F3B",r=0.76,g=0.12,b=0.23},
			WARRIOR 	= {hex="C79C6E",r=0.78,g=0.61,b=0.43},
			PALADIN 	= {hex="F58CBA",r=0.96,g=0.54,b=0.72}
	}
}

--------------------------------------
-- Config functions
--------------------------------------
function Config:Toggle()
	local menu = UIConfig or Config:CreateMenu();
	menu:SetShown(not menu:IsShown());
	core.Management.Start();
end

function Config:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex;
end

--[[
	Function to create a button with a determinated function passed as parameter.
]]--
function Config:CreateButton(layer,point, relativeFrame, relativePoint, xOffset,yOffset, text, onClickFunction, inactive)
	local btn = CreateFrame("Button", "nil", layer, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset);
	btn:SetSize(100, 40);
	btn:SetText(text);
	btn:SetNormalFontObject("GameFontNormalLarge");
	btn:SetHighlightFontObject("GameFontHighlightLarge");
	if (inactive)
	then
		btn:Disable();	
	end
	btn:SetScript("OnClick",onClickFunction);
	return btn;
end

--[[
	To Apply Class Color to desired texts.
]]--
function Config:ApplyClassColor(textMain,textOff,class)
	print(class);
	if (string.match(class, "Bruj")  or string.match(class, "Warlo")) then
		textMain:SetTextColor(defaults.classColors.WARLOCK.r,defaults.classColors.WARLOCK.g,defaults.classColors.WARLOCK.b);
		textOff:SetTextColor(defaults.classColors.WARLOCK.r,defaults.classColors.WARLOCK.g,defaults.classColors.WARLOCK.b);
	elseif (string.match(class, "Cazador") or string.match(class, "Hunter")) then 
		textMain:SetTextColor(defaults.classColors.HUNTER.r,defaults.classColors.HUNTER.g,defaults.classColors.HUNTER.b);
		textOff:SetTextColor(defaults.classColors.HUNTER.r,defaults.classColors.HUNTER.g,defaults.classColors.HUNTER.b);
	elseif (string.match(class, "Guerrer") or string.match(class, "Warr")) then 
		textMain:SetTextColor(defaults.classColors.WARRIOR.r,defaults.classColors.WARRIOR.g,defaults.classColors.WARRIOR.b);
		textOff:SetTextColor(defaults.classColors.WARRIOR.r,defaults.classColors.WARRIOR.g,defaults.classColors.WARRIOR.b);
	elseif (string.match(class, "Chaman") or string.match(class, "Shaman")) then 
		textMain:SetTextColor(defaults.classColors.SHAMAN.r,defaults.classColors.SHAMAN.g,defaults.classColors.SHAMAN.b);
		textOff:SetTextColor(defaults.classColors.SHAMAN.r,defaults.classColors.SHAMAN.g,defaults.classColors.SHAMAN.b);
	elseif (string.match(class, "Mag") or string.match(class, "Mage")) then 
		textMain:SetTextColor(defaults.classColors.MAGE.r,defaults.classColors.MAGE.g,defaults.classColors.MAGE.b);
		textOff:SetTextColor(defaults.classColors.MAGE.r,defaults.classColors.MAGE.g,defaults.classColors.MAGE.b);
	elseif (string.match(class, "Picar") or string.match(class, "Rogu")) then 
		textMain:SetTextColor(defaults.classColors.ROGUE.r,defaults.classColors.ROGUE.g,defaults.classColors.ROGUE.b);
		textOff:SetTextColor(defaults.classColors.ROGUE.r,defaults.classColors.ROGUE.g,defaults.classColors.ROGUE.b);	
	elseif (string.match(class, "Sacerdot") or string.match(class, "Priest")) then 
		textMain:SetTextColor(defaults.classColors.PRIEST.r,defaults.classColors.PRIEST.g,defaults.classColors.PRIEST.b);
		textOff:SetTextColor(defaults.classColors.PRIEST.r,defaults.classColors.PRIEST.g,defaults.classColors.PRIEST.b);
	elseif (string.match(class, "Druid")) then 
		textMain:SetTextColor(defaults.classColors.DRUID.r,defaults.classColors.DRUID.g,defaults.classColors.DRUID.b);
		textOff:SetTextColor(defaults.classColors.DRUID.r,defaults.classColors.DRUID.g,defaults.classColors.DRUID.b);
	elseif (string.match(class, "Caball") or string.match(class, "DEATHKNIGHT")) then 
		textMain:SetTextColor(defaults.classColors.DEATHKNIGHT.r,defaults.classColors.DEATHKNIGHT.g,defaults.classColors.DEATHKNIGHT.b);
		textOff:SetTextColor(defaults.classColors.DEATHKNIGHT.r,defaults.classColors.DEATHKNIGHT.g,defaults.classColors.DEATHKNIGHT.b);
	elseif (string.match(class, "Palad")) then 
		textMain:SetTextColor(defaults.classColors.PALADIN.r,defaults.classColors.PALADIN.g,defaults.classColors.PALADIN.b);
		textOff:SetTextColor(defaults.classColors.PALADIN.r,defaults.classColors.PALADIN.g,defaults.classColors.PALADIN.b);
	end
end

--[[
	Crreate Counters for lists.
]]--
function Config:CreateTextCounters(layer)
	local text;
	local texts={};
	for i=1, 40,1 
		do
			text=layer:CreateFontString(nil,"OVERLAY","GameFontNormal");			
			text:SetPoint("TOPLEFT", 180, -20*(i-1));	
			--text:SetPoint("RIGHT", core.Config.UIConfig.TextsMain[i], "LEFT", 5, 0);
			text:SetText("0");
			text:SetTextColor(1,1,1,1);
			texts[i]=text;			
		end
	return texts
end

--[[
	Create + and - buttons for lists.
]]--
function Config:CreatePlusButtons(layer,type)
	local plusBtn;
	local plusBtns={};
	local minusBtn;
	local minusBtns={};
	for i=1, 40,1 
		do
			plusBtn=CreateFrame("Button", "nil", layer, "GameMenuButtonTemplate");
			plusBtn:SetPoint("TOPLEFT",12,-20*(i-1));
			plusBtn:SetSize(15, 15);
			plusBtn:SetText("+");
			plusBtn:SetNormalFontObject("GameFontNormal");
			plusBtn:SetHighlightFontObject("GameFontHighlight");
			plusBtn:SetID(i);
			plusBtn:SetAttribute("type",type)
			plusBtn:SetScript("OnClick",core.Management.AddOne);
			plusBtns[i]=plusBtn;

			minusBtn=CreateFrame("Button", "nil", layer, "GameMenuButtonTemplate");
			minusBtn:SetPoint("TOPLEFT",24,-20*(i-1));
			minusBtn:SetSize(15, 15);
			minusBtn:SetText("-");
			minusBtn:SetNormalFontObject("GameFontNormal");
			minusBtn:SetHighlightFontObject("GameFontHighlight");
			minusBtn:SetID(i);
			minusBtn:SetAttribute("type",type)
			minusBtn:SetScript("OnClick",core.Management.RemoveOne);
			minusBtns[i]=minusBtn;

		end
	return plusBtns, minusBtns;
end

--[[
	Scroll Funcionality
]]--
local function ScrollFrame_OnMouseWheel(self, delta)
	local newValue = self:GetVerticalScroll() - (delta * 20);
	
	if (newValue < 0) then
		newValue = 0;
	elseif (newValue > self:GetVerticalScrollRange()) then
		newValue = self:GetVerticalScrollRange();
	end
	
	self:SetVerticalScroll(newValue);
end

--[[
	Tab Funcionality
]]--
local function Tab_OnClick(self)
	PanelTemplates_SetTab(self:GetParent(), self:GetID());
	
	local scrollChild = UIConfig.ScrollFrame:GetScrollChild();
	if (scrollChild) then
		scrollChild:Hide();
	end
	
	UIConfig.ScrollFrame:SetScrollChild(self.content);
	self.content:Show();	
end

--[[
	Config the tabs of our main layout.
]]--
function Config:SetTabs(frame, numTabs, ...)
	frame.numTabs = numTabs;
	
	local contents = {};
	local frameName = frame:GetName();
	
	for i = 1, numTabs do	
		local tab = CreateFrame("Button", frameName.."Tab"..i, frame, "CharacterFrameTabButtonTemplate");
		tab:SetID(i);
		tab:SetText(select(i, ...));
		tab:SetScript("OnClick", Tab_OnClick);
		
		tab.content = CreateFrame("Frame", nil, UIConfig.ScrollFrame);
		tab.content:SetSize(260, 360);
		tab.content:Hide();
		
		tab.content.bg = tab.content:CreateTexture(nil, "BACKGROUND");
		tab.content.bg:SetAllPoints(true);
		
		
		table.insert(contents, tab.content);
		
		if (i == 1) then
			tab:SetPoint("TOPLEFT", UIConfig, "BOTTOMLEFT", 5, 7);
		else
			tab:SetPoint("TOPLEFT", _G[frameName.."Tab"..(i - 1)], "TOPRIGHT", -14, 0);
		end	
	end
	
	Tab_OnClick(_G[frameName.."Tab1"]);
	
	return unpack(contents);
end

--[[
	To create main frames y his childs.
]]--
function Config:CreateMenu()
	UIConfig = CreateFrame("Frame", "ZekRollPlusOne", UIParent, "BasicFrameTemplateWithInset");
	UIConfig:SetSize(260, 360);
	UIConfig:SetPoint("CENTER");
	
	UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0);
	UIConfig.title:SetText("Zek Roll+1 v.1.0");

	-- Do layout draggeable
	UIConfig:SetMovable(true);
	UIConfig:EnableMouse(true);
	UIConfig:RegisterForDrag("LeftButton");
	UIConfig:SetScript("OnDragStart", function(self, button)
		self:StartMoving();
	end);
	UIConfig:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing();
	end);

	-- Do Layout Scrollable
	UIConfig.ScrollFrame = CreateFrame("ScrollFrame", nil, UIConfig, "UIPanelScrollFrameTemplate");
	UIConfig.ScrollFrame:SetPoint("TOPLEFT", UIConfig, "TOPLEFT", 4, -34);
	UIConfig.ScrollFrame:SetPoint("BOTTOMRIGHT", UIConfig, "BOTTOMRIGHT", -4, 20);
	UIConfig.ScrollFrame:SetClipsChildren(true);
	UIConfig.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);

	UIConfig.ScrollFrame.ScrollBar:ClearAllPoints();
	UIConfig.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", UIConfig.ScrollFrame, "TOPRIGHT", -12, -18);
	UIConfig.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", UIConfig.ScrollFrame, "BOTTOMRIGHT", -7, 18);
	UIConfig.MainTab, UIConfig.OffTab, UIConfig.OptionsTab = self:SetTabs(UIConfig, 3, "Main", "OffSpect", "Options");


	----------------------------------
	-- Buttons
	----------------------------------
	-- Save Button:
	UIConfig.startBtn = self:CreateButton(UIConfig.OptionsTab,"CENTER", UIConfig.OptionsTab, "CENTER",0, 80, "Start", core.Management.Start,false);

	-- Reset Button:	
	UIConfig.resetBtn = self:CreateButton(UIConfig.OptionsTab,"CENTER", UIConfig.startBtn, "CENTER",0, -80, "Reset", core.Management.Reset,false);

	-- Load Button:	
	UIConfig.exportBtn = self:CreateButton(UIConfig.OptionsTab,"CENTER", UIConfig.resetBtn, "CENTER",0, -80, "Export", core.Management.Export,true);

	----------------------------------
	-- List of Raid Members (names, counts, buttons)
	----------------------------------
	UIConfig.TextsMain=self:CreateTextLabels(UIConfig.MainTab);
	UIConfig.TextsOff=self:CreateTextLabels(UIConfig.OffTab);
	UIConfig.PlusButtonsMain,UIConfig.MinusButtonsMain=self:CreatePlusButtons(UIConfig.MainTab,"mainSpect");
	UIConfig.PlusButtonsOff,UIConfig.MinusButtonsOff=self:CreatePlusButtons(UIConfig.OffTab,"offSpect");
	UIConfig.TextsCounterMain=self:CreateTextCounters(UIConfig.MainTab);
	UIConfig.TextsCounterOff=self:CreateTextCounters(UIConfig.OffTab);

	UIConfig:Hide();
	core.Config.UIConfig = UIConfig;
	return UIConfig;
end




























--Config:CreateMenu();



--[[
function Config:CreateLabel()
	local label = CreateFrame("EditBox", nil, UIConfig, "InputBoxTemplate");
	label:SetPoint("TOPLEFT", UIConfig.title, 5, -15);
	label:SetWidth(430);
	label:SetText("Paste the list here.");
	label:SetAutoFocus(false);
	label:SetMultiLine(true);
	label:SetMaxLetters(2000);
	label:SetEnabled(false);

	return label;
end
--]]

	--[[
	local line = UIConfig:CreateLine()
	line:SetColorTexture(1,0,0,1)
	line:SetStartPoint("TOPLEFT",10,10)
	line:SetEndPoint("BOTTOMRIGHT",10,10)
	--]]
	
	

	--[[
	UIConfig.editBox = CreateFrame("EditBox", nil, UIConfig, "InputBoxTemplate");
	UIConfig.editBox:SetPoint("TOPLEFT", UIConfig.title, 5, -5);
	UIConfig.editBox:SetWidth(430);
	UIConfig.editBox:SetText("Paste the list here.");
	UIConfig.editBox:SetAutoFocus(false);
	UIConfig.editBox:SetMultiLine(true);
	UIConfig.editBox:SetMaxLetters(2000);
	--]]

--[[
	----------------------------------
	-- Sliders
	----------------------------------
	-- Slider 1:
	UIConfig.slider1 = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate");
	UIConfig.slider1:SetPoint("TOP", UIConfig.loadBtn, "BOTTOM", 0, -20);
	UIConfig.slider1:SetMinMaxValues(1, 100);
	UIConfig.slider1:SetValue(50);
	UIConfig.slider1:SetValueStep(30);
	UIConfig.slider1:SetObeyStepOnDrag(true);

	-- Slider 2:
	UIConfig.slider2 = CreateFrame("SLIDER", nil, UIConfig, "OptionsSliderTemplate");
	UIConfig.slider2:SetPoint("TOP", UIConfig.slider1, "BOTTOM", 0, -20);
	UIConfig.slider2:SetMinMaxValues(1, 100);
	UIConfig.slider2:SetValue(40);
	UIConfig.slider2:SetValueStep(30);
	UIConfig.slider2:SetObeyStepOnDrag(true);

	----------------------------------
	-- Check Buttons
	----------------------------------
	-- Check Button 1:
	UIConfig.checkBtn1 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate");
	UIConfig.checkBtn1:SetPoint("TOPLEFT", UIConfig.slider1, "BOTTOMLEFT", -10, -40);
	UIConfig.checkBtn1.text:SetText("My Check Button!");

	-- Check Button 2:
	UIConfig.checkBtn2 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate");
	UIConfig.checkBtn2:SetPoint("TOPLEFT", UIConfig.checkBtn1, "BOTTOMLEFT", 0, -10);
	UIConfig.checkBtn2.text:SetText("Another Check Button!");
	UIConfig.checkBtn2:SetChecked(true);
	--]]