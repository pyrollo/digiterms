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

digimons = {}
digimons.name = minetest.get_current_modname()
digimons.path = minetest.get_modpath(digimons.name)

dofile(digimons.path.."/font_mozart.lua")
dofile(digimons.path.."/functions.lua")
dofile(digimons.path.."/nodes.lua")
--dofile(digimons.path.."/crafts.lua")

display_api.register_display_entity("digimons:screen")
