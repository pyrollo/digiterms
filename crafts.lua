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

local function material_fallback(list)
  for _, material in ipairs(list) do
    if minetest.registered_items[material] then
      return material
    end
  end
end

local body = material_fallback({
  'homedecor:plastic_sheeting',
  'default:steel_ingot',
})

local glass = material_fallback({
  'xpanes:pane_flat',
  'default:glass',
})

local electronic = material_fallback({
  'mesecons_microcontroller:microcontroller0000',
  'mesecons_luacontroller:luacontroller0000',
  'default:copper_ingot',
})

local wire = 'digilines:wire_std_00000000'

print("Craft materials:")
print("Body: "..(body or "None!"))
print("Glass: "..(glass or "None!"))
print("Electronic: "..(electronic or "None!"))
print("Wire: "..(wire or "None!"))

minetest.register_craft({
	output = "digiterms:lcd_monitor 1",
	recipe = {
		{body, electronic, ''},
		{glass, material_fallback({'mesecons_materials:silicon', 'dye:black'}), ''},
		{body, wire, ''}
	}
})

minetest.register_craft({
	output = "digiterms:cathodic_amber_monitor",
	recipe = {
		{body, body, ''},
		{glass, 'dye:orange', electronic},
		{body, body, wire}
	}
})

minetest.register_craft({
	output = "digiterms:cathodic_green_monitor 1",
	recipe = {
		{body, body, ''},
		{glass, 'dye:green', electronic},
    {body, body, wire}
	}
})
