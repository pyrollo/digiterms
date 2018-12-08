digiterms.register_monitor('digiterms:scifi_monitor', {
  description = "Scifi monitor",
	paramtype = "light",
	paramtype2 = "facedir",
  use_texture_alpha = true,
	sunlight_propagates = true,
  light_source = 15,
  tiles = {
    "digiterms_scifi_glscrn.png",
    "digiterms_scifi_glscrn.png",
    "digiterms_scifi_glscrn.png",
    "digiterms_scifi_glscrn.png",
    "digiterms_scifi_glscrn.png",
    "digiterms_scifi_glscrn.png",
  },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      {-0.4375, -0.5, -0.125, 0.4375, -0.1875, 0.0625}, -- NodeBox1
      {-0.375, -0.5, -0.0625, 0.375, 0.5, 0}, -- NodeBox10
    }
  },
  sounds = default.node_sound_glass_defaults(),
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	display_entities = {
		["digiterms:screen"] = {
				on_display_update = font_api.on_display_update,
				depth = -7/16 - display_api.entity_spacing,
				top = -1/16,
				size = { x = 23/32, y = 10/16 },
				columns = 20, lines = 4,
				color = "#76EDCD", font_name = digiterms.font, halign="left", valing="top",
		},
	},
})
