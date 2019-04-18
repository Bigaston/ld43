return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.6",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 9,
  tilewidth = 80,
  tileheight = 80,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "Tiles",
      firstgid = 1,
      filename = "Other Files/Tiles.tsx",
      tilewidth = 80,
      tileheight = 80,
      spacing = 0,
      margin = 0,
      image = "img/Tiles.png",
      imagewidth = 1040,
      imageheight = 80,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 80,
        height = 80
      },
      properties = {},
      terrains = {},
      tilecount = 13,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Calque de Tile 1",
      x = 0,
      y = 0,
      width = 16,
      height = 9,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 4, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 1,
        1, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 1,
        1, 9, 1, 1, 4, 6, 6, 6, 6, 6, 6, 5, 1, 1, 9, 1,
        1, 3, 5, 1, 9, 1, 1, 1, 1, 1, 1, 9, 1, 4, 2, 1,
        13, 13, 9, 1, 9, 1, 4, 6, 6, 5, 1, 9, 1, 9, 13, 13,
        13, 13, 9, 1, 9, 1, 9, 13, 13, 9, 1, 9, 1, 9, 13, 13,
        1, 4, 2, 1, 9, 1, 9, 13, 13, 9, 1, 9, 1, 3, 5, 1,
        1, 9, 1, 1, 9, 1, 9, 13, 13, 9, 1, 9, 1, 1, 9, 1,
        1, 10, 1, 1, 12, 1, 10, 13, 13, 12, 1, 10, 1, 1, 12, 1
      }
    }
  }
}
