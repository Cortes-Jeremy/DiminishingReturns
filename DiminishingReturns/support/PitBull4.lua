local addon = DiminishingReturns
if not addon then return end

addon:RegisterAddonSupport('PitBull4', function()

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

	local db = addon.db:RegisterNamespace('PitBull4', {profile={
		target = defaults,
		focus = defaults,
	}})

	local function RegisterSingletonFrame(unit)
		local function GetDatabase() return db.profile[unit], db end
		addon:RegisterFrameConfig('PitBull4: '..addon.L[unit], GetDatabase)
		addon:RegisterFrame('PitBull4_Frames_'..unit, function(frame)
			return addon:SpawnFrame(frame, frame, GetDatabase)
		end)
	end

	RegisterSingletonFrame('target')
	RegisterSingletonFrame('focus')

end)
