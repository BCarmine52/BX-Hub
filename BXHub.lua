-- BXHub.lua

local BXHub = {}

-- Função de inicialização para criar a HUD
function BXHub:initialize(player)
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Criando a tela principal da HUD
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "BXHub"
    mainFrame.Size = UDim2.new(0, 225, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -112, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderSizePixel = 0
    mainFrame.BackgroundTransparency = 0.5
    mainFrame.Parent = playerGui
    mainFrame.Active = true
    mainFrame.Draggable = true -- Para mover a HUD

    -- Título da HUD
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Text = "BX Hub"
    title.Font = Enum.Font.Bold
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.TextScaled = true
    title.Parent = mainFrame

    -- Botão de minimizar
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 50, 0, 50)
    minimizeButton.Position = UDim2.new(1, -50, 0, 0)
    minimizeButton.Text = "BX"
    minimizeButton.Font = Enum.Font.Bold
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.BackgroundTransparency = 0.5
    minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    minimizeButton.Parent = mainFrame

    local isMinimized = false

    minimizeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
        minimizeButton.Text = mainFrame.Visible and "BX" or ""
    end)

    -- Tabs
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
        tabButton.Font = Enum.Font.Bold
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.BackgroundTransparency = 0.5
        tabButton.Parent = mainFrame

        tabButton.MouseButton1Click:Connect(function()
            -- Lógica para trocar de tab
            for _, btn in ipairs(mainFrame:GetChildren()) do
                if btn:IsA("TextButton") and btn.Name == tab.Name then
                    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde
                else
                    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza
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
        button.Font = Enum.Font.Bold
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
