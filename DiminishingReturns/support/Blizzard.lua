local addon = DiminishingReturns
if not addon then return end

-- FrameXML is a internal fake to have this working like other support
addon:RegisterAddonSupport('FrameXML', function()

	local db = addon.db:RegisterNamespace('Blizzard', {profile={
		player = {
			enabled = true,
			iconSize = 30,
			direction = 'RIGHT',
			spacing = 3,
			anchorPoint = 'TOPLEFT',
			relPoint = 'TOPLEFT',
			xOffset = 40,
			yOffset = 20,
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
		},
		target = {
			enabled = true,
			iconSize = 30,
			direction = 'RIGHT',
			spacing = 3,
			anchorPoint = 'TOPLEFT',
			relPoint = 'TOPRIGHT',
			xOffset = -100,
			yOffset = 20,
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
		},
		focus = {
			enabled = true,
			iconSize = 30,
			direction = 'RIGHT',
			spacing = 3,
			anchorPoint = 'TOPLEFT',
			relPoint = 'TOPRIGHT',
			xOffset = -100,
			yOffset = 20,
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
		},
	}})

	local function RegisterFrame(name, unit)
		local function GetDatabase() return db.profile[unit], db end
		addon:RegisterFrameConfig('Blizzard: '..addon.L[unit], GetDatabase)
		addon:RegisterFrame(name, function(frame)
			return addon:SpawnFrame(frame, frame, GetDatabase)
		end)
	end

	RegisterFrame('PlayerFrame', 'player')
	RegisterFrame('TargetFrame', 'target')
	RegisterFrame('FocusFrame', 'focus')
end)
