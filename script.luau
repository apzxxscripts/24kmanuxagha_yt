-- // ⚡ R&N FUSIONS X AGHA — PremiumV3 (Password Hidden / Obfuscated)
-- Only for PremiumV3 users | Password is stored encoded (not plaintext)
-- If you need to change the password: use the encode helper (commented below) to generate a new encoded string.

local attempts = 0
local TweenService = game:GetService("TweenService")

-- ===== Obfuscation helpers (Additive + Hex encode)
-- We store the password as hex produced by: (byte + keyByte) % 256
-- Decoder below recovers the original password at runtime.
local encoded_password_hex = "a589dba0d3c1a9e4d588dbb6cface6cb" -- encoded
local _secret_key = "sUp3rS4lt!" -- keep this secret (required to decode)

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

-- Uncomment & use this if you want to encode a new password locally (not to be shipped in final code)
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
-- Example usage (run in a safe environment): print(encode_password("your_new_pass", "sUp3rS4lt!"))
]]

-- Decode at runtime
local password = decode_password(encoded_password_hex, _secret_key)
-- ===== end obfuscation helpers

-- GUI (insane premium, black & red)
local gui = Instance.new("ScreenGui")
gui.Name = "RN_FUSIONS_X_AGHA_PREMIUMV3"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 520, 0, 360)
frame.Position = UDim2.new(0.5, -260, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 1
frame.Parent = gui

-- fade in
TweenService:Create(frame, TweenInfo.new(1.0, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- neon border
local border = Instance.new("UIStroke", frame)
border.Color = Color3.fromRGB(255, 0, 60)
border.Thickness = 2.8
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- top shadow glow (image slice)
local shadow = Instance.new("ImageLabel", frame)
shadow.ZIndex = -1
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 80, 1, 80)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(255, 0, 40)
shadow.ImageTransparency = 0.74
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)

-- logo (fancy)
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 68, 0, 68)
logo.Position = UDim2.new(0, 18, 0, -4)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://137059799924514"
logo.ImageTransparency = 1
logo.Parent = frame
TweenService:Create(logo, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()

-- title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
title.Text = "🔒 R&N FUSIONS X AGHA — PremiumV3"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 0, 80)
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

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

-- discord hover glow animation
local hoverTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local discordGlow = Instance.new("UIStroke", discordButton)
discordGlow.Color = Color3.fromRGB(255,0,60)
discordGlow.Thickness = 1.8
discordGlow.Transparency = 1

discordButton.MouseEnter:Connect(function()
    TweenService:Create(discordGlow, hoverTweenInfo, {Transparency = 0}):Play()
    TweenService:Create(discordButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(60,0,0)}):Play()
end)
discordButton.MouseLeave:Connect(function()
    TweenService:Create(discordGlow, hoverTweenInfo, {Transparency = 1}):Play()
    TweenService:Create(discordButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(30,0,0)}):Play()
end)

discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/KkHJznVJbv")
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
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -34)
footer.BackgroundTransparency = 1
footer.Text = "⚡ Only for PremiumV3 users | © R&N FUSIONS X AGHA"
footer.Font = Enum.Font.Gotham
footer.TextSize = 13
footer.TextColor3 = Color3.fromRGB(220, 0, 40)
footer.Parent = frame

-- cinematic ACCESS GRANTED (sound optional)
local function AccessGranted()
    title.Text = "✅ ACCESS GRANTED — WELCOME PREMIUMV3 USER"
    status.Text = "🔓 Unlocked Successfully!"
    copyButton.Visible = true

    -- big glow pulse
    local pulse = Instance.new("UIStroke", frame)
    pulse.Color = Color3.fromRGB(0,255,140)
    pulse.Thickness = 3
    pulse.Transparency = 0.8

    for i = 1, 5 do
        TweenService:Create(pulse, TweenInfo.new(0.18), {Transparency = 1}):Play()
        wait(0.18)
        TweenService:Create(pulse, TweenInfo.new(0.18), {Transparency = 0.3}):Play()
        wait(0.18)
    end
    pulse:Destroy()

    -- small title color flash
    local t = TweenService:Create(title, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {TextColor3 = Color3.fromRGB(0,255,140)})
    t:Play()
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

-- copy function
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
