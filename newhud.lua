-- Biblioteca UnLeaked modificada para suportar múltiplas tabs
--[[
  UI lib made by bungie#0001
  
  - Please do not use this without permission, I am working really hard on this UI to make it perfect and do not have a big 
    problem with other people using it, please just make sure you message me and ask me before using.
]]

-- / Locals
local Workspace = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- / Services
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")  -- Definindo RunService corretamente
local CoreGuiService = game:GetService("CoreGui")
local ContentService = game:GetService("ContentProvider")
local TeleportService = game:GetService("TeleportService")

local library = {
    version = "2.0.2",
    title = title or "xsx " .. tostring(math.random(1,366)),
    fps = 0,
    rank = "private"
}

coroutine.wrap(function()
    RunService.RenderStepped:Connect(function(v)
        library.fps =  math.round(1/v)
    end)
end)()

-- Função modificada para criação de múltiplas tabs
function library:Init(key)
    for _,v in next, CoreGuiService:GetChildren() do
        if v.Name == "screen" then
            v:Destroy()
        end
    end

    local title = library.title
    key = key or Enum.KeyCode.RightAlt

    -- [CÓDIGO DA GUI E CRIAÇÃO DE ELEMENTOS DA INTERFACE]
    -- AQUI SERÁ INCLUÍDA A FUNÇÃO PARA CRIAÇÃO E EXIBIÇÃO DAS MULTIPLAS TABS
end

-- [RESTANTE DO CÓDIGO ORIGINAL]
