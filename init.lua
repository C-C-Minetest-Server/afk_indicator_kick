local S = minetest.get_translator("afk_indicator_kick")
local MAX_INACTIVE_TIME = tonumber(minetest.settings:get("afkkick.max_inactive_time")) or 300
local WARN_TIME = tonumber(minetest.settings:get("afkkick.warn_time")) or 20

local function loop()
	for x,y in pairs(afk_indicator.get_all_longer_than(MAX_INACTIVE_TIME - WARN_TIME - 1)) do
		local LEFT_TIME = MAX_INACTIVE_TIME - y
		if LEFT_TIME <= 0 then
			minetest.kick_player(x,"AFK for too long")
			return
		end
		minetest.chat_send_player(x,minetest.colorize("#ece81a",S("WARNING: Please move in @1 seconds or you will be kicked!",LEFT_TIME)))
	end
	minetest.after(1,loop)
end
minetest.after(1,loop)
