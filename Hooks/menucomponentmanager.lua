local AkimboHeavyCrossbow_MenuComponentManager_create_weapon_mod_icon_list = MenuComponentManager.create_weapon_mod_icon_list

function MenuComponentManager:create_weapon_mod_icon_list(weapon, category, factory_id, ...)
	return AkimboHeavyCrossbow_MenuComponentManager_create_weapon_mod_icon_list(self, weapon:gsub("_beakimbo", ""), category, factory_id:gsub("_beakimbo", ""), ...)
end