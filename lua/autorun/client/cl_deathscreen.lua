local isAlive = true
local respawnTime = 10 	-- Respawn timer (in seconds)
local respawnTimeLeft = respawnTime

surface.CreateFont("bots", {
	font = "Battle Bots",
	size = 50,
	weight = 100,
	scanlines = 2,
	antialias = true,
	italic = true,
	outline = true
})

surface.CreateFont("bbots", {
	font = "Arial Black",
	size = 50,
	weight = 100,
	scanlines = 2,
	antialias = true,
	italic = true,
	outline = true
})

local function DrawDeathScreenHUD()
	if LocalPlayer():Alive() then
		isAlive = true
		respawnTimeLeft = respawnTime
		return
	end
	isAlive = false

	local screenWidth, screenHeight = ScrW(), ScrH()

	draw.RoundedBox(0, 0, 0, screenWidth, screenHeight, Color(0, 0, 0, 230))	 -- Background

	local text = "You died!"	-- the text change it to whatever you want
	surface.SetFont("bots")
	local textWidth, textHeight = surface.GetTextSize(text)

	surface.SetTextColor(Color(255, 255, 255, 255))
	surface.SetTextPos(screenWidth / 2 - textWidth / 2, screenHeight / 2 - textHeight / 2)
	surface.DrawText(text)

	local timerText = string.format("%.2f", respawnTimeLeft)
	surface.SetFont("bbots")
	local timerTextWidth = surface.GetTextSize(timerText)

	surface.SetTextColor(Color(255, 255, 255, 255))
	surface.SetTextPos(screenWidth / 2 - timerTextWidth / 2, screenHeight / 2 + textHeight / 2 + 80)
	surface.DrawText(timerText)

	-- Background of the line
	local bgBarWidth = 700
	local bgBarHeight = 30
	local bgBarX = screenWidth / 2 - bgBarWidth / 2
	local bgBarY = screenHeight / 2 + textHeight / 2 + 30

	draw.RoundedBox(15, bgBarX, bgBarY, bgBarWidth, bgBarHeight, Color(0, 0, 0, 200))

	-- Charging line
	local barWidth = 700
	local barHeight = 30
	local barX = screenWidth / 2 - barWidth / 2
	local barY = screenHeight / 2 + textHeight / 2 + 30

	draw.RoundedBox(15, barX, barY, barWidth * (1 - respawnTimeLeft / respawnTime), barHeight, Color(255, 255, 255, 255))
end

local function UpdateRespawnTimer()
	if not isAlive then
		respawnTimeLeft = math.max(0, respawnTimeLeft - FrameTime())
	end
end

hook.Add("HUDPaint", "DeathScreenHUD", DrawDeathScreenHUD)
hook.Add("Think", "UpdateRespawnTimer", UpdateRespawnTimer)
