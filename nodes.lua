--[[
	digiterms mod for Minetest - Digilines monitors using Display API / Font API
	(c) Pierre-Yves Rollo

	This file is part of digiterms.

	signs is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	signs is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with signs.  If not, see <http://www.gnu.org/licenses/>.
--]]

local common_node_def = {
	groups = { display_api = 1},
	on_place = function(itemstack, placer, pointed_thing)
			minetest.rotate_node(itemstack, placer, pointed_thing)
			return display_api.on_place(itemstack, placer, pointed_thing)
		end,
	on_destruct = display_api.on_destruct,
	on_rotate = display_api.on_rotate,
	on_punch = display_api.update_entities,
	on_construct = function(pos)
			minetest.get_meta(pos):set_string("formspec",
				"field[channel;Channel;${channel}]")
			display_api.on_construct(pos)
		end,
	on_receive_fields = function(pos, formname, fields, player)
			local name = player:get_player_name()
			if minetest.is_protected(pos, name) then
				minetest.record_protection_violation(pos, name)
				return
			end

			if (fields.channel) then
				minetest.get_meta(pos):set_string("channel", fields.channel)
			end
		end,
	digiline = {
		wire = { use_autoconnect = false },
		receptor = {},
		effector = {
			action = function(pos, _, channel, msg)
					if channel ~= minetest.get_meta(pos):get_string("channel") then
						return
					end
					digiterms.push_text_on_screen(pos, msg)
				end,
		},
	},
}

function digiterms.register_monitor(nodename, nodedef)
	def = table.copy(common_node_def)
	for key, value in pairs(nodedef) do
		if key == 'groups' then
			def[key] = def[key] or {}
			for key2, value2 in pairs(value) do
				def[key][key2] = value2
			end
		else
			def[key] = value
		end
	end
	minetest.register_node(nodename, def)
end

local cathodic_node_box = {
	type = "fixed",
	fixed = {
		{-8/16, 8/16, -8/16, 8/16, 7/16, -7/16},
		{-8/16, -8/16, -8/16, 8/16, -5/16, -7/16},
		{-8/16, 7/16, -8/16, -7/16, -5/16, -7/16},
		{7/16, 7/16, -8/16, 8/16, -5/16, -7/16},
		{-8/16, -8/16, -7/16, 8/16, 8/16, 1/16},
		{-6/16, 5/16, 1/16, 6/16, -8/16, 8/16}
	}
}
local cathodic_collision_box = {
	type = "fixed",
	fixed = {
		{-8/16, -8/16, -8/16, 8/16, 8/16, 1/16},
		{-6/16, 5/16, 1/16, 6/16, -8/16, 8/16}
	}
}

digiterms.register_monitor('digiterms:cathodic_amber_monitor', {
	description = "Cathodic amber monitor",
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { "digiterms_amber_top.png", "digiterms_amber_bottom.png",
						"digiterms_amber_sides.png", "digiterms_amber_sides.png^[transformFX]",
						"digiterms_amber_back.png", "digiterms_amber_front.png",},
	drawtype = "nodebox",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	node_box = cathodic_node_box,
	collision_box = cathodic_collision_box,
	selection_box = cathodic_collision_box,
	display_entities = {
		["digiterms:screen"] = {
				on_display_update = font_api.on_display_update,
				depth = -7/16 - display_api.entity_spacing,
				top = -1/16,
				size = { x = 23/32, y = 10/16 },
				columns = 20, lines = 6,
				color = "#FFA000", font_name = digiterms.font, halign="left", valing="top",
		},
	},
})

digiterms.register_monitor('digiterms:cathodic_green_monitor', {
	description = "Cathodic green monitor",
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { "digiterms_green_top.png", "digiterms_green_bottom.png",
						"digiterms_green_sides.png", "digiterms_green_sides.png^[transformFX]",
						"digiterms_green_back.png", "digiterms_green_front.png",},
	drawtype = "nodebox",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	node_box = cathodic_node_box,
	collision_box = cathodic_collision_box,
	selection_box = cathodic_collision_box,
	display_entities = {
		["digiterms:screen"] = {
				on_display_update = font_api.on_display_update,
				depth = -7/16 - display_api.entity_spacing,
				top = -1/16,
				size = { x = 23/32, y = 10/16 },
				columns = 20, lines = 6,
				color = "#00FF00", font_name = digiterms.font, halign="left", valing="top",
		},
	},
})
