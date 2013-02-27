class Page < ActiveRecord::Base
  attr_accessible :subject_id, :name, :permalink, :position, :visible
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

end
