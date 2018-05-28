Hooks:PostHook(WeaponFactoryTweakData, "init", "AkimboHeavyCrossbow_TweakDatainit", function(wFac)	
	for k, v in pairs(wFac.parts or {}) do
		wFac.parts[k..'_beakimbo'] = deep_clone(v)
	end
end)