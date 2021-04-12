local addon = DiminishingReturns
if not addon then return end

-- This allow oUF addons to add support themselves
function addon:DeclareOUF(parent, oUF)
	local defaults = {
		enabled = true,
		iconSize = 24,
		direction = 'RIGHT',
		spacing = 2,
		anchorPoint = 'TOPLEFT',
		relPoint = 'BOTTOMLEFT',
		xOffset = 0,
		yOffset = -4,
		iconFont = 'PT Sans Narrow',
		bigTextSize = 13,
		bigTextFlags = 'OUTLINE',
		bigTextPoint = 'CENTER',
		bigTextRelativePoint = 'CENTER',
		bigTextXOffset = 0,
		bigTextYOffset = 0,
		bigTextShadowXOffset = 1,
		bigTextShadowYOffset = -1,
		smallTextSize = 10,
		smallTextFlags = 'OUTLINE',
		smallTextPoint = 'CENTER',
		smallTextRelativePoint = 'CENTER',
		smallTextXOffset = 0,
		smallTextYOffset = 0,
		smallTextShadowXOffset = 1,
		smallTextShadowYOffset = -1,
	}

	db = addon.db:RegisterNamespace(parent, {profile={
		player = defaults,
		target = defaults,
		focus = defaults,
		party = defaults
	}})

	local getDatabaseFuncs = {}

	-- Frame checking code
	local function CheckFrame(frame)
		local unit = frame.unit
		if not unit then return end
		if string.find(unit, 'party') ~= nil then -- handle party1,2...
			unit = 'party'
		end
		if unit ~= 'target' and unit ~= 'focus' and unit ~= 'player' and unit ~= 'party' then return end

		local GetDatabase = getDatabaseFuncs[unit]
		if not GetDatabase then
			-- Avoid creating several time the same config
			GetDatabase = function() return db.profile[unit], db end
			addon:RegisterFrameConfig(parent..': '..addon.L[unit], GetDatabase)
			getDatabaseFuncs[unit] = GetDatabase
		end
		return addon:SpawnFrame(frame, frame, GetDatabase)
	end

	-- Check existing frames
	for i, frame in pairs(oUF.objects) do
		CheckFrame(frame)
	end

	-- Register check for future frames
	oUF:RegisterInitCallback(CheckFrame)
end

-- Scan for declared oUF
-- V: reworked the code to try and scan after a few OnUpdate, in case of a loading order issue
--    it's not pretty, but it works, and considering the original code had a `CreateFrame`, I think
--    that's the way the author was going to code it in a future version.
for index = 1, GetNumAddOns() do
	local global = GetAddOnMetadata(index, 'X-oUF')

	if global then
		local parent = GetAddOnInfo(index)
		local callbackFrame
		local i = 0

		local function ClearFrame()
			if callbackFrame then
				callbackFrame:SetScript('OnUpdate', nil)
			end
		end

		local function TryLoad()
			local oUF = _G[global]
			if oUF then
				addon:DeclareOUF(parent, oUF)
				ClearFrame()
			else
				-- retry on every OnUpdate for 100 times
				if i > 100 then
					ClearFrame()
				elseif callbackFrame == nil then
					callbackFrame = CreateFrame('Frame')
					callbackFrame:SetScript('OnUpdate', TryLoad)
				end
				i = i + 1
			end
		end

		addon:RegisterAddonSupport(parent, TryLoad)
	end

end
