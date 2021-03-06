class Subject < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :created_at
  
  has_many :pages

  validates_presence_of :name 
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :search, lambda {|query| where(["name LIKE?","%#{query}%"])}
end
