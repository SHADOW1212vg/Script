-- Interface + Aimbot para Mobs

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "CustomUI"

-- Painel principal
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 30, 60) -- roxo escuro
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true

-- Botão de abrir/fechar
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0.5, -20, 0.5, -100)
toggleButton.BackgroundColor3 = Color3.fromRGB(90, 70, 130)
toggleButton.Text = "-"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextScaled = true
toggleButton.BorderSizePixel = 0

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	toggleButton.Text = mainFrame.Visible and "-" or "+"
end)

-- Título
local label = Instance.new("TextLabel", mainFrame)
label.Size = UDim2.new(1, 0, 0, 40)
label.Text = "Menu de Script"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSansBold
label.TextScaled = true
label.BackgroundTransparency = 1

-- Botão Aimbot
local aimbotButton = Instance.new("TextButton", mainFrame)
aimbotButton.Size = UDim2.new(0, 200, 0, 40)
aimbotButton.Position = UDim2.new(0.5, -100, 0, 80)
aimbotButton.Text = "Aimbot: OFF"
aimbotButton.BackgroundColor3 = Color3.fromRGB(130, 50, 120)
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotButton.Font = Enum.Font.SourceSans
aimbotButton.TextScaled = true
aimbotButton.BorderSizePixel = 0

-- Lógica do Aimbot
local camera = workspace.CurrentCamera
local rs = game:GetService("RunService")
local aimbotEnabled = false

aimbotButton.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	aimbotButton.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
end)

rs.RenderStepped:Connect(function()
	if not aimbotEnabled then return end

	local closestTarget = nil
	local shortestDistance = math.huge

	for _, mob in pairs(workspace:GetDescendants()) do
		if mob:IsA("Model") and mob:FindFirstChild("Head") and mob ~= player.Character then
			local distance = (camera.CFrame.Position - mob.Head.Position).Magnitude
			if distance < shortestDistance then
				shortestDistance = distance
				closestTarget = mob
			end
		end
	end

	if closestTarget and closestTarget:FindFirstChild("Head") then
		camera.CFrame = CFrame.new(camera.CFrame.Position, closestTarget.Head.Position)
	end
end)
