-- Função para encontrar todos os jogadores no servidor
local function getAllPlayers()
    local players = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(players, player.Name)
    end
    return players
end

-- Função para acompanhar o inimigo
local function aimAt(target)
    local camera = game.Workspace.CurrentCamera
    camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
end

-- Variáveis do aimbot
local aimbotEnabled = false
local selectedPlayers = {}

-- Atualiza o aimbot
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled and #selectedPlayers > 0 then
        for _, player in ipairs(selectedPlayers) do
            if player and player.Character then
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    aimAt(targetRoot)
                end
            end
        end
    end
end)

-- Criação da interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local PlayerDropdown = Instance.new("TextButton")
local PlayerList = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Active = true
Frame.Draggable = true

TitleLabel.Parent = Frame
TitleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Text = "J445DX"
TitleLabel.TextSize = 20

ToggleButton.Parent = Frame
ToggleButton.BackgroundColor3 = Color3.new(1, 0, 0)
ToggleButton.Position = UDim2.new(0, 10, 0, 120)
ToggleButton.Size = UDim2.new(0, 280, 0, 30)
ToggleButton.Text = "Ligar"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)

PlayerDropdown.Parent = Frame
PlayerDropdown.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
PlayerDropdown.Position = UDim2.new(0, 10, 0, 50)
PlayerDropdown.Size = UDim2.new(0, 280, 0, 30)
PlayerDropdown.Text = "Select Players"
PlayerDropdown.TextColor3 = Color3.new(1, 1, 1)

PlayerList.Parent = Frame
PlayerList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerList.Position = UDim2.new(0, 10, 0, 80)
PlayerList.Size = UDim2.new(0, 280, 0, 100)
PlayerList.Visible = false

UIListLayout.Parent = PlayerList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

PlayerDropdown.MouseButton1Click:Connect(function()
    PlayerList.Visible = not PlayerList.Visible
    if PlayerList.Visible then
        for _, playerName in ipairs(getAllPlayers()) do
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Parent = PlayerList
            PlayerButton.Size = UDim2.new(1, 0, 0, 30)
            PlayerButton.Text = playerName
            PlayerButton.TextColor3 = Color3.new(1, 1, 1)
            PlayerButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            PlayerButton.MouseButton1Click:Connect(function()
                table.insert(selectedPlayers, game.Players:FindFirstChild(playerName))
                PlayerDropdown.Text = "Target: " .. playerName
                PlayerList.Visible = false
            end)
        end
    else
        for _, child in ipairs(PlayerList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        ToggleButton.BackgroundColor3 = Color3.new(0, 1, 0)
        ToggleButton.Text = "Desligar"
    else
        ToggleButton.BackgroundColor3 = Color3.new(1, 0, 0)
        ToggleButton.Text = "Ligar"
    end
end)