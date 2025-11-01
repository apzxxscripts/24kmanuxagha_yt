-- R&N FUSIONS X AGHA — PremiumV3 REMASTERED (Crimson Core) — FINAL

-- ===== SERVICES =====
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

-- ===== SECURITY (encoded password) =====
local encoded_password_hex = "a589dba0d3c1a9e4d588dbb6cface6cb"
local _secret_key = "sUp3rS4lt!"

local function hexToBytes(hex)
    local bytes = {}
    for i = 1, #hex, 2 do bytes[#bytes+1] = tonumber(hex:sub(i, i+1), 16) end
    return bytes
end

local function decode_password(hex, key)
    local bytes = hexToBytes(hex)
    local out = {}
    for i = 1, #bytes do
        local k = string.byte(key, ((i-1) % #key) + 1)
        local b = (bytes[i] - k) % 256
        out[#out+1] = string.char(b)
    end
    return table.concat(out)
end

local password = decode_password(encoded_password_hex, _secret_key)

-- ===== SAFE CLEANUP (remove older GUIs) =====
for _, c in pairs(game.CoreGui:GetChildren()) do
    if c.Name == "RNF_PremiumV3_Final" then pcall(function() c:Destroy() end) end
end

-- ===== BLUR =====
if not Lighting:FindFirstChild("RNF_PremiumBlur") then
    local blur = Instance.new("BlurEffect")
    blur.Name = "RNF_PremiumBlur"
    blur.Size = 0
    blur.Parent = Lighting
    TweenService:Create(blur, TweenInfo.new(0.42, Enum.EasingStyle.Quad), {Size = 6}):Play()
else
    local b = Lighting:FindFirstChild("RNF_PremiumBlur")
    TweenService:Create(b, TweenInfo.new(0.32, Enum.EasingStyle.Quad), {Size = 6}):Play()
end

-- ===== GUI ROOT =====
local gui = Instance.new("ScreenGui")
gui.Name = "RNF_PremiumV3_Final"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game.CoreGui

-- ===== CONTAINER =====
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 640, 0, 460)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0.5, 0.5, 0)
container.BackgroundColor3 = Color3.fromRGB(15,15,15)
container.BorderSizePixel = 0
container.ClipsDescendants = true
container.Parent = gui
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", container)
stroke.Color = Color3.fromRGB(170,18,36)
stroke.Thickness = 1.6
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- HEADER
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 68)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(28,8,8)
header.BorderSizePixel = 0
header.Parent = container
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(1, -160, 1, 0)
title.Position = UDim2.new(0, 24, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔒 R&N FUSIONS X AGHA — PremiumV3"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,195,200)
title.TextXAlignment = Enum.TextXAlignment.Left

local logo = Instance.new("ImageLabel")
logo.Parent = header
logo.Size = UDim2.new(0, 64, 0, 64)
logo.Position = UDim2.new(1, -100, 0.5, -32)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://137059799924514"
logo.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 10)

local btnClose = Instance.new("TextButton")
btnClose.Parent = header
btnClose.Size = UDim2.new(0, 36, 0, 36)
btnClose.Position = UDim2.new(1, -42, 0.5, -18)
btnClose.Text = "✕"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 20
btnClose.BackgroundTransparency = 0.12
btnClose.BackgroundColor3 = Color3.fromRGB(28,8,8)
btnClose.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(0, 10)
local btnCloseStroke = Instance.new("UIStroke", btnClose)
btnCloseStroke.Color = Color3.fromRGB(130,30,40)

-- BODY
local body = Instance.new("Frame")
body.Parent = container
body.Position = UDim2.new(0, 24, 0, 84)
body.Size = UDim2.new(1, -48, 1, -160)
body.BackgroundTransparency = 1
body.BorderSizePixel = 0

local inputBox = Instance.new("TextBox")
inputBox.Parent = body
inputBox.Size = UDim2.new(1, 0, 0, 52)
inputBox.Position = UDim2.new(0, 0, 0, 0)
inputBox.PlaceholderText = "🔐 Enter PremiumV3 Password"
inputBox.ClearTextOnFocus = false
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.TextColor3 = Color3.fromRGB(238,238,238)
inputBox.BackgroundColor3 = Color3.fromRGB(30,12,12)
inputBox.BorderSizePixel = 0
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)
local inputStroke = Instance.new("UIStroke", inputBox)
inputStroke.Color = Color3.fromRGB(125,20,30)
inputStroke.Thickness = 1.2

local unlockBtn = Instance.new("TextButton")
unlockBtn.Parent = body
unlockBtn.Size = UDim2.new(1, 0, 0, 50)
unlockBtn.Position = UDim2.new(0, 0, 0, 68)
unlockBtn.Text = "🔓 Unlock PremiumV3 Access"
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.TextSize = 17
unlockBtn.TextColor3 = Color3.fromRGB(255,255,255)
unlockBtn.BackgroundColor3 = Color3.fromRGB(180,12,28)
unlockBtn.BorderSizePixel = 0
Instance.new("UICorner", unlockBtn).CornerRadius = UDim.new(0, 10)
local unlockStroke = Instance.new("UIStroke", unlockBtn)
unlockStroke.Color = Color3.fromRGB(235,70,90)
unlockStroke.Thickness = 1.4

local copyBtn = Instance.new("TextButton")
copyBtn.Parent = body
copyBtn.Size = UDim2.new(1, 0, 0, 46)
copyBtn.Position = UDim2.new(0, 0, 0, 126)
copyBtn.Text = "📂 Copy Game + Scripts"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 15
copyBtn.TextColor3 = Color3.fromRGB(245,245,245)
copyBtn.BackgroundColor3 = Color3.fromRGB(120,12,36)
copyBtn.Visible = false
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 10)
local copyStroke = Instance.new("UIStroke", copyBtn)
copyStroke.Color = Color3.fromRGB(170,60,80)

local discordBtn = Instance.new("TextButton")
discordBtn.Parent = body
discordBtn.Size = UDim2.new(1, 0, 0, 46)
discordBtn.Position = UDim2.new(0, 0, 0, 184)
discordBtn.Text = "💬 Join Discord — R&N FUSIONS X AGHA"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 15
discordBtn.TextColor3 = Color3.fromRGB(235,235,235)
discordBtn.BackgroundColor3 = Color3.fromRGB(26,8,8)
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 10)
local discordStroke2 = Instance.new("UIStroke", discordBtn)
discordStroke2.Color = Color3.fromRGB(90,18,30)

local status = Instance.new("TextLabel")
status.Parent = body
status.Size = UDim2.new(1, 0, 0, 28)
status.Position = UDim2.new(0, 0, 1, -28)
status.BackgroundTransparency = 1
status.Text = "💬 Status: Waiting for password..."
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextColor3 = Color3.fromRGB(205,205,205)
status.TextXAlignment = Enum.TextXAlignment.Left

-- CREDITS SCREEN (full screen takeover)
local creditsScreen = Instance.new("Frame")
creditsScreen.Name = "CreditsScreen"
creditsScreen.Parent = gui
creditsScreen.BackgroundColor3 = Color3.fromRGB(12,12,12)
creditsScreen.Size = UDim2.new(1, 0, 1, 0)
creditsScreen.Position = UDim2.new(0, 0, 0, 0)
creditsScreen.Visible = false
creditsScreen.ZIndex = 80
creditsScreen.BackgroundTransparency = 1

local creditsCenter = Instance.new("Frame")
creditsCenter.Parent = creditsScreen
creditsCenter.Size = UDim2.new(0, 820, 0, 520)
creditsCenter.AnchorPoint = Vector2.new(0.5,0.5)
creditsCenter.Position = UDim2.new(0.5, 0, 0.5, 0)
creditsCenter.BackgroundColor3 = Color3.fromRGB(20,20,20)
creditsCenter.BorderSizePixel = 0
Instance.new("UICorner", creditsCenter).CornerRadius = UDim.new(0, 16)
local creditsCenterStroke = Instance.new("UIStroke", creditsCenter)
creditsCenterStroke.Color = Color3.fromRGB(170,18,36)
creditsCenterStroke.Thickness = 1.6

local creditsTitle = Instance.new("TextLabel")
creditsTitle.Parent = creditsCenter
creditsTitle.Size = UDim2.new(1, -40, 0, 44)
creditsTitle.Position = UDim2.new(0, 20, 0, 16)
creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "Credits — R&N FUSIONS X AGHA"
creditsTitle.Font = Enum.Font.GothamBold
creditsTitle.TextSize = 22
creditsTitle.TextColor3 = Color3.fromRGB(255,210,210)
creditsTitle.TextXAlignment = Enum.TextXAlignment.Left

local creditsDesc = Instance.new("TextLabel")
creditsDesc.Parent = creditsCenter
creditsDesc.Size = UDim2.new(1, -40, 0, 40)
creditsDesc.Position = UDim2.new(0, 20, 0, 64)
creditsDesc.BackgroundTransparency = 1
creditsDesc.Text = "Thanks for using PremiumV3. Click a profile to copy the Roblox profile link."
creditsDesc.Font = Enum.Font.Gotham
creditsDesc.TextSize = 14
creditsDesc.TextColor3 = Color3.fromRGB(200,200,200)
creditsDesc.TextWrapped = true
creditsDesc.TextXAlignment = Enum.TextXAlignment.Left

-- rows container
local rows = Instance.new("Frame")
rows.Parent = creditsCenter
rows.Size = UDim2.new(1, -60, 0, 300)
rows.Position = UDim2.new(0, 30, 0, 116)
rows.BackgroundTransparency = 1

-- helper to create circular avatar + label + button
local function createProfileRow(parent, yOffset, titleText, userId, url)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.Size = UDim2.new(1, 0, 0, 92)
    row.Position = UDim2.new(0, 0, 0, yOffset)
    row.BackgroundTransparency = 1

    local avatar = Instance.new("ImageLabel")
    avatar.Parent = row
    avatar.Size = UDim2.new(0, 92, 0, 92)
    avatar.Position = UDim2.new(0, 0, 0, 0)
    avatar.BackgroundTransparency = 1
    avatar.Image = "" -- will set later
    avatar.ScaleType = Enum.ScaleType.Fit
    local corner = Instance.new("UICorner", avatar)
    corner.CornerRadius = UDim.new(1, 0) -- circle

    local textBox = Instance.new("TextLabel")
    textBox.Parent = row
    textBox.Size = UDim2.new(0.62, -12, 1, 0)
    textBox.Position = UDim2.new(0, 108, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.Font = Enum.Font.GothamSemibold
    textBox.TextSize = 16
    textBox.Text = titleText
    textBox.TextColor3 = Color3.fromRGB(255,220,220)
    textBox.TextXAlignment = Enum.TextXAlignment.Left

    local copyBtn = Instance.new("TextButton")
    copyBtn.Parent = row
    copyBtn.Size = UDim2.new(0.22, 0, 0, 40)
    copyBtn.Position = UDim2.new(0.78, 0, 0.5, -20)
    copyBtn.Text = "Copy Link"
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextSize = 14
    copyBtn.BackgroundColor3 = Color3.fromRGB(120,12,36)
    copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    copyBtn.BorderSizePixel = 0
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)
    local copyStroke2 = Instance.new("UIStroke", copyBtn)
    copyStroke2.Color = Color3.fromRGB(170,60,80)

    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(url) end)
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Credits",
                Text = "Profile link copied to clipboard!",
                Duration = 3
            })
        end)
    end)

    -- fetch headshot thumbnail safely
    spawn(function()
        local thumbUrl
        local ok, res = pcall(function()
            local endpoint = ("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%s&size=150x150&format=Png&isCircular=true"):format(tostring(userId))
            return HttpService:GetAsync(endpoint, true)
        end)
        if ok and res then
            local success, data = pcall(function() return HttpService:JSONDecode(res) end)
            if success and data and data.data and data.data[1] and data.data[1].imageUrl then
                thumbUrl = data.data[1].imageUrl
            end
        end
        -- fallback to a generic headshot asset if HttpService is blocked or fails
        if not thumbUrl then
            thumbUrl = "rbxassetid://7204491234" -- small fallback icon (replace with any valid asset id you like)
        end
        -- assign safely (pcall because some executors block setting external urls)
        pcall(function() avatar.Image = thumbUrl end)
    end)

    return row
end

-- create three profile rows
createProfileRow(rows, 0, "Developer — https://www.roblox.com/users/8769314544/profile", 8769314544, "https://www.roblox.com/users/8769314544/profile")
createProfileRow(rows, 100, "Collaborated With — https://www.roblox.com/users/1033230584/profile", 1033230584, "https://www.roblox.com/users/1033230584/profile")
createProfileRow(rows, 200, "Tester — https://www.roblox.com/users/5605094637/profile", 5605094637, "https://www.roblox.com/users/5605094637/profile")

-- back button
local backBtn = Instance.new("TextButton")
backBtn.Parent = creditsCenter
backBtn.Size = UDim2.new(0, 160, 0, 44)
backBtn.Position = UDim2.new(0, 30, 1, -70)
backBtn.Text = "← Back to Main UI"
backBtn.Font = Enum.Font.GothamBold
backBtn.TextSize = 15
backBtn.TextColor3 = Color3.fromRGB(255,255,255)
backBtn.BackgroundColor3 = Color3.fromRGB(28,10,10)
Instance.new("UICorner", backBtn).CornerRadius = UDim.new(0, 10)
local backStroke = Instance.new("UIStroke", backBtn)
backStroke.Color = Color3.fromRGB(110,18,30)

-- ===== HELPERS =====
local function safeTween(obj, props, info)
    local ok, err = pcall(function()
        TweenService:Create(obj, info or TweenInfo.new(0.28), props):Play()
    end)
    if not ok then
        -- ignore tween errors silently
    end
end

local function hoverScale(btn)
    btn.MouseEnter:Connect(function()
        safeTween(btn, {Size = btn.Size + UDim2.new(0,6,0,6), Position = btn.Position - UDim2.new(0,3,0,3)}, TweenInfo.new(0.12, Enum.EasingStyle.Quad))
    end)
    btn.MouseLeave:Connect(function()
        safeTween(btn, {Size = btn.Size - UDim2.new(0,6,0,6), Position = btn.Position + UDim2.new(0,3,0,3)}, TweenInfo.new(0.12, Enum.EasingStyle.Quad))
    end)
end

for _, b in pairs({unlockBtn, copyBtn, discordBtn, btnClose, backBtn}) do hoverScale(b) end

-- ===== DRAGGING (RenderStepped-driven, low-lag) =====
do
    local dragging = false
    local dragStart = Vector2.new()
    local startPos = Vector2.new()
    local conn

    local function toScreenOffset(pos)
        local x = math.clamp(pos.X, 8, workspace.CurrentCamera.ViewportSize.X - container.AbsoluteSize.X - 8)
        local y = math.clamp(pos.Y, 8, workspace.CurrentCamera.ViewportSize.Y - container.AbsoluteSize.Y - 8)
        return Vector2.new(x, y)
    end

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local mouse = UserInputService:GetMouseLocation()
            dragStart = Vector2.new(mouse.X, mouse.Y)
            startPos = Vector2.new(container.AbsolutePosition.X, container.AbsolutePosition.Y)
            -- small pop
            safeTween(container, {Size = container.Size + UDim2.new(0,10,0,10)}, TweenInfo.new(0.12))
            -- connect RenderStepped for smooth movement
            conn = RunService.RenderStepped:Connect(function()
                if not dragging then return end
                local mouseNow = UserInputService:GetMouseLocation()
                local delta = Vector2.new(mouseNow.X, mouseNow.Y) - dragStart
                local newPos = startPos + delta
                -- clamp
                local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280,720)
                local clampedX = math.clamp(newPos.X, 8, vp.X - container.AbsoluteSize.X - 8)
                local clampedY = math.clamp(newPos.Y, 8, vp.Y - container.AbsoluteSize.Y - 8)
                container.Position = UDim2.new(0, clampedX, 0, clampedY)
            end)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
            dragging = false
            safeTween(container, {Size = UDim2.new(0, 640, 0, 460)}, TweenInfo.new(0.12))
            if conn then conn:Disconnect() conn = nil end
        end
    end)
end

-- ===== OPEN / CLOSE CREDITS =====
local function openCredits()
    creditsScreen.Visible = true
    creditsScreen.BackgroundTransparency = 1
    creditsCenter.Position = UDim2.new(0.5, 0, 0.5, 40)
    creditsCenter.BackgroundTransparency = 1
    safeTween(creditsScreen, {BackgroundTransparency = 0}, TweenInfo.new(0.28, Enum.EasingStyle.Quad))
    safeTween(creditsCenter, {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0}, TweenInfo.new(0.36, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
end

local function closeCredits()
    safeTween(creditsCenter, {Position = UDim2.new(0.5, 0, 0.5, 40), BackgroundTransparency = 1}, TweenInfo.new(0.26, Enum.EasingStyle.Quad))
    safeTween(creditsScreen, {BackgroundTransparency = 1}, TweenInfo.new(0.26, Enum.EasingStyle.Quad))
    delay(0.28, function() creditsScreen.Visible = false end)
end

-- attach Credits open to top-right logo click + a dedicated Credits button
local creditsOpenBtn = Instance.new("TextButton")
creditsOpenBtn.Parent = container
creditsOpenBtn.Size = UDim2.new(0, 120, 0, 40)
creditsOpenBtn.Position = UDim2.new(0, 24, 1, -72)
creditsOpenBtn.Text = "Credits"
creditsOpenBtn.Font = Enum.Font.GothamBold
creditsOpenBtn.TextSize = 15
creditsOpenBtn.TextColor3 = Color3.fromRGB(255,255,255)
creditsOpenBtn.BackgroundColor3 = Color3.fromRGB(26,10,10)
Instance.new("UICorner", creditsOpenBtn).CornerRadius = UDim.new(0,10)
local creditsStrokeBtn2 = Instance.new("UIStroke", creditsOpenBtn)
creditsStrokeBtn2.Color = Color3.fromRGB(110,18,30)

creditsOpenBtn.MouseButton1Click:Connect(function() openCredits() end)
logo.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then openCredits() end
end)
backBtn.MouseButton1Click:Connect(function() closeCredits() end)

-- ===== TOP CLOSE (clean destroy + remove blur) =====
btnClose.MouseButton1Click:Connect(function()
    local blur = Lighting:FindFirstChild("RNF_PremiumBlur")
    if blur then safeTween(blur, {Size = 0}, TweenInfo.new(0.32)); delay(0.34, function() pcall(function() blur:Destroy() end) end) end
    safeTween(container, {BackgroundTransparency = 1}, TweenInfo.new(0.22))
    delay(0.22, function() pcall(function() gui:Destroy() end) end)
end)

-- ===== BUTTON ACTIONS =====
discordBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/KkHJznVJbv") end)
    pcall(function() StarterGui:SetCore("SendNotification", {Title="Discord", Text="Link copied to clipboard!", Duration=3}) end)
end)

unlockBtn.MouseButton1Click:Connect(function()
    if inputBox.Text == password then
        unlockBtn.Visible = false
        inputBox.Visible = false
        copyBtn.Visible = true
        status.Text = "🔓 Unlocked — Welcome PremiumV3 user!"
        -- pulse
        local pulse = Instance.new("UIStroke", container)
        pulse.Color = Color3.fromRGB(0,200,120)
        pulse.Thickness = 2
        pulse.Transparency = 0.9
        for i=1,4 do safeTween(pulse, {Transparency = 1}, TweenInfo.new(0.12)); wait(0.12); safeTween(pulse, {Transparency = 0.3}, TweenInfo.new(0.12)); wait(0.12) end
        pcall(function() pulse:Destroy() end)
        -- chime
        pcall(function()
            local s = Instance.new("Sound", container)
            s.SoundId = "rbxassetid://184352017"
            s.Volume = 1
            s:Play()
            Debris:AddItem(s, 2)
        end)
    else
        local attemptsNow = tonumber(container:GetAttribute("attempts") or 0) + 1
        container:SetAttribute("attempts", attemptsNow)
        status.Text = "❌ Wrong Password ("..attemptsNow.."/3)"
        safeTween(inputStroke, {Color = Color3.fromRGB(220,30,30)}, TweenInfo.new(0.12))
        delay(0.22, function() safeTween(inputStroke, {Color = Color3.fromRGB(125,20,30)}, TweenInfo.new(0.12)) end)
        if attemptsNow >= 3 then
            status.Text = "🚫 Access Locked"
            wait(0.9)
            local blur = Lighting:FindFirstChild("RNF_PremiumBlur")
            if blur then safeTween(blur, {Size = 0}, TweenInfo.new(0.32)); delay(0.34, function() pcall(function() blur:Destroy() end) end) end
            pcall(function() gui:Destroy() end)
        end
    end
end)

copyBtn.MouseButton1Click:Connect(function()
    status.Text = "📁 Copying with scripts..."
    local ok, err = pcall(function()
        local saveinstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau"))()
        saveinstance({
            FileName = "RNFusions_FullCopy_" .. tostring(game.PlaceId) .. ".rbxlx",
            Decompile = true,
            IncludeScripts = true,
            CreatorTag = "Copied by R&N FUSIONS X AGHA — PremiumV3"
        })
    end)
    if ok then status.Text = "✅ Game saved successfully!" else status.Text = "❌ Error: "..tostring(err) end
end)

-- ===== ENTRANCE ANIMATIONS =====
do
    container.BackgroundTransparency = 1
    container.Position = UDim2.new(0.5, -320, 0.5, 10)
    safeTween(container, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -320, 0.5, 0)}, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
    safeTween(title, {TextColor3 = Color3.fromRGB(255,170,180)}, TweenInfo.new(0.45))
end

-- CLEANUP guard (remove blur if GUI destroyed)
gui.AncestryChanged:Connect(function()
    if not gui:IsDescendantOf(game) then
        local blur = Lighting:FindFirstChild("RNF_PremiumBlur")
        if blur then pcall(function() blur:Destroy() end) end
    end
end)

print("[RNF] PremiumV3 Final loaded — profile icons enabled, dragging optimized.")
