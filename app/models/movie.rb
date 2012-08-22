class Movie < ActiveRecord::Base
  attr_accessible :title
  has_and_belongs_to_many :actors
  # accepts_nested_attributes_for :actors

  validates_presence_of :title
  validates_uniqueness_of :title
    
  def self.from_xml(xml_data)
    Nokogiri::XML.parse(xml_data).root.children.each do |movie_node|
      next if movie_node.name == 'text'
      m = Movie.find_or_initialize_by_title(movie_node.attributes["title"].to_s)
      movie_node.children.each do |actor_node|
        next if actor_node.name == 'text'
        a = Actor.find_or_initialize_by_name(actor_node.attributes["name"].to_s)
        m.actors << a unless m.actors.include?(a)
        a.save
      end
      m.save
    end
  end  
end
