local AkimboHeavyCrossbow_WeaponFactoryManager_get_part_desc_by_part_id_from_weapon = WeaponFactoryManager.get_part_desc_by_part_id_from_weapon

function WeaponFactoryManager:get_part_desc_by_part_id_from_weapon(part_id, factory_id, blueprint)
	return AkimboHeavyCrossbow_WeaponFactoryManager_get_part_desc_by_part_id_from_weapon(self, part_id, factory_id:gsub("_beakimbo", ""), blueprint)
end

local AkimboHeavyCrossbow_WeaponFactoryManager_part_data = WeaponFactoryManager._part_data

function WeaponFactoryManager:_part_data(part_id, factory_id, override)
	return AkimboHeavyCrossbow_WeaponFactoryManager_part_data(self, part_id, factory_id:gsub("_beakimbo", ""), override)
end