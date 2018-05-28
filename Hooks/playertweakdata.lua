Hooks:PostHook(PlayerTweakData, "init", "AkimboHeavyCrossbow_PlayerTweakData", function(self)
	self.stances.saw_beakimbo = deep_clone(self.stances.saw)
end) 
