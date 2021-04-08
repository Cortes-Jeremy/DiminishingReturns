-- Addon creation and initialization

DiminishingReturns = CreateFrame("Frame")
local addon = DiminishingReturns
LibStub('LibAdiEvent-1.0').Embed(addon)
addon:SetMessageChannel(addon)

-- Debugging code
if tekDebug then
	local frame = tekDebug:GetFrame("DiminishingReturns")
	function addon:Debug(...) frame:AddMessage(strjoin(" ", tostringall(...))) end
else
	function addon.Debug() end
end

local DEFAULT_CONFIG = {
--	version = 1.1,
	learnCategories = false,
	categories = {
		["sleep"] = true,
		["ctrlstun"] = true,
		["fear"] = true,
		["ctrlroot"] = true,
		["mc"] = true,
		["banish"] = true,
		["disorient"] = true,
		["cyclone"] = true,
		['*'] = false
	},
	resetDelay = 20,
	pveMode = true,
	soundAtReset = false,
	resetSound = LibStub('LibSharedMedia-3.0'):GetDefault('sound'),
	bigTimer = true,
	timerPrecision = 1,
}
addon.DEFAULT_CONFIG = DEFAULT_CONFIG

function addon:OnProfileChanged(self, ...)
	addon:TriggerMessage('OnProfileChanged')
end

local function OnLoad(self, event, name, ...)
	if name:lower() ~= "diminishingreturns" then return end
	self:UnregisterEvent('ADDON_LOADED', OnLoad)
	OnLoad = nil

	local db = LibStub('AceDB-3.0'):New("DiminishingReturnsDB", {profile=DEFAULT_CONFIG})
	db.RegisterCallback(self, 'OnProfileChanged')
	db.RegisterCallback(self, 'OnProfileCopied', 'OnProfileChanged')
	db.RegisterCallback(self, 'OnProfileReset', 'OnProfileChanged')
	self.db = db

	-- Optional LibDualSpec-1.0 support
	local LibDualSpec = LibStub('LibDualSpec-1.0', true)
	if LibDualSpec then
		self.LibDualSpec = LibDualSpec
		LibDualSpec:EnhanceDatabase(db, "Diminishing Returns")
	end

	addon:LoadAddonSupport()

	if IsLoggedIn() then
		self:CheckActivation('OnLoad')
	end
end

addon:RegisterEvent('ADDON_LOADED', OnLoad)

-- Test mode
function addon:SetTestMode(mode)
	self.testMode = mode
	addon:TriggerMessage('SetTestMode', self.testMode)
end

SLASH_DRTEST1 = "/drtest"
SlashCmdList.DRTEST = function()
	addon:SetTestMode(not addon.testMode)
end
