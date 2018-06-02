Hooks:PostHook( BlackMarketTweakData, "_init_weapon_skins", "AkimboSawWeaponSkinsInit", function(self)
	local saw_skins = {
		"saw_buck",
		"saw_smosh",
		"saw_cs3",
		"saw_tam"
	}

	for i, skin in ipairs(saw_skins) do
		table.insert(self.weapon_skins[skin].weapon_ids, "saw_akimbo")
	end
end )