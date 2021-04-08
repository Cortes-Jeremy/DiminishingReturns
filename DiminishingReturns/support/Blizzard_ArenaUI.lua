local addon = DiminishingReturns
if not addon then return end

addon:RegisterAddonSupport('Blizzard_ArenaUI', function()

	local db = addon.db:RegisterNamespace('Blizzard_ArenaUI', {profile={
		anchorPoint = "RIGHT",
		direction = "LEFT",
		spacing = 3,
		iconSize = 27,
		xOffset = -33,
		yOffset = -2,
		relPoint = "LEFT",
		enabled = true,
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

	addon:RegisterFrameConfig(addon.L['Blizzard: arena enemies'], GetDatabase)

	local function SetupFrame(frame)
		return addon:SpawnFrame(frame, frame, GetDatabase)
	end

	for i = 1,5 do
		addon:RegisterFrame('ArenaEnemyFrame'..i, SetupFrame)
	end

end)
