    -- DISCORD
    disable_webhook = false
    edited_webhook = true
    message_webhook = "1420929242929168474"
    webhookdc = "https://discord.com/api/webhooks/1405979061162999980/_yNOxEjMX8GMEPMf8UsWzvd3U2CnNpUpfStARWMdnTompo-Rw5PK8ITj6tRYGbIWuPLI"

    -- MODE
    auto_find_world = false

    -- SETTING FIND AND LOCK WORLD
    create_farm = 1
    letter = 10
    nonumber = true

    -- DF DESIGN ROTATION
    SL_mode = true
    door_itemid = 12
    entrance_itemid = 2810
    sl_id = 202
    edit_doorid = "Z1612"

    -- DF WORLD LIST
    list_world_DF = { "UKRWK", "BNTDU", "GSSWH", "PYHZH", "NTLWG", "LSFWF", "VRGWP", "AVLJP", "MXPFK", "CMDUY", "VKZYV", "OFUHM", "EQCWD", "NWWFE", "AQNFQ", "WIGGC", "SJTXQ", "YKQYI", "QTSST", "EHLWJ", "FBOPG", "YKIJR", "UXVIM", "XYOXQ", "GPKZJ", "RDIBN", "IICWY", "LRSUG", "EJXYO", "IVZBN", "JWVDP", "WQSYE" }
    limit_bot_per_world = 1
    whiteListGrowid = {"ZayDF"}

    -- GENERAL SETTING – OPTIONAL
    break_rock = true
    auto_buy_bp = true
    save_seed = true
    remove_bot = false
    plat_id = 102

    -- STORAGE WORLD SETTING
    world_storage = "SDIRT55"
    id_world_storage = "Z1612"
    world_plat = "SPLAT999"
    id_door_plat = "Z1612"
    world_seed = "SDIRT55"
    id_world_seed = "Z1612"
    move_direction = 1

    -- DELAY
    delay_punch = math.random(100, 150)
    delay_place = math.random(100, 150)
    delay_findpath = math.random(150, 200)
    delay_reconnect = math.random(15000, 20000)
    delay_joinworld = 5000
    delay_move_interval = 230
    move_range = 3
    delay_wrench = 5000
    delay_reapply_lock = 5000

    -- LAINNYA
    trash_list = {11, 10, 2914, 5024, 5026, 5028, 5030, 5032, 5034, 5036, 5038, 5040, 5042, 5044}


local script = "dfv3"

getBot().auto_trash = false
getBot().collect_range = 3
getBot():setInterval(Action.move, delay_move_interval/1000)
getBot().move_range = move_range
getBot().auto_reconnect = false
wl_id = 242
jammer_id = 226
ownerzitus = ""
-- ERROR HANDLING
edit_doorid = edit_doorid:upper()
for i in pairs(list_world_DF) do
    list_world_DF[i] = list_world_DF[i]:upper()
end
world_storage = world_storage:upper()
id_world_storage = id_world_storage:upper()

world_plat = world_plat:upper()
id_door_plat = id_door_plat:upper()

world_seed = world_seed:upper()
id_world_seed = id_world_seed:upper()

nuked = false
levelWorld = false
maxlimit = false

index_world = 0
total_world = #list_world_DF

uptime = os.time()
list_time = {}
for i in pairs(list_world_DF) do
    table.insert(list_time, " ||???||")
end

-- ============================================================================
function getUptime()
    textUptime = math.floor((os.time() - uptime) / 86400) .. " Days " .. math.floor((os.time() - uptime) % 86400 / 3600) .. " Hours " .. math.floor((os.time() - uptime) % 86400 % 3600 / 60) .. " Minutes"
    return textUptime
end

function getTextWorld()
    temp = ""
    
    for _, world in pairs(list_world_DF) do
        if auto_find_world then
            temp = temp .. _ ..". ||" .. world:upper() .. "||\n"
        else
            temp = temp .. _ ..". ||" .. world:upper() .. "|| | " .. list_time[_] .. "\n"
        end
    end
    return temp
end

function powershell(text, curent, textWorld)
    if disable_webhook then
        return
    end
    wh = Webhook.new(webhookdc)
    wh.embed1.use = true
    wh.username = "DF LOGS"
    wh.embed1.title = "<:dirt:1022839909683302422> AUTO DF v3.13 <:dirt:1022839909683302422>"
    wh.embed1.color = "4672231"
    wh.embed1.footer.text = os.date("!%a %b %d, %Y at %I:%M %p", os.time() + 7 * 60 * 60)
    wh.embed1:addField("<:megaphone:1164892284408582206> INFORMATION",text,false)
    wh.embed1:addField("<:bot:1119535018608435301> BOT","||"..getBot().name.."||",false)
    wh.embed1:addField("<a:online:1087347595287986236> STATUS",getBotStatus(),false)
    wh.embed1:addField("<:clock:1131558211485454459> UPTIME",getUptime(),false)
    wh.embed1:addField("<:world:996054982795198544> WORLD "..curent.."/"..#list_world_DF,textWorld,false)

    if edited_webhook then
        wh:edit(message_webhook)
    else
        wh:send()
    end
end

getposx = function()
    player = getBot():getWorld():getLocal()
    if player then
        return math.floor(player.posx/32)
    end
    return 0
end

getposy = function()
    player = getBot():getWorld():getLocal()
    if player then
        return math.floor(player.posy/32)
    end
    return 0
end

function getBotStatus()
    local status = getBot().status
    if status == BotStatus.online then
        return "online"
    elseif status == BotStatus.offline then
        return "offline"
    elseif status == BotStatus.wrong_password then
        return "wrong_password"
    elseif status == BotStatus.account_banned then
        return "account_banned"
    elseif status == BotStatus.location_banned then
        return "location_banned"
    elseif status == BotStatus.version_update then
        return "version_update"
    elseif status == BotStatus.advanced_account_protection then
        return "advanced_account_protection"
    elseif status == BotStatus.server_overload then
        return "login fail"
    elseif status == BotStatus.too_many_login then
        return "login fail"
    elseif status == BotStatus.maintenance then
        return "maintenance"
    elseif status == BotStatus.server_busy then
        return "login fail"
    elseif status == BotStatus.guest_limit then
        return "guest_limit"
    elseif status == BotStatus.http_block then
        return "http_block"
    elseif status == BotStatus.bad_name_length then
        return "bad_name_length"
    elseif status == BotStatus.invalid_account then
        return "invalid_account"
    elseif status == BotStatus.error_connecting then
        return "error_connecting"
    elseif status == BotStatus.changing_subserver then
        return "changing sub_server"
    elseif status == BotStatus.logon_fail then
        return "login fail"
    else
        return "unknown_status"
    end
end

function logToTxt(farm_world)
    local file = io.open("DF_" .. getBot().name .. ".txt", "a")
    file:write("\n\"" .. farm_world .. "\",")
    file:close()
end

function logger(message)
    local file = io.open("Logs.txt", "a")
    file:write(message.."\n")
    file:close()
end

addEvent(Event.variantlist, function(variant, netid)
    if variant:get(0):getString() == "OnConsoleMessage" then
        if variant:get(1):getString():lower():find("inaccessible") then
            nuked = true
            print("nuked")
        end
        if variant:get(1):getString():lower():find("can't enter") then
            levelWorld = true
            print("levelworld")
        end
        if variant:get(1):getString():lower():find("oops,") then
            maxlimit=true
            print("maxlimit")
        end
    end
end)

function join(worldmu, iddoormu)
    while not nuked and not levelWorld and not maxlimit and getBot():getWorld().name:lower() ~= worldmu:lower() do
        getBot():warp(worldmu:upper().."|"..iddoormu:upper())
        listenEvents(10)
        while getBotStatus() ~= "online" or getBot():getPing() == 0 do
            while getBot().google_status == 1 do
                sleep(30000)
            end
            if getBot().google_status ~= 1 and getBotStatus() ~= "online" then
                getBot():connect()
                sleep(delay_reconnect)
            end
        end
    end

    if not nuked and not levelWorld and not maxlimit then
        return true
    else
        print("failed join world (nuked/level/limit)")
        nuked = false
        levelWorld = false
        maxlimit = false
        return false
    end
end

function isLimitWorld(worldmu)
    while not nuked and not levelWorld and not maxlimit and getBot():getWorld().name:lower() ~= worldmu:lower() do
        getBot():warp(worldmu:upper())
        listenEvents(10)
        while getBotStatus() ~= "online" or getBot():getPing() == 0 do
            while getBot().google_status == 1 do
                sleep(30000)
            end
            if getBot().google_status ~= 1 and getBotStatus() ~= "online" then
                getBot():connect()
                sleep(delay_reconnect)
            end
        end
    end

    if not maxlimit then
        return false
    else
        nuked = false
        levelWorld = false
        maxlimit = false
        return true
    end
end

-- MOVE WHEN IN WHITE DOOR
function checkWD(world, door)
    while getTile(getposx(), getposy()).fg == 6 do
        print(getBot().name.." at white door.. re join door")
        getBot():warp(world.."|"..door)
        sleep(delay_joinworld)
        while getBotStatus() ~= "online" or getBot():getPing() == 0 do
            while getBot().google_status == 1 do
                sleep(30000)
            end
            if getBot().google_status ~= 1 and getBotStatus() ~= "online" then
                getBot():connect()
                sleep(delay_reconnect)
            end
        end
    end
end

function reconnect(world, door)
    if getBotStatus() ~= "online" or getBot():getPing() == 0 then
        print(getBot().name.. " - disconnected, reconnnecting...")
        powershell("Bot ".. getBot().name .." disconnected, reconnnecting... ", index_world, getTextWorld())
        while getBotStatus() ~= "online" or getBot():getPing() == 0 do
            while getBot().google_status == 1 do
                sleep(30000)
            end
            if getBot().google_status ~= 1 and getBotStatus() ~= "online" then
                getBot():connect()
                sleep(delay_reconnect)
            end
        end
        print(getBot().name.. " - ONLINE back")
        powershell("Bot ".. getBot().name .." reconnected", index_world, getTextWorld())
        join(world, door)
    end
    if world == world_storage or world == world_plat or world == world_seed then
        checkWD(world, door)
    else
        if SL_mode then
            checkWD(world, door)  
        end
    end
end

function dropItem(itemID, count)
    if getBot():getInventory():findItem(itemID) >= count then
        getBot():drop(itemID, count)
        sleep(4000)
    end
end

-- AUTO TRASH
function trash(world)
    x = getposx()
    y = getposy()
    reconnect(world, edit_doorid)
    for i, trash in ipairs(trash_list) do
        if getBot():getInventory():findItem(trash) > 190 then
            getBot():trash(trash, getBot():getInventory():findItem(trash))
            sleep(3000)
        end
    end

    if not save_seed then
        TrashF = {2, 14, 4, 3, 15, 5, 11}
        for i, trash in pairs(TrashF) do
            if getBot():getInventory():findItem(trash) > 190 then
                getBot():trash(trash, 50)
                sleep(3000)
            end
        end
    else
        TrashF = {2, 14, 4}
        for i, trash in pairs(TrashF) do
            if getBot():getInventory():findItem(trash) > 190 then
                getBot():trash(trash, 50)
                sleep(3000)
            end
        end
        Isseed = false
        Listseed = {3, 15, 5, 11}
        for i, seed in pairs(Listseed) do
            if getBot():getInventory():findItem(seed) > 150 then
                Isseed = true
            end
        end
        -- save seed
        if Isseed then
            print(getBot().name .. " - SAVING SEED")
            if not join(world_seed, id_world_seed) then
                print("NUKED WORLD SEED")
                return
            end

            reconnect(world_seed, id_world_seed)
            
            for i, seed in ipairs(Listseed) do
                if getBot():getInventory():findItem(seed) > 150 then
                    count_seed = getBot():getInventory():findItem(seed)
                    getBot():drop(seed, count_seed)
                    sleep(4000)
                    while count_seed == getBot():getInventory():findItem(seed) do
                        getBot():moveTo(move_direction, 0)
                        sleep(1000)
                        getBot():drop(seed, count_seed)
                        sleep(4000)
                    end
                end
            end

            -- BACK TO WORLD DF
            join(world, edit_doorid)
            reconnect(world, edit_doorid)
            while getposx() ~= x or getposy() ~= y do
                getBot():findPath(x, y)
                sleep(200)
            end
        end
    end
end

function clearSide(world)
    powershell("Clearing side", index_world, getTextWorld())
    -- KIRI
    for i = 24, 53 do
        reconnect(world, edit_doorid)
        if getTile(1, i).bg == 14 or getTile(1, i).fg ~= plat_id or getTile(0, i).bg == 14 or getTile(0, i).fg == 2 then
            reconnect(world, edit_doorid)
            while getTile(1, i).bg == 14 or getTile(1, i).fg == 2 do
                reconnect(world, edit_doorid)
                while getposx() ~= 1 or getposy() ~= i-1 do
                    getBot():findPath(1, i - 1)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
                getBot():hit(getposx(), getposy()+1)
                sleep(delay_punch)
                if getTile(1, i).bg == 0 then
                    getBot():collect(2)
                    sleep(20)
                end
                trash(world)
            end
            reconnect(world, edit_doorid)

            while getTile(0, i).bg == 14 or getTile(0, i).fg == 2 do
                reconnect(world, edit_doorid)
                while getposx() ~= 1 or getposy() ~= i-1 do
                    getBot():findPath(1, i - 1)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
        
                getBot():hit(getposx()-1, getposy()+1)
                sleep(delay_punch)
                if getTile(1, i).bg == 0 then
                    getBot():collect(2)
                    sleep(20)
                end
                trash(world)
            end
        end
    end

    -- KANAN
    for i = 24, 53 do
        reconnect(world, edit_doorid)
        if getTile(98, i).bg == 14 or getTile(98, i).fg ~= plat_id or getTile(99, i).bg == 14 or getTile(99, i).fg == 2 or getTile(0, i).fg == 2 then
            reconnect(world, edit_doorid)
            while getTile(98, i).bg == 14 or getTile(98, i).fg == 2 do
                reconnect(world, edit_doorid)
                while getposx() ~= 98 or getposy() ~= i-1 do
                    getBot():findPath(98, i - 1)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
                getBot():hit(getposx(), getposy()+1)
                sleep(delay_punch)
                if getTile(1, i).bg == 0 then
                    getBot():collect(2)
                    sleep(20)
                end
                trash(world)
            end
            reconnect(world, edit_doorid)

            while getTile(99, i).bg == 14 or getTile(99, i).fg == 2 do
                reconnect(world, edit_doorid)
                while getposx() ~= 98 or getposy() ~= i-1 do
                    getBot():findPath(98, i - 1)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
        
                getBot():hit(getposx()+1, getposy()+1)
                sleep(delay_punch)
                if getTile(98, i).bg == 0 then
                    getBot():collect(2)
                    sleep(20)
                end
                trash(world)
            end
        end
    end
end

function getTotalBot()
    temp = false
    real = {}
    for _, player in pairs(getPlayers()) do
        for _, white in pairs(whiteListGrowid) do
            if player.name:lower() == white:lower() then
                temp = true
                break
            end
        end
        if not temp then
            table.insert(real, player)
        end
        temp = false
    end
    return #real
end

function getIndexBots()
    local temp = 1
    for _, bot in pairs(getBots()) do
        if bot.name:lower() == getBot().name:lower() then
            return temp
        end
        temp = temp + 1
    end
    return temp
end

function getIndexBot()
    temp = false
    real = {}
    for _, player in pairs(getPlayers()) do
        local growid = player.name
        -- if growid:find("_") then
        --     growid = growid:gsub("[%d_]", "")
        -- end
        for _, white in pairs(whiteListGrowid) do
            if growid:lower() == white:lower() then
                temp = true
                if player.isLocalPlayer then
                    table.insert(real, player)
                end
                break
            end
        end
        if not temp then
            table.insert(real, player)
        end
        temp = false
    end

    urutan = 1
    for _, player in pairs(real) do
        if player.isLocalPlayer then
            return urutan
        end
        urutan = urutan + 1
    end
    return urutan-1
end

function splitJobs(jobsList, world)
    reconnect(world, edit_doorid)
    local total_bot = getTotalBot()
    local botJobs = {}
    for bot = 1, total_bot do
        botJobs[bot] = {}
    end

    local currentIndex = 1
    for _, job in ipairs(jobsList) do
        local botIndex = (currentIndex - 1) % total_bot + 1
        table.insert(botJobs[botIndex], job)
        currentIndex = currentIndex + 1
    end

    return botJobs
end

function clearDirt(world)
    print(getBot().name .. " - Clearing all dirt")
    powershell("Clearing all dirt", index_world, getTextWorld())

    local jobs = {}
    local temp_jobs = {}
    for i = 25, 53, 2 do
        table.insert(jobs, i)
        table.insert(temp_jobs, i)
    end

    local list_job = splitJobs(jobs, world)
    local index_bot = getIndexBot()
    print(getBot().name .. " - ".. index_bot)
    local h = 1
    local size_array = #list_job[index_bot]
    local step = 1
    while h <= size_array do
        local i = list_job[index_bot][h]

        if step % 2 == 1 then
            for j = 2, 97 do
                jobs = temp_jobs
                list_job = splitJobs(jobs, world)
                index_bot = getIndexBot()
                if list_job[index_bot][h] ~= i then
                    print(getBot().name.. " - updating jobs")
                    h = 1
                    break
                end
                reconnect(world, edit_doorid)
                print(getBot().name .. " Target : "..j..","..i)

                while (getTile(j, i).bg == 14 or getTile(j, i).fg == 2) and getTile(j, i).fg ~= 6 do
                    while getposx() ~= j - 1 or getposy() ~= i do
                        getBot():findPath(j - 1, i)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end
                    reconnect(world, edit_doorid)
                    getBot():hit(getposx()+1, getposy())
                    sleep(delay_punch)
                    getBot():collect(2)
                    sleep(20)
                    trash(world)
                end

                if break_rock then
                    while getTile(j, i-1).fg == 10 do
                        while getposx() ~= j - 1 or getposy() ~= i do
                            getBot():findPath(j - 1, i)
                            sleep(delay_findpath)
                            reconnect(world, edit_doorid)
                        end
                        reconnect(world, edit_doorid)
                        getBot():hit(getposx()+1, getposy()-1)
                        sleep(delay_punch)
                        getBot():collect(2)
                        sleep(20)
                        trash(world)
                    end
                end

                while getTile(j, i-1).fg == 4 do
                    while getposx() ~= j - 1 or getposy() ~= i do
                        getBot():findPath(j - 1, i)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end
                    reconnect(world, edit_doorid)
                    getBot():hit(getposx()+1, getposy()-1)
                    sleep(delay_punch)
                    getBot():collect(2)
                    sleep(20)
                    trash(world)
                end
            end
        else
            for j = 97, 2, -1 do
                jobs = temp_jobs
                list_job = splitJobs(jobs, world)
                index_bot = getIndexBot()
                if list_job[index_bot][h] ~= i then
                    print(getBot().name.. " - updating jobs")
                    h = 1
                    break
                end
                reconnect(world, edit_doorid)
                print(getBot().name .. " Target : "..j..","..i)

                while (getTile(j, i).bg == 14 or getTile(j, i).fg == 2) and getTile(j, i).fg ~= 6 do
                    while getposx() ~= j + 1 or getposy() ~= i do
                        getBot():findPath(j + 1, i)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end
                    reconnect(world, edit_doorid)
                    getBot():hit(getposx()-1, getposy())
                    sleep(delay_punch)
                    getBot():collect(2)
                    sleep(20)
                    trash(world)
                end

                if break_rock then
                    while getTile(j, i-1).fg == 10 do
                        while getposx() ~= j + 1 or getposy() ~= i do
                            getBot():findPath(j + 1, i)
                            sleep(delay_findpath)
                            reconnect(world, edit_doorid)
                        end
                        reconnect(world, edit_doorid)
                        getBot():hit(getposx()-1, getposy()-1)
                        sleep(delay_punch)
                        getBot():collect(2)
                        sleep(20)
                        trash(world)
                    end
                end

                while getTile(j, i-1).fg == 4 do
                    while getposx() ~= j + 1 or getposy() ~= i do
                        getBot():findPath(j + 1, i)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end
                    reconnect(world, edit_doorid)
                    getBot():hit(getposx()-1, getposy()-1)
                    sleep(delay_punch)
                    getBot():collect(2)
                    sleep(20)
                    trash(world)
                end
            end
        end

        h = h + 1
        size_array = #list_job[index_bot]
        step = step + 1
    end
end

function takePlat(world)
    -- take plat
    if getBot():getInventory():findItem(plat_id) < 52 or getBot():getInventory():findItem(plat_id) > 52 then
        while getBot():getInventory():findItem(plat_id) < 52 do
            if join(world_plat, id_door_plat) then
                for _, object in pairs(getObjects()) do
                    if object.id == plat_id then
                        reconnect(world_plat, id_door_plat)
                        local x = math.floor(object.x / 32)
                        local y = math.floor(object.y / 32)
                        while getposx() ~= x or getposy() ~= y do
                            getBot():findPath(x, y)
                            sleep(delay_findpath)
                            reconnect(world_plat, id_door_plat)
                            print("findpath to plat ".. x.. ", ".. y)
                        end
                        getBot():collect(2)
                        sleep(1000)
                        print("Collecting")
                    end
                    if getBot():getInventory():findItem(plat_id) > 52 then
                        break
                    end
                end
            else
                print("WORLD PLAT NUKED")
                -- continue what happen if world plat nuked?
                -- diubah pake dirt aja?
            end
            sleep(1000)
        end

        while getBot():getInventory():findItem(plat_id) > 52 do
            if join(world_plat, id_door_plat) then
                print("dropping sisa plat")
                getBot():moveTo(1, 0)
                sleep(500)
                dropItem(plat_id, getBot():getInventory():findItem(plat_id)-52)
                sleep(1000)
            end
            sleep(1000)
        end

        join(world, edit_doorid)
        reconnect(world, edit_doorid)
    end
end

function isBuildPlat(world)
    local jobs = {}
    local temp_jobs = {}
    for i = 2, 52, 2 do
        table.insert(jobs, i)
        table.insert(temp_jobs, i)
    end

    local list_job = splitJobs(jobs, world)
    local index_bot = getIndexBot()
    print(getBot().name .. " - ".. index_bot)
    -- kiri
    local h = 1
    local size_array = #list_job[index_bot]
    while h <= size_array do
        local i = list_job[index_bot][h]
        jobs = temp_jobs
        list_job = splitJobs(jobs, world)
        index_bot = getIndexBot()
        if list_job[index_bot][h] ~= i then
            h = 1
            print(getBot().name.. " - updating jobs")
            break
        end
        reconnect(world, edit_doorid)
        if getTile(1, i).fg == 0 then
            reconnect(world, edit_doorid)
            return false
        end
        h = h + 1
        size_array = #list_job[index_bot]
    end
    
    -- kanan
    h = 1
    size_array = #list_job[index_bot]
    while h <= size_array do
        local i = list_job[index_bot][h]
        jobs = temp_jobs
        list_job = splitJobs(jobs, world)
        index_bot = getIndexBot()
        if list_job[index_bot][h] ~= i then
            h = 1
            print(getBot().name.. " - updating jobs")
            break
        end
        reconnect(world, edit_doorid)
        if getTile(98, i).fg == 0 then
            reconnect(world, edit_doorid)
            return false
        end
        h = h + 1
        size_array = #list_job[index_bot]
    end
    return true
end

-- TAKE AND PUT PLATFORM
function platform(world)
    print(getBot().name .. " - placing plat")

    if not isBuildPlat(world) then
        takePlat(world)
        local jobs = {}
        local temp_jobs = {}
        for i = 2, 52, 2 do
            table.insert(jobs, i)
            table.insert(temp_jobs, i)
        end

        local list_job = splitJobs(jobs, world)
        local index_bot = getIndexBot()
        print(getBot().name .. " - ".. index_bot)
        
        -- kiri
        local h = 1
        local size_array = #list_job[index_bot]
        while h <= size_array do
            local i = list_job[index_bot][h]
            jobs = temp_jobs
            list_job = splitJobs(jobs, world)
            index_bot = getIndexBot()
            if list_job[index_bot][h] ~= i then
                h = 1
                print(getBot().name.. " - updating jobs")
                goto sini
            end
            reconnect(world, edit_doorid)
            while getTile(1, i).fg == 0 do
                reconnect(world, edit_doorid)
                while getposx() ~= 1 or getposy() ~= i-1 do
                    getBot():findPath(1, i - 1)
                    sleep(delay_findpath)
                end
                
                getBot():place(getposx(), getposy()+1, plat_id)
                sleep(delay_place)
            end
            h = h + 1
            size_array = #list_job[index_bot]

            ::sini::
        end
        
        -- kanan
        h = 1
        size_array = #list_job[index_bot]
        while h <= size_array do
            local i = list_job[index_bot][h]
            jobs = temp_jobs
            list_job = splitJobs(jobs, world)
            index_bot = getIndexBot()
            if list_job[index_bot][h] ~= i then
                h = 1
                print(getBot().name.. " - updating jobs")
                goto sini
            end
            reconnect(world, edit_doorid)
            while getTile(98, i).fg == 0 do
                reconnect(world, edit_doorid)
                while getposx() ~= 98 or getposy() ~= i-1 do
                    getBot():findPath(98, i - 1)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
                
                getBot():place(getposx(), getposy()+1, plat_id)
                sleep(delay_place)
            end
            h = h + 1
            size_array = #list_job[index_bot]
            ::sini::
        end
    end
end

function plantHT(world, isLock)
    print(getBot().name .. " - plant ht")
    while getBot():getInventory():findItem(2) == 0 do
        urutan = getIndexBot()
        if isLock then
            y = 23
        else
            y = 23 + (urutan * 2)
        end
        
        for x = 2, 22 do
            if getBot():getInventory():findItem(2) > 180 then
                break
            end
            
            if getBot():getInventory():findItem(3) == 0 then
                while getBot():getInventory():findItem(3) == 0 do
                    if join(world_seed, id_world_seed) then
                        for _, object in pairs(getObjects()) do
                            local xx = math.floor(object.x / 32)
                            local yy = math.floor(object.y / 32)
                            if object.id == 3 then
                                while getposx() ~= xx or getposy() ~= yy do
                                    getBot():findPath(xx, yy)
                                    sleep(delay_findpath)
                                    reconnect(world_seed, id_world_seed)
                                end
                                getBot():collect(2)
                                sleep(10)
                            end
                            if getBot():getInventory():findItem(3) > 0 then
                                break
                            end
                        end
                    else
                        print("NUKED ".. world_seed)
                        join(world, edit_doorid)
                        return
                    end
                    sleep(1000)
                end

                if getBot():getInventory():findItem(3) > 0 then
                    join(world, edit_doorid)
                    reconnect(world, edit_doorid)
                    break
                end
            end
            
            while getTile(x, y).fg == 3 and getTile(x, y):canHarvest() == true do
                while getposx() ~= x or getposy() ~= y do
                    getBot():findPath(x, y)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end

                reconnect(world, edit_doorid)
                getBot():hit(getposx(), getposy())
                sleep(delay_punch)
                getBot():collect(2)
                sleep(10)
            end
            
            reconnect(world, edit_doorid)
            while getTile(x, y).fg == 0 and getBot():getInventory():findItem(3) > 0 and getInfo(getTile(x, y+1).fg).collision_type == 1 or getInfo(getTile(x, y+1).fg).collision_type == 2 do
                while getposx() ~= x or getposy() ~= y do
                    getBot():findPath(x, y)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
                getBot():place(getposx(), getposy(), 3)
                sleep(delay_place)
                reconnect(world, edit_doorid)
            end
        end
    end
end

function placeDirt(world)
    print(getBot().name .. " - placing dirt")
    powershell("Placing Dirt", index_world, getTextWorld())
    local jobs = {}
    local temp_jobs = {}
    for i = 52, 2, -2 do
        table.insert(jobs, i)
        table.insert(temp_jobs, i)
    end
    local list_job = splitJobs(jobs, world)
    local index_bot = getIndexBot()
    print(getBot().name .. " - ".. index_bot)

    local h = 1
    local size_array = #list_job[index_bot]
    local direction = 1
    while h <= size_array do
        local y = list_job[index_bot][h]

        local startX, endX, stepX
        if direction == 1 then
            startX, endX, stepX = 2, 97, 2
        else
            startX, endX, stepX = 97, 2, -2
        end

        for x = startX, endX, stepX do
            jobs = temp_jobs
            list_job = splitJobs(jobs, world)
            index_bot = getIndexBot()
            if list_job[index_bot][h] ~= y then
                h = 1
                print(getBot().name.. " - updating jobs")
                break
            end
            reconnect(world, edit_doorid)

            if getTile(x, y).fg == 0 then
                plantHT(world, false)
                reconnect(world, edit_doorid)

                while getTile(x, y).fg == 0 do
                    reconnect(world, edit_doorid)

                    if getTile(x, y-1).fg == 0 then
                        while getposx() ~= x or getposy() ~= y-1 do
                            getBot():findPath(x, y-1)
                            sleep(delay_findpath)
                            reconnect(world, edit_doorid)
                        end
                    elseif getTile(x, y+1).fg == 0 then
                        while getposx() ~= x or getposy() ~= y+1 do
                            getBot():findPath(x, y+1)
                            sleep(delay_findpath)
                            reconnect(world, edit_doorid)
                        end
                    else
                        while getposx() ~= x-1 or getposy() ~= y-1 do
                            getBot():findPath(x-1, y-1)
                            sleep(delay_findpath)
                            reconnect(world, edit_doorid)
                        end
                    end

                    local range_step = (direction == 1) and 1 or -1
                    for i = 0, 2 do
                        local px = x + (i * range_step)
                        if px >= 2 and px <= 97 and getTile(px, y).fg == 0 and getBot():getInventory():findItem(2) > 0 then
                            getBot():place(px, y, 2)
                            sleep(delay_place)
                        end
                    end

                    if getTile(x, y).fg ~= 0 then
                        break
                    end
                end
            end
        end

        h = h + 1
        size_array = #list_job[index_bot]
        direction = -direction
    end
end

function allDone(world)
    print(getBot().name .. " - Harvesting tree")
    for y = 23, 53, 2 do
        for x = 2, 22 do
            while getTile(x, y).fg == 3 do
                reconnect(world, edit_doorid)
                while getposx() ~= x or getposy() ~= y do
                    getBot():findPath(x, y)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
    
                getBot():hit(getposx(), getposy()) -- exit world??
                sleep(delay_punch)
                trash(world)
                getBot():collect(2)
                sleep(10)
            end
        end
    end 
end

function cekList(list)
    local count = create_farm
    for _, item in pairs(list) do
        if item == entrance_itemid then
            count = count * 2
        else
            count = create_farm
        end
        if getBot():getInventory():findItem(item) > count then
            return true
        end
    end
    return false
end

function isTimeToTake()
    local count = create_farm
    list = {wl_id, jammer_id}

    if SL_mode then
        table.insert(list, entrance_itemid)
        table.insert(list, door_itemid)
        table.insert(list, sl_id)
    end

    for _, item in pairs(list) do
        if item == entrance_itemid then
            count = count * 2
        else
            count = create_farm
        end
        if getBot():getInventory():findItem(item) < count then
            return true
        end
    end
    return false
end

function takeItem()
    print(getBot().name .. " - TAKING ITEM")
    local count = create_farm
    list = {wl_id, jammer_id}

    if SL_mode then
        table.insert(list, entrance_itemid)
        table.insert(list, door_itemid)
        table.insert(list, sl_id)
    end

    isWarp = false
    for _, item in pairs(list) do
        if item == entrance_itemid then
            count = count * 2
        else
            count = create_farm
        end
        if getBot():getInventory():findItem(item) < count then
            isWarp = true
            break
        end
    end

    if isWarp then
        if not join(world_storage, id_world_storage) then
            print("NUKED WORLD STORAGE : ".. world_storage)
            return
        end
    
        reconnect(world_storage, id_world_storage)

        for _, item in pairs(list) do
            if item == entrance_itemid then
                count = count * 2
            else
                count = create_farm
            end
            if getBot():getInventory():findItem(item) < count then
                while getBot():getInventory():findItem(item) < count do
                    for _, object in pairs(getObjects()) do
                        if object.id == item then
                            x = math.floor(object.x / 32)
                            y = math.floor(object.y / 32)
                            while getposx() ~= x or getposy() ~= y do
                                getBot():findPath(x,y)
                                sleep(40)
                                reconnect(world_storage, id_world_storage)
                            end
                            sleep(delay_findpath)
                            getBot():collect(2)
                            sleep(20)
                            sleep(delay_findpath)
                        end
                    end
                    reconnect(world_storage, id_world_storage)
                    print("no " .. getInfo(item).name)
                    sleep(1000)
                end
            end
        end

        while cekList(list) do
            for _, item in pairs(list) do
                if item == entrance_itemid then
                    count = count * 2
                else
                    count = create_farm
                end
                if getBot():getInventory():findItem(item) > count then
                    join(world_storage, id_world_storage)
                    reconnect(world_storage, id_world_storage)
                    getBot():drop(item, getBot():getInventory():findItem(item)-count)
                    sleep(4000)
                    while getBot():getInventory():findItem(item) > count do
                        getBot():moveTo(-1, 0)
                        sleep(delay_findpath)
                        getBot():drop(item, getBot():getInventory():findItem(item)-count)
                        sleep(4000)
                        reconnect(world_storage, id_world_storage)
                    end
                end
            end
        end
    end
end

function dropAll()
    list = {wl_id, jammer_id}

    if SL_mode then
        table.insert(list, entrance_itemid)
        table.insert(list, door_itemid)
        table.insert(list, sl_id)
    end

    if not join(world_storage, id_world_storage) then
        print("NUKED WORLD STORAGE : ".. world_storage)
        return
    end

    reconnect(world_storage, id_world_storage)

    while cekList(list) do
        for _, item in pairs(list) do
            if getBot():getInventory():findItem(item) > 0 then
                join(world_storage, id_world_storage)
                reconnect(world_storage, id_world_storage)
                getBot():drop(item, getBot():getInventory():findItem(item))
                sleep(4000)
                
                while getBot():getInventory():findItem(item) > 0 do
                    getBot():moveTo(-1, 0)
                    sleep(delay_findpath)
                    getBot():drop(item, getBot():getInventory():findItem(item))
                    sleep(4000)
                    reconnect(world_storage, id_world_storage)
                end
            end
        end
    end
end

function randomize()
    world = ""
    if nonumber then
        for i = 1, letter, 1 do
            world = world .. string.char(math.random(97, 122))
            world = string.upper(world)
        end
    else
        for i = 1, letter, 1 do
            if (i % 2 == 0) then
                world = world .. string.char(math.random(97, 122))
                world = string.upper(world)
            else
                world = world .. string.char(math.random(48, 57))
                world = string.upper(world)
            end
        end
    end
    return world
end

function isFlat()
    for y = 0, 23 do
        for x = 0, 99 do
            if getTile(x, y).fg ~= 6 then
                if getTile(x, y).fg ~= 0 or getTile(x, y).bg ~= 0 then
                    return false
                end
            end
        end
    end
    return true
end

function isLocked()
    if getBot():getWorld():hasAccess(0, 0) ~= 0 then
        return false
    end
    return true
end

function editDoor(label, world, doorid, incX, incY)
    getBot():wrench(getposx()+incX, getposy()+incY)
    sleep(5000)
    getBot():sendPacket(2, "action|dialog_return\ndialog_name|door_edit\ntilex|" .. getposx()+incX .. "|\ntiley|" ..getposy() + incY .. "|\ndoor_name|" .. label .. "\ndoor_target|" .. world .. "\ndoor_id|" ..doorid .. "\ncheckbox_locked|0")
end

function main()
    if auto_find_world then
        list_world_DF = {}
        while isTimeToTake() do
            takeItem()
            sleep(500)
        end
        
        for i = 1, create_farm do
            index_world = i
            isCreated = false
            world = ""
            while not isCreated do
                world = randomize()
                print(world)
                if join(world, "LOL") then
                    if isFlat() and not isLocked() then
                        table.insert(list_world_DF, world)
                        isCreated = true
                        logToTxt(world)
                        powershell("Generated ||".. world.."||", index_world, getTextWorld())
                    end
                else
                    if isLimitWorld(world) then
                        powershell("Reached max limit world try again tomorrow", index_world, getTextWorld())
                        create_farm = 0
                        dropAll()
                        getBot():disconnect()
                        return
                    end
                end
            end

            total_world = #list_world_DF
            
            if not SL_mode then
                -- place WL and jammer only
                while getTile(getposx(), getposy()-1).fg ~= wl_id do
                    getBot():place(getposx(), getposy()-1, wl_id) -- KALO PLACE -1 = ATAS, BAWAH = 1
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
                
                while getTile(getposx()-1, getposy()-1).fg ~= jammer_id do
                    getBot():place(getposx()-1, getposy()-1, jammer_id) -- KALO PLACE -1 = ATAS, BAWAH = 1
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end
                
                -- nyalain jammer
                while getTile(getposx()-1,getposy()-1):hasFlag(0x40) == false do
                    getBot():hit(getposx()-1,getposy()-1)
                    sleep(1000)
                    reconnect(world, edit_doorid)
                end

                reconnect(world, edit_doorid)
                -- SET PUBLIC WL
                while getBot():getWorld():hasAccess(getposx(), getposy()-2) ~= 2 do
                    reconnect(world, edit_doorid)
                    getBot():wrench(getposx(), getposy()-1)
                    sleep(delay_wrench)
                    getBot():sendPacket(2,"action|dialog_return\ndialog_name|lock_edit\ntilex|" .. getposx() .."|\ntiley|" .. getposy() - 1 .."|\nbuttonClicked|recalcLock\n\ncheckbox_public|1\ncheckbox_ignore|0")
                    sleep(delay_reapply_lock)
                end
            else
                -- PLACE SL, JAMMER, WL, DOOR, ENTRANCE
                -- Break BAWAH
                SL_mode = false
                while getTile(getposx() - 2, getposy() + 1).fg ~= 0 or getTile(getposx() - 2, getposy() + 1).bg ~= 0 do
                    getBot():hit(getposx()-2, getposy()+1)
                    sleep(delay_punch)
                    reconnect(world, edit_doorid)
                end

                while getTile(getposx() - 1, getposy() + 1).fg ~= 0 or getTile(getposx() - 1, getposy() + 1).bg ~= 0 do
                    getBot():hit(getposx()-1, getposy()+1)
                    sleep(delay_punch)
                    reconnect(world, edit_doorid)
                end

                while getTile(getposx() - 1, getposy() + 2).fg ~= 0 or getTile(getposx() - 1, getposy() + 2).bg ~= 0 do
                    getBot():hit(getposx()-1, getposy()+2)
                    sleep(delay_punch)
                    reconnect(world, edit_doorid)
                end

                while getTile(getposx() + 1, getposy() + 1).fg ~= 0 or getTile(getposx() + 1, getposy() + 1).bg ~= 0 do
                    getBot():hit(getposx()+1, getposy()+1)
                    sleep(delay_punch)
                    reconnect(world, edit_doorid)
                end

                -- BREAK ATAS
                while getTile(getposx() - 1, getposy() - 1).fg ~= 0 do
                    getBot():hit(getposx()-1, getposy()-1)
                    sleep(delay_punch)
                    reconnect(world, edit_doorid)
                end

                while getTile(getposx(), getposy() - 1).fg ~= 0 do
                    getBot():hit(getposx(), getposy()-1)
                    sleep(delay_punch)
                    reconnect(world, edit_doorid)
                end

                while getTile(getposx() + 1, getposy() - 1).fg ~= 0 do
                    getBot():hit(getposx()+1, getposy()-1)
                    sleep(delay_punch)
                    reconnect(world, edit_doorid)
                end

                reconnect(world, edit_doorid)
                posx_wd = getposx()
                posy_wd = getposy()

                getBot():collect(5)
                sleep(20)

                while getposx() ~= posx_wd or getposy() ~= posy_wd do
                    getBot():findPath(posx_wd, posy_wd)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end

                -- PLACE JAMMER
                while getTile(getposx()-1, getposy()-1).fg ~= jammer_id do
                    getBot():place(getposx()-1, getposy()-1, jammer_id)
                    sleep(delay_place)
                    reconnect(world, edit_doorid)
                end

                while getTile(getposx()-1,getposy()-1):hasFlag(0x40) == false do
                    getBot():hit(getposx()-1,getposy()-1)
                    sleep(1000)
                    reconnect(world, edit_doorid)
                end

                -- PLACE SL
                while getTile(getposx(), getposy()-1).fg ~= sl_id do
                    getBot():place(getposx(), getposy()-1, sl_id)
                    sleep(delay_place)
                    reconnect(world, edit_doorid)
                end

                -- PLACE ENTRANCE
                while getTile(getposx() - 1, getposy()).fg ~= entrance_itemid do
                    getBot():place(getposx()-1, getposy(), entrance_itemid)
                    sleep(delay_place)
                    reconnect(world, edit_doorid)
                end
                while getTile(getposx() + 1, getposy()).fg ~= entrance_itemid do
                    getBot():place(getposx()+1, getposy(), entrance_itemid)
                    sleep(delay_place)
                    reconnect(world, edit_doorid)
                end

                print(custom_pos_door)
                -- PLACE DOOR + EDIT DOOR
                if custom_pos_door then
                    -- loop check door edited or no
                    while getposx() ~= pos_x_door or getposy() ~= pos_y_door do
                        getBot():findPath(pos_x_door, pos_y_door)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                        print(getBot().name .. " - Finding path to place door "..pos_x_door.. ", "..pos_y_door)
                    end

                    while getTile(pos_x_door, pos_y_door).fg ~= door_itemid do
                        getBot():place(pos_x_door, pos_y_door, door_itemid)
                        sleep(delay_place)
                        reconnect(world, edit_doorid)
                    end

                    while not getTile(pos_x_door, pos_y_door):getExtra() do
                        while getposx() ~= pos_x_door or getposy() ~= pos_y_door do
                            getBot():findPath(pos_x_door, pos_y_door)
                            sleep(delay_findpath)
                            reconnect(world, edit_doorid)
                            print(getBot().name .. " - Finding path to place door "..pos_x_door.. ", "..pos_y_door)
                        end
                        editDoor("WHAT!?", getBot():getWorld().name, edit_doorid, 0, 0)
                        sleep(10000)
                    end
                else
                    while getposx() ~= posx_wd-1 or getposy() ~= posy_wd do
                        getBot():findPath(posx_wd-1, posy_wd)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end

                    while getTile(getposx(), getposy()+1).fg ~= door_itemid do
                        getBot():place(getposx(), getposy()+1, door_itemid)
                        sleep(delay_place)
                        reconnect(world, edit_doorid)
                    end

                    while not getTile(posx_wd-1, posy_wd+1):getExtra() do
                        while getposx() ~= posx_wd-1 or getposy() ~= posy_wd do
                            getBot():findPath(posx_wd-1, posy_wd)
                            sleep(delay_findpath)
                            reconnect(world, edit_doorid)
                        end
                        editDoor("WHAT!?", getBot():getWorld().name, edit_doorid, 0, 1)
                        sleep(10000)
                    end
                end
                
                while getposx() ~= posx_wd or getposy() ~= posy_wd do
                    getBot():findPath(posx_wd, posy_wd)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end

                -- PLACE DIRT KANAN
                if getBot():getInventory():findItem(2) > 0 then
                    while getTile(getposx()+1, getposy()-1).fg ~= 2 do
                        getBot():place(getposx()+1, getposy()-1, 2)
                        sleep(delay_place)
                        reconnect(world, edit_doorid)
                    end
                else
                    plantHT(world, true)
                    allDone(world)
                    while getposx() ~= posx_wd or getposy() ~= posy_wd do
                        getBot():findPath(posx_wd, posy_wd)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end
                    while getTile(getposx()+1, getposy()-1).fg ~= 2 do
                        getBot():place(getposx()+1, getposy()-1, 2)
                        sleep(delay_place)
                        reconnect(world, edit_doorid)
                    end
                end

                -- REAPPLY LOCK
                while getBot():getWorld():hasAccess(getposx(), getposy()-2) == 1 do
                    reconnect(world, edit_doorid)
                    getBot():wrench(getposx(), getposy()-1)
                    sleep(delay_wrench)
                    getBot():sendPacket(2,"action|dialog_return\ndialog_name|lock_edit\ntilex|" .. getposx() .."|\ntiley|" .. getposy()-1 .."|\nbuttonClicked|recalcLock\n\ncheckbox_public|0\ncheckbox_ignore|1")
                    sleep(delay_wrench)
                end

                while getposx() ~= posx_wd+1 or getposy() ~= posy_wd do
                    getBot():findPath(posx_wd+1, posy_wd)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end

                -- PLACE WL
                while getTile(posx_wd+1, posy_wd+1).fg ~= wl_id do
                    getBot():place(posx_wd+1, posy_wd+1, wl_id)
                    sleep(delay_place)
                    reconnect(world, edit_doorid)
                    while getposx() ~= posx_wd+1 or getposy() ~= posy_wd do
                        getBot():findPath(posx_wd+1, posy_wd)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end
                end

                -- SET PUBLIC WL
                while getBot():getWorld():hasAccess(getposx(), getposy()-2) ~= 2 do
                    while getposx() ~= posx_wd+1 or getposy() ~= posy_wd do
                        getBot():findPath(posx_wd+1, posy_wd)
                        sleep(delay_findpath)
                        reconnect(world, edit_doorid)
                    end
                    sleep(1000)
                    reconnect(world, edit_doorid)
                    getBot():wrench(posx_wd+1, posy_wd+1)
                    sleep(delay_wrench)
                    getBot():sendPacket(2, "action|dialog_return\ndialog_name|lock_edit\ntilex|" .. posx_wd+1 .. "|\ntiley|" .. posy_wd + 1 .. "|\nbuttonClicked|recalcLock\n\ncheckbox_public|1\ncheckbox_ignore|0")
                    sleep(delay_reapply_lock)
                end

                while getposx() ~= posx_wd or getposy() ~= posy_wd do
                    getBot():findPath(posx_wd, posy_wd)
                    sleep(delay_findpath)
                    reconnect(world, edit_doorid)
                end

                -- back to default 
                SL_mode = true
            end

            powershell("Success Lock ".. world, index_world, getTextWorld())
        end
    else
        for _, world in pairs(list_world_DF) do
            index_world = _
            print(getBot().name.. "  will warp in "..(getIndexBots()*2000/1000).." second")
            if _ == 1 then
                sleep(getIndexBots()*2000)
            end
            if join(world, edit_doorid) then
                total_bot = getTotalBot()
                if total_bot <= limit_bot_per_world then
                    time =  os.time()
                    reconnect(world, edit_doorid)
                    powershell("Start Building DF", index_world, getTextWorld())
                    clearSide(world)
                    platform(world)
                    clearDirt(world)
                    placeDirt(world)
                    allDone(world)
                    sleep(100)
                    getBot():collect(2)
                    sleep(20)
                    -- recheck lagi
                    clearDirt(world)
                    placeDirt(world)
                    allDone(world)
                    placeDirt(world)
                    selesai = os.time()
                    time = selesai - time
                    -- webhook
                    list_time[_] = math.floor(time % 86400 / 3600) .. " Hours " .. math.floor(time % 86400 % 3600 / 60) .. " Minutes"
                    powershell("Done Build DF", index_world, getTextWorld())
                end 
            end
            ::continue::
        end
    end
end


    main()

if remove_bot then
    getBot():disconnect()
end