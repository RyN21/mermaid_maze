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
  # GRASS_TILES_IMAGES = {
  #   :wall_top => "assets/tiles/grass_tiles/wall_top.png",
  #   :wall_bottom => "assets/tiles/grass_tiles/wall_bottom.png",
  #   :wall_left => "assets/tiles/grass_tiles/wall_left.png",
  #   :wall_right => "assets/tiles/grass_tiles/wall_right.png",
  #   :corner_top_left => "assets/tiles/grass_tiles/corner_top_left.png",
  #   :corner_top_right => "assets/tiles/grass_tiles/corner_top_right.png",
  #   :corner_bottom_left => "assets/tiles/grass_tiles/corner_bottom_left.png",
  #   :corner_bottom_right => "assets/tiles/grass_tiles/corner_bottom_right.png",
  #   :top_bottom => "assets/tiles/grass_tiles/top_bottom.png",
  #   :left_right => "assets/tiles/grass_tiles/left_right.png",
  #   :top_sides => "assets/tiles/grass_tiles/top_sides.png",
  #   :bottom_sides => "assets/tiles/grass_tiles/bottom_sides.png",
  #   :left_tb => "assets/tiles/grass_tiles/left_tb.png",
  #   :right_tb => "assets/tiles/grass_tiles/right_tb.png",
  #   :all_sides => "assets/tiles/grass_tiles/all_sides.png",
  #   :plain_grass => "assets/tiles/grass_tiles/plain_grass.png"
  # }

  # # Tile Mapping Settings
  # TILE_MAPPING = {
  #   [:north] => :wall_top,
  #   [:south] => :wall_bottom,
  #   [:west] => :wall_left,
  #   [:east] => :wall_right,
  #   [:north, :west] => :corner_top_left,
  #   [:east, :north] => :corner_top_right,
  #   [:south, :west] => :corner_bottom_left,
  #   [:east, :south] => :corner_bottom_right,
  #   [:north, :south] => :top_bottom,
  #   [:east, :west] => :left_right,
  #   [:east, :north, :west] => :top_sides,
  #   [:east, :south, :west] => :bottom_sides,
  #   [:north, :south, :west] => :left_tb,
  #   [:east, :north, :south] => :right_tb,
  #   [:east, :north, :south, :west] => :all_sides,
  #   [] => :plain_grass
  # }

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
