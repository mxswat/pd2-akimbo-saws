function SawHit:on_collision(col_ray, weapon_unit, user_unit, damage, isAkimbo)
	local hit_unit = col_ray.unit

	if hit_unit and hit_unit:base() and hit_unit:base()._tweak_table and string.find(hit_unit:base()._tweak_table, "tank") then
		damage = 50
	end

	local result = InstantBulletBase.on_collision(self, col_ray, weapon_unit, user_unit, damage)

	if hit_unit:damage() and col_ray.body:extension() and col_ray.body:extension().damage then
		damage = math.clamp(damage * managers.player:upgrade_value("saw", "lock_damage_multiplier", 1) * 4, 0, 200)

		local lock_damage = damage
        if isAkimbo then
            log("isAkimbo")
            lock_damage = lock_damage * 2
        end
		col_ray.body:extension().damage:damage_lock(user_unit, col_ray.normal, col_ray.position, col_ray.direction, lock_damage)

		if hit_unit:id() ~= -1 then
			managers.network:session():send_to_peers_synched("sync_body_damage_lock", col_ray.body, damage)
		end
	end

	return result
end
