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

  # Player Settings
  PLAYER_SPEED = 4

  # Animal Settings
  ANIMAL_IMAGE = "assets/images/animal.png"

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
