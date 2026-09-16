-- ============================================================
-- LOADER UG INFO // RIVALS
-- ============================================================

local KeyAuthConfig = {
    name = "UG INFO Rivals",
    ownerid = "LyIUZh7KNG",
    version = "1.0",
    api_url = "https://keyauth.win/api/1.2/",
}

local function getKeyUIParent()
    if gethui then
        local ok, hui = pcall(gethui)
        if ok and hui then return hui end
    end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    return game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local keyUIParent = getKeyUIParent()

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "UG_INFO_KeyAuth"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.DisplayOrder = 60000
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() keyGui.Parent = keyUIParent end)
if not keyGui.Parent then
    keyGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 380, 0, 240)
keyFrame.Position = UDim2.new(0.5, -190, 0.5, -120)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Parent = keyGui

local kfCorner = Instance.new("UICorner")
kfCorner.CornerRadius = UDim.new(0, 14)
kfCorner.Parent = keyFrame

local kfStroke = Instance.new("UIStroke")
kfStroke.Color = Color3.fromRGB(230, 230, 230)
kfStroke.Thickness = 1.4
kfStroke.Transparency = 0.25
kfStroke.Parent = keyFrame

local kfGrad = Instance.new("UIGradient")
kfGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8)),
})
kfGrad.Rotation = 90
kfGrad.Parent = keyFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -24, 0, 32)
title.Position = UDim2.new(0, 12, 0, 12)
title.BackgroundTransparency = 1
title.Text = "UG INFO // RIVALS"
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = keyFrame

local brand = Instance.new("TextLabel")
brand.Size = UDim2.new(1, -24, 0, 20)
brand.Position = UDim2.new(0, 12, 0, 44)
brand.BackgroundTransparency = 1
brand.Text = "Entre ta clé pour continuer"
brand.TextColor3 = Color3.fromRGB(160, 160, 160)
brand.Font = Enum.Font.Gotham
brand.TextSize = 12
brand.TextXAlignment = Enum.TextXAlignment.Left
brand.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -24, 0, 42)
keyBox.Position = UDim2.new(0, 12, 0, 76)
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyBox.BorderSizePixel = 0
keyBox.Text = ""
keyBox.PlaceholderText = "XXXX-XXXX-XXXX"
keyBox.TextColor3 = Color3.fromRGB(245, 245, 245)
keyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyBox.Font = Enum.Font.GothamBold
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame
local kbCorner = Instance.new("UICorner")
kbCorner.CornerRadius = UDim.new(0, 8)
kbCorner.Parent = keyBox

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -24, 0, 20)
statusLabel.Position = UDim2.new(0, 12, 0, 124)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = keyFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(1, -24, 0, 40)
submitBtn.Position = UDim2.new(0, 12, 0, 148)
submitBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
submitBtn.Text = "VALIDER"
submitBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 13
submitBtn.AutoButtonColor = false
submitBtn.Parent = keyFrame
local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 8)
sbCorner.Parent = submitBtn

local discordLabel = Instance.new("TextLabel")
discordLabel.Size = UDim2.new(1, -24, 0, 20)
discordLabel.Position = UDim2.new(0, 12, 1, -30)
discordLabel.BackgroundTransparency = 1
discordLabel.Text = ".gg/uginfo"
discordLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
discordLabel.Font = Enum.Font.GothamBold
discordLabel.TextSize = 11
discordLabel.TextXAlignment = Enum.TextXAlignment.Left
discordLabel.Parent = keyFrame

local isDragging = false
local dragStart = nil
local startPos = nil
keyFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = keyFrame.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local d = input.Position - dragStart
        keyFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

local function validateKey()
    local key = keyBox.Text
    if key == "" or key == "XXXX-XXXX-XXXX" then
        statusLabel.Text = "Entre une clé valide."
        statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
        return
    end

    statusLabel.Text = "Vérification en cours..."
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    submitBtn.Text = "..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)

    task.spawn(function()
        local hwid = "UNKNOWN"
        if gethwid then
            local ok, h = pcall(gethwid)
            if ok and h then hwid = h end
        end

        local url = KeyAuthConfig.api_url .. "?type=init&name=" .. KeyAuthConfig.name .. "&ownerid=" .. KeyAuthConfig.ownerid .. "&ver=" .. KeyAuthConfig.version
        local ok, response = pcall(function() return game:HttpGet(url) end)

        if not ok or not response then
            statusLabel.Text = "Erreur de connexion au serveur."
            statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
            submitBtn.Text = "VALIDER"
            submitBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            return
        end

        local success, data = pcall(function() return game:GetService("HttpService"):JSONDecode(response) end)
        if not success or not data or not data.success then
            local errMsg = "Erreur d'initialisation."
            if data and data.message then
                errMsg = "API: " .. tostring(data.message)
            elseif not success then
                errMsg = "JSON: " .. tostring(data)
            end
            statusLabel.Text = errMsg
            statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
            submitBtn.Text = "VALIDER"
            submitBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            return
        end

        local sessionid = data.sessionid
        local enckey = data.enckey

        local licUrl = KeyAuthConfig.api_url .. "?type=license&key=" .. key .. "&sessionid=" .. sessionid .. "&name=" .. KeyAuthConfig.name .. "&ownerid=" .. KeyAuthConfig.ownerid .. "&hwid=" .. hwid
        local ok2, response2 = pcall(function() return game:HttpGet(licUrl) end)

        if not ok2 or not response2 then
            statusLabel.Text = "Erreur de vérification."
            statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
            submitBtn.Text = "VALIDER"
            submitBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            return
        end

        local success2, data2 = pcall(function() return game:GetService("HttpService"):JSONDecode(response2) end)
        if success2 and data2 and data2.success then
            statusLabel.Text = "Clé valide. Chargement du cheat..."
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            submitBtn.Text = "✓"
            submitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
            task.wait(0.6)
            keyGui:Destroy()

            local loadOk, loadErr = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/nyra000000/ug-info-rivals/refs/heads/main/cheat"))()
            end)
            if not loadOk then
                warn("[UG INFO] Erreur de chargement: " .. tostring(loadErr))
            end
        else
            local errorMsg = "Clé invalide ou expirée."
            if data2 and data2.message then errorMsg = data2.message end
            statusLabel.Text = errorMsg
            statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
            submitBtn.Text = "VALIDER"
            submitBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        end
    end)
end

submitBtn.MouseButton1Click:Connect(validateKey)
keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then validateKey() end
end)

-- FIN KEYAUTH
