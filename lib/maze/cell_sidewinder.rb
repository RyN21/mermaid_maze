class CellSidewinder
  attr_accessor :row, :col, :links, :is_border, :tile_path

  def initialize row, col, rows, cols
    @row        = row
    @col        = col
    @links      = [] # stores references to linked neighboring cells
    @is_border  = (row == 0 || col == 0 || row == rows - 1 || col == cols - 1)
    @tile_path  = false
    @tile_image = Gosu::Image.new("assets/tiles/grass_tiles/plain_grass.png")
  end


  # Link this cell to another cell ( BiDirectional )
  def link cell
    return if is_border # Do not link border cells
    @links << cell unless @links.include?(cell)
    cell.links << self unless cell.links.include?(self)
  end


  # Checks if this cell is linked to another
  def linked? cell
    @links.include? cell
  end



  def update_tile(neighbors)
    # If this cell is part of the path, it does not need a tile (Background shows)
    if @tile_path
      @tile_image = nil
      return
    end
    # determine21  walls based on neighbors
    walls = []
    walls << :north if neighbors[:north]&.tile_path
    walls << :south if neighbors[:south]&.tile_path
    walls << :west  if neighbors[:west]&.tile_path
    walls << :east  if neighbors[:east]&.tile_path
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
