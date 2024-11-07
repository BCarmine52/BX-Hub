-- Adicionando função Unload na biblioteca Yun
function initLibrary()
    local folderName = "epic config folder"
    if not isfolder(folderName) then
        makefolder(folderName)
    end

    local gameConfigFolder = folderName .. "/" .. game.PlaceId
    if not isfolder(gameConfigFolder) then
        makefolder(gameConfigFolder)
    end

    local inputService = game:GetService("UserInputService")
    local tweenService = game:GetService("TweenService")
    local runService = game:GetService("RunService")
    local coreGui = game:GetService("CoreGui")

    local utility = {}
    function utility.create(class, properties)
        local obj = Instance.new(class)
        for prop, v in next, properties or {} do
            obj[prop] = v
        end
        obj.AutoButtonColor = false
        return obj
    end

    -- Configuração da biblioteca
    local library = {}
    
    -- Função Unload para fechar e remover a HUD
    function library:Unload()
        if coreGui:FindFirstChild("screen") then
            coreGui:FindFirstChild("screen"):Destroy()
            print("HUD descarregada com sucesso.")
        end
    end

    -- Funções e definições restantes da biblioteca
    function library:Load(options)
        -- Configuração inicial da janela principal
        local window = {
            name = options.name or "My Library",
            sizeX = options.sizeX or 500,
            sizeY = options.sizeY or 600,
            color = options.color or Color3.fromRGB(255, 255, 255)
        }
        
        -- Criação do GUI
        local screen = utility.create("ScreenGui", { Name = "screen", Parent = coreGui })
        local mainFrame = utility.create("Frame", {
            Parent = screen,
            Size = UDim2.new(0, window.sizeX, 0, window.sizeY),
            Position = UDim2.new(0.5, -window.sizeX / 2, 0.5, -window.sizeY / 2),
            BackgroundColor3 = window.color,
            AnchorPoint = Vector2.new(0.5, 0.5),
        })

        -- Adicionando Tabs
        function window:Tab(name)
            local tab = {}
            tab.name = name
            tab.frame = utility.create("Frame", {
                Parent = mainFrame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            })

            function tab:Section(options)
                local section = {}
                section.name = options.name
                section.column = options.column or 1
                section.frame = utility.create("Frame", {
                    Parent = tab.frame,
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Color3.fromRGB(100, 100, 100),
                    BorderSizePixel = 0
                })

                function section:Toggle(options)
                    local toggle = utility.create("TextButton", {
                        Parent = section.frame,
                        Text = options.Name,
                        Size = UDim2.new(0, 100, 0, 30),
                        BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                        TextColor3 = Color3.fromRGB(255, 255, 255)
                    })
                    toggle.MouseButton1Click:Connect(function()
                        options.callback(not toggle.Selected)
                        toggle.Selected = not toggle.Selected
                    end)
                end

                function section:Button(options)
                    local button = utility.create("TextButton", {
                        Parent = section.frame,
                        Text = options.Name,
                        Size = UDim2.new(0, 100, 0, 30),
                        BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                        TextColor3 = Color3.fromRGB(255, 255, 255)
                    })
                    button.MouseButton1Click:Connect(options.callback)
                end
                
                return section
            end
            return tab
        end
        return window
    end

    return library
end
