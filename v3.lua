-- // ⚡ R&N FUSIONS X AGHA — PremiumV3 (Password Hidden / Obfuscated)
-- Full premium GUI version — separate Credits window (open with Credits button)
-- Password encoded (no plaintext)

local attempts = 0
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

-- ===== Obfuscation helpers (Additive + Hex encode)
-- Password (hidden): "24kmanuxagha_ytx"
local encoded_password_hex = "a589dba0d3c1a9e4d588dbb6cface6cb" -- encoded (do NOT change unless you encode another)
local _secret_key = "sUp3rS4lt!" -- keep secret

local function hexToBytes(hex)
    local bytes = {}
    for i = 1, #hex, 2 do
        local byte = tonumber(hex:sub(i, i+1), 16)
        table.insert(bytes, byte)
    end
    return bytes
end

local function decode_password(hex, key)
    local bytes = hexToBytes(hex)
    local out = {}
    for i = 1, #bytes do
        local k = string.byte(key, ((i-1) % #key) + 1)
        local b = (bytes[i] - k) % 256
        table.insert(out, string.char(b))
    end
    return table.concat(out)
end

-- Uncomment & use this helper locally (don't ship plaintext)
--[[
local function encode_password(plain, key)
    local out = {}
    for i = 1, #plain do
        local b = string.byte(plain, i)
        local k = string.byte(key, ((i-1) % #key) + 1)
        local v = (b + k) % 256
        out[#out+1] = string.format("%02x", v)
    end
    return table.concat(out)
end
-- Example (run locally): print(encode_password("24kmanuxagha_ytx", "sUp3rS4lt!"))
]]

local password = decode_password(encoded_password_hex, _secret_key)
-- ===== end obfuscation helpers

-- MAIN GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RN_FUSIONS_X_AGHA_PREMIUMV3"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 520, 0, 420)
frame.Position = UDim2.new(0.5, -260, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 0
frame.Active = true
frame.BackgroundTransparency = 1
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- neon border
local border = Instance.new("UIStroke", frame)
border.Color = Color3.fromRGB(255, 0, 60)
border.Thickness = 2.8
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- subtle ripple shadow (behind)
local shadow = Instance.new("ImageLabel", frame)
shadow.Name = "TopGlow"
shadow.ZIndex = -2
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.45, 0)
shadow.Size = UDim2.new(1, 120, 1, 120)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(255, 0, 40)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)

-- logo (updated)
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 72, 0, 72)
logo.Position = UDim2.new(0, 18, 0, -6)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://137059799924514" -- NEW LOGO ID
logo.ImageTransparency = 1
logo.Parent = frame

-- header container (drag area)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundTransparency = 1
header.Parent = frame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
title.Text = "🔒 R&N FUSIONS X AGHA — PremiumV3"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 0, 80)
title.Parent = header
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

-- close button (top-right)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,34,0,34)
closeBtn.Position = UDim2.new(1,-44,0,12)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)
local closeStroke = Instance.new("UIStroke", closeBtn)
closeStroke.Color = Color3.fromRGB(255,60,60)
closeStroke.Transparency = 0.7
closeStroke.Thickness = 1.2

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundTransparency = 0, Size = closeBtn.Size + UDim2.new(0,4,0,4)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundTransparency = 0.2, Size = closeBtn.Size - UDim2.new(0,4,0,4)}):Play()
end)
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
    wait(0.28)
    if gui and gui.Parent then gui:Destroy() end
end)

-- input box
local input = Instance.new("TextBox")
input.Size = UDim2.new(1, -44, 0, 40)
input.Position = UDim2.new(0, 22, 0, 82)
input.PlaceholderText = "🔐 Enter PremiumV3 Password"
input.Text = ""
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.TextColor3 = Color3.new(1, 1, 1)
input.BackgroundColor3 = Color3.fromRGB(28, 7, 7)
input.ClearTextOnFocus = false
input.Parent = frame
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

-- unlock button
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -44, 0, 44)
button.Position = UDim2.new(0, 22, 0, 134)
button.Text = "🔓 Unlock PremiumV3 Access"
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(200, 0, 40)
button.Parent = frame
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

-- copy button (hidden initially)
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1, -44, 0, 44)
copyButton.Position = UDim2.new(0, 22, 0, 188)
copyButton.Text = "📂 Copy Game + Scripts"
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 18
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 90)
copyButton.Visible = false
copyButton.Parent = frame
Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 6)

-- "Join Discord" button (glowing)
local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(1, -44, 0, 44)
discordButton.Position = UDim2.new(0, 22, 0, 242)
discordButton.Text = "💬 Join Discord — R&N FUSIONS X AGHA"
discordButton.Font = Enum.Font.GothamBold
discordButton.TextSize = 17
discordButton.TextColor3 = Color3.new(1, 1, 1)
discordButton.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
discordButton.Parent = frame
Instance.new("UICorner", discordButton).CornerRadius = UDim.new(0, 6)

-- Credits open button (separate window)
local creditsOpenBtn = Instance.new("TextButton")
creditsOpenBtn.Size = UDim2.new(0.34, 0, 0, 32)
creditsOpenBtn.Position = UDim2.new(0.66, -6, 1, -90)
creditsOpenBtn.AnchorPoint = Vector2.new(0,0)
creditsOpenBtn.Text = "Credits"
creditsOpenBtn.Font = Enum.Font.GothamBold
creditsOpenBtn.TextSize = 14
creditsOpenBtn.TextColor3 = Color3.new(1,1,1)
creditsOpenBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
creditsOpenBtn.Parent = frame
Instance.new("UICorner", creditsOpenBtn).CornerRadius = UDim.new(0,6)

-- hover glow
local hoverTweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local discordGlow = Instance.new("UIStroke", discordButton)
discordGlow.Color = Color3.fromRGB(255,0,60)
discordGlow.Thickness = 1.8
discordGlow.Transparency = 1

discordButton.MouseEnter:Connect(function()
    TweenService:Create(discordGlow, hoverTweenInfo, {Transparency = 0}):Play()
    TweenService:Create(discordButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(60,0,0), Position = UDim2.new(0,22,0,240)}):Play()
end)
discordButton.MouseLeave:Connect(function()
    TweenService:Create(discordGlow, hoverTweenInfo, {Transparency = 1}):Play()
    TweenService:Create(discordButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(30,0,0), Position = UDim2.new(0,22,0,242)}):Play()
end)

discordButton.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/KkHJznVJbv") end)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "R&N FUSIONS X AGHA",
            Text = "✅ Discord link copied to clipboard!",
            Duration = 3
        })
    end)
end)

-- status label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -44, 0, 28)
status.Position = UDim2.new(0, 22, 0, 298)
status.BackgroundTransparency = 1
status.Text = "💬 Status: Waiting for password..."
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = Color3.fromRGB(200,200,200)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

-- footer note
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 28)
footer.Position = UDim2.new(0, 0, 1, -56)
footer.BackgroundTransparency = 1
footer.Text = "⚡ Only for PremiumV3 users | © R&N FUSIONS X AGHA"
footer.Font = Enum.Font.Gotham
footer.TextSize = 13
footer.TextColor3 = Color3.fromRGB(220, 0, 40)
footer.Parent = frame

-- CREDITS MODAL (separate window)
local creditsModal = Instance.new("Frame")
creditsModal.Size = UDim2.new(0, 420, 0, 220)
creditsModal.Position = UDim2.new(0.5, -210, 0.5, -110)
creditsModal.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
creditsModal.BorderSizePixel = 0
creditsModal.Visible = false
creditsModal.Parent = gui
Instance.new("UICorner", creditsModal).CornerRadius = UDim.new(0, 10)
creditsModal.ZIndex = 60

local creditsBorder = Instance.new("UIStroke", creditsModal)
creditsBorder.Color = Color3.fromRGB(255, 0, 60)
creditsBorder.Thickness = 2
creditsBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local creditsTitle = Instance.new("TextLabel")
creditsTitle.Size = UDim2.new(1, -24, 0, 44)
creditsTitle.Position = UDim2.new(0, 12, 0, 8)
creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "Credits"
creditsTitle.Font = Enum.Font.GothamBold
creditsTitle.TextSize = 20
creditsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsTitle.TextXAlignment = Enum.TextXAlignment.Left
creditsTitle.Parent = creditsModal

local creditsDesc = Instance.new("TextLabel")
creditsDesc.Size = UDim2.new(1, -24, 0, 60)
creditsDesc.Position = UDim2.new(0, 12, 0, 48)
creditsDesc.BackgroundTransparency = 1
creditsDesc.Text = "Thanks for using PremiumV3. Click a profile to copy the Roblox profile link."
creditsDesc.Font = Enum.Font.Gotham
creditsDesc.TextSize = 14
creditsDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
creditsDesc.TextWrapped = true
creditsDesc.TextXAlignment = Enum.TextXAlignment.Left
creditsDesc.Parent = creditsModal

-- buttons for profiles
local devBtn = Instance.new("TextButton")
devBtn.Size = UDim2.new(1, -36, 0, 36)
devBtn.Position = UDim2.new(0, 18, 0, 120)
devBtn.Text = "DEV — Open Profile (Copy Link)"
devBtn.Font = Enum.Font.GothamBold
devBtn.TextSize = 14
devBtn.TextColor3 = Color3.new(1,1,1)
devBtn.BackgroundColor3 = Color3.fromRGB(30,0,0)
devBtn.Parent = creditsModal
Instance.new("UICorner", devBtn).CornerRadius = UDim.new(0,6)

local collabBtn = Instance.new("TextButton")
collabBtn.Size = UDim2.new(1, -36, 0, 36)
collabBtn.Position = UDim2.new(0, 18, 0, 160)
collabBtn.Text = "Collaborated with — Open (Copy Link)"
collabBtn.Font = Enum.Font.GothamBold
collabBtn.TextSize = 14
collabBtn.TextColor3 = Color3.new(1,1,1)
collabBtn.BackgroundColor3 = Color3.fromRGB(30,0,0)
collabBtn.Parent = creditsModal
Instance.new("UICorner", collabBtn).CornerRadius = UDim.new(0,6)

-- small tester button (placed next to collab using a small layout)
local testerBtn = Instance.new("TextButton")
testerBtn.Size = UDim2.new(1, -36, 0, 36)
testerBtn.Position = UDim2.new(0, 18, 0, 200)
testerBtn.Text = "Tester — Open Profile (Copy Link)"
testerBtn.Font = Enum.Font.GothamBold
testerBtn.TextSize = 14
testerBtn.TextColor3 = Color3.new(1,1,1)
testerBtn.BackgroundColor3 = Color3.fromRGB(30,0,0)
testerBtn.Parent = creditsModal
Instance.new("UICorner", testerBtn).CornerRadius = UDim.new(0,6)

-- close credits button
local creditsClose = Instance.new("TextButton")
creditsClose.Size = UDim2.new(0, 32, 0, 32)
creditsClose.Position = UDim2.new(1, -44, 0, 12)
creditsClose.Text = "✕"
creditsClose.Font = Enum.Font.GothamBold
creditsClose.TextSize = 18
creditsClose.TextColor3 = Color3.new(1,1,1)
creditsClose.BackgroundTransparency = 0.2
creditsClose.Parent = creditsModal
Instance.new("UICorner", creditsClose).CornerRadius = UDim.new(0,6)

-- profile URLs
local devURL = "https://www.roblox.com/users/8769314544/profile"
local collabURL = "https://www.roblox.com/users/1033230584/profile"
local testerURL = "https://www.roblox.com/users/5605094637/profile"

devBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(devURL) end)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Credits",
            Text = "DEV profile link copied to clipboard!",
            Duration = 3
        })
    end)
end)

collabBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(collabURL) end)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Credits",
            Text = "Collaborator profile link copied to clipboard!",
            Duration = 3
        })
    end)
end)

testerBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(testerURL) end)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Credits",
            Text = "Tester profile link copied to clipboard!",
            Duration = 3
        })
    end)
end)

creditsClose.MouseButton1Click:Connect(function()
    TweenService:Create(creditsModal, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -210, 0.5, -110), BackgroundTransparency = 1}):Play()
    wait(0.22)
    creditsModal.Visible = false
    creditsModal.BackgroundTransparency = 0
    creditsModal.Position = UDim2.new(0.5, -210, 0.5, -110)
end)

-- Credits open logic: animate modal in
creditsOpenBtn.MouseButton1Click:Connect(function()
    if not creditsModal.Visible then
        creditsModal.Position = UDim2.new(0.5, -210, 1.3, 0)
        creditsModal.Visible = true
        creditsModal.BackgroundTransparency = 1
        TweenService:Create(creditsModal, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -210, 0.5, -110), BackgroundTransparency = 0}):Play()
    else
        -- close it
        TweenService:Create(creditsModal, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -210, 1.3, 0), BackgroundTransparency = 1}):Play()
        wait(0.22)
        creditsModal.Visible = false
        creditsModal.BackgroundTransparency = 0
        creditsModal.Position = UDim2.new(0.5, -210, 0.5, -110)
    end
end)

-- small helper: bounce tween
local function bounce(instance)
    local up = TweenService:Create(instance, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = instance.Position - UDim2.new(0,0,0,6)})
    local down = TweenService:Create(instance, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = instance.Position})
    up:Play(); up.Completed:Wait()
    down:Play()
end

-- cinematic ACCESS GRANTED (sound + effects)
local function AccessGranted()
    title.Text = "✅ ACCESS GRANTED — WELCOME PREMIUMV3 USER"
    status.Text = "🔓 Unlocked Successfully!"
    copyButton.Visible = true

    -- unlock sound (pcall in case sound permissions)
    pcall(function()
        local s = Instance.new("Sound", frame)
        s.SoundId = "rbxassetid://184352017" -- subtle chime (replace if needed)
        s.Volume = 1
        s:Play()
        Debris:AddItem(s, 2)
    end)

    -- big glow pulse
    local pulse = Instance.new("UIStroke", frame)
    pulse.Color = Color3.fromRGB(0,255,140)
    pulse.Thickness = 3
    pulse.Transparency = 0.9

    for i = 1, 5 do
        TweenService:Create(pulse, TweenInfo.new(0.18), {Transparency = 1}):Play()
        wait(0.12)
        TweenService:Create(pulse, TweenInfo.new(0.18), {Transparency = 0.3}):Play()
        wait(0.12)
    end
    pulse:Destroy()

    -- small title color flash
    local t = TweenService:Create(title, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {TextColor3 = Color3.fromRGB(0,255,140)})
    t:Play()

    -- subtle copyButton pop-in
    copyButton.Position = UDim2.new(0,22,0,220)
    copyButton.BackgroundTransparency = 1
    copyButton.TextTransparency = 1
    TweenService:Create(copyButton, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0, TextTransparency = 0, Position = UDim2.new(0,22,0,188)}):Play()

    -- optionally show credits modal briefly (commented out)
    -- creditsOpenBtn.MouseButton1Click() -- leave user to open credits manually
end

-- unlock logic
button.MouseButton1Click:Connect(function()
    if input.Text == password then
        button.Visible = false
        input.Visible = false
        AccessGranted()
    else
        attempts = attempts + 1
        status.Text = "❌ Wrong Password ("..attempts.."/3)"
        border.Color = Color3.fromRGB(255, 80, 80)
        wait(0.35)
        border.Color = Color3.fromRGB(255, 0, 60)
        if attempts >= 3 then
            title.Text = "🚫 Access Locked"
            wait(1)
            gui:Destroy()
        end
    end
end)

-- copy function (preserved original behavior)
copyButton.MouseButton1Click:Connect(function()
    status.Text = "📁 Copying with scripts..."
    local success, err = pcall(function()
        local saveinstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau"))()
        saveinstance({
            FileName = "RNFusions_FullCopy_" .. tostring(game.PlaceId) .. ".rbxlx",
            Decompile = true,
            IncludeScripts = true,
            CreatorTag = "Copied by R&N FUSIONS X AGHA — PremiumV3"
        })
        status.Text = "✅ Game saved successfully!"
    end)
    if not success then
        status.Text = "❌ Error: " .. tostring(err)
    end
end)

-- subtle hover effects for main buttons
local function bindHoverEffects(btn)
    local glow = Instance.new("UIStroke", btn)
    glow.Color = Color3.fromRGB(255, 100, 120)
    glow.Thickness = 1.6
    glow.Transparency = 1
    btn.MouseEnter:Connect(function()
        TweenService:Create(glow, hoverTweenInfo, {Transparency = 0}):Play()
        TweenService:Create(btn, hoverTweenInfo, {Size = btn.Size + UDim2.new(0,6,0,6), Position = btn.Position - UDim2.new(0,3,0,3)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(glow, hoverTweenInfo, {Transparency = 1}):Play()
        TweenService:Create(btn, hoverTweenInfo, {Size = btn.Size - UDim2.new(0,6,0,6), Position = btn.Position + UDim2.new(0,3,0,3)}):Play()
    end)
end

bindHoverEffects(button)
bindHoverEffects(copyButton)
bindHoverEffects(discordButton)
bindHoverEffects(creditsOpenBtn)
bindHoverEffects(devBtn)
bindHoverEffects(collabBtn)
bindHoverEffects(testerBtn)
bindHoverEffects(closeBtn)
bindHoverEffects(creditsClose)

-- entrance animation (pop + fade)
TweenService:Create(frame, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
TweenService:Create(logo, TweenInfo.new(0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0,18,0,6)}):Play()
TweenService:Create(title, TweenInfo.new(0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()

-- idle bobbing animation to give life (subtle)
spawn(function()
    local elapsed = 0
    while gui and gui.Parent do
        elapsed = elapsed + RunService.Heartbeat:Wait()
        local offset = math.sin(elapsed * 1.1) * 4
        frame.Position = UDim2.new(0.5, -260, 0.5, -210 + offset)
        wait(0.02)
    end
end)

-- CUSTOM SMOOTH DRAGGING (draggable by header or logo)
do
    local dragging = false
    local dragStart
    local startPos

    local function onInputBegan(inputObj)
        if inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouseLoc = UserInputService:GetMouseLocation()
            local mx, my = mouseLoc.X, mouseLoc.Y
            local absPos = frame.AbsolutePosition
            local localX = mx - absPos.X
            local localY = my - absPos.Y

            if (localY >= 0 and localY <= 60) or
               (mx >= logo.AbsolutePosition.X and mx <= logo.AbsolutePosition.X + logo.AbsoluteSize.X and my >= logo.AbsolutePosition.Y and my <= logo.AbsolutePosition.Y + logo.AbsoluteSize.Y) then
                dragging = true
                dragStart = Vector2.new(mx, my)
                startPos = frame.Position
                frame.ZIndex = 50
                TweenService:Create(frame, TweenInfo.new(0.12), {Size = frame.Size + UDim2.new(0,6,0,6)}):Play()
            end
        end
    end

    local function onInputChanged(inputObj)
        if dragging and inputObj.UserInputType == Enum.UserInputType.MouseMovement then
            local mouseLoc = UserInputService:GetMouseLocation()
            local delta = Vector2.new(mouseLoc.X, mouseLoc.Y) - dragStart
            local newX = startPos.X.Offset + delta.X
            local newY = startPos.Y.Offset + delta.Y
            local viewportSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280,720)
            local maxX = viewportSize.X - frame.AbsoluteSize.X - 8
            local maxY = viewportSize.Y - frame.AbsoluteSize.Y - 8
            newX = math.clamp(newX, 8 - frame.AbsoluteSize.X/2, maxX)
            newY = math.clamp(newY, 8 - frame.AbsoluteSize.Y/2, maxY)
            frame.Position = UDim2.new(0, newX, 0, newY)
        end
    end

    local function onInputEnded(inputObj)
        if dragging and inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            frame.ZIndex = 1
            TweenService:Create(frame, TweenInfo.new(0.12), {Size = UDim2.new(0,520,0,420)}):Play()
        end
    end

    UserInputService.InputBegan:Connect(onInputBegan)
    UserInputService.InputChanged:Connect(onInputChanged)
    UserInputService.InputEnded:Connect(onInputEnded)
end

-- make sure GUI cleans gracefully if the game or parent gets removed
gui.AncestryChanged:Connect(function()
    if not gui:IsDescendantOf(game) then
        -- loop checks gui.Parent, so termination happens naturally
    end
end)
