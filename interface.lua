-- Carregar a interface simplificada e garantir a compatibilidade móvel
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "SHADOW_UI"

-- Criando a aba de painel com fundo preto e bordas neon roxas
local panel = Instance.new("Frame", screenGui)
panel.Size = UDim2.new(0, 300, 0, 500)
panel.Position = UDim2.new(0.5, -150, 0.5, -250)
panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
panel.BorderSizePixel = 2
panel.BorderColor3 = Color3.fromRGB(138, 43, 226)  -- Roxo neon
panel.Visible = false

-- Botão flutuante para abrir/fechar a interface
local floatButton = Instance.new("TextButton", screenGui)
floatButton.Size = UDim2.new(0, 50, 0, 50)
floatButton.Position = UDim2.new(0, 20, 0, 20)
floatButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)  -- Roxo
floatButton.Text = "A"
floatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
floatButton.Font = Enum.Font.SourceSansBold
floatButton.TextSize = 24

floatButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

-- Criando a aba de "Dados do Script"
local dataTab = Instance.new("Frame", panel)
dataTab.Size = UDim2.new(1, 0, 0.2, 0)
dataTab.Position = UDim2.new(0, 0, 0, 0)
dataTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local dataLabel = Instance.new("TextLabel", dataTab)
dataLabel.Size = UDim2.new(1, 0, 1, 0)
dataLabel.Text = "Nome: SHADOW\nSkin: Default\nExecutor: KRNL"
dataLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
dataLabel.TextSize = 18
dataLabel.BackgroundTransparency = 1

-- Criando as opções de Aimbot
local aimbotTab = Instance.new("Frame", panel)
aimbotTab.Size = UDim2.new(1, 0, 0.3, 0)
aimbotTab.Position = UDim2.new(0, 0, 0.2, 0)
aimbotTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local aimbotLabel = Instance.new("TextLabel", aimbotTab)
aimbotLabel.Size = UDim2.new(1, 0, 0.5, 0)
aimbotLabel.Text = "Aimbot"
aimbotLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotLabel.TextSize = 24
aimbotLabel.BackgroundTransparency = 1

local aimbotToggle = Instance.new("TextButton", aimbotTab)
aimbotToggle.Size = UDim2.new(0.8, 0, 0.3, 0)
aimbotToggle.Position = UDim2.new(0.1, 0, 0.5, 0)
aimbotToggle.Text = "OFF"
aimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Vermelho (OFF)

local aimbotActive = false
local aimbotTarget = nil

-- Função para ativar e desativar o Aimbot
aimbotToggle.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        aimbotToggle.Text = "ON"
        aimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Verde (ON)
        -- Encontrar um alvo para o aimbot
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player ~= game.Players.LocalPlayer then
                aimbotTarget = player.Character.HumanoidRootPart
                break
            end
        end
    else
        aimbotToggle.Text = "OFF"
        aimbotToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Vermelho (OFF)
    end
end)

-- Função do Aimbot
game:GetService("RunService").Heartbeat:Connect(function()
    if aimbotActive and aimbotTarget then
        local targetPos = aimbotTarget.Position
        -- Ajustar a mira para o alvo
        -- Aqui você pode usar o código do aimbot para ajustar a posição da câmera ou para seguir o alvo
    end
end)

-- Criar a função para o Aimbot de Mobs
local mobAimbotTab = Instance.new("Frame", panel)
mobAimbotTab.Size = UDim2.new(1, 0, 0.3, 0)
mobAimbotTab.Position = UDim2.new(0, 0, 0.5, 0)
mobAimbotTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local mobAimbotLabel = Instance.new("TextLabel", mobAimbotTab)
mobAimbotLabel.Size = UDim2.new(1, 0, 0.5, 0)
mobAimbotLabel.Text = "Aimbot - Mobs"
mobAimbotLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mobAimbotLabel.TextSize = 24
mobAimbotLabel.BackgroundTransparency = 1

local mobAimbotToggle = Instance.new("TextButton", mobAimbotTab)
mobAimbotToggle.Size = UDim2.new(0.8, 0, 0.3, 0)
mobAimbotToggle.Position = UDim2.new(0.1, 0, 0.5, 0)
mobAimbotToggle.Text = "OFF"
mobAimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mobAimbotToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Vermelho (OFF)

local mobAimbotActive = false
local mobAimbotTarget = nil

-- Função para ativar e desativar o Aimbot de Mobs
mobAimbotToggle.MouseButton1Click:Connect(function()
    mobAimbotActive = not mobAimbotActive
    if mobAimbotActive then
        mobAimbotToggle.Text = "ON"
        mobAimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Verde (ON)
        -- Aqui você pode implementar a lógica para encontrar e mirar em mobs
    else
        mobAimbotToggle.Text = "OFF"
        mobAimbotToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Vermelho (OFF)
    end
end)

-- Função do Aimbot de Mobs
game:GetService("RunService").Heartbeat:Connect(function()
    if mobAimbotActive and mobAimbotTarget then
        local targetPos = mobAimbotTarget.Position
        -- Ajustar a mira para o mob
    end
end
