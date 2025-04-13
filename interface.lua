local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Interface
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "SHADOW_HUB"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botão flutuante
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = gui
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
toggleBtn.BorderColor3 = Color3.fromRGB(170, 0, 255)
toggleBtn.BorderSizePixel = 2
toggleBtn.Text = "≡"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextScaled = true
toggleBtn.Draggable = false

-- Arrastar para mobile
local dragging, dragInput, dragStart, startPos
toggleBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = toggleBtn.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

toggleBtn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Painel principal
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 300, 0, 400)
panel.Position = UDim2.new(0.5, -150, 0.5, -200)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
panel.BorderColor3 = Color3.fromRGB(170, 0, 255)
panel.BorderSizePixel = 3
panel.Visible = false
panel.Active = true
panel.Draggable = true

-- Título
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "SHADOW HUB"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(170, 0, 255)
title.TextScaled = true

-- Toggle painel
toggleBtn.MouseButton1Click:Connect(function()
	panel.Visible = not panel.Visible
end)

-- Criação de botões
local function createButton(text, position, callback)
	local btn = Instance.new("TextButton", panel)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, position)
	btn.BackgroundColor3 = Color3.fromRGB(30, 0, 60)
	btn.BorderColor3 = Color3.fromRGB(170, 0, 255)
	btn.BorderSizePixel = 2
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 14
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Aimbot NPC
local aimbotOn = false
local aimbotConn

local function getNearestMob()
	local nearest, shortest = nil, math.huge
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= LocalPlayer.Character then
			local hrp = obj:FindFirstChild("HumanoidRootPart")
			if hrp then
				local dist = (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
				if dist < shortest then
					shortest = dist
					nearest = hrp
				end
			end
		end
	end
	return nearest
end

local function enableAimbot()
	aimbotConn = RunService.RenderStepped:Connect(function()
		local target = getNearestMob()
		if target then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
		end
	end)
end

local function disableAimbot()
	if aimbotConn then
		aimbotConn:Disconnect()
		aimbotConn = nil
	end
end

-- Botão ON/OFF
local aimbotButton
aimbotButton = createButton("Aimbot: OFF", 60, function()
	aimbotOn = not aimbotOn
	aimbotButton.Text = "Aimbot: " .. (aimbotOn and "ON" or "OFF")
	if aimbotOn then
		enableAimbot()
	else
		disableAimbot()
	end
end)
