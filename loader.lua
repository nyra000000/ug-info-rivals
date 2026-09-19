-- ============================================================
-- KEYAUTH LOADER POUR XENO
-- ============================================================

local KeyAuthConfig = {
    name = "UG INFO Rivals",
    ownerid = "LyIUZh7KNG",
    version = "1.0",
    api_url = "https://keyauth.win/api/1.2/",
}

-- ============================================================
-- FONCTION POUR SAUVEGARDER / CHARGER LA CLÉ (XENO)
-- ============================================================
local function saveKey(key)
    if Xeno and Xeno.SetGlobal then
        pcall(function() Xeno.SetGlobal("UGINFO_KEY", key) end)
    end
    -- Fallback : presse-papier
    if setclipboard then
        pcall(setclipboard, key)
    end
end

local function loadKey()
    if Xeno and Xeno.GetGlobal then
        local ok, key = pcall(function() return Xeno.GetGlobal("UGINFO_KEY") end)
        if ok and key and type(key) == "string" and key ~= "" then
            return key
        end
    end
    return nil
end

local function clearKey()
    if Xeno and Xeno.SetGlobal then
        pcall(function() Xeno.SetGlobal("UGINFO_KEY", "") end)
    end
end

-- ============================================================
-- VÉRIFICATION KEYAUTH (même code qu'avant)
-- ============================================================
local function verifyKey(key)
    local hwid = "UNKNOWN"
    if gethwid then
        local ok, h = pcall(gethwid)
        if ok and h then hwid = h end
    end

    local url = KeyAuthConfig.api_url .. "?type=init&name=" .. KeyAuthConfig.name .. "&ownerid=" .. KeyAuthConfig.ownerid .. "&ver=" .. KeyAuthConfig.version
    local ok, response = pcall(function() return game:HttpGet(url) end)
    if not ok or not response then return false, "Erreur de connexion au serveur." end

    local success, data = pcall(function() return game:GetService("HttpService"):JSONDecode(response) end)
    if not success or not data or not data.success then
        local errMsg = "Erreur d'initialisation."
        if data and data.message then errMsg = "API: " .. tostring(data.message) end
        return false, errMsg
    end

    local sessionid = data.sessionid

    local licUrl = KeyAuthConfig.api_url .. "?type=license&key=" .. key .. "&sessionid=" .. sessionid .. "&name=" .. KeyAuthConfig.name .. "&ownerid=" .. KeyAuthConfig.ownerid .. "&hwid=" .. hwid
    local ok2, response2 = pcall(function() return game:HttpGet(licUrl) end)
    if not ok2 or not response2 then return false, "Erreur de vérification." end

    local success2, data2 = pcall(function() return game:GetService("HttpService"):JSONDecode(response2) end)
    if success2 and data2 and data2.success then
        return true, "OK"
    else
        local errorMsg = "Clé invalide ou expirée."
        if data2 and data2.message then errorMsg = data2.message end
        return false, errorMsg
    end
end

-- ============================================================
-- CHARGEMENT DU CHEAT
-- ============================================================
local function loadCheat()
    local loadOk, loadErr = pcall(function()
        loadstring(game:HttpGet("TON_URL_GITHUB"))()
    end)
    if not loadOk then
        warn("[UG INFO] Erreur de chargement: " .. tostring(loadErr))
    end
end

-- ============================================================
-- VÉRIFICATION AUTOMATIQUE AU LANCEMENT
-- ============================================================
local savedKey = loadKey()
if savedKey and savedKey ~= "" then
    task.spawn(function()
        local valid, msg = verifyKey(savedKey)
        if valid then
            loadCheat()
            return
        else
            clearKey()
        end
    end)
end

-- ============================================================
-- FENÊTRE KEYAUTH (affichée seulement si pas de clé valide)
-- ============================================================
task.spawn(function()
    task.wait(1)

    -- Si le cheat a déjà été chargé, on ne fait rien
    if getgenv and getgenv().UGINFO_CHEAT_LOADED then return end

    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "UG_INFO_KeyAuth"
    keyGui.ResetOnSpawn = false
    keyGui.IgnoreGuiInset = true
    keyGui.DisplayOrder = 60000
    keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    keyGui.Parent = game:GetService("CoreGui")

    -- ... (le reste de la fenêtre KeyAuth, identique au code précédent)

    local function validate()
        local key = keyBox.Text
        if key == "" or key == "XXXX-XXXX-XXXX" then
            statusLabel.Text = "Entre une clé valide."
            return
        end

        statusLabel.Text = "Vérification..."
        submitBtn.Text = "..."

        task.spawn(function()
            local valid, msg = verifyKey(key)
            if valid then
                saveKey(key)
                if getgenv then getgenv().UGINFO_CHEAT_LOADED = true end
                statusLabel.Text = "Clé valide. Chargement..."
                task.wait(0.6)
                keyGui:Destroy()
                loadCheat()
            else
                statusLabel.Text = msg
                submitBtn.Text = "VALIDER"
            end
        end)
    end

    submitBtn.MouseButton1Click:Connect(validate)
    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then validate() end
    end)
end)
