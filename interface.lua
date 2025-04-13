-- SHADOW HUB Interface Futurista Mobile

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local executor = identifyexecutor and identifyexecutor() or "Desconhecido"

-- GUI principal
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "SHADOW_GUI"
ScreenGui.ResetOnSpawn = false

-- Botão flutuante para abrir/fechar
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = "≡"
ToggleButton.TextScaled = true
ToggleButton.AutoButtonColor = false
ToggleButton.ZIndex = 10

-- Janela principal
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 370)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderColor3 = Color3.fromRGB(170, 0, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Título
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "SHADOW HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(170, 0, 255)
Title.TextScaled = true

-- Aba: Informações
local InfoBox = Instance.new("TextLabel", MainFrame)
InfoBox.Size = UDim2.new(1, -20, 0, 80)
InfoBox.Position = UDim2.new(0, 10, 0, 50)
InfoBox.BackgroundTransparency = 0.4
InfoBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
InfoBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBox.Font = Enum.Font.Gotham
InfoBox.TextSize = 14
InfoBox.TextWrapped = true
InfoBox.TextYAlignment = Enum.TextYAlignment.Top
InfoBox.Text = "Nick: " .. player.Name .. "\nSkin: " .. player.Character:FindFirstChildOfClass("Shirt") and "Customizada" or "Default" .. "\nExecutor: " .. executor

-- Botão Aimbot
local AimbotLabel = Instance.new("TextLabel", MainFrame)
AimbotLabel.Position = UDim2.new(0, 10, 0, 145)
AimbotLabel.Size = UDim2.new(1, -20, 0, 20)
AimbotLabel.BackgroundTransparency = 1
AimbotLabel.Text = "Aimbot: trava mira no NPC mais próximo"
AimbotLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotLabel.Font = Enum.Font.Gotham
AimbotLabel.TextSize = 12

local AimbotButton = Instance.new("TextButton", MainFrame)
AimbotButton.Position = UDim2.new(0.5, -60, 0, 170)
AimbotButton.Size = UDim2.new(0, 120, 0, 35)
AimbotButton.BackgroundColor3 = Color3.fromRGB(30, 0, 60)
AimbotButton.BorderColor3 = Color3.fromRGB(170, 0, 255)
AimbotButton.BorderSizePixel = 2
AimbotButton.Text = "Aimbot: OFF"
AimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotButton.Font = Enum.Font.GothamBold
AimbotButton.TextSize = 14

-- Aimbot lógica
local aimbotAtivo = false
local RunService = game:GetService("RunService")

local function getClosestNPC()
    local closest, shortest = nil, math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= player.Character then
            local distance = (v:GetPivot().Position - player.Character:GetPivot().Position).Magnitude
            if distance < shortest then
                closest = v
                shortest = distance
            end
        end
    end
    return closest
end

local function travarMira()
    RunService:BindToRenderStep("Aimbot", Enum.RenderPriority.Camera.Value + 1, function()
        local target = getClosestNPC()
        if target and target:FindFirstChild("HumanoidRootPart") then
            workspace.CurrentCamera.CFrame = CFrame.new(
                workspace.CurrentCamera.CFrame.Position,
                target.HumanoidRootPart.Position
            )
        end
    end)
end

local function desligarMira()
    RunService:UnbindFromRenderStep("Aimbot")
end

AimbotButton.MouseButton1Click:Connect(function()
    aimbotAtivo = not aimbotAtivo
    AimbotButton.Text = aimbotAtivo and "Aimbot: ON" or "Aimbot: OFF"
    if aimbotAtivo then
        travarMira()
    else
        desligarMira()
    end
end)

-- Toggle do painel
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
