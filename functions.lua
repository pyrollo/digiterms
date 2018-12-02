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

digimons.columns = 30

local function get_lines(pos)
  local lines = {}
  local meta = minetest.get_meta(pos)
  local text = meta:get_string("display_text")
  local pos = 1
	repeat
		local found = text:find("\n", pos) or #text + 1
    lines[#lines+1] = text:sub(pos, found - 1)
		pos = found + 1
	until (pos > (#text + 1))
  return lines
end

local function set_lines(pos, lines)
  local meta = minetest.get_meta(pos)
  meta:set_string("display_text", table.concat(lines, "\n"))
end

local function push_line(lines, line, maxlines)
  for index = 1, (maxlines - 1) do
    lines[index] = lines[index + 1] or ""
  end
  lines[maxlines] = line
end

local function push_text(lines, text, maxlines, maxcolumns)
	local pos = 1
	repeat
		local found = text:find("\n", pos) or #text + 1
    local line = text:sub(pos, found - 1)
    for index = 1, math.ceil(line:len() / maxcolumns) do
      local part = line:sub((index-1)*maxcolumns+1, index*maxcolumns)
      push_line(lines, part, maxlines)
    end
		pos = found + 1
	until (pos > (#text + 1))
  end

function digimons.push_text_on_screen(pos, text)
  local lines = get_lines(pos)
  push_text(lines, text, 6, 20)
  set_lines(pos, lines)
  display_api.update_entities(pos)
end
