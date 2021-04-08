local addon = DiminishingReturns
if not addon then return end

addon:RegisterAddonSupport('XPerl', function()

	local defaults = {
		enabled = true,
		iconSize = 24,
		direction = 'RIGHT',
		spacing = 2,
		anchorPoint = 'BOTTOMLEFT',
		relPoint = 'TOPLEFT',
		xOffset = 4,
		yOffset = 4,
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

	local db = addon.db:RegisterNamespace('XPerl', {profile={
		target = defaults,
		focus = defaults,
	}})

	local function ucfirst(s)
		return s:sub(1,1):upper()..s:sub(2)
	end

	local function RegisterFrame(unit)
		local function GetDatabase() return db.profile[unit], db end
		addon:RegisterFrameConfig('XPerl: '..addon.L[unit], GetDatabase)
		return addon:RegisterFrame('XPerl_'..ucfirst(unit), function(frame)
			return addon:SpawnFrame(frame, frame, GetDatabase)
		end)
	end

	local gotTarget = RegisterFrame('target')
	local gotFocus = RegisterFrame('focus')

	if not gotTarget or not gotFocus then
		hooksecurefunc('XPerl_SecureUnitButton_OnLoad', addon.CheckFrame)
	end

end)
