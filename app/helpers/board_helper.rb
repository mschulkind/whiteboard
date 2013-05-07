module BoardHelper
  def board_json
    {
      lines: @board.lines.map do |line|
        {
          points: line.points.map do |point|
            {x: point.x, y: point.y}
          end
        }
      end
    }.to_json.html_safe
  end
end
