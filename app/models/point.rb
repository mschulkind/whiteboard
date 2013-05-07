class Point
  include Mongoid::Document
  embedded_in :line
end
