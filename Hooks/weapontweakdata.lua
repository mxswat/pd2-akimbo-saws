Hooks:PostHook(WeaponTweakData, "init", "AkimboHeavyCrossbow_WPTweakDatainit", function(wP)	
	for k, v in pairs(wP or {}) do
		if k:find('_beakimbo') then
			local new_k = k:gsub('_beakimbo', '')			
			wP[k].animations = deep_clone((wP[new_k].animations or wP.x_usp.animations))
			wP[k].animations.reload_name_id = new_k
			if wP[new_k].timers then
				wP[k].timers = {}
				for i_t, d_t in pairs(wP[new_k].timers) do
					wP[k].timers[i_t] = d_t * 2
				end
			end
			if wP[new_k].stats then			
				wP[k].stats.concealment = math.round((wP[new_k].stats.concealment or 0) * 0.6)
				wP[k].stats.spread = math.round((wP[new_k].stats.spread or 0) * 0.6)
				wP[k].stats.spread_moving = math.round((wP[new_k].stats.spread_moving or 0) * 0.6)
				wP[k].stats.recoil  = math.round((wP[new_k].stats.recoil  or 0) * 0.6)
			end
		end
	end
end)