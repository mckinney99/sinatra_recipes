class Recipe < ActiveRecord::Base
	include Slugifiable::InstanceMethods
	extend Slugifiable::ClassMethods
	
	belongs_to :user

	

  def self.find_by_slug(slug)
    Recipe.all.find do |recipe|
      recipe.slug == slug
end
end
end