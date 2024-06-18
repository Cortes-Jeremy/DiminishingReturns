local addon = DiminishingReturns
if not addon then return end

addon:RegisterAddonSupport('FrameXMLCompactFrames', function()

	local db = addon.db:RegisterNamespace('Blizzard_CompactFrames', {profile={
		enabled = true,
		iconSize = 20,
		direction = 'RIGHT',
		spacing = 3,
		anchorPoint = 'TOPLEFT',
		relPoint = 'TOPLEFT',
		xOffset = 0,
		yOffset = 15,
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

	addon:RegisterFrameConfig('Blizzard: CompactFrames', GetDatabase)

	local function SetupFrame(frame)
		return addon:SpawnFrame(frame, frame, GetDatabase)
	end

	for i = 1,4 do
		addon:RegisterFrame('CompactRaidFrame'..i, SetupFrame)
	end

end)
