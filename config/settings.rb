module Config
  # Window Settings
  WINDOW_WIDTH  = 800
  WINDOW_HEIGHT = 600
  FULLSCREEN    = true
  CAPTION       = "Mermaid Maze"

  # Grid Settings
  CELL_SIZE = 50
  GRID_ROWS = WINDOW_HEIGHT / CELL_SIZE
  GRID_COLS = WINDOW_WIDTH / CELL_SIZE

  # Color Settings
  COLORS = {
    background: Gosu::Color.new(255, 100, 80, 235), # Sky Blue
    wall: Gosu::Color.new(255, 139, 69, 19), # Brown
    path: Gosu::Color.new(255, 255, 255, 255) # White
  }

  GRASS_TILES_IMAGES = {
    [:north] => "assets/tiles/my_tiles/top.png",
    [:south] => "assets/tiles/my_tiles/bottom.png",
    [:west] => "assets/tiles/my_tiles/left.png",
    [:east] => "assets/tiles/my_tiles/right.png",
    [:north, :west] => "assets/tiles/my_tiles/corner_top_left.png",
    [:east, :north] => "assets/tiles/my_tiles/corner_top_right.png",
    [:south, :west] => "assets/tiles/my_tiles/corner_bottom_left.png",
    [:east, :south] => "assets/tiles/my_tiles/corner_bottom_right.png",
    [:north, :south] => "assets/tiles/my_tiles/top_bottom.png",
    [:east, :west] => "assets/tiles/my_tiles/left_right.png",
    [:east, :north, :west] => "assets/tiles/my_tiles/top_sides.png",
    [:east, :south, :west] => "assets/tiles/my_tiles/bottom_sides.png",
    [:north, :south, :west] => "assets/tiles/my_tiles/left_tb.png",
    [:east, :north, :south] => "assets/tiles/my_tiles/right_tb.png",
    [:east, :north, :south, :west] => "assets/tiles/my_tiles/all_sides.png",
    [] => "assets/tiles/my_tiles/plain.png"
  }

  # Mermaid Character Path Settings
  MERMAIDS = {
    blue: {
      up:,
      down:,
      left:,
      right:
    },
    pink: {
      up:,
      down:,
      left:,
      right:
    },
    purple: {
      up:,
      down:,
      left:,
      right:
    }
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
