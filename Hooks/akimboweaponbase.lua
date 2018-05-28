AkimboSawWeaponBase = AkimboSawWeaponBase or class(SawWeaponBase)
AkimboSawWeaponBase.AKIMBO = true

-- Lines: 19 to 25
function AkimboSawWeaponBase:init(...)
	AkimboSawWeaponBase.super.init(self, ...)

	self._unit:set_extension_update_enabled(Idstring("base"), true)

	self._fire_callbacks = {}
end

local mvec_to = Vector3()
local mvec_spread_direction = Vector3()
function SawWeaponBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul)
	local result = {}
	local hit_unit = nil

	mvector3.set(mvec_spread_direction, direction)
	mvector3.set(mvec_to, mvec_spread_direction)
	mvector3.multiply(mvec_to, 100)
	mvector3.add(mvec_to, from_pos)

	local damage = self:_get_current_damage(dmg_mul)
	local valid_hit = false
	local col_ray = nil

	if self._saw_through_shields then
		local hits = {}
		col_ray = World:raycast_all("ray", from_pos, mvec_to, "slot_mask", self._bullet_slotmask, "ignore_unit", self._setup.ignore_units, "ray_type", "body bullet lock")

		for i, hit in ipairs(col_ray) do
			local is_shield = hit.unit:in_slot(8) and alive(hit.unit:parent())
			local is_enemy = hit.unit:character_damage() ~= nil

			if not ray_table_contains(hits, hit.unit) then
				table.insert(hits, hit)
			elseif hit.unit:character_damage() and hit.unit:character_damage().is_head and hit.unit:character_damage().is_head(hit.body) then
				ray_copy(hits, hit)
			end
		end

		for i, hit in pairs(hits) do
			hit_unit = SawHit:on_collision(hit, self._unit, user_unit, damage, direction)
		end

		valid_hit = #col_ray > 0
	else
		col_ray = World:raycast("ray", from_pos, mvec_to, "slot_mask", self._bullet_slotmask, "ignore_unit", self._setup.ignore_units, "ray_type", "body bullet lock")

		if col_ray then
			hit_unit = SawHit:on_collision(col_ray, self._unit, user_unit, damage, direction)
			valid_hit = true
		end
	end

	result.hit_enemy = hit_unit

	if self._alert_events then
		result.rays = {col_ray}
	end

	if col_ray then
		managers.statistics:shot_fired({
			hit = true,
			weapon_unit = self._unit
		})
	end

	return result, valid_hit
end

function AkimboSawWeaponBase:stop_shooting(...)
	AkimboSawWeaponBase.super.stop_shooting(self, ...)

	if alive(self._second_gun) then
		self._second_gun:base().super.stop_shooting(self._second_gun:base(), ...)
	end
end

function AkimboSawWeaponBase:_play_sound_sawing()
	AkimboSawWeaponBase.super._play_sound_sawing(self)

	if alive(self._second_gun) then
		self._second_gun:base().super._play_sound_sawing(self._second_gun:base())
	end
end

function AkimboSawWeaponBase:_play_sound_idle()
	AkimboSawWeaponBase.super._play_sound_idle(self)

	if alive(self._second_gun) then
		self._second_gun:base().super._play_sound_idle(self._second_gun:base())
	end
end

function AkimboSawWeaponBase:_start_sawing_effect(...)
	AkimboSawWeaponBase.super._start_sawing_effect(self, ...)

	if alive(self._second_gun) then
		self._second_gun:base().super._start_sawing_effect(self._second_gun:base(), ...)
	end
end

function AkimboSawWeaponBase:_stop_sawing_effect(...)
	AkimboSawWeaponBase.super._stop_sawing_effect(self, ...)

	if alive(self._second_gun) then
		self._second_gun:base().super._stop_sawing_effect(self._second_gun:base(), ...)
	end
end

function AkimboSawWeaponBase:_second_gun_tweak_data_anim_version(anim)
	return AkimboWeaponBase._second_gun_tweak_data_anim_version(self, anim)
end

function AkimboSawWeaponBase:tweak_data_anim_play(anim, ...)
	if alive(self._second_gun) then
		local second_gun_anim = self:_second_gun_tweak_data_anim_version(anim)

		self._second_gun:base():tweak_data_anim_play(second_gun_anim, ...)
	end

	return AkimboSawWeaponBase.super.tweak_data_anim_play(self, anim, ...)
end

function AkimboSawWeaponBase:tweak_data_anim_stop(...)
	return AkimboWeaponBase.tweak_data_anim_stop(self, ...)
end

function AkimboSawWeaponBase:destroy(...)
	AkimboWeaponBase.destroy(self, ...)
end

function AkimboSawWeaponBase:mute_firing()
	AkimboWeaponBase.mute_firing(self)
end

function AkimboSawWeaponBase:on_enabled(...)
	AkimboWeaponBase.on_enabled(self, ...)
end

function AkimboSawWeaponBase:on_disabled(...)
	AkimboWeaponBase.on_disabled(self, ...)
end

function AkimboSawWeaponBase:on_equip(...)
	AkimboWeaponBase.on_equip(self, ...)
end

function AkimboSawWeaponBase:_create_second_gun(unit_name)
	AkimboWeaponBase._create_second_gun(self, unit_name)
end

function AkimboSawWeaponBase:create_second_gun(create_second_gun)
	AkimboWeaponBase.create_second_gun(self, create_second_gun)
end

NPCAkimboSawWeaponBase = NPCAkimboSawWeaponBase or class(AkimboWeaponBase)