-- BXHub.lua

local BXHub = {}

-- Função para criar a janela principal da HUD
function BXHub:CreateWindow(title)
    title = title or "HUD"

    -- Criação do Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = title
    mainFrame.Size = UDim2.new(0, 225, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -112, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderSizePixel = 0
    mainFrame.BackgroundTransparency = 0.5
    mainFrame.Active = true
    mainFrame.Draggable = true -- Permite arrastar a HUD

    -- Título da HUD
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold -- Fonte em negrito válida
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextScaled = true
    titleLabel.Parent = mainFrame

    return mainFrame -- Retorna o frame principal criado
end

-- Função de inicialização para adicionar a HUD ao PlayerGui
function BXHub:initialize(player)
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Criar e configurar a janela principal com o título
    local mainFrame = self:CreateWindow("BX Hub")
    mainFrame.Parent = playerGui -- Adiciona a HUD ao PlayerGui do jogador

    -- Botão de minimizar
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 50, 0, 50)
    minimizeButton.Position = UDim2.new(1, -50, 0, 0)
    minimizeButton.Text = "BX"
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.BackgroundTransparency = 0.5
    minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    minimizeButton.Parent = mainFrame

    local isMinimized = false

    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        mainFrame.Visible = not isMinimized
        minimizeButton.Text = isMinimized and "BX" or "BX Hub"
    end)

    -- Tabs e sistema de animação para a seleção ativa
    local tabs = {
        { Name = "Main", Buttons = {
            { Text = "Baby Farm" },
            { Text = "Pet Farm" },
            { Text = "Farm All Pets" },
            { Text = "Farm AgeUp" },
            { Text = "Save Config" },
            { Text = "Unload" }
        }},
        { Name = "Shop", Buttons = {
            { Text = "Quantity Eggs" },
            { Text = "Select Egg" },
            { Text = "Buy Selected Egg" }
        }}
    }

    for _, tab in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Text = tab.Name
        tabButton.Size = UDim2.new(0.5, 0, 0, 25)
        tabButton.Position = UDim2.new(0.5 * (_ - 1), 0, 0, 25)
        tabButton.Font = Enum.Font.GothamBold
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.BackgroundTransparency = 0.5
        tabButton.Parent = mainFrame

        tabButton.MouseButton1Click:Connect(function()
            for _, btn in ipairs(mainFrame:GetChildren()) do
                if btn:IsA("TextButton") and btn.Name == tab.Name then
                    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde para o tab ativo
                else
                    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza para tabs inativos
                end
            end
        end)
    end

    -- Funções auxiliares para criar botões e checkboxes
    local function createButton(parent, text, position)
        local button = Instance.new("TextButton")
        button.Text = text
        button.Size = UDim2.new(0, 100, 0, 25)
        button.Position = position
        button.Font = Enum.Font.GothamBold
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.BackgroundTransparency = 0.5
        button.Parent = parent
        return button
    end

    local function createCheckbox(parent, position)
        local checkbox = Instance.new("Frame")
        checkbox.Size = UDim2.new(0, 20, 0, 20)
        checkbox.Position = position
        checkbox.BackgroundColor3 = Color3.fromRGB(128, 128, 128) -- Cinza inicial
        checkbox.Parent = parent
        checkbox.Name = "Checkbox"

        checkbox.MouseButton1Click:Connect(function()
            if checkbox.BackgroundColor3 == Color3.fromRGB(0, 255, 0) then
                checkbox.BackgroundColor3 = Color3.fromRGB(128, 128, 128) -- Desativa
            else
                checkbox.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Ativa
            end
        end)
        
        return checkbox
    end

    -- Criação dos botões na tab Main
    local mainTab = Instance.new("Frame")
    mainTab.Name = "Main"
    mainTab.Size = UDim2.new(1, 0, 1, -25)
    mainTab.Position = UDim2.new(0, 0, 0, 50)
    mainTab.BackgroundTransparency = 1
    mainTab.Visible = true
    mainTab.Parent = mainFrame

    -- Botões com checkbox
    local buttons = {
        {Text = "Baby Farm", Position = UDim2.new(0, 10, 0, 60)},
        {Text = "Pet Farm", Position = UDim2.new(0, 10, 0, 90)},
        {Text = "Farm All Pets", Position = UDim2.new(0, 10, 0, 120)},
        {Text = "Farm AgeUp", Position = UDim2.new(0, 10, 0, 150)}
    }

    for _, btnInfo in ipairs(buttons) do
        local button = createButton(mainTab, btnInfo.Text, btnInfo.Position)
        createCheckbox(button, UDim2.new(1, -30, 0, 0))
    end

    -- Botões Save Config e Unload
    local saveButton = createButton(mainTab, "Save Config", UDim2.new(0, 10, 0, 180))
    local unloadButton = createButton(mainTab, "Unload", UDim2.new(0, 10, 0, 210))

    -- Função para fechar HUD
    unloadButton.MouseButton1Click:Connect(function()
        mainFrame:Destroy()
    end)
end

return BXHub
