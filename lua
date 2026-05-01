
if not getgenv().UndetectedSafeHub then
    getgenv().UndetectedSafeHub = true

    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    local _LocalPlayer = game:GetService('Players').LocalPlayer
    _LocalPlayer:WaitForChild('PlayerGui', 600)
    game:GetService('HttpService')
    game:GetService('Players')
    game:GetService('Workspace')

    local _ReplicatedStorage = game:GetService('ReplicatedStorage')
    local _Players = game:GetService('Players')
    local _RunService = game:GetService('RunService')
    local _Workspace = game:GetService('Workspace')
    local _VirtualUser = game:GetService('VirtualUser')
    local _LocalPlayer2 = _Players.LocalPlayer
    local _CoinCollected = _ReplicatedStorage.Remotes.Gameplay.CoinCollected
    local _RoundStart = _ReplicatedStorage.Remotes.Gameplay.RoundStart
    local u10 = {
        'MouseButton1Click',
        'MouseButton1Down',
        'Activated',
    }

    function TapUI(p11, p12, p13)
        if p12 == 'Active Check' then
            if not p11.Active then return end
            p11 = p11[p13]
        end
        if p12 == 'Text Check' then
            if p11 ~= '^' then return end
        else
            p13 = p11
        end
        local v14, v15, v16 = pairs(u10)
        while true do
            local v17
            v16, v17 = v14(v15, v16)
            if v16 == nil then break end
            local v18, v19, v20 = pairs(getconnections(p13[v17]))
            while true do
                local v21
                v20, v21 = v18(v19, v20)
                if v20 == nil then break end
                v21:Fire()
            end
        end
    end

    repeat
        task.wait(1)
        pcall(function()
            TapUI(_LocalPlayer2.PlayerGui.DeviceSelect.Container.Tablet.Button)
        end)
        pcall(function()
            TapUI(game:GetService('Players').LocalPlayer.PlayerGui.Join.Friends.Play)
        end)
    until _LocalPlayer2.PlayerGui:FindFirstChild('MainGUI')

    repeat
        fr = pcall(function()
            require(game:GetService('ReplicatedStorage').Modules.TradeModule)
        end)
        task.wait()
    until fr

    local v22 = {
        AutoRevealRoles = false,
        AutoAdvertizeDiscord = false,
        CoinFarm = {
            StatsOverlay = false,
            State = false,
            Settings = {
                Speed = 22.5,
                DestroyMap = false,
                DestroyPlayers = false,
                Fly = false,
                DieAtFullBag = false,
            },
        },
        CoinFarm2 = {
            State = false,
            Settings = {
                Speed = 22.5,
                DestroyMap = false,
                DestroyPlayers = false,
                DieAtFullBag = false,
                Disable3DRendering = false,
            },
        },
        CoinFarm3 = {State = false},
        ESP = {
            Players = false,
            Traps = false,
            DroppedGun = false,
        },
        Noclip = false,
        Gameplay = {
            AutoPickUpGun = false,
            AutoShooting = false,
        },
        AutoFarm = {
            TeleportSpawn = false,
            KillEveryoneAsAMurderer = false,
            AutoFlingMurderer = false,
            AutoFlingSheriff = false,
            AutoPrestige = false,
            KillEveryoneAsAMurdererAtFullBag = false,
            TeleportUnderMap = false,
            AutoTeleportToRandomServerIfServerIsEmpty = false,
            AutoFlingMurdererAtFullBag = false,
            PlayersToAutoServerHop = 2,
        },
        AnnoyingStuff = {
            Fling = {
                PickedPlayer = nil,
                LoopFlingAllPlayers = false,
            },
        },
        Sliders = {
            Speed = _LocalPlayer2.Character.Humanoid.WalkSpeed,
            Jump = _LocalPlayer2.Character.Humanoid.JumpPower,
        },
        AutoOpenCrates = {
            State = false,
            Crate = 'MysteryBox1',
            CrateType = 'MysteryBox',
        },
        VisualGun = false,
        ShuffleWeapons = false,
        Emotes = {
            SelectedEmote = 'zen',
            AutoPlayEmotes = false,
            AutoPlaySelectedEmote = false,
            EmoteSpamSpeed = 1,
        },
    }

    DefaultConfig = v22

    function deep_copy_table(p23)
        local v24 = table.clone(p23)
        local v25, v26, v27 = pairs(v24)
        while true do
            local v28
            v27, v28 = v25(v26, v27)
            if v27 == nil then break end
            if type(v28) == 'table' then
                v24[v27] = table.clone(v28)
            end
        end
        return v24
    end

    Config = deep_copy_table(DefaultConfig)

    print('Loaded [MM2]')

    DevelopingLog = '\r\nThis script was created by Fashn\r\nfor UndetectedSafeHub Project\r\n'

    _LocalPlayer.Idled:connect(function()
        _VirtualUser:ClickButton2(Vector2.new())
    end)

    function TeleportUnderMap()
        if workspace:FindFirstChild('safespot') then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-106, 87.5, 2)
        else
            safespot = Instance.new('Part')
            safespot.Name = 'safespot'
            safespot.Size = Vector3.new(25, 3, 25)
            safespot.Position = Vector3.new(-106, 83, 2)
            safespot.Parent = workspace
            safespot.Anchored = true
            safespot.CanCollide = true
            safespot.Transparency = 0
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-106, 87.5, 2)
            task.wait(0.1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-106, 87.5, 2)
            task.wait(0.1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-106, 87.5, 2)
        end
    end

    game:GetService('GuiService').ErrorMessageChanged:Connect(function()
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)

    local u29 = {
        'sit', 'ninja', 'dab', 'zen', 'floss',
        'headless', 'zombie', 'wave', 'cheer', 'laugh',
    }

    function PlayEmote(p30)
        game:GetService('ReplicatedStorage').Remotes.Misc.PlayEmote:Fire(p30)
    end

    task.spawn(function()
        while task.wait(1 / Config.Emotes.EmoteSpamSpeed) do
            if Config.Emotes.AutoPlayEmotes then
                PlayEmote(u29[math.random(1, #u29)])
            end
        end
    end)

    function fly()
        speeds = 1
        local _LocalPlayer3 = game:GetService('Players').LocalPlayer
        local _Character = _LocalPlayer2.Character
        if _Character then _Character:FindFirstChildWhichIsA('Humanoid') end
        nowe = false
        Duration = 5
        if nowe ~= true then
            nowe = true
            _LocalPlayer2.Character.Animate.Disabled = true
            local _Character2 = _LocalPlayer2.Character
            local v34 = _Character2:FindFirstChildOfClass('Humanoid') or _Character2:FindFirstChildOfClass('AnimationController')
            local v35, v36, v37 = pairs(v34:GetPlayingAnimationTracks())
            while true do
                local v38
                v37, v38 = v35(v36, v37)
                if v37 == nil then break end
                v38:AdjustSpeed(0)
            end
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
            _LocalPlayer3.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        else
            nowe = false
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
            _LocalPlayer3.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            _LocalPlayer3.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        end
        local v39 = _LocalPlayer2
        local _UpperTorso = v39.Character.UpperTorso
        local v41 = {f=0,b=0,l=0,r=0}
        local v42 = {f=0,b=0,l=0,r=0}
        local v43 = 50
        local v44 = 0
        local _BodyGyro = Instance.new('BodyGyro', _UpperTorso)
        _BodyGyro.P = 90000
        _BodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
        _BodyGyro.cframe = _UpperTorso.CFrame
        local _BodyVelocity = Instance.new('BodyVelocity', _UpperTorso)
        _BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
        _BodyVelocity.maxForce = Vector3.new(9000000000, 9000000000, 9000000000)
        if nowe == true then
            v39.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService('Players').LocalPlayer.Character.Humanoid.Health == 0 do
            wait()
            if v41.l + v41.r ~= 0 or v41.f + v41.b ~= 0 then
                v44 = v44 + 0.5 + v44 / v43
                if v43 < v44 then v44 = v43 end
            elseif v41.l + v41.r == 0 and (v41.f + v41.b == 0 and v44 ~= 0) then
                local v47 = v44 - 1
                v44 = v47 < 0 and 0 or v47
            end
            if v41.l + v41.r ~= 0 or v41.f + v41.b ~= 0 then
                _BodyVelocity.velocity = (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (v41.f + v41.b) + (game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(v41.l + v41.r, (v41.f + v41.b) * 0.2, 0).p - game.Workspace.CurrentCamera.CoordinateFrame.p)) * v44
                v42 = {f=v41.f,b=v41.b,l=v41.l,r=v41.r}
            elseif v41.l + v41.r ~= 0 or (v41.f + v41.b ~= 0 or v44 == 0) then
                _BodyVelocity.velocity = Vector3.new(0, 0, 0)
            else
                _BodyVelocity.velocity = (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (v42.f + v42.b) + (game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(v42.l + v42.r, (v42.f + v42.b) * 0.2, 0).p - game.Workspace.CurrentCamera.CoordinateFrame.p)) * v44
            end
            _BodyGyro.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((v41.f + v41.b) * 50 * v44 / v43), 0, 0)
        end
        _BodyGyro:Destroy()
        _BodyVelocity:Destroy()
        v39.Character.Humanoid.PlatformStand = false
        _LocalPlayer2.Character.Animate.Disabled = false
        tpwalking = false
    end

    function destroyplayers()
        local v48, v49, v50 = pairs(game.Players:GetPlayers())
        while true do
            local v51
            v50, v51 = v48(v49, v50)
            if v50 == nil then break end
            if v51 ~= _LocalPlayer2 and game.Workspace:WaitForChild(v51.Name, 0.01) then
                game.Workspace[v51.Name]:Destroy()
            end
        end
    end

    function DestroyMapFunc()
        local v52, v53, v54 = pairs(game.Workspace:GetChildren())
        while true do
            local u55
            v54, u55 = v52(v53, v54)
            if v54 == nil then break end
            if u55:IsA('Model') and u55:FindFirstChild('CoinContainer') then
                if pcall(function() basesex = u55.Base end) then basesex:Destroy() end
                if pcall(function() decoration = u55.Decoration_Christmas end) then decoration:Destroy() end
                if pcall(function() outfits = u55.Outfits end) then outfits:Destroy() end
                if pcall(function() raggy = u55.Raggy end) then raggy:Destroy() end
                if pcall(function() interactive = u55.Interactive end) then interactive:Destroy() end
                if pcall(function() spawns = u55.Spawns end) then spawns:Destroy() end
            end
        end
    end

    function clipclop()
        local v56, v57, v58 = pairs(_LocalPlayer2.Character:GetDescendants())
        while true do
            local v59
            v58, v59 = v56(v57, v58)
            if v58 == nil then break end
            if v59:IsA('BasePart') and (v59.CanCollide == true and v59.Name ~= floatName) then
                v59.CanCollide = false
            end
        end
    end

    Noclipping = _RunService.Stepped:Connect(function()
        if Config.Noclip and _LocalPlayer2.Character and (_LocalPlayer2.Character:FindFirstChildOfClass('Humanoid') and _LocalPlayer2.Character.Humanoid.Health > 0 and _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart')) then
            clipclop()
        end
    end)

    function RandomItemFromInventory()
        local _Weapons = require(game:GetService('ReplicatedStorage').Modules.InventoryModule).MyInventory.Data.Weapons
        local v61, v62, v63 = pairs(_Weapons)
        local v64 = {}
        while true do
            local v65
            v63, v65 = v61(v62, v63)
            if v63 == nil then break end
            local v66 = nil
            local v67 = nil
            while true do
                local v68
                v67, v68 = v65(v66, v67)
                if v67 == nil then break end
                table.insert(v64, v67)
            end
        end
        return v64[math.random(1, #v64)]
    end

    _RunService.Stepped:Connect(function()
        if Config.Emotes.AutoPlaySelectedEmote then
            PlayEmote(Config.Emotes.SelectedEmote)
        end
        if Config.ShuffleWeapons then
            local v69 = {RandomItemFromInventory(), 'Weapons'}
            game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('Inventory'):WaitForChild('Equip'):FireServer(unpack(v69))
        end
        if game:GetService('CoreGui'):FindFirstChild('CenteredLabelGui') and game:GetService('CoreGui'):FindFirstChild('CenteredLabelGui'):FindFirstChild('CenteredTextLabel') then
            game:GetService('CoreGui').CenteredLabelGui.CenteredTextLabel.Visible = Config.CoinFarm.StatsOverlay
        end
        if _LocalPlayer2.Character and (_LocalPlayer2.Character:FindFirstChildOfClass('Humanoid') and _LocalPlayer2.Character.Humanoid.Health > 0 and _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart')) then
            if Config.Sliders.Speed ~= _LocalPlayer2.Character.Humanoid.WalkSpeed then
                _LocalPlayer2.Character.Humanoid.WalkSpeed = Config.Sliders.Speed
            end
            if Config.Sliders.Jump ~= _LocalPlayer2.Character.Humanoid.JumpPower then
                _LocalPlayer2.Character.Humanoid.JumpPower = Config.Sliders.Jump
            end
        end
    end)

    local u70 = _LocalPlayer2

    task.spawn(function()
        while task.wait(1) do
            if Config.CoinFarm.Settings.Fly and _LocalPlayer2.Character and (_LocalPlayer2.Character:FindFirstChildOfClass('Humanoid') and _LocalPlayer2.Character.Humanoid.Health > 0 and _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart')) then
                task.spawn(function() fly() end)
            end
        end
    end)

    DestroyPlayers = _RunService.Stepped:Connect(function()
        if Config.CoinFarm.Settings.DestroyPlayers then
            destroyplayers()
        end
    end)

    local function u86()
        local v71 = {}
        if u70.Character and u70.Character:FindFirstChild('HumanoidRootPart') then
            local _Position = u70.Character.HumanoidRootPart.Position
            local v74, v75, v76 = pairs(_Workspace:GetChildren())
            while true do
                local v77
                v76, v77 = v74(v75, v76)
                if v76 == nil then break end
                if v77:IsA('Model') and v77:FindFirstChild('CoinContainer') then
                    local v78, v79, v80 = pairs(v77.CoinContainer:GetChildren())
                    while true do
                        local v81
                        v80, v81 = v78(v79, v80)
                        if v80 == nil then break end
                        if v81.Name == 'Coin_Server' and (not v81:FindFirstChild('CollectedCoin') and v81:FindFirstChild('TouchInterest')) then
                            local _Magnitude = (_Position - v81.Position).Magnitude
                            if _Magnitude < 100 then
                                table.insert(v71, {Coin = v81, Distance = _Magnitude})
                            end
                        end
                    end
                end
            end
            table.sort(v71, function(p83, p84) return p83.Distance < p84.Distance end)
        end
        local v85 = v71[1]
        if v85 then v85 = v71[1].Coin end
        return v85
    end

    TweenService = game.TweenService

    function coinfarm1()
        local u97 = _RunService.Heartbeat:Connect(function()
            if Config.CoinFarm.State then
                local _Game = u70.PlayerGui:WaitForChild('MainGUI').Game
                if _Game.CoinBags.Visible and (not _Game.CoinBags.Container.Candy.Full.Visible and u70.Character) and u70.Character:FindFirstChild('HumanoidRootPart') then
                    local _HumanoidRootPart = u70.Character.HumanoidRootPart
                    if not _HumanoidRootPart:FindFirstChild('FLY_NIGGER') then
                        local _BodyVelocity2 = Instance.new('BodyVelocity', _HumanoidRootPart)
                        _BodyVelocity2.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
                        _BodyVelocity2.Name = 'FLY_NIGGER'
                    end
                    AutoFarming = true
                    clipclop()
                    local u92 = u86()
                    if u92 then
                        _HumanoidRootPart.Anchored = false
                        spawn(function()
                            if u70.Character then
                                local _HumanoidRootPart2 = u70.Character:WaitForChild('HumanoidRootPart')
                                local v94 = (_HumanoidRootPart2.Position - u92.Position).Magnitude / Config.CoinFarm.Settings.Speed
                                local v95 = CFrame.new(u92.Position + Vector3.new(0, -1, 0))
                                TweenService:Create(_HumanoidRootPart2, TweenInfo.new(v94, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = v95}):Play()
                                if u92 and u92.Parent then
                                    local u96 = nil
                                    u96 = u92.Touched:Connect(function(_)
                                        task.wait(0.1)
                                        if u92 then
                                            u92:Destroy()
                                            u96:Disconnect()
                                        end
                                    end)
                                end
                            end
                        end)
                    else
                        _HumanoidRootPart.Anchored = true
                    end
                    task.wait(0.02)
                    AutoFarming = false
                end
            end
        end)
        local u100 = _CoinCollected.OnClientEvent:Connect(function(_, p98, p99)
            if p98 == p99 then
                u97:Disconnect()
                roundEndConenction:Disconnect()
            end
        end)
        local u101 = u70.Character.Humanoid.Died:Connect(function()
            task.wait(1)
            repeat task.wait() until u70.Character ~= nil
            repeat task.wait() until u70.PlayerGui ~= nil
            task.wait(1)
            repeat task.wait() until game:GetService('Players').LocalPlayer.PlayerGui.MainGUI ~= nil
            task.wait(1)
            Teleport_to_map()
        end)
        roundEndConenction = game:GetService('ReplicatedStorage').Remotes.Gameplay.RoundEndFade.OnClientEvent:Connect(function()
            u97:Disconnect()
            u100:Disconnect()
            u101:Disconnect()
            roundEndConenction:Disconnect()
        end)
    end

    CoinColldown = 2

    local v102 = Vector3.new(1, -100, 1)
    local _Part = Instance.new('Part', workspace)
    local u104 = _LocalPlayer2

    _Part.Anchored = true
    _Part.Position = v102
    _Part.Size = Vector3.new(100, 1.2, 100)

    local u105 = false

    function PlayerToBrick()
        u104.Character.HumanoidRootPart.CFrame = CFrame.new(_Part.Position + Vector3.new(math.random(-10, 5), 5, math.random(-10, 5)))
    end

    function PlayerToCoin(p106)
        if p106 then
            u104.Character.HumanoidRootPart.CFrame = CFrame.new(p106.Position + Vector3.new(0, -6, 0))
        end
    end

    function GetMap()
        local v107, v108, v109 = ipairs(workspace:GetChildren())
        while true do
            local v110
            v109, v110 = v107(v108, v109)
            if v109 == nil then break end
            if v110:FindFirstChild('CoinContainer') then return v110 end
        end
    end

    function CoinFarm3()
        u105 = false
        if Config.CoinFarm3.State then PlayerToBrick() end
        while not u105 do
            local v111 = GetMap()
            if v111 then
                if not Config.CoinFarm3.State then break end
                task.spawn(function() pcall(function() DestroyMapFunc() end) end)
                local _huge = math.huge
                local v113, v114, v115 = ipairs(v111.CoinContainer:GetChildren())
                local v116 = nil
                while true do
                    local v117
                    v115, v117 = v113(v114, v115)
                    if v115 == nil then break end
                    if v117:FindFirstChild('TouchInterest') then
                        local _Y = v117.Position.Y
                        if _Y < _huge then v116 = v117; _huge = _Y end
                    end
                end
                coin = v116
                local u119 = false
                PlayerToCoin(coin)
                local v122 = _CoinCollected.OnClientEvent:Connect(function(_, p120, p121, _)
                    u119 = true
                    if p120 == p121 then u105 = true end
                end)
                if u105 then break end
                repeat
                    task.wait()
                    task.spawn(function()
                        firetouchinterest(u104.Character.HumanoidRootPart, coin, 0)
                        firetouchinterest(u104.Character.HumanoidRootPart, coin, 1)
                    end)
                    task.wait()
                    clipclop()
                    PlayerToCoin(coin)
                until u119 or not coin:FindFirstChild('TouchInterest')
                v122:Disconnect()
                PlayerToBrick()
                wait(CoinColldown)
            else
                task.wait(1)
                if not Config.CoinFarm3.State then break end
            end
        end
    end

    game:GetService('ReplicatedStorage').Remotes.Gameplay.RoundStart.OnClientEvent:Connect(function()
        task.spawn(function() CoinFarm3() end)
        RunningCoinFarm3 = true
    end)

    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        if Config.CoinFarm3.State then PlayerToBrick() end
    end)

    function init()
        if workspace:FindFirstChild('AutoCoinPart') then
            workspace.AutoCoinPart:Destroy()
        end
        local u123 = nil
        local u125 = false
        local _Part2 = Instance.new('Part')
        local _Position2 = _LocalPlayer2.Character.HumanoidRootPart.Position
        _Part2.Name = 'AutoCoinPart'
        _Part2.Color = Color3.new(0, 0, 0)
        _Part2.Material = Enum.Material.Plastic
        _Part2.Transparency = 1
        _Part2.Position = _Position2
        _Part2.Size = Vector3.new(1, 0.5, 1)
        _Part2.CastShadow = true
        _Part2.Anchored = true
        _Part2.CanCollide = false
        _Part2.Parent = workspace
        CoinFarm2Connection = _RunService.Heartbeat:Connect(function()
            if Config.CoinFarm2.State == true and (u125 == false and _LocalPlayer2.Character) and _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart') then
                u125 = true
                workspace.AutoCoinPart.CFrame = _LocalPlayer2.Character.HumanoidRootPart.CFrame
                local v128, v129, v130 = pairs(workspace:GetDescendants())
                while true do
                    local v131
                    v130, v131 = v128(v129, v130)
                    if v130 == nil then break end
                    if v131.Name == 'Coin_Server' and v131:FindFirstChild('TouchInterest') then
                        if u123 then
                            if (_LocalPlayer2.Character.HumanoidRootPart.Position - u123.Position).Magnitude > (_LocalPlayer2.Character.HumanoidRootPart.Position - v131.Position).Magnitude then
                                u123 = v131
                            end
                        else
                            u123 = v131
                        end
                    end
                end
                if u123 then
                    CoinFound = true
                    if math.floor((_LocalPlayer2.Character.HumanoidRootPart.Position - u123.Position).Magnitude) < 80 then
                        TweenSpeed = math.floor((_LocalPlayer2.Character.HumanoidRootPart.Position - u123.Position).Magnitude) / Config.CoinFarm2.Settings.Speed
                    else
                        Teleport_to_map()
                        _Part2.Position = _LocalPlayer2.Character.HumanoidRootPart.Position
                        task.wait(0.1)
                        TweenSpeed = math.floor((_LocalPlayer2.Character.HumanoidRootPart.Position - u123.Position).Magnitude) / Config.CoinFarm2.Settings.Speed
                    end
                    if not TweenSpeed then return end
                    local _TweenService = game:GetService('TweenService')
                    tweenInfo = TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear)
                    tweenService = _TweenService
                    tween = tweenService:Create(workspace.AutoCoinPart, tweenInfo, {CFrame = u123.CFrame + Vector3.new(0, -5, 0)})
                    tween:Play()
                    wait(TweenSpeed)
                    if u123 then
                        pcall(function()
                            firetouchinterest(_LocalPlayer2.Character.HumanoidRootPart, u123, 0)
                            firetouchinterest(_LocalPlayer2.Character.HumanoidRootPart, u123, 1)
                        end)
                        u123.Parent = nil
                    end
                    TweenSpeed = 0.08
                    u123 = nil
                    CoinFound = false
                    u125 = false
                end
            end
            if Config.CoinFarm2.State == true and (game:GetService('Workspace'):FindFirstChild('AutoCoinPart') and (CoinFound == true and _LocalPlayer2.Character) and _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart')) then
                local _CFrame = game:GetService('Workspace').AutoCoinPart.CFrame
                local v134 = CFrame.Angles(math.rad(90), math.rad(0), math.rad(90))
                _LocalPlayer2.Character.HumanoidRootPart.CFrame = CFrame.new(_CFrame.Position) * v134
            end
        end)
        FullBagConnection = _CoinCollected.OnClientEvent:Connect(function(_, p135, p136, _)
            if p135 == p136 then
                CoinFarm2Connection:Disconnect()
                FullBagConnection:Disconnect()
                DeathConnection:Disconnect()
                if workspace:FindFirstChild('AutoCoinPart') then
                    workspace:FindFirstChild('AutoCoinPart'):Destroy()
                end
            end
        end)
        DeathConnection = _LocalPlayer2.Character.Humanoid.Died:Connect(function()
            CoinFarm2Connection:Disconnect()
            FullBagConnection:Disconnect()
            DeathConnection:Disconnect()
            if workspace:FindFirstChild('AutoCoinPart') then
                workspace:FindFirstChild('AutoCoinPart'):Destroy()
            end
        end)
    end

    spawn(coinfarm1)
    spawn(init)

    local function u149()
        local v137, v138, v139 = ipairs(game.Players:GetPlayers())
        while true do
            local v140
            v139, v140 = v137(v138, v139)
            if v139 == nil then break end
            if v140:FindFirstChild('Backpack') and v140.Backpack:FindFirstChild('Knife') then return v140 end
        end
        local v141, v142, v143 = ipairs(game.Players:GetPlayers())
        while true do
            local v144
            v143, v144 = v141(v142, v143)
            if v143 == nil then break end
            if v144.Character and v144.Character:FindFirstChild('Knife') then return v144 end
        end
        if playerData then
            local v145, v146, v147 = pairs(playerData)
            while true do
                local v148
                v147, v148 = v145(v146, v147)
                if v147 == nil then break end
                if v148.Role == 'Murderer' and game.Players:FindFirstChild(v147) then
                    return game.Players:FindFirstChild(v147)
                end
            end
        end
        return nil
    end

    local function u162()
        local v150, v151, v152 = ipairs(game.Players:GetPlayers())
        while true do
            local v153
            v152, v153 = v150(v151, v152)
            if v152 == nil then break end
            if v153:FindFirstChild('Backpack') and v153.Backpack:FindFirstChild('Gun') then return v153 end
        end
        local v154, v155, v156 = ipairs(game.Players:GetPlayers())
        while true do
            local v157
            v156, v157 = v154(v155, v156)
            if v156 == nil then break end
            if v157.Character and v157.Character:FindFirstChild('Gun') then return v157 end
        end
        if playerData then
            local v158, v159, v160 = pairs(playerData)
            while true do
                local v161
                v160, v161 = v158(v159, v160)
                if v160 == nil then break end
                if v161.Role == 'Sheriff' and game.Players:FindFirstChild(v160) then
                    return game.Players:FindFirstChild(v160)
                end
            end
        end
        return nil
    end

    function reloadESP()
        local v163, v164, v165 = ipairs(workspace:GetChildren())
        while true do
            local v166
            v165, v166 = v163(v164, v165)
            if v165 == nil then break end
            if v166.Name == 'PlayerESP' then v166:Destroy() end
        end
        local v167 = game.Players:GetChildren()
        local v168, v169, v170 = ipairs(v167)
        while true do
            local u171
            v170, u171 = v168(v169, v170)
            if v170 == nil then break end
            if u171.Character ~= nil then
                local _Character3 = u171.Character
                if not _Character3:FindFirstChild('PlayerESP') then
                    local _Highlight = Instance.new('Highlight', workspace)
                    _Highlight.Name = 'PlayerESP'
                    _Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    _Highlight.Adornee = _Character3
                    _Highlight.FillColor = Color3.fromRGB(255, 255, 255)
                    _Highlight.FillTransparency = 0.5
                    task.spawn(function()
                        if u171 ~= u149() then
                            if u171 ~= u162() then
                                _Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                _Highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                            else
                                _Highlight.FillColor = Color3.fromRGB(0, 150, 255)
                                _Highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
                            end
                        else
                            _Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            _Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                        end
                        if _Highlight then
                            if not u171 then return end
                            _Highlight.Adornee = u171.Character or u171.CharactedAdded:Wait()
                        end
                    end)
                end
            end
        end
    end

    function KillEveryoneAsAMurderer()
        if not _LocalPlayer2.Character:FindFirstChild('Knife') then
            _LocalPlayer2.Character:FindFirstChild('Humanoid')
            if not _LocalPlayer2.Backpack:FindFirstChild('Knife') then return end
            _LocalPlayer2.Character:FindFirstChild('Humanoid'):EquipTool(_LocalPlayer2.Backpack:FindFirstChild('Knife'))
        end
        local v174, v175, v176 = ipairs(game.Players:GetPlayers())
        while true do
            local v177
            v176, v177 = v174(v175, v176)
            if v176 == nil then break end
            if v177.Character and (v177.Character:FindFirstChild('HumanoidRootPart') and v177 ~= _LocalPlayer2) then
                v177.Character:FindFirstChild('HumanoidRootPart').Anchored = true
                v177.Character:FindFirstChild('HumanoidRootPart').CFrame = _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart').CFrame + _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart').CFrame.LookVector * 1
            end
        end
        _LocalPlayer2.Character.Knife.Stab:FireServer(unpack({'Slash'}))
    end

    local function v193()
        if u162() == _LocalPlayer2 and Config.Gameplay.AutoShooting then
            local v178 = u149()
            if not v178 then return end
            local _Character4 = v178.Character
            if not _Character4 then return end
            local _HumanoidRootPart3 = _Character4:FindFirstChild('HumanoidRootPart')
            if not _HumanoidRootPart3 then return end
            local _Position3 = _HumanoidRootPart3.Position
            if not _LocalPlayer2.Character then return end
            local _HumanoidRootPart4 = _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart')
            if not _HumanoidRootPart4 then return end
            local v183 = _Position3 - _HumanoidRootPart4.Position
            local v184 = RaycastParams.new()
            v184.FilterType = Enum.RaycastFilterType.Exclude
            v184.FilterDescendantsInstances = {_LocalPlayer2.Character}
            local v185 = workspace:Raycast(_HumanoidRootPart4.Position, v183, v184)
            if (not v185 or v185.Instance.Parent == v178.Character) and (_LocalPlayer2.Character:FindFirstChild('Gun') or _LocalPlayer2.Backpack:FindFirstChild('Gun')) then
                _LocalPlayer2.Character.Humanoid:EquipTool(game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Gun'))
                local v186 = u149()
                local _UpperTorso2 = v186.Character:FindFirstChild('UpperTorso')
                local _Humanoid = v186.Character:FindFirstChild('Humanoid')
                if not _UpperTorso2 then return end
                if not _Humanoid then return end
                local _AssemblyLinearVelocity = _UpperTorso2.AssemblyLinearVelocity
                local _MoveDirection = _Humanoid.MoveDirection
                local v191 = _LocalPlayer2
                local v192 = (_UpperTorso2.Position + _AssemblyLinearVelocity * Vector3.new(0, 0.5, 0) * 0.14 + _MoveDirection * 2.8) * (v191:GetNetworkPing() * 1000 * 0 + 1)
                _LocalPlayer2.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(1, v192, 'AH2')
            end
        end
    end

    _RunService.RenderStepped:Connect(v193)

    function AdvertizeDiscord()
        local v194 = game:GetService('TextChatService'):WaitForChild('TextChannels'):GetChildren()
        local v195, v196, v197 = ipairs(v194)
        while true do
            local v198
            v197, v198 = v195(v196, v197)
            if v197 == nil then break end
            v198:SendAsync('UndetectedSafeHub\r\n        gg PwTPex2g6T')
        end
    end

    _RoundStart.OnClientEvent:Connect(function(_)
        if Config.AutoRevealRoles then RevealRoles() end
        if Config.AutoAdvertizeDiscord then AdvertizeDiscord() end
        if Config.AutoFarm.KillEveryoneAsAMurderer then
            task.wait(1)
            repeat KillEveryoneAsAMurderer(); task.wait(1) until u149() ~= u70
        end
        if Config.AutoFarm.AutoFlingMurderer then
            murd = u149()
            if murd and murd ~= game.Players.LocalPlayer then miniFling(murd) end
        end
        if Config.AutoFarm.AutoFlingSheriff then
            sher = u162()
            if sher and sher ~= game.Players.LocalPlayer then miniFling(sher) end
        end
        if Config.AutoFarm.TeleportSpawn then Teleport_to_lobby() end
        spawn(init)
        spawn(coinfarm1)
    end)

    _RunService.Heartbeat:Connect(function()
        if Config.CoinFarm.Settings.DestroyMap then DestroyMapFunc() end
    end)

    game.ReplicatedStorage:WaitForChild('Remotes'):WaitForChild('Gameplay'):WaitForChild('PlayerDataChanged', 5).OnClientEvent:Connect(function(p199)
        playerData = p199
        if Config.ESP.Players then reloadESP() end
    end)

    function getMap()
        local v200, v201, v202 = ipairs(workspace:GetChildren())
        while true do
            local v203
            v202, v203 = v200(v201, v202)
            if v202 == nil then break end
            if v203:FindFirstChild('CoinContainer') and v203:FindFirstChild('Spawns') then return v203 end
        end
        return nil
    end

    function GetAllEmotes()
        game.ReplicatedStorage.Remotes.Extras.GetPlayerData:InvokeServer('GetData')
        local _EmoteModule = game:GetService('ReplicatedStorage').Modules.EmoteModule
        local _Emotes = _LocalPlayer2.PlayerGui.MainGUI.Game:FindFirstChild('Emotes')
        require(_EmoteModule).GeneratePage({'headless','zombie','zen','ninja','floss','dab','sit'}, _Emotes, 'Free Emotes')
        getgenv().FreeEmotesOperator = true
        while getgenv().FreeEmotesOperator == true do
            if _LocalPlayer2.PlayerGui.MainGUI.Game:FindFirstChild('Emotes') and not _LocalPlayer2.PlayerGui.MainGUI.Game.Emotes.EmotePages:FindFirstChild('Free Emotes') then
                getgenv().FreeEmotesOperator = false
                GetAllEmotes()
            end
            _RunService.RenderStepped:wait()
        end
    end

    function pickupgun()
        if getMap() then
            if getMap():FindFirstChild('GunDrop') then
                if u149() ~= _LocalPlayer2 then
                    if _LocalPlayer2.Character then
                        local v206 = _LocalPlayer2.Character:GetPivot()
                        _LocalPlayer2.Character:MoveTo(getMap():FindFirstChild('GunDrop').Position)
                        _LocalPlayer2.Backpack.ChildAdded:Wait()
                        _LocalPlayer2.Character:PivotTo(v206)
                    else return end
                else return end
            else return end
        else return end
    end

    workspace.DescendantAdded:Connect(function(p207)
        if Config.ESP.Traps and p207.Name == 'Trap' and p207.Parent:IsDescendantOf(workspace) then
            p207.Transparency = 0
            local v208 = trapESP:Clone()
            v208.Parent = workspace
            v208.Adornee = p207
        end
        if Config.ESP.DroppedGun and p207.Name == 'GunDrop' then
            if not workspace:FindFirstChild('GunESP') then
                local _Highlight2 = Instance.new('Highlight', workspace)
                _Highlight2.OutlineTransparency = 1
                _Highlight2.FillColor = Color3.fromRGB(255, 255, 0)
                _Highlight2.Name = 'GunESP'
                _Highlight2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                _Highlight2.Adornee = p207
                _Highlight2.Enabled = true
            end
            workspace:FindFirstChild('GunESP').Adornee = p207
            workspace:FindFirstChild('GunESP').Enabled = true
            if Config.Gameplay.AutoPickUpGun then
                task.wait(0.5)
                for _ = 1, 5 do pickupgun() end
            end
        end
    end)

    workspace.DescendantRemoving:Connect(function(p210)
        if Config.ESP.DroppedGun and p210.Name == 'GunDrop' then
            if workspace:FindFirstChild('GunESP') then workspace:FindFirstChild('GunESP'):Destroy() end
            task.wait(0.6)
            if Config.ESP.Players then
                local v211, v212, v213 = ipairs(workspace:GetChildren())
                while true do
                    local v214
                    v213, v214 = v211(v212, v213)
                    if v213 == nil then break end
                    if v214:IsA('Highlight') then v214:Destroy() end
                end
            end
            local v215 = game.Players:GetChildren()
            local v216, v217, v218 = ipairs(v215)
            while true do
                local u219
                v218, u219 = v216(v217, v218)
                if v218 == nil then break end
                if u219.Character ~= nil then
                    local _Character5 = u219.Character
                    if not _Character5:FindFirstChild('PlayerESP') then
                        local _Highlight3 = Instance.new('Highlight', workspace)
                        _Highlight3.Name = 'PlayerESP'
                        _Highlight3.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        _Highlight3.Adornee = _Character5
                        _Highlight3.FillColor = Color3.fromRGB(255, 255, 255)
                        _Highlight3.FillTransparency = 0.5
                        task.spawn(function()
                            if u219 ~= u149() then
                                if u219 ~= u162() then
                                    _Highlight3.FillColor = Color3.fromRGB(0, 255, 0)
                                    _Highlight3.OutlineColor = Color3.fromRGB(0, 255, 0)
                                else
                                    _Highlight3.FillColor = Color3.fromRGB(255, 255, 0)
                                    _Highlight3.OutlineColor = Color3.fromRGB(255, 255, 0)
                                end
                            else
                                _Highlight3.FillColor = Color3.fromRGB(255, 0, 0)
                                _Highlight3.OutlineColor = Color3.fromRGB(255, 0, 0)
                            end
                            if _Highlight3 then
                                if not u219 then return end
                                _Highlight3.Adornee = u219.Character or u219.CharactedAdded:Wait()
                            end
                        end)
                    end
                end
            end
        end
    end)

    function killme()
        _LocalPlayer2.Character:BreakJoints()
    end

    function Teleport_to_lobby(_)
        _LocalPlayer2.Character:MoveTo(Vector3.new(-107, 152, 41))
    end

    function Teleport_to_map(_)
        if getMap() then
            local _Spawns = getMap():FindFirstChild('Spawns')
            if _Spawns then
                local v223 = _Spawns:GetChildren()
                local v224 = v223[math.random(1, #v223)]
                _LocalPlayer2.Character:MoveTo(v224.Position)
            end
        end
    end

    function CrashServer()
        local _GetSyncData = game:GetService('ReplicatedStorage').GetSyncData
        local _InvokeServer = _GetSyncData.InvokeServer
        local _spawn = task.spawn
        game:GetService('StarterGui'):SetCore('SendNotification', {
            Title = 'Server IS COOKED',
            Text = 'look how ppl freezing mid air lmao',
            Duration = 5,
        })
        local v228 = 0
        while true do
            for _ = 1, 1 do _spawn(_InvokeServer, _GetSyncData) end
            v228 = v228 + 1
            if v228 == 3 then wait(0); v228 = 0 end
        end
    end

    function miniFling(p229)
        _LocalPlayer2:GetMouse()
        local _Players2 = game:GetService('Players')
        local _LocalPlayer4 = _Players2.LocalPlayer
        local u232 = false
        ;(function(p233)
            local _Character6 = _LocalPlayer4.Character
            local u235
            if _Character6 then u235 = _Character6:FindFirstChildOfClass('Humanoid') else u235 = _Character6 end
            local u236
            if u235 then u236 = u235.RootPart else u236 = u235 end
            if not p233 then return end
            local _Character7 = p233.Character
            local u238 = nil
            local u239 = nil
            local v240 = nil
            local v241 = nil
            local v242 = nil
            if not _Character7 then return end
            if _Character7:FindFirstChildOfClass('Humanoid') then u238 = _Character7:FindFirstChildOfClass('Humanoid') end
            if u238 and u238.RootPart then u239 = u238.RootPart end
            if _Character7:FindFirstChild('Head') then v240 = _Character7.Head end
            if _Character7:FindFirstChildOfClass('Accessory') then v241 = _Character7:FindFirstChildOfClass('Accessory') end
            if v241 and v241:FindFirstChild('Handle') then v242 = v241.Handle end
            if _Character6 and (u235 and u236) then
                if u236.Velocity.Magnitude < 50 then getgenv().OldPos = u236.CFrame end
                if v240 then
                    if v240.Velocity.Magnitude > 500 then return end
                elseif not v240 and (v242 and v242.Velocity.Magnitude > 500) then
                    return
                end
                if v240 then
                    workspace.CurrentCamera.CameraSubject = v240
                elseif v240 or not v242 then
                    if u238 and u239 then workspace.CurrentCamera.CameraSubject = u238 end
                else
                    workspace.CurrentCamera.CameraSubject = v242
                end
                if not _Character7:FindFirstChildWhichIsA('BasePart') then return end
                local function u246(p243, p244, p245)
                    u236.CFrame = CFrame.new(p243.Position) * p244 * p245
                    if game.Players.LocalPlayer:FindFirstChild('Character') then
                        _Character6:SetPrimaryPartCFrame(CFrame.new(p243.Position) * p244 * p245)
                        u236.Velocity = Vector3.new(90000000, 900000000, 90000000)
                        u236.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
                    end
                end
                local function v251(p247)
                    local v248 = tick()
                    local v249 = 2
                    local v250 = 0
                    while u236 and u238 do
                        if p247.Velocity.Magnitude >= 50 then
                            u246(p247, CFrame.new(0, 1.5, u238.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, -u238.WalkSpeed), CFrame.Angles(0, 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, 1.5, u238.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, 1.5, u239.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, -u239.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, 1.5, u239.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)); task.wait()
                        else
                            v250 = v250 + 100
                            u246(p247, CFrame.new(0, 1.5, 0) + u238.MoveDirection * p247.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v250), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, 0) + u238.MoveDirection * p247.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v250), 0, 0)); task.wait()
                            u246(p247, CFrame.new(2.25, 1.5, -2.25) + u238.MoveDirection * p247.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v250), 0, 0)); task.wait()
                            u246(p247, CFrame.new(-2.25, -1.5, 2.25) + u238.MoveDirection * p247.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v250), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, 1.5, 0) + u238.MoveDirection, CFrame.Angles(math.rad(v250), 0, 0)); task.wait()
                            u246(p247, CFrame.new(0, -1.5, 0) + u238.MoveDirection, CFrame.Angles(math.rad(v250), 0, 0)); task.wait()
                        end
                        if p247.Velocity.Magnitude > 500 or (p247.Parent ~= p233.Character or (p233.Parent ~= _Players2 or (p233.Character ~= _Character7 or (u238.Sit or (u235.Health <= 0 or tick() > v248 + v249))))) then
                            break
                        end
                    end
                end
                workspace.FallenPartsDestroyHeight = 0 / 0
                local _BodyVelocity3 = Instance.new('BodyVelocity')
                _BodyVelocity3.Name = 'EpixVel'
                _BodyVelocity3.Parent = u236
                _BodyVelocity3.Velocity = Vector3.new(900000000, 900000000, 900000000)
                _BodyVelocity3.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
                u235:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                if u239 and v240 then
                    if (u239.CFrame.p - v240.CFrame.p).Magnitude <= 5 then v251(u239) else v251(v240) end
                elseif u239 and not v240 then
                    v251(u239)
                elseif u239 or not v240 then
                    if not u239 and (not v240 and (v241 and v242)) then v251(v242) end
                else
                    v251(v240)
                end
                _BodyVelocity3:Destroy()
                u235:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                workspace.CurrentCamera.CameraSubject = u235
                while true do
                    u236.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
                    if not game.Players.LocalPlayer:FindFirstChild('Character') then return end
                    _Character6:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
                    u235:ChangeState('GettingUp')
                    table.foreach(_Character6:GetChildren(), function(_, p253)
                        if p253:IsA('BasePart') then
                            local v254 = Vector3.new()
                            p253.RotVelocity = Vector3.new()
                            p253.Velocity = v254
                        end
                    end)
                    task.wait()
                    if (u236.Position - getgenv().OldPos.p).Magnitude < 25 then
                        workspace.FallenPartsDestroyHeight = getgenv().FPDH
                    end
                end
            else
                return
            end
        end)(({p229})[1])
        workspace.FallenPartsDestroyHeight = -50000
    end

    task.spawn(function()
        while task.wait() do
            if Config.AnnoyingStuff.Fling.LoopFlingAllPlayers then
                local v255, v256, v257 = ipairs(game.Players:GetPlayers())
                while true do
                    local u258
                    v257, u258 = v255(v256, v257)
                    if v257 == nil then break end
                    if u258 ~= _LocalPlayer2 then
                        pcall(function() miniFling(u258) end)
                    end
                end
            end
        end
    end)

    function ServerHop()
        local v259 = {}
        local v260 = request({
            Url = string.format('https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true', game.PlaceId),
        })
        local v261 = game:GetService('HttpService'):JSONDecode(v260.Body)
        if v261 and v261.data then
            local v262 = next
            local _data = v261.data
            local v264 = nil
            while true do
                local v265
                v264, v265 = v262(_data, v264)
                if v264 == nil then break end
                if type(v265) == 'table' and (tonumber(v265.playing) and (tonumber(v265.maxPlayers) and (v265.playing < v265.maxPlayers and v265.id ~= game.JobId))) then
                    table.insert(v259, 1, v265.id)
                end
            end
        end
        if #v259 > 0 then
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v259[math.random(1, #v259)], game:GetService('Players').LocalPlayer)
        end
    end

    game:GetService('Players').PlayerRemoving:Connect(function(_)
        if Config.AutoFarm.AutoTeleportToRandomServerIfServerIsEmpty and #game.Players:GetPlayers() < Config.AutoFarm.PlayersToAutoServerHop then
            ServerHop()
        end
    end)

    task.spawn(function()
        while task.wait(30) do
            if Config.AutoFarm.AutoPrestige then
                game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('Inventory'):WaitForChild('Prestige'):FireServer()
            end
        end
    end)

    local _ScreenGui = Instance.new('ScreenGui')
    _ScreenGui.Name = 'CenteredLabelGui'
    _ScreenGui.Parent = game:GetService('CoreGui')
    local _TextLabel = Instance.new('TextLabel')
    _TextLabel.Name = 'CenteredTextLabel'
    _TextLabel.Visible = false
    _TextLabel.Text = ''
    _TextLabel.Size = UDim2.new(0.5, 0, 0.1, 0)
    _TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    _TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    _TextLabel.BackgroundTransparency = 1
    _TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    _TextLabel.Font = Enum.Font.SourceSansBold
    _TextLabel.TextSize = 48
    _TextLabel.Parent = _ScreenGui

    startTime = tick()
    totalCoinsCollected = 0

    _CoinCollected.OnClientEvent:Connect(function(_, p268, p269, _)
        totalCoinsCollected = totalCoinsCollected + 1
        RNcoins = p268
        MAXcoins = p269
        if p268 == p269 then
            if Config.AutoFarm.KillEveryoneAsAMurdererAtFullBag and u149() == _LocalPlayer2 then
                KillEveryoneAsAMurderer()
                task.wait(1)
            end
            if Config.AutoFarm.AutoFlingMurdererAtFullBag and u149() ~= _LocalPlayer2 then
                murd = u149()
                if murd and murd ~= game.Players.LocalPlayer then
                    miniFling(murd)
                    task.wait(1)
                end
            end
            if Config.AutoFarm.TeleportUnderMap then
                wait(0.1)
                TeleportUnderMap()
            elseif Config.CoinFarm.Settings.DieAtFullBag then
                _LocalPlayer2.Character:FindFirstChildOfClass('Humanoid'):ChangeState(Enum.HumanoidStateType.Dead)
            end
        end
    end)

    task.wait(0.01)
    coinsPerHour = 0
    MAXcoins = 40
    RNcoins = 0

    _RunService.RenderStepped:Connect(function()
        game:GetService('RunService'):Set3dRenderingEnabled(not Config.CoinFarm2.Disable3DRendering)
        elapsedTime = tick() - startTime
        if totalCoinsCollected <= 0 then
            coinsPerHour = 0
        else
            coinsPerHour = math.floor(totalCoinsCollected * 3600 / elapsedTime)
        end
        _TextLabel.Text = 'Coins Collected: ' .. RNcoins .. '/' .. MAXcoins .. '\nTotal Coins: ' .. totalCoinsCollected .. '\nCoins Per Hour: ' .. coinsPerHour
    end)

    task.spawn(function()
        while task.wait(15) do
            if Config.AutoOpenCrates.State then
                local v270 = {Config.AutoOpenCrates.Crate, Config.AutoOpenCrates.CrateType, 'Coins'}
                game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('Shop'):WaitForChild('OpenCrate'):InvokeServer(unpack(v270))
            end
        end
    end)

    guns = {
        Gingerscope = {
            MeshId = 'rbxassetid://15374602183',
            Offset = Vector3.zero,
            Scale = Vector3.new(0.084, 0.084, 0.084),
            TextureId = 'rbxassetid://15409041564',
            VertexColor = Vector3.new(1, 1, 1),
            CFrame = CFrame.new(0.129999995, 0, 0.075000003, 1, 0, 0, 0, 0.707388222, 0.706825197, 0, -0.706825197, 0.707388222),
            Grip = CFrame.new(0, -0.400000006, 0.899999976, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            Image = 'http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=15666596216',
            GuiColor = Color3.new(0.39215686274509803, 0.0392156862745098, 1),
        },
    }
    chosengun = 'Gingerscope'

    function equipgun(p271)
        if __EQUIPPED == false then return end
        disconect()
        ch = _LocalPlayer2.Character
        repeat task.wait() until ch:FindFirstChild('HumanoidRootPart')
        local v272, v273, v274 = pairs(workspace.WeaponDisplays:GetChildren())
        local gun = nil
        local knife = nil
        while true do
            local v275
            v274, v275 = v272(v273, v274)
            if v274 == nil then break end
            local a = v275.RigidConstraint.Attachment0
            local b = v275.RigidConstraint.Attachment0
            if a == ch:FindFirstChild('GunBelt', true) then gun = v275 end
            if b == ch:FindFirstChild('KnifeBack', true) then knife = v275 end
        end
        task.wait(0.1)
        if gun and knife then
            repeat task.wait() until gun:FindFirstChild('Attachment')
            gun.Attachment.CFrame = guns[p271].CFrame
            local v276, v277, v278 = pairs(guns[p271])
            while true do
                local v279
                v278, v279 = v276(v277, v278)
                if v278 == nil then break end
                if v278 ~= 'CFrame' and (v278 ~= 'Grip' and (v278 ~= 'Image' and v278 ~= 'GuiColor')) then
                    gun.Mesh[v278] = v279
                end
            end
            backpackImageConnection = _LocalPlayer2.Backpack.DescendantAdded:Connect(function(_)
                if guns[p271] then
                    local v280, v281, v282 = pairs(game:GetService('CoreGui').RobloxGui.Backpack.Hotbar:GetChildren())
                    while true do
                        local v283
                        v282, v283 = v280(v281, v282)
                        if v282 == nil then break end
                        if v283.Icon.Image ~= '' and u162() == _LocalPlayer2 then
                            v283.Icon.Image = guns[p271].Image
                        end
                    end
                end
            end)
            GunVisual = _LocalPlayer2.Backpack.DescendantAdded:Connect(function(p284)
                if tostring(p284) == 'Gun' then
                    task.wait()
                    USABLEGUN = _LocalPlayer2.Backpack.Gun.Handle
                    local v285, v286, v287 = pairs(guns[p271])
                    while true do
                        local v288
                        v287, v288 = v285(v286, v287)
                        if v287 == nil then break end
                        if v287 ~= 'CFrame' and (v287 ~= 'Grip' and (v287 ~= 'Image' and v287 ~= 'GuiColor')) then
                            USABLEGUN.Mesh[v287] = v288
                        end
                    end
                    USABLEGUN.Parent.Grip = guns[p271].Grip
                end
            end)
            return
        end
    end

    function disconect()
        if backpackImageConnection then backpackImageConnection:Disconnect(); backpackImageConnection = nil end
        if GunVisual then GunVisual:Disconnect(); GunVisual = nil end
        if autoEquipGun then autoEquipGun:Disconnect(); autoEquipGun = nil end
    end

    function RevealRoles()
        local v289 = game:GetService('TextChatService'):WaitForChild('TextChannels'):GetChildren()
        local v290, v291, v292 = ipairs(v289)
        while true do
            local v293
            v292, v293 = v290(v291, v292)
            if v292 == nil then break end
            if v293.Name ~= 'RBXSystem' then
                local v294 = u149()
                local v295 = u162()
                local v296 = not v294 and '-' or v294.Name
                local v297 = not v295 and '-' or v295.Name
                v293:SendAsync((string.format('Murderer: %s |\r\nSheriff: %s |\r\nUndetectedSafeHub', v296, v297)))
            end
        end
    end

    function spawnitem()
        local v298, v299, v300 = pairs(game:GetService('Players').LocalPlayer.PlayerGui.MainGUI.Game.Inventory.Main.Weapons.Items.Container:GetChildren())
        while true do
            local v301
            v300, v301 = v298(v299, v300)
            if v300 == nil then break end
            local v302, v303, v304 = pairs(v301:GetChildren())
            while true do
                local v305
                v304, v305 = v302(v303, v304)
                if v304 == nil then break end
                v301.ChildAdded:Connect(function(p306)
                    if p306.Name == 'NewItem' then
                        p306.Container.ActionButton.MouseButton1Click:Connect(function()
                            disconect(); __EQUIPPED = false
                        end)
                    end
                end)
                local v307, v308, v309 = pairs(v305:GetChildren())
                while true do
                    local v310
                    v309, v310 = v307(v308, v309)
                    if v309 == nil then break end
                    if v310.Name == 'NewItem' then
                        v310.Container.ActionButton.MouseButton1Click:Connect(function()
                            disconect(); __EQUIPPED = false
                        end)
                    end
                end
            end
        end
        local v311, v312, v313 = pairs(game:GetService('Players').LocalPlayer.PlayerGui.MainGUI.Game.Inventory.Main.Weapons.Items.Container:GetChildren())
        while true do
            local v314
            v313, v314 = v311(v312, v313)
            if v313 == nil then break end
            if v314.Name == 'Holiday' then
                christmas = v314.Container.Christmas
                halloween = v314.Container.Halloween
            end
        end
        local v315, v316, v317 = pairs(christmas.Container:GetChildren())
        while true do
            local v318
            v317, v318 = v315(v316, v317)
            if v317 == nil then break end
            if v318.Name == 'NewItem' then
                v318.Container.ActionButton.MouseButton1Click:Connect(function()
                    disconect(); __EQUIPPED = false
                end)
            end
        end
        christmas.Container.ChildAdded:Connect(function(p319)
            if p319.Name == 'NewItem' then
                p319.Container.ActionButton.MouseButton1Click:Connect(function()
                    disconect(); __EQUIPPED = false
                end)
            end
        end)
        local v320, v321, v322 = pairs(halloween.Container:GetChildren())
        while true do
            local v323
            v322, v323 = v320(v321, v322)
            if v322 == nil then break end
            if v323.Name == 'NewItem' then
                v323.Container.ActionButton.MouseButton1Click:Connect(function()
                    disconect(); __EQUIPPED = false
                end)
            end
        end
        halloween.Container.ChildAdded:Connect(function(p324)
            if p324.Name == 'NewItem' then
                p324.Container.ActionButton.MouseButton1Click:Connect(function()
                    disconect(); __EQUIPPED = false
                end)
            end
        end)
        weapons = game:GetService('Players').LocalPlayer.PlayerGui.MainGUI.Game.Inventory.Main.Weapons
        newitem = game:GetService('ReplicatedStorage').Modules.InventoryModule.NewItem:Clone()
        newitem.Name = 'FakeItem'
        newitem.Parent = weapons.Items.Container.Holiday.Container.Christmas.Container
        newitem.ItemName.Label.Text = chosengun
        newitem.Tags.Evo.Visible = false
        newitem.Container.Icon.Image = guns[chosengun].Image
        newitem.Container.Amount.Text = ''
        newitem.ItemName.BackgroundColor3 = guns[chosengun].GuiColor
        function click()
            __EQUIPPED = true
            equipped = weapons.Equipped.Container.Gun.Container
            equipped.ItemName.BackgroundColor3 = guns[chosengun].GuiColor
            equipped.ItemName.Label.Text = chosengun
            equipped.Container.Icon.Image = guns[chosengun].Image
            equipgun(chosengun)
            autoEquipGun = _LocalPlayer2.CharacterAdded:Connect(function()
                equipgun(chosengun)
            end)
        end
        clickconnection = newitem.Container.ActionButton.MouseButton1Click:Connect(function()
            click()
        end)
        if __EQUIPPED == true then task.wait(); click() end
    end

    _LocalPlayer2.CharacterAdded:Connect(function()
        if Config.VisualGun then spawnitem() end
    end)

    boxmodule = require(game:GetService('ReplicatedStorage').Modules.BoxModule)
itemdatabase = require(game:GetService('ReplicatedStorage').Database.Sync.Item)

task.spawn(function()
    repeat task.wait(0.5) until game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('MainGUI')
        and game:GetService('Players').LocalPlayer.PlayerGui.MainGUI:FindFirstChild('Inventory')
        and game:GetService('Players').LocalPlayer.PlayerGui.MainGUI.Inventory:FindFirstChild('NewItem')
    local ok, result = pcall(function()
        return getsenv(game:GetService('Players').LocalPlayer.PlayerGui.MainGUI.Inventory.NewItem)._G
    end)
    if ok then
        poop = result
    else
        warn('Failed to get poop _G:', result)
    end
end)


    function getrandombox()
        local v325 = require(game:GetService('ReplicatedStorage').Database.Sync.MysteryBox)
        if not v325 or next(v325) == nil then return nil end
        local v326, v327, v328 = pairs(v325)
        local v329 = {}
        while true do
            local v330
            v328, v330 = v326(v327, v328)
            if v328 == nil then break end
            table.insert(v329, v328)
        end
        return v329[math.random(1, #v329)]
    end

    getgenv().spawnamount = 1

    function opencrate(p331, p332)
        if p332 then
            poop.NewItem(p331, nil, nil, 'Weapons', getgenv().spawnamount)
        else
            boxmodule.OpenBox(getrandombox(), p331)
            poop.NewItem(p331, nil, nil, 'Weapons', 1)
        end
    end

    function getrawnamebyrealname(p333)
        local v334, v335, v336 = pairs(itemdatabase)
        while true do
            local v337
            v336, v337 = v334(v335, v336)
            if v336 == nil then break end
            if p333 == v336 then return v336 end
        end
    end

    function gettable(p338)
        nikita_gay = {}
        local v339, v340, v341 = pairs(itemdatabase)
        while true do
            local v342
            v341, v342 = v339(v340, v341)
            if v341 == nil then break end
            if string.find(v341:lower(), p338:lower()) then
                table.insert(nikita_gay, v341)
            end
        end
        return nikita_gay
    end

    function print_table(p343)
        local v344 = {}
        local v345 = {}
        local v346 = {}
        local v347 = '{\n'
        local v348 = 1
        local function v351(p349)
            local v350 = ''
            for _ = 1, p349 do v350 = v350 .. '\t' end
            return v350
        end
        while true do
            local v352, v353, v354 = pairs(p343)
            local v355 = 0
            while true do
                local v356
                v354, v356 = v352(v353, v354)
                if v354 == nil then break end
                v355 = v355 + 1
            end
            local v357, v358, v359 = pairs(p343)
            local v360 = 1
            while true do
                local v361
                v359, v361 = v357(v358, v359)
                if v359 == nil then break end
                if v344[p343] == nil or v344[p343] <= v360 then
                    if string.find(v347, '}', v347:len()) then
                        v347 = v347 .. ',\n'
                    elseif not string.find(v347, '\n', v347:len()) then
                        v347 = v347 .. '\n'
                    end
                    table.insert(v346, v347)
                    local v362 = ''
                    local v363
                    if type(v359) == 'number' or type(v359) == 'boolean' then
                        v363 = '[' .. tostring(v359) .. ']'
                    else
                        v363 = "['" .. tostring(v359) .. "']"
                    end
                    local v364
                    if type(v361) == 'number' or type(v361) == 'boolean' then
                        v364 = v362 .. v351(v348) .. v363 .. ' = ' .. tostring(v361)
                    else
                        if type(v361) == 'table' then
                            v347 = v362 .. v351(v348) .. v363 .. ' = {\n'
                            table.insert(v345, p343)
                            table.insert(v345, v361)
                            v344[p343] = v360 + 1
                        end
                        v364 = v362 .. v351(v348) .. v363 .. " = '" .. tostring(v361) .. "'"
                    end
                    if v360 == v355 then
                        v347 = v364 .. '\n' .. v351(v348 - 1) .. '}'
                    else
                        v347 = v364 .. ','
                    end
                elseif v360 == v355 then
                    v347 = v347 .. '\n' .. v351(v348 - 1) .. '}'
                end
                v360 = v360 + 1
            end
            if #v345 <= 0 then
                table.insert(v346, v347)
                local v365 = table.concat(v346)
                print(v365)
                return
            end
            p343 = v345[#v345]
            v345[#v345] = nil
            v348 = v344[p343] == nil and v348 + 1 or v348 - 1
        end
    end

    -- ============================================================
    -- RAYFIELD UI
    -- ============================================================
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = 'UndetectedSafeHub  https://discord.gg/rCDwwPuhn6',
        LoadingTitle = 'UndetectedSafeHub',
        LoadingSubtitle = 'by Fashn',
        Theme = 'Default',
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = 'UndetectedSafeHub',
            FileName = 'mm2',
        },
        Discord = {
            Enabled = false,
        },
        KeySystem = false,
    })

    -- GAMEPLAY TAB
    local GameplayTab = Window:CreateTab('Gameplay', 4483362458)

    local BasicSection = GameplayTab:CreateSection('Basic Stuff')

    GameplayTab:CreateToggle({
        Name = 'Noclip',
        CurrentValue = false,
        Flag = 'noclip',
        Callback = function(v)
            Config.Noclip = v
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Fly GUI',
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt'))()
        end,
    })

    local ToolsSection = GameplayTab:CreateSection('Tools')

    GameplayTab:CreateButton({
        Name = 'Pick Up Gun',
        Callback = function()
            pickupgun()
        end,
    })

    GameplayTab:CreateToggle({
        Name = 'Auto Pick Up Gun',
        CurrentValue = false,
        Flag = 'autopickupgun',
        Callback = function(v)
            Config.Gameplay.AutoPickUpGun = v
        end,
    })

    local OtherToolsSection = GameplayTab:CreateSection('Other Tools')

    GameplayTab:CreateButton({
        Name = 'Teleport To Map',
        Callback = function()
            Teleport_to_map()
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Teleport To Lobby',
        Callback = function()
            Teleport_to_lobby()
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Notify Murderer Username',
        Callback = function()
            local v423 = u149()
            if v423 then
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = 'Murderer Username:',
                    Text = v423.Name,
                    Duration = 5,
                })
            end
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Notify Sheriff Username',
        Callback = function()
            local v424 = u162()
            if v424 then
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = 'Sheriff Username:',
                    Text = v424.Name,
                    Duration = 5,
                })
            end
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Say Sheriff and Murderer Usernames',
        Callback = function()
            RevealRoles()
        end,
    })

    GameplayTab:CreateToggle({
        Name = 'Auto Reveal Roles',
        CurrentValue = false,
        Flag = 'revealroles',
        Callback = function(v)
            Config.AutoRevealRoles = v
        end,
    })

    local MoreToolsSection = GameplayTab:CreateSection('More Tools')

    GameplayTab:CreateButton({
        Name = 'Kill Everyone As A Murderer',
        Callback = function()
            if u149() ~= _LocalPlayer2 then
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = 'You are not a murderer',
                    Text = 'U dont have a knife',
                    Duration = 5,
                })
            end
            KillEveryoneAsAMurderer()
        end,
    })

    GameplayTab:CreateButton({
        Name = 'TP All Players To Me',
        Callback = function()
            if u149() == _LocalPlayer2 then
                local v402, v403, v404 = ipairs(game.Players:GetPlayers())
                while true do
                    local v405
                    v404, v405 = v402(v403, v404)
                    if v404 == nil then break end
                    if v405.Character and (v405.Character:FindFirstChild('HumanoidRootPart') and v405 ~= _LocalPlayer2) then
                        v405.Character:FindFirstChild('HumanoidRootPart').Anchored = true
                        v405.Character:FindFirstChild('HumanoidRootPart').CFrame = _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart').CFrame + _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart').CFrame.LookVector * 5
                    end
                end
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = 'Teleported every player to you',
                    Text = 'Kill everyone at once when u want',
                    Duration = 5,
                })
            else
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = 'You are not a murderer',
                    Text = 'This is not useful if u are not murderer',
                    Duration = 5,
                })
            end
        end,
    })

    GameplayTab:CreateToggle({
        Name = 'Auto Shoot Murderer',
        CurrentValue = false,
        Flag = 'silentaim',
        Callback = function(v)
            Config.Gameplay.AutoShooting = v
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Manual Shoot Murderer',
        Callback = function()
            if _LocalPlayer2.Character:FindFirstChild('Gun') or _LocalPlayer2.Backpack:FindFirstChild('Gun') then
                _LocalPlayer2.Character.Humanoid:EquipTool(game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Gun'))
                local v407 = u149()
                local _UpperTorso3 = v407.Character:FindFirstChild('UpperTorso')
                local _Humanoid2 = v407.Character:FindFirstChild('Humanoid')
                local _AssemblyLinearVelocity2 = _UpperTorso3.AssemblyLinearVelocity
                local _MoveDirection2 = _Humanoid2.MoveDirection
                local v412 = _LocalPlayer2
                local v413 = (_UpperTorso3.Position + _AssemblyLinearVelocity2 * Vector3.new(0, 0.5, 0) * 0.14 + _MoveDirection2 * 2.8) * (v412:GetNetworkPing() * 1000 * 0 + 1)
                _LocalPlayer2.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(1, v413, 'AH2')
            end
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Spin Around Murderer',
        Callback = function()
            local _LocalPlayer5 = game:GetService('Players').LocalPlayer
            local v415 = _LocalPlayer5.Character or _LocalPlayer5.CharacterAdded:Wait()
            v415:WaitForChild('HumanoidRootPart')
            local v416 = u149()
            local _HumanoidRootPart5 = (v416.Character or v416.CharacterAdded:Wait()):WaitForChild('HumanoidRootPart')
            local v418 = 0
            local v419 = 15
            local v420 = 0.03
            repeat
                local v421 = math.cos(math.rad(v418)) * v419
                local v422 = math.sin(math.rad(v418)) * v419
                v415:SetPrimaryPartCFrame(_HumanoidRootPart5.CFrame * CFrame.new(v421, 0, v422))
                v418 = v418 + 5
                wait(v420)
            until u149() == nil
        end,
    })

    local SpeedJumpSection = GameplayTab:CreateSection('Speed and Jump')

    GameplayTab:CreateSlider({
        Name = 'Speed',
        Range = {0, 100},
        Increment = 0.1,
        Suffix = '',
        CurrentValue = DefaultConfig.Sliders.Speed,
        Flag = 'speed',
        Callback = function(v)
            Config.Sliders.Speed = v
        end,
    })

    GameplayTab:CreateSlider({
        Name = 'Jump',
        Range = {0, 100},
        Increment = 0.1,
        Suffix = '',
        CurrentValue = DefaultConfig.Sliders.Jump,
        Flag = 'jump',
        Callback = function(v)
            Config.Sliders.Jump = v
        end,
    })

    local AnnoyingSection = GameplayTab:CreateSection('Annoying Stuff')

    ListOfPlayers = {}
    local v427, v428, v429 = ipairs(game.Players:GetPlayers())
    while true do
        local v433
        v429, v433 = v427(v428, v429)
        if v429 == nil then break end
        table.insert(ListOfPlayers, v433.Name)
    end

    local PlayerListDropdown = GameplayTab:CreateDropdown({
        Name = 'Pick A Player',
        Options = ListOfPlayers,
        CurrentOption = {},
        MultipleOptions = false,
        Flag = 'playerlist',
        Callback = function(v)
            Config.AnnoyingStuff.Fling.PickedPlayer = v
        end,
    })

    game.Players.PlayerAdded:Connect(function(p435)
        table.insert(ListOfPlayers, p435.Name)
        PlayerListDropdown:Set(ListOfPlayers[1])
    end)
    game.Players.PlayerRemoving:Connect(function(p436)
        for i, v in ipairs(ListOfPlayers) do
            if v == p436.Name then
                table.remove(ListOfPlayers, i)
                break
            end
        end
    end)

    GameplayTab:CreateButton({
        Name = 'Fling Chosen Player',
        Callback = function()
            if Config.AnnoyingStuff.Fling.PickedPlayer then
                miniFling(game.Players[Config.AnnoyingStuff.Fling.PickedPlayer])
            end
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Fling Murderer',
        Callback = function()
            miniFling(u149())
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Fling Sheriff',
        Callback = function()
            miniFling(u162())
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Fling Random Player',
        Callback = function()
            local v441 = game.Players:GetPlayers()
            local v442 = v441[math.random(1, #v441)]
            miniFling(v442)
        end,
    })

    GameplayTab:CreateButton({
        Name = 'Fling All Players [Slow]',
        Callback = function()
            local v443, v444, v445 = ipairs(game.Players:GetPlayers())
            while true do
                local v446
                v445, v446 = v443(v444, v445)
                if v445 == nil then break end
                miniFling(v446)
            end
        end,
    })

    GameplayTab:CreateToggle({
        Name = 'Loop Fling All Players',
        CurrentValue = false,
        Flag = 'loopfling',
        Callback = function(v)
            Config.AnnoyingStuff.Fling.LoopFlingAllPlayers = v
        end,
    })

    -- ESP TAB
    local ESPTab = Window:CreateTab('ESP', 4483362458)
    ESPTab:CreateSection('ESP Settings')

    ESPTab:CreateToggle({
        Name = 'Player ESP',
        CurrentValue = false,
        Flag = 'playeresp',
        Callback = function(v)
            Config.ESP.Players = v
            if v then
                reloadESP()
            else
                local v450, v451, v452 = ipairs(workspace:GetChildren())
                while true do
                    local v453
                    v452, v453 = v450(v451, v452)
                    if v452 == nil then break end
                    if v453.Name == 'PlayerESP' then v453:Destroy() end
                end
            end
        end,
    })

    ESPTab:CreateToggle({
        Name = 'Traps ESP',
        CurrentValue = false,
        Flag = 'trapsesp',
        Callback = function(v)
            Config.ESP.Traps = v
        end,
    })

    ESPTab:CreateToggle({
        Name = 'Dropped Gun ESP',
        CurrentValue = false,
        Flag = 'droppedgunesp',
        Callback = function(v)
            Config.ESP.DroppedGun = v
        end,
    })

    ESPTab:CreateSection('Spoof Username')

    ESPTab:CreateButton({
        Name = 'Spoof Username',
        Callback = function()
            loadstring(game:HttpGet('https://pastebin.com/raw/rf0PbX6z'))()
        end,
    })

    -- AUTOFARM TAB
    local AutofarmTab = Window:CreateTab('Autofarm', 4483362458)
    AutofarmTab:CreateSection('Autofarm Features')

    AutofarmTab:CreateToggle({
        Name = 'Auto Teleport At Spawn',
        CurrentValue = false,
        Flag = 'autoteleportspawn',
        Callback = function(v)
            Config.AutoFarm.TeleportSpawn = v
        end,
    })

    AutofarmTab:CreateToggle({
        Name = 'Auto Kill Everyone As A Murderer',
        CurrentValue = false,
        Flag = 'autokilleveryone',
        Callback = function(v)
            Config.AutoFarm.KillEveryoneAsAMurderer = v
        end,
    })

    AutofarmTab:CreateToggle({
        Name = "Auto Prestige each 100 lvl's",
        CurrentValue = false,
        Flag = 'autoprestige',
        Callback = function(v)
            Config.AutoFarm.AutoPrestige = v
        end,
    })

    AutofarmTab:CreateSection('More Features')

    AutofarmTab:CreateToggle({
        Name = 'Auto Fling Murderer',
        CurrentValue = false,
        Flag = 'autoflingmurderer',
        Callback = function(v)
            Config.AutoFarm.AutoFlingMurderer = v
        end,
    })

    AutofarmTab:CreateToggle({
        Name = 'Auto Fling Sheriff',
        CurrentValue = false,
        Flag = 'autoflingsheriff',
        Callback = function(v)
            Config.AutoFarm.AutoFlingSheriff = v
        end,
    })

    AutofarmTab:CreateToggle({
        Name = 'Server Hop If Server Is Empty',
        CurrentValue = false,
        Flag = 'serverhopifserverisempty',
        Callback = function(v)
            Config.AutoFarm.AutoTeleportToRandomServerIfServerIsEmpty = v
        end,
    })

    AutofarmTab:CreateSlider({
        Name = 'Players To Auto Server Hop',
        Range = {1, 12},
        Increment = 1,
        Suffix = '',
        CurrentValue = 2,
        Flag = 'playerstoautoserverhop',
        Callback = function(v)
            Config.AutoFarm.PlayersToAutoServerHop = v
        end,
    })

    -- COIN FARM TAB
    local CoinFarmTab = Window:CreateTab('Coin Farm', 4483362458)
    CoinFarmTab:CreateSection('Coin Farm 1 [Updated]')

    CoinFarmTab:CreateToggle({
        Name = 'Enable Coin Farm 1',
        CurrentValue = false,
        Flag = 'coinfarmstate',
        Callback = function(v)
            Config.CoinFarm.State = v
            if not v then
                local _HumanoidRootPart6 = u70.Character.HumanoidRootPart
                _HumanoidRootPart6.Anchored = false
                if _HumanoidRootPart6:FindFirstChild('FLY_NIGGER') then
                    _HumanoidRootPart6.FLY_NIGGER:Destroy()
                end
            end
        end,
    })

    CoinFarmTab:CreateSlider({
        Name = 'Farm Speed (CF1)',
        Range = {15, 25},
        Increment = 0.1,
        Suffix = '',
        CurrentValue = DefaultConfig.CoinFarm.Settings.Speed,
        Flag = 'coinfarmspeed',
        Callback = function(v)
            Config.CoinFarm.Settings.Speed = v
        end,
    })

    CoinFarmTab:CreateButton({
        Name = 'Print Config',
        Callback = function()
            print_table(Config)
        end,
    })

    CoinFarmTab:CreateSection('Coin Farm 2 (FASTER)')

    CoinFarmTab:CreateToggle({
        Name = 'Enable Coin Farm 2',
        CurrentValue = false,
        Flag = 'coinfarm2state',
        Callback = function(v)
            Config.CoinFarm2.State = v
        end,
    })

    CoinFarmTab:CreateSlider({
        Name = 'Farm Speed (CF2)',
        Range = {15, 25},
        Increment = 0.1,
        Suffix = '',
        CurrentValue = DefaultConfig.CoinFarm2.Settings.Speed,
        Flag = 'coinfarm2speed',
        Callback = function(v)
            Config.CoinFarm2.Settings.Speed = v
        end,
    })

    CoinFarmTab:CreateSection('Coin Farm 3 (Safe TP)')

    CoinFarmTab:CreateToggle({
        Name = 'Enable Coin Farm 3',
        CurrentValue = false,
        Flag = 'coinfarm3state',
        Callback = function(v)
            Config.CoinFarm3.State = v
            if v then
                task.spawn(function() CoinFarm3() end)
            end
        end,
    })

    CoinFarmTab:CreateSection('Coin Settings')

    CoinFarmTab:CreateToggle({
        Name = 'Floating (no falling under map)',
        CurrentValue = false,
        Flag = 'coinfly',
        Callback = function(v)
            Config.CoinFarm.Settings.Fly = v
            if FlyPatchIgnore ~= nil then
                FlyPatchIgnore = true
                if not v then killme() end
            end
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Destroy Player Models',
        CurrentValue = false,
        Flag = 'destroyplayerscoin',
        Callback = function(v)
            Config.CoinFarm.Settings.DestroyPlayers = v
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Destroy Map',
        CurrentValue = false,
        Flag = 'destroymapcoin',
        Callback = function(v)
            Config.CoinFarm.Settings.DestroyMap = v
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Die at Full Bag',
        CurrentValue = false,
        Flag = 'dieatfullbag',
        Callback = function(v)
            Config.CoinFarm.Settings.DieAtFullBag = v
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Teleport Under Lobby At Full Bag',
        CurrentValue = false,
        Flag = 'teleportundermap',
        Callback = function(v)
            Config.AutoFarm.TeleportUnderMap = v
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Auto Kill Everyone At Full Bag As A Murderer',
        CurrentValue = false,
        Flag = 'autokilleveryonefullbag',
        Callback = function(v)
            Config.AutoFarm.KillEveryoneAsAMurdererAtFullBag = v
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Auto Fling Murderer At Full Bag',
        CurrentValue = false,
        Flag = 'autoflingmurdereratfullbag',
        Callback = function(v)
            Config.AutoFarm.AutoFlingMurdererAtFullBag = v
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Disable 3D Rendering',
        CurrentValue = false,
        Flag = 'disable3drendering',
        Callback = function(v)
            Config.CoinFarm2.Disable3DRendering = v
        end,
    })

    CoinFarmTab:CreateToggle({
        Name = 'Stats Overlay',
        CurrentValue = false,
        Flag = 'statsoverlay',
        Callback = function(v)
            Config.CoinFarm.StatsOverlay = v
        end,
    })

    CoinFarmTab:CreateSection('Auto Open Crates')

    CoinFarmTab:CreateToggle({
        Name = 'Auto Open Chosen Box',
        CurrentValue = false,
        Flag = 'autoopencrates',
        Callback = function(v)
            Config.AutoOpenCrates.State = v
        end,
    })

    boxes1 = {}
    local v459, v460, v461 = pairs(require(game:GetService('ReplicatedStorage').Database.Sync.Shop).Weapons)
    while true do
        local v462
        v461, v462 = v459(v460, v461)
        if v461 == nil then break end
        table.insert(boxes1, tostring(v461))
    end

    CoinFarmTab:CreateDropdown({
        Name = 'Choose Box',
        Options = boxes1,
        CurrentOption = {'MysteryBox1'},
        MultipleOptions = false,
        Flag = 'autoopencratesbox',
        Callback = function(v)
            local newValue = v
            Config.AutoOpenCrates.Crate = newValue
            Config.AutoOpenCrates.CrateType = require(game:GetService('ReplicatedStorage').Database.Sync.Shop).Weapons[newValue].DataType
        end,
    })

    -- MISC TAB
    local MiscTab = Window:CreateTab('Misc', 4483362458)

    MiscTab:CreateSection('Server Stuff')

    MiscTab:CreateButton({
        Name = 'Rejoin Server',
        Callback = function()
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId)
        end,
    })

    MiscTab:CreateButton({
        Name = 'Server Hop',
        Callback = function()
            ServerHop()
        end,
    })

    MiscTab:CreateSection('Server Crasher')

    MiscTab:CreateButton({
        Name = 'Crash Server',
        Callback = function()
            if getgenv().dev then
                CrashServer()
            else
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = 'Buy Premium',
                    Text = '1 harvester is nothing for a server crash exploit',
                    Duration = 5,
                })
            end
        end,
    })

    MiscTab:CreateSection('Unlock Emotes')

    MiscTab:CreateButton({
        Name = 'Unlock All Emotes',
        Callback = function()
            GetAllEmotesExecuted = false
            if GetAllEmotesExecuted == false and (_LocalPlayer2.PlayerGui.MainGUI.Game:FindFirstChild('Emotes') and (_LocalPlayer2.Character:FindFirstChild('HumanoidRootPart') and _LocalPlayer2.Character.Humanoid.Health >= 0)) then
                GetAllEmotesExecuted = true
                GetAllEmotes()
            end
        end,
    })

    MiscTab:CreateSection('Inventory Stuff')

    MiscTab:CreateToggle({
        Name = 'Spawn Gingerscope',
        CurrentValue = false,
        Flag = 'visualgun',
        Callback = function(v)
            Config.VisualGun = v
            if v then spawnitem() end
        end,
    })

    MiscTab:CreateSection('Spam Random Emotes')

    MiscTab:CreateToggle({
        Name = 'Toggle Spam',
        CurrentValue = false,
        Flag = 'emotespam',
        Callback = function(v)
            Config.Emotes.AutoPlayEmotes = v
        end,
    })

    MiscTab:CreateSlider({
        Name = 'Spam Speed',
        Range = {1, 10},
        Increment = 1,
        Suffix = '',
        CurrentValue = 1,
        Flag = 'emotespamspeed',
        Callback = function(v)
            Config.Emotes.EmoteSpamSpeed = v
        end,
    })

    MiscTab:CreateSection('Spam Selected Emote')

    MiscTab:CreateToggle({
        Name = 'Spam Selected Emote',
        CurrentValue = false,
        Flag = 'spamselectedemote',
        Callback = function(v)
            Config.Emotes.AutoPlaySelectedEmote = v
        end,
    })

    MiscTab:CreateDropdown({
        Name = 'Pick An Emote',
        Options = u29,
        CurrentOption = {'dab'},
        MultipleOptions = false,
        Flag = 'pickedemote',
        Callback = function(v)
            Config.Emotes.SelectedEmote = v
        end,
    })

    MiscTab:CreateSection('Fast Skin Swapper')

    MiscTab:CreateToggle({
        Name = 'Shuffle Skins',
        CurrentValue = false,
        Flag = 'shuffleskins',
        Callback = function(v)
            Config.ShuffleWeapons = v
        end,
    })

    MiscTab:CreateSection('Crate Spawner')

    local WeaponsList = MiscTab:CreateDropdown({
        Name = 'Pick A Weapon',
        Options = {'please filter weapons'},
        CurrentOption = {'please filter weapons'},
        MultipleOptions = false,
        Flag = 'weapontoscroll',
        Callback = function(v)
            getgenv().newValue = getrawnamebyrealname(v)
        end,
    })

    MiscTab:CreateInput({
        Name = 'Filter Database',
        CurrentValue = 'Harvester',
        PlaceholderText = 'Type weapon name...',
        RemoveTextAfterFocusLost = false,
        Flag = 'filterdatabase',
        Callback = function(v)
            local eee = gettable(v)
            wait(1)
            WeaponsList:Set(eee[1] or 'No results')
        end,
    })

    MiscTab:CreateButton({
        Name = 'Open Crate',
        Callback = function()
            opencrate(getgenv().newValue, false)
        end,
    })

    MiscTab:CreateSlider({
        Name = 'Crate Spawn Chance',
        Range = {1, 100},
        Increment = 1,
        Suffix = '',
        CurrentValue = 1,
        Flag = 'cratespawnchance',
        Callback = function(v)
            getgenv().spawnamount = v
        end,
    })

    MiscTab:CreateButton({
        Name = 'Just Spawn Item',
        Callback = function()
            if getgenv().newValue ~= nil then
                opencrate(getgenv().newValue, true)
            else
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = 'No weapon selected',
                    Text = 'Please select a weapon',
                    Duration = 5,
                })
            end
        end,
    })

    -- SETTINGS TAB
    local SettingsTab = Window:CreateTab('Settings', 4483362458)
    SettingsTab:CreateSection('Settings')

    SettingsTab:CreateButton({
        Name = 'Save Config',
        Callback = function()
            Rayfield:SaveConfiguration()
            game:GetService('StarterGui'):SetCore('SendNotification', {
                Title = 'Config Saved!',
                Text = 'Your config has been saved.',
                Duration = 5,
            })
        end,
    })

    SettingsTab:CreateButton({
        Name = 'Load Config',
        Callback = function()
            Rayfield:LoadConfiguration()
            game:GetService('StarterGui'):SetCore('SendNotification', {
                Title = 'Config Loaded!',
                Text = 'Settings have been applied.',
                Duration = 5,
            })
        end,
    })

    SettingsTab:CreateButton({
        Name = 'Reset Config',
        Callback = function()
            Config = deep_copy_table(DefaultConfig)
            game:GetService('StarterGui'):SetCore('SendNotification', {
                Title = 'Config Reset!',
                Text = 'If you rejoin you will have default settings.',
                Duration = 5,
            })
        end,
    })

    -- ABOUT TAB
    local AboutTab = Window:CreateTab('About Script', 4483362458)
    AboutTab:CreateSection('About')

    AboutTab:CreateLabel(DevelopingLog)
    AboutTab:CreateLabel('Version: 1.5 | Last Changes: New Coin Farm 3!')

    AboutTab:CreateSection('Discord')

    AboutTab:CreateButton({
        Name = 'Join Discord (copy link)',
        Callback = function()
            setclipboard('https://discord.gg/rCDwwPuhn6')
        end,
    })

    AboutTab:CreateButton({
        Name = 'Advertize Discord',
        Callback = function()
            AdvertizeDiscord()
        end,
    })

    AboutTab:CreateToggle({
        Name = 'Auto Advertize Discord At Round Start',
        CurrentValue = false,
        Flag = 'autoadvertizediscord',
        Callback = function(v)
            Config.AutoAdvertizeDiscord = v
        end,
    })

    Rayfield:LoadConfiguration()
end
