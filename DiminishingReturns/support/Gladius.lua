local addon = DiminishingReturns
if not addon then return end

addon:RegisterAddonSupport('Gladius', function()

	local db = addon.db:RegisterNamespace('Gladius', {profile={
		enabled = true,
		iconSize = 40,
		direction = 'RIGHT',
		spacing = 2,
		anchorPoint = 'TOPLEFT',
		relPoint = 'TOPRIGHT',
		xOffset = 3,
		yOffset = 0,
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
	}})

	local function GetDatabase()
		return db.profile, db
	end

	addon:RegisterFrameConfig('Gladius', GetDatabase)

	local function SetupFrame(frame)
		return addon:SpawnFrame(frame:GetParent(), frame, GetDatabase)
	end

	local needHook = false
	for i = 1,5 do
		if not addon:RegisterFrame('GladiusButton'..i, SetupFrame) then
			needHook = true
		end
	end

	if needHook then
		hooksecurefunc(Gladius, 'UpdateAttribute', function(gladius, unit)
			addon.CheckFrame(gladius.buttons[unit].secure)
		end)
	end

end)
