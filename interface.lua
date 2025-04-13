-- Criar a GUI principal
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ModernScript"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Função para criar o botão flutuante com imagem de arma (móvel)
local function createFloatingButton(imageID, position)
    local button = Instance.new("TextButton", gui)
    button.Size = UDim2.new(0, 60, 0, 60)
    button.Position = position
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Image = imageID
    button.Draggable = true  -- Torna o botão móvel
    return button
end

-- Botão flutuante para abrir/fechar a interface (ícone de arma)
local floatButton = createFloatingButton("rbxassetid://1234567890", UDim2.new(0, 10, 0.5, -30)) -- Atualize o ID da imagem
floatButton.MouseButton1Click:Connect(function()
    if interface.Visible then
        interface:TweenPosition(UDim2.new(0, -400, 0.5, -250), "Out", "Quad", 0.5, true)
    else
        interface:TweenPosition(UDim2.new(0, 10, 0.5, -250), "Out", "Quad", 0.5, true)
    end
    interface.Visible = not interface.Visible
end)

-- Painel principal da interface
local interface = Instance.new("Frame", gui)
interface.Size = UDim2.new(0, 400, 0, 500)
interface.Position = UDim2.new(0, -400, 0.5, -250)
interface.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
interface.BackgroundTransparency = 0.6
interface.Visible = false
interface.ClipsDescendants = true

-- Função para criar uma aba na interface
local function createTab(name, position)
    local tab = Instance.new("TextButton", interface)
    tab.Size = UDim2.new(0, 380, 0, 40)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 20
    return tab
end

-- Criando abas
local aimbotTab = createTab("Aimbot", UDim2.new(0, 10, 0, 50))
local executorTab = createTab("Executor", UDim2.new(0, 10, 0, 100))
local skinTab = createTab("Skin Changer", UDim2.new(0, 10, 0, 150))
local dataTab = createTab("Dados do Script", UDim2.new(0, 10, 0, 200))

-- Função para criar botão do aimbot
local aimbotButton = Instance.new("TextButton", interface)
aimbotButton.Size = UDim2.new(0, 380, 0, 40)
aimbotButton.Position = UDim2.new(0, 10, 0, 250)
aimbotButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
aimbotButton.Text = "Ativar Aimbot"
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotButton.TextSize = 20

-- Variáveis de controle
local aimbotActive = false
local aimbotIndicator = nil
local aimbotType = nil -- Tipo de aimbot (Player ou Mobs)
local aimbotOnOffButton = nil -- Para o botão On/Off

-- Quando o botão de aimbot for pressionado
aimbotButton.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        -- Adiciona o botão On/Off para aimbot
        aimbotOnOffButton = Instance.new("TextButton", interface)
        aimbotOnOffButton.Size = UDim2.new(0, 380, 0, 40)
        aimbotOnOffButton.Position = UDim2.new(0, 10, 0, 300)
        aimbotOnOffButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        aimbotOnOffButton.Text = "Aimbot: ON"
        aimbotOnOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        aimbotOnOffButton.TextSize = 20
        -- Se o aimbot estiver ativado, cria a bola roxa
        aimbotIndicator = Instance.new("Part", workspace)
        aimbotIndicator.Shape = Enum.PartType.Ball
        aimbotIndicator.Size = Vector3.new(5, 5, 5)
        aimbotIndicator.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        aimbotIndicator.Color = Color3.fromRGB(255, 0, 255)
        aimbotIndicator.Anchored = true
    else
        -- Desativa o aimbot e remove a bola roxa
        if aimbotIndicator then
            aimbotIndicator:Destroy()
        end
        if aimbotOnOffButton then
            aimbotOnOffButton:Destroy()
        end
    end
end)

-- Função para criar as opções de Aimbot Player e Aimbot Mobs
local aimbotPlayerButton = Instance.new("TextButton", aimbotTab)
aimbotPlayerButton.Size = UDim2.new(0, 380, 0, 40)
aimbotPlayerButton.Position = UDim2.new(0, 10, 0, 50)
aimbotPlayerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
aimbotPlayerButton.Text = "Aimbot Player"
aimbotPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotPlayerButton.TextSize = 20

local aimbotMobsButton = Instance.new("TextButton", aimbotTab)
aimbotMobsButton.Size = UDim2.new(0, 380, 0, 40)
aimbotMobsButton.Position = UDim2.new(0, 10, 0, 100)
aimbotMobsButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
aimbotMobsButton.Text = "Aimbot Mobs"
aimbotMobsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotMobsButton.TextSize = 20

-- Definir qual tipo de aimbot será ativado
aimbotPlayerButton.MouseButton1Click:Connect(function()
    aimbotType = "Player"
end)

aimbotMobsButton.MouseButton1Click:Connect(function()
    aimbotType = "Mobs"
end)

-- Função para mover o aimbot com o personagem (Não foco no personagem do player)
game:GetService("RunService").Heartbeat:Connect(function()
    if aimbotActive and aimbotIndicator then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            aimbotIndicator.Position = character.HumanoidRootPart.Position
        end
    end
end)

-- Função para o aimbot focar nos jogadores ou mobs ao invés do jogador local
local function getTarget()
    local closestTarget = nil
    local closestDistance = math.huge
    
    -- Definir targets como outros players ou mobs
    for _, target in pairs(game.Workspace:GetChildren()) do
        if target:FindFirstChild("Humanoid") and target:FindFirstChild("HumanoidRootPart") then
            if target.Name ~= game.Players.LocalPlayer.Name then
                local dist = (target.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist < closestDistance then
                    closestDistance = dist
                    closestTarget = target
                end
            end
        end
    end

    return closestTarget
end

-- Verificar se o aimbot está ativo e seguir o alvo
game:GetService("RunService").Heartbeat:Connect(function()
    if aimbotActive and aimbotType then
        local target = getTarget()

        if target then
            -- Move o aimbot para o alvo
            aimbotIndicator.Position = target.HumanoidRootPart.Position
        end
    end
end)

-- Exibindo os dados do script
local function showScriptData()
    local dataFrame = Instance
