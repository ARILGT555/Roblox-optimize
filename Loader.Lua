-- 🔧 Made by arilgt555 | Roblox Light Mod Menu

local CoreGui = game:GetService("CoreGui")

-- GUI Setup
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "LightHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 140)
frame.Position = UDim2.new(0, 10, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "⚙️ LightHub by arilgt555"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- Button
local toggle = Instance.new("TextButton", frame)
toggle.Text = "🟢 Optimize: OFF"
toggle.Size = UDim2.new(0.9, 0, 0, 30)
toggle.Position = UDim2.new(0.05, 0, 0, 40)
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.Gotham
toggle.TextSize = 14
local btnCorner = Instance.new("UICorner", toggle)
btnCorner.CornerRadius = UDim.new(0, 6)

-- FPS Counter
local fps = Instance.new("TextLabel", frame)
fps.Size = UDim2.new(1, 0, 0, 30)
fps.Position = UDim2.new(0, 0, 1, -30)
fps.BackgroundTransparency = 1
fps.TextColor3 = Color3.new(0, 1, 0)
fps.Font = Enum.Font.Code
fps.TextSize = 14
fps.Text = "FPS: 0"

-- Logic
local active = false

toggle.MouseButton1Click:Connect(function()
	active = not active
	toggle.Text = active and "🔴 Optimize: ON" or "🟢 Optimize: OFF"
	if active then
		-- Anti-lag mode ON
		coroutine.wrap(function()
			for _,v in ipairs(workspace:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Trail") then
					v:Destroy()
				end
				if v:IsA("BasePart") then
					pcall(function()
						v.Material = Enum.Material.SmoothPlastic
						v.CastShadow = false
						v.Reflectance = 0
					end)
				end
			end
		end)()
	else
		-- Reset rendering only
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	end
end)

-- FPS Counter
local runService = game:GetService("RunService")
local lastUpdate = tick()
local frames = 0

runService.RenderStepped:Connect(function()
	frames += 1
	if tick() - lastUpdate >= 1 then
		fps.Text = "FPS: " .. tostring(frames)
		frames = 0
		lastUpdate = tick()
	end
end)
