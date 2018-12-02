--[[
    digimons mod for Minetest - Digiline monitors using Display API / Font API
    (c) Pierre-Yves Rollo

    This file is part of digimons.

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

minetest.register_node('digimons:cathodic_amber_monitor', {
  description = "Cathodic amber monitor",
  sunlight_propagates = false,
  paramtype = "light",
  paramtype2 = "facedir",
  tiles = { "digimons_amber_top.png", "digimons_amber_bottom.png",
            "digimons_amber_sides.png", "digimons_amber_sides.png^[transformFX]",
            "digimons_amber_back.png", "digimons_amber_front.png",},
  drawtype = "nodebox",
  groups = {choppy = 1, oddly_breakable_by_hand = 1, display_modpack_node = 1},
  node_box = {
    type = "fixed",
    fixed = {
      {-8/16, 8/16, -8/16, 8/16, 7/16, -7/16},
      {-8/16, -8/16, -8/16, 8/16, -5/16, -7/16},
      {-8/16, 7/16, -8/16, -7/16, -5/16, -7/16},
      {7/16, 7/16, -8/16, 8/16, -5/16, -7/16},
      {-8/16, -8/16, -7/16, 8/16, 8/16, 1/16},
      {-6/16, 5/16, 1/16, 6/16, -8/16, 8/16}
    },
  },
  display_entities = {
    ["digimons:screen"] = {
        on_display_update = font_api.on_display_update,
        depth = -7/16 - display_api.entity_spacing,
        top = -1/16,
        aspect_ratio = 0.5, maxlines = 6,
        size = { x = 23/32, y = 10/16 },
        color = "#FFA000", font_name = "mozart", halign="left", valing="top",
    },
  },
  on_place = function(itemstack, placer, pointed_thing)
      minetest.rotate_node(itemstack, placer, pointed_thing)
      return display_api.on_place(itemstack, placer, pointed_thing)
    end,
  on_construct = function(pos)
      minetest.get_meta(pos):set_string("formspec",
        "field[channel;Channel;${channel}]")
      display_api.on_construct(pos)
    end,
  on_destruct = display_api.on_destruct,
  on_rotate = display_api.on_rotate,
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
  on_punch = display_api.update_entities,
  digiline = {
    receptor = {},
    effector = {
      action = function(pos, _, channel, msg)
          if channel ~= minetest.get_meta(pos):get_string("channel") then
            return
          end
          digimons.push_text_on_screen(pos, msg)
        end,
  	},
  },
})
