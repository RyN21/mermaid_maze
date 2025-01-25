require_relative "cell_sidewinder"

class MazeSidewinder
  TILE_SIZE = Config::CELL_SIZE
  attr_reader :grid

  def initialize(rows, cols)
    @rows   = rows
    @cols   = cols
    @grid   = Array.new(rows) { |row| Array.new(cols) { |col| CellSidewinder.new(row, col, rows, cols) } }
    generate_maze
  end



  def update
    @world.step(1.0/60.0, 6, 2)
  end



  def generate_maze
    @grid.each_with_index do |row, row_index|
      next if row_index == 0 || row_index == @rows - 1 || row_index.even?
      row.each_with_index do |_, col_index|
        next if col_index == 0 || col_index == @cols - 1 || col_index.even?
        if rand < 0.5
          carve_horizontally(row_index, col_index)
        else
          carve_vertically(row_index, col_index)
        end
      end
    end
    connect_isolated_paths
    update_all_tiles
  end



  def carve_horizontally(row, col)
    return if col >= @cols - 2
    @grid[row][col].tile_path = true
    @grid[row][col + 1].tile_path = true
  end



  def carve_vertically(row, col)
    return if row >= @rows - 2
    @grid[row][col].tile_path = true
    @grid[row + 1][col].tile_path = true
  end



  def draw(cell_size)
    @grid.each do |row|
      row.each do |cell|
        if !cell.tile_path
          x = cell.col * cell_size
          y = cell.row * cell_size
          cell.draw x, y, cell_size
        end
      end
    end
  end



  def update_all_tiles
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        neighbors = {
          north: (row_index >= 0 ? @grid[row_index - 1][col_index] : nil),
          south: (row_index <= @rows.size + 2 ? @grid[row_index + 1][col_index] : nil),
          west:  (col_index >= 0 ? @grid[row_index][col_index - 1] : nil),
          east:  (col_index <= @cols.size + 4 ? @grid[row_index][col_index + 1] : nil)
        }
        cell.update_tile(neighbors)
      end
    end
  end



  def connect_isolated_paths
    regions = label_regions

    while regions.size > 1
      region1, region2 = regions.keys.sample(2)
      point1, point2 = find_nearest_points(regions, region1, region2)

      connect_points(point1, point2)

      regions[region1].concat(regions[region2])
      regions.delete(region2)
    end

    verify_connectivity
  end



  def is_path?(x, y)
    return false if x < 0 || y < 0 || x >= @cols || y>= @rows
    @grid[y][x].tile_path
  end



  private




  def label_regions
    regions = {}
    region_id = 0

    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        next unless cell.tile_path # Skip non-path cells
        next if regions.values.any? { |region| region.include?([y, x]) }

        region_id += 1
        regions[region_id] = flood_fill(y, x)
      end
    end

    regions
  end

  def flood_fill(start_y, start_x)
    queue = [[start_y, start_x]]
    visited = Set.new

    while !queue.empty?
      y, x = queue.shift
      next if visited.include?([y, x])
      next unless (0...@rows).cover?(y) && (0...@cols).cover?(x)
      next unless @grid[y][x].tile_path # Only consider path cells

      visited.add([y, x])

      [[y-1, x], [y+1, x], [y, x-1], [y, x+1]].each do |ny, nx|
        queue << [ny, nx] if (0...@rows).cover?(ny) && (0...@cols).cover?(nx)
      end
    end

    visited.to_a
  end

  def find_nearest_points(regions, region1, region2)
    min_distance = Float::INFINITY
    nearest_points = nil

    regions[region1].each do |y1, x1|
      regions[region2].each do |y2, x2|
        distance = (y2 - y1).abs + (x2 - x1).abs
        if distance < min_distance
          min_distance = distance
          nearest_points = [[y1, x1], [y2, x2]]
        end
      end
    end

    nearest_points
  end

  def connect_points(point1, point2)
    y1, x1 = point1
    y2, x2 = point2

    while y1 != y2 || x1 != x2
      if y1 < y2
        y1 += 1
      elsif y1 > y2
        y1 -= 1
      elsif x1 < x2
        x1 += 1
      elsif x1 > x2
        x1 -= 1
      end

      @grid[y1][x1].tile_path = true # Set the cell as a path
    end
  end

  def verify_connectivity
    start_point = find_start_point
    visited = flood_fill(start_point[0], start_point[1])

    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell.tile_path && !visited.include?([y, x])
          puts "Warning: Disconnected path found at (#{y}, #{x})"
        end
      end
    end
  end

  def find_start_point
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        return [y, x] if cell.tile_path
      end
    end
  end
end
