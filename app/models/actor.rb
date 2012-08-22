require 'degrees_of_separation'

class Actor < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :movies

  validates_presence_of :name
  validates_uniqueness_of :name
  
  def degrees_separated_from(other)
    g = Graph.new
    Actor.all.each do |actor|
      g.push actor
    end
    Movie.all.each do |movie|
      movie.actors.each_cons(2) do |ac|
        g.connect_both ac[0], ac[1]
      end
    end
    return g.degrees_of_separation(self, other)
  end
end
