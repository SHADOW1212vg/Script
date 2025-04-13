
-- Interface SHADOW com layout moderno (cinza) e suporte mobile
local User = game.Players.LocalPlayer
local Mouse = User:GetMouse()
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.ResetOnSpawn = false

-- Painel principal
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 280)
Main.Position = UDim2.new(0.5, -175, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 12)

-- Título
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "SHADOW HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold

-- Abas
local Tabs = {}
local function createTab(name, posX)
    local tab = Instance.new("TextButton", Main)
    tab.Size = UDim2.new(0, 100, 0, 30)
    tab.Position = UDim2.new(0, posX, 0, 50)
    tab.Text = name
    tab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 14
    tab.Font = Enum.Font.GothamSemibold
    tab.Name = name.."Tab"

    local corner = Instance.new("UICorner", tab)
    corner.CornerRadius = UDim.new(0, 8)

    Tabs[name] = tab
end

createTab("Aimbot Player", 10)
createTab("Aimbot Mobs", 120)
createTab("Dados", 230)

-- Conteúdo
local OnOffButton = Instance.new("TextButton", ScreenGui)
OnOffButton.Size = UDim2.new(0, 80, 0, 40)
OnOffButton.Position = UDim2.new(0.5, -40, 0.8, 0)
OnOffButton.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
OnOffButton.Text = "ON / OFF"
OnOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OnOffButton.TextSize = 14
OnOffButton.Visible = false
OnOffButton.Name = "AimbotToggle"

local ButtonCorner = Instance.new("UICorner", OnOffButton)
ButtonCorner.CornerRadius = UDim.new(0, 8)

Tabs["Aimbot Player"].MouseButton1Click:Connect(function()
    OnOffButton.Visible = true
end)

Tabs["Aimbot Mobs"].MouseButton1Click:Connect(function()
    OnOffButton.Visible = true
end)

-- Flutuante para abrir/fechar
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
ToggleBtn.Image = "rbxassetid://13042449981" -- Ícone de arma (batata frita se preferir trocar)
ToggleBtn.BackgroundTransparency = 1

local dragging, dragInput, dragStart, startPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)
