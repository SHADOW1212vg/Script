local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- GUI
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "OMGHUB"
gui.ResetOnSpawn = false

-- Janela Principal
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
main.BorderSizePixel = 0

-- Tornar arrastável no mobile
local dragging = false
local dragInput, dragStart, startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

main.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(50, 45, 70)

local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "OMG HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1

-- Conteúdo
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -120, 1, 0)
content.Position = UDim2.new(0, 120, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
content.BorderSizePixel = 0

-- Página do Aimbot
local aimbotPage = Instance.new("Frame", content)
aimbotPage.Size = UDim2.new(1, 0, 1, 0)
aimbotPage.BackgroundTransparency = 1
aimbotPage.Visible = false

local toggle = Instance.new("TextButton", aimbotPage)
toggle.Size = UDim2.new(0, 200, 0, 50)
toggle.Position = UDim2.new(0.5, -100, 0.5, -25)
toggle.BackgroundColor3 = Color3.fromRGB(90, 60, 130)
toggle.Text = "Aimbot: OFF"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 20
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.BorderSizePixel = 0
toggle.ClipsDescendants = true
Instance.new("UICorner", toggle)

-- Lógica do Aimbot
local aimbotEnabled = false
toggle.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	toggle.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
	toggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(130, 70, 200) or Color3.fromRGB(90, 60, 130)
end)

RunService.RenderStepped:Connect(function()
	if not aimbotEnabled then return end
	local character = LocalPlayer.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end

	local closest, distance = nil, math.huge
	for _, mob in ipairs(workspace:GetDescendants()) do
		if mob:IsA("Model") and mob:FindFirstChild("Head") and mob ~= character then
			local dist = (mob.Head.Position - character.HumanoidRootPart.Position).Magnitude
			if dist < distance then
				distance = dist
				closest = mob
			end
		end
	end

	if closest and closest:FindFirstChild("Head") then
		local pos = closest.Head.Position
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, pos)
	end
end)

-- Botões na Sidebar
local function createButton(name, onClick)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, 45 + (#sidebar:GetChildren() - 2) * 40)
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(60, 50, 90)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn)
	btn.MouseButton1Click:Connect(onClick)
end

createButton("Aimbot", function()
	aimbotPage.Visible = true
end)

createButton("Fechar", function()
	gui:Destroy()
end)
