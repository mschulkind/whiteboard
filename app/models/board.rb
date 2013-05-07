class Board
  include Mongoid::Document
  embeds_many :lines
  
  def as_json(options={})
    {
      lines: lines.map do |line|
        {
          points: line.points.map do |point|
            {x: point.x, y: point.y}
          end
        }
      end
    }
  end
end
