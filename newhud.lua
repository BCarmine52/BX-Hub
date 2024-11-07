
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

    -- Função Unload para fechar e remover a HUD
    local library = {}
    function library:Unload()
        if coreGui:FindFirstChild("screen") then
            coreGui:FindFirstChild("screen"):Destroy()
            print("HUD descarregada com sucesso.")
        end
    end

    -- Restante das funções da biblioteca

    -- Retorna a biblioteca com a função Unload adicionada
    return library
end
