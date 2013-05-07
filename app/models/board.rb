class Board
  include Mongoid::Document
  embeds_many :lines
end
