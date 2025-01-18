class Cell
  attr_accessor :row, :col, :path_tile

  def initialize row, col
    @row        = row
    @col        = col
    @path_tile  = false # whether this cell is part of the path
    @tile_image = Gosu::Image.new("assets/tiles/grass_tiles/plain_grass.png")
    # @walls      = { north: true, south: true, west: true, east: true}
  end

  def update_tile(neighbors)
    # If this cell is part of the path, it does not need a tile (Background shows)
    if @path_tile
      @tile_image = nil
      return
    end
    # determine21  walls based on neighbors
    walls = []
    walls << :north if neighbors[:north]&.path_tile
    walls << :south if neighbors[:south]&.path_tile
    walls << :west  if neighbors[:west]&.path_tile
    walls << :east  if neighbors[:east]&.path_tile
    # Select correct tile image based on wall configuration
    image_path  = Config::GRASS_TILES_IMAGES[walls.sort] || "assets/tiles/grass_tiles/plain_grass.png"
    @tile_image = Gosu::Image.new(image_path)
  end

  def draw x, y, cell_size
    # Calculate scaling factors
    scale_x = cell_size.to_f / @tile_image.width
    scale_y = cell_size.to_f / @tile_image.height
    @tile_image.draw x, y, 0, scale_x, scale_y unless @path_tile
  end
end
