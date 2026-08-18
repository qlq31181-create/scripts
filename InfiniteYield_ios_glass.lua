-- Infinite Yield FE v6.4.2 (Modificado)
-- Interfaz iOS Glass | Español
-- Credit: Edge // Zwolf // Moon // Toon // Peyton // ATP

if IY_LOADED and not _G.IY_DEBUG then return end
pcall(function() getgenv().IY_LOADED = true end)
if not game:IsLoaded() then game.Loaded:Wait() end

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

cloneref = missing("function", cloneref, function(...) return ... end)
sethidden = missing("function", sethiddenproperty or set_hidden_property or set_hidden_prop)
gethidden = missing("function", gethiddenproperty or get_hidden_property or get_hidden_prop)
queueteleport = missing("function", queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport))
httprequest = missing("function", request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request))
everyClipboard = missing("function", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))
firetouchinterest = missing("function", firetouchinterest)
hookfunction = missing("function", hookfunction)
hookmetamethod = missing("function", hookmetamethod)
getnamecallmethod = missing("function", getnamecallmethod or get_namecall_method)
checkcaller = missing("function", checkcaller, function() return false end)
newcclosure = missing("function", newcclosure, function(f, ...) return f(...) end)
getgc = missing("function", getgc or get_gc_objects)

Services = setmetatable({}, {
    __index = function(self, name)
        local success, cache = pcall(function()
            return cloneref(game:GetService(name))
        end)
        if success then
            rawset(self, name, cache)
            return cache
        end
    end
})

Players = Services.Players
UserInputService = Services.UserInputService
TweenService = Services.TweenService
HttpService = Services.HttpService
RunService = Services.RunService
TeleportService = Services.TeleportService
StarterGui = Services.StarterGui
Lighting = Services.Lighting
ReplicatedStorage = Services.ReplicatedStorage
PathService = Services.PathfindingService
Teams = Services.Teams

PlayerGui = cloneref(Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui"))
COREGUI = Services.CoreGui or PlayerGui
IYMouse = cloneref(Players.LocalPlayer:GetMouse())
PlaceId, JobId = game.PlaceId, game.JobId

xpcall(function()
    IsOnMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, UserInputService:GetPlatform())
end, function()
    IsOnMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end)

currentVersion = "6.4.2"

-- ==================== COLORES iOS GLASS ====================
local iosColors = {
    bg = Color3.fromRGB(255, 255, 255),
    bgTransparency = 0.85,
    titleBar = Color3.fromRGB(242, 242, 247),
    titleText = Color3.fromRGB(0, 0, 0),
    accent = Color3.fromRGB(0, 122, 255),
    text = Color3.fromRGB(0, 0, 0),
    textSecondary = Color3.fromRGB(142, 142, 147),
    separator = Color3.fromRGB(209, 209, 214),
    cell = Color3.fromRGB(255, 255, 255),
    cellTransparency = 0.1,
    shadow = Color3.fromRGB(0, 0, 0),
    notification = Color3.fromRGB(255, 255, 255),
}

-- ==================== CREAR GUI ====================
local function randomString()
    local length = math.random(10, 20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

PARENT = nil
MAX_DISPLAY_ORDER = 1.7976931348623157e308

if get_hidden_gui or gethui then
    local hiddenUI = get_hidden_gui or gethui
    local Main = Instance.new("ScreenGui")
    Main.Name = randomString()
    Main.ResetOnSpawn = false
    Main.DisplayOrder = MAX_DISPLAY_ORDER
    Main.Parent = hiddenUI()
    PARENT = Main
elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
    local Main = Instance.new("ScreenGui")
    Main.Name = randomString()
    Main.ResetOnSpawn = false
    Main.DisplayOrder = MAX_DISPLAY_ORDER
    syn.protect_gui(Main)
    Main.Parent = COREGUI
    PARENT = Main
elseif COREGUI:FindFirstChild("RobloxGui") then
    PARENT = COREGUI.RobloxGui
else
    local Main = Instance.new("ScreenGui")
    Main.Name = randomString()
    Main.ResetOnSpawn = false
    Main.DisplayOrder = MAX_DISPLAY_ORDER
    Main.Parent = COREGUI
    PARENT = Main
end

-- ==================== PANEL PRINCIPAL ====================
local ScaledHolder = Instance.new("Frame")
ScaledHolder.Name = randomString()
ScaledHolder.Size = UDim2.fromScale(1, 1)
ScaledHolder.BackgroundTransparency = 1
ScaledHolder.Parent = PARENT

local Holder = Instance.new("Frame")
Holder.Name = randomString()
Holder.Parent = ScaledHolder
Holder.Active = true
Holder.AnchorPoint = Vector2.new(1, 1)
Holder.Position = UDim2.new(1, -20, 1, -20)
Holder.Size = UDim2.new(0, 280, 0, 360)
Holder.BackgroundColor3 = iosColors.bg
Holder.BackgroundTransparency = iosColors.bgTransparency
Holder.BorderSizePixel = 0
Holder.ZIndex = 10

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = Holder

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(200, 200, 200)
stroke.Thickness = 0.5
stroke.Transparency = 0.5
stroke.Parent = Holder

-- Shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Parent = Holder
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(23, 23, 277, 277)
shadow.ZIndex = 9

-- ==================== BARRA DE TITULO ====================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = Holder
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = iosColors.titleBar
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 11

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TitleBar
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Infinite Yield v" .. currentVersion
Title.TextColor3 = iosColors.titleText
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 11

-- Boton cerrar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "Close"
CloseBtn.Parent = TitleBar
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
CloseBtn.Text = ""
CloseBtn.ZIndex = 12

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = CloseBtn

local closeIcon = Instance.new("TextLabel")
closeIcon.Parent = CloseBtn
closeIcon.Size = UDim2.new(1, 0, 1, 0)
closeIcon.BackgroundTransparency = 1
closeIcon.Text = "X"
closeIcon.TextColor3 = Color3.new(1, 1, 1)
closeIcon.Font = Enum.Font.GothamBold
closeIcon.TextSize = 12
closeIcon.ZIndex = 12

CloseBtn.MouseButton1Click:Connect(function()
    ScaledHolder:Destroy()
end)

-- Boton minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "Minimize"
MinBtn.Parent = TitleBar
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -70, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 159, 10)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.ZIndex = 12

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = MinBtn

-- Drag
local dragStart, startPos, dragging
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Holder.Position
    end
end)
TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        Holder.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- Minimizar
local minimized = false
local fullSize = Holder.Size
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        fullSize = Holder.Size
        Holder:TweenSize(UDim2.new(0, 280, 0, 44), "Out", "Quad", 0.2)
    else
        Holder:TweenSize(fullSize, "Out", "Quad", 0.2)
    end
end)

-- ==================== BARRA DE COMANDOS ====================
local CmdBar = Instance.new("Frame")
CmdBar.Name = "CmdBar"
CmdBar.Parent = Holder
CmdBar.Size = UDim2.new(1, -16, 0, 36)
CmdBar.Position = UDim2.new(0, 8, 0, 52)
CmdBar.BackgroundColor3 = iosColors.cell
CmdBar.BackgroundTransparency = 0.15
CmdBar.BorderSizePixel = 0
CmdBar.ZIndex = 11

local cmdCorner = Instance.new("UICorner")
cmdCorner.CornerRadius = UDim.new(0, 10)
cmdCorner.Parent = CmdBar

local CmdInput = Instance.new("TextBox")
CmdInput.Name = "Input"
CmdInput.Parent = CmdBar
CmdInput.Size = UDim2.new(1, -16, 1, 0)
CmdInput.Position = UDim2.new(0, 8, 0, 0)
CmdInput.BackgroundTransparency = 1
CmdInput.Text = ""
CmdInput.PlaceholderText = "Escribe un comando..."
CmdInput.PlaceholderColor3 = iosColors.textSecondary
CmdInput.TextColor3 = iosColors.text
CmdInput.Font = Enum.Font.Gotham
CmdInput.TextSize = 14
CmdInput.TextXAlignment = Enum.TextXAlignment.Left
CmdInput.ClearTextOnFocus = false
CmdInput.ZIndex = 11

-- ==================== ZONA DE COMANDOS ====================
local CMDsF = Instance.new("ScrollingFrame")
CMDsF.Name = "CMDs"
CMDsF.Parent = Holder
CMDsF.Size = UDim2.new(1, -16, 1, -100)
CMDsF.Position = UDim2.new(0, 8, 0, 94)
CMDsF.BackgroundTransparency = 1
CMDsF.BorderSizePixel = 0
CMDsF.ScrollBarThickness = 4
CMDsF.ScrollBarImageColor3 = iosColors.accent
CMDsF.CanvasSize = UDim2.new(0, 0, 0, 0)
CMDsF.ZIndex = 11

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = CMDsF
listLayout.Padding = UDim.new(0, 4)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

local padding = Instance.new("UIPadding")
padding.Parent = CMDsF
padding.PaddingTop = UDim.new(0, 4)
padding.PaddingBottom = UDim.new(0, 4)

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    CMDsF.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 8)
end)

-- ==================== FUNCION DE COMANDOS ====================
local commands = {}
local cmdCount = 0

local function addCmd(name, desc, func)
    cmdCount = cmdCount + 1
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = CMDsF
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = iosColors.cell
    btn.BackgroundTransparency = 0.15
    btn.BorderSizePixel = 0
    btn.LayoutOrder = cmdCount
    btn.ZIndex = 11

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn

    local label = Instance.new("TextLabel")
    label.Parent = btn
    label.Size = UDim2.new(1, -16, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = iosColors.text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 11

    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = btn
    descLabel.Size = UDim2.new(1, -16, 0, 14)
    descLabel.Position = UDim2.new(0, 12, 1, -16)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = iosColors.textSecondary
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 10
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.ZIndex = 11

    btn.MouseButton1Click:Connect(function()
        pcall(func)
    end)

    commands[name:lower()] = {desc = desc, func = func}

    local baseName = name:match("^(%S+)")
    if baseName and baseName:lower() ~= name:lower() then
        commands[baseName:lower()] = {desc = desc, func = func}
    end
end

-- ==================== COMANDOS ====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getRoot()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHum()
    local char = getChar()
    return char and char:FindFirstChild("Humanoid")
end

-- Volar
local flyActive = false
local flyGyro, flyVel
addCmd("Volar", "Activar/desactivar volar", function()
    flyActive = not flyActive
    if flyActive then
        local root = getRoot()
        if not root then return end
        flyGyro = Instance.new("BodyGyro")
        flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyGyro.P = 9e9
        flyGyro.Parent = root
        flyVel = Instance.new("BodyVelocity")
        flyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyVel.Velocity = Vector3.new(0, 0, 0)
        flyVel.P = 1000
        flyVel.Parent = root
        RunService.RenderStepped:Connect(function()
            if not flyActive then return end
            local moveDir = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            flyVel.Velocity = moveDir * 60
            flyGyro.CFrame = Camera.CFrame
        end)
    else
        if flyGyro then flyGyro:Destroy() flyGyro = nil end
        if flyVel then flyVel:Destroy() flyVel = nil end
    end
end)

-- Velocidad
addCmd("Velocidad [num]", "Cambiar velocidad (default 16)", function(speed)
    local hum = getHum()
    if hum then hum.WalkSpeed = tonumber(speed) or 16 end
end)

-- Salto
addCmd("Salto [num]", "Cambiar altura de salto", function(power)
    local hum = getHum()
    if hum then hum.JumpPower = tonumber(power) or 50 end
end)

-- Noclip
local noclipActive = false
addCmd("Noclip", "Activar/desactivar noclip", function()
    noclipActive = not noclipActive
end)

RunService.Stepped:Connect(function()
    if noclipActive then
        local char = LocalPlayer.Character
        if char then
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
end)

-- God Mode
local godActive = false
addCmd("God Mode", "Activar/desactivar modo dios", function()
    godActive = not godActive
    if godActive then
        local hum = getHum()
        if hum then hum.MaxHealth = math.huge hum.Health = math.huge end
    else
        local hum = getHum()
        if hum then hum.MaxHealth = 100 hum.Health = 100 end
    end
end)

-- ESP
local espActive = false
local espObjects = {}
addCmd("ESP", "Activar/desactivar ESP de jugadores", function()
    espActive = not espActive
    if not espActive then
        for _, v in pairs(espObjects) do
            if v and v.Parent then v:Destroy() end
        end
        espObjects = {}
    end
end)

RunService.RenderStepped:Connect(function()
    if espActive then
        for _, v in pairs(espObjects) do
            if v and v.Parent then v:Destroy() end
        end
        espObjects = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChild("Humanoid")
                if root and hum and hum.Health > 0 then
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0, 100, 0, 40)
                    bill.StudsOffset = Vector3.new(0, 3, 0)
                    bill.Adornee = root
                    bill.AlwaysOnTop = true
                    bill.Parent = root

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 0, 16)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = plr.Name
                    nameLabel.TextColor3 = Color3.fromRGB(0, 122, 255)
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.TextSize = 12
                    nameLabel.Parent = bill

                    local healthLabel = Instance.new("TextLabel")
                    healthLabel.Size = UDim2.new(1, 0, 0, 12)
                    healthLabel.Position = UDim2.new(0, 0, 0, 16)
                    healthLabel.BackgroundTransparency = 1
                    healthLabel.Text = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
                    healthLabel.TextColor3 = Color3.fromRGB(52, 199, 89)
                    healthLabel.Font = Enum.Font.Gotham
                    healthLabel.TextSize = 10
                    healthLabel.Parent = bill

                    table.insert(espObjects, bill)
                end
            end
        end
    end
end)

-- Click TP
local clickTpActive = false
addCmd("Click TP", "Activar click para teletransportar", function()
    clickTpActive = not clickTpActive
end)

IYMouse.Button1Down:Connect(function()
    if clickTpActive then
        local root = getRoot()
        if root and IYMouse.Target then
            root.CFrame = IYMouse.Target.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

-- Teleport a jugador
addCmd("TP [jugador]", "Teletransportar a un jugador", function(targetName)
    local target = Players:FindFirstChild(targetName)
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        local myRoot = getRoot()
        if targetRoot and myRoot then
            myRoot.CFrame = targetRoot.CFrame
        end
    end
end)

-- Traer jugador
addCmd("Traer [jugador]", "Traer un jugador hacia ti", function(targetName)
    local target = Players:FindFirstChild(targetName)
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        local myRoot = getRoot()
        if targetRoot and myRoot then
            targetRoot.CFrame = myRoot.CFrame + Vector3.new(3, 0, 0)
        end
    end
end)

-- Invisibility
local invisActive = false
addCmd("Invisible", "Activar/desactivar invisibilidad", function()
    invisActive = not invisActive
    local char = getChar()
    if char then
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = invisActive and 1 or 0
            elseif v:IsA("Decal") then
                v.Transparency = invisActive and 1 or 0
            end
        end
    end
end)

-- Gravedad
addCmd("Gravedad [num]", "Cambiar gravedad", function(grav)
    Workspace.Gravity = tonumber(grav) or 196.2
end)

-- FOV
addCmd("FOV [num]", "Cambiar campo de vision", function(fov)
    Camera.FieldOfView = tonumber(fov) or 70
end)

-- NoClip
addCmd("Sin Paredes", "Lo mismo que Noclip", function()
    noclipActive = not noclipActive
end)

-- Respawn
addCmd("Respawn", "Reaparecer", function()
    LocalPlayer:LoadCharacter()
end)

-- Server Hop
addCmd("Cambiar Server", "Ir a otro servidor", function()
    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
    for _, server in ipairs(servers.data) do
        if server.id ~= JobId and server.playing < server.maxPlayers then
            TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
            break
        end
    end
end)

-- Anti AFK
local antiAfkActive = false
addCmd("Anti AFK", "Activar/desactivar anti AFK", function()
    antiAfkActive = not antiAfkActive
end)

spawn(function()
    while task.wait(10) do
        if antiAfkActive then
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)

-- Spam chat
addCmd("Spam [mensaje]", "Spamear un mensaje en el chat", function(msg)
    for i = 1, 10 do
        ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer(msg, "All")
        task.wait(0.5)
    end
end)

-- Durmiente
addCmd("Dormir", "Poner al jugador a dormir", function()
    local char = getChar()
    if char then
        local animate = char:FindFirstChild("Animate")
        if animate then
            animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=282575704"
        end
    end
end)

-- Caer
addCmd("Caer", "Hacer que todos caigan", function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + Vector3.new(0, -500, 0)
            end
        end
    end
end)

-- Lanzar
addCmd("Lanzar", "Lanzar a todos los jugadores", function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 500, 0)
                bv.MaxForce = Vector3.new(0, 5000, 0)
                bv.Parent = root
                game:GetService("Debris"):AddItem(bv, 0.1)
            end
        end
    end
end)

-- ==================== EJECUTAR COMANDO ====================
CmdInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and CmdInput.Text ~= "" then
        local text = CmdInput.Text
        local args = string.split(text, " ")
        local cmdName = table.remove(args, 1):lower()

        if commands[cmdName] then
            pcall(function()
                commands[cmdName].func(unpack(args))
            end)
        end

        CmdInput.Text = ""
    end
end)

-- ==================== NOTIFICACION ====================
spawn(function()
    task.wait(1)
    local notif = Instance.new("Frame")
    notif.Parent = ScaledHolder
    notif.Size = UDim2.new(0, 280, 0, 60)
    notif.Position = UDim2.new(0.5, -140, 1, 80)
    notif.BackgroundColor3 = iosColors.notification
    notif.BackgroundTransparency = 0.1
    notif.BorderSizePixel = 0
    notif.ZIndex = 20

    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 12)
    notifCorner.Parent = notif

    local notifStroke = Instance.new("UIStroke")
    notifStroke.Color = Color3.fromRGB(200, 200, 200)
    notifStroke.Thickness = 0.5
    notifStroke.Transparency = 0.5
    notifStroke.Parent = notif

    local notifTitle = Instance.new("TextLabel")
    notifTitle.Parent = notif
    notifTitle.Size = UDim2.new(1, -16, 0, 20)
    notifTitle.Position = UDim2.new(0, 8, 0, 8)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = "Infinite Yield Cargado"
    notifTitle.TextColor3 = iosColors.text
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextSize = 14
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    notifTitle.ZIndex = 21

    local notifText = Instance.new("TextLabel")
    notifText.Parent = notif
    notifText.Size = UDim2.new(1, -16, 0, 14)
    notifText.Position = UDim2.new(0, 8, 0, 28)
    notifText.BackgroundTransparency = 1
    notifText.Text = "Escribe comandos en la barra de busqueda"
    notifText.TextColor3 = iosColors.textSecondary
    notifText.Font = Enum.Font.Gotham
    notifText.TextSize = 11
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.ZIndex = 21

    task.wait(3)
    notif:TweenPosition(UDim2.new(0.5, -140, 1, 160), "Out", "Quad", 0.3)
    task.wait(0.3)
    notif:Destroy()
end)

print("Infinite Yield iOS Glass cargado | Escribe comandos en la barra")
