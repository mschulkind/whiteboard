class Line
  include Mongoid::Document
  embedded_in :board
  embeds_many :points
  field :uuid
end
