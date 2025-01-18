module Config
  # Window Settings
  WINDOW_WIDTH  = 800
  WINDOW_HEIGHT = 600
  FULLSCREEN    = false
  CAPTION       = "Critter Quest"

  # Grid Settings
  CELL_SIZE = 50
  GRID_ROWS = WINDOW_HEIGHT / CELL_SIZE
  GRID_COLS = WINDOW_WIDTH / CELL_SIZE

  # Color Settings
  COLORS = {
    background: Gosu::Color.new(255, 135, 206, 235), # Sky Blue
    wall: Gosu::Color.new(255, 139, 69, 19), # Brown
    path: Gosu::Color.new(255, 255, 255, 255) # White
  }

  # Grass Tile Settings
  GRASS_TILES_IMAGES = {
    [:north] => "assets/tiles/grass_tiles/wall_top.png",
    [:south] => "assets/tiles/grass_tiles/wall_bottom.png",
    [:west] => "assets/tiles/grass_tiles/wall_left.png",
    [:east] => "assets/tiles/grass_tiles/wall_right.png",
    [:north, :west] => "assets/tiles/grass_tiles/corner_top_left.png",
    [:east, :north] => "assets/tiles/grass_tiles/corner_top_right.png",
    [:south, :west] => "assets/tiles/grass_tiles/corner_bottom_left.png",
    [:east, :south] => "assets/tiles/grass_tiles/corner_bottom_right.png",
    [:north, :south] => "assets/tiles/grass_tiles/top_bottom.png",
    [:east, :west] => "assets/tiles/grass_tiles/left_right.png",
    [:east, :north, :west] => "assets/tiles/grass_tiles/top_sides.png",
    [:east, :south, :west] => "assets/tiles/grass_tiles/bottom_sides.png",
    [:north, :south, :west] => "assets/tiles/grass_tiles/left_tb.png",
    [:east, :north, :south] => "assets/tiles/grass_tiles/right_tb.png",
    [:east, :north, :south, :west] => "assets/tiles/grass_tiles/all_sides.png",
    [] => "assets/tiles/grass_tiles/plain_grass.png"
  }

  # Assets Path Settings
  ASSETS = {
    player: "assets/images/player.png",
    wall: "assets/images/wall.png",
    path: "assets/images/path.png",
    start: "assets/images/start.png",
    goal: "assets/images/goal.png",
    background_music: "assets/sounds/background_music.mp3",
  }
end
