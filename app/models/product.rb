class Product < ApplicationRecord
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	
	private 
		def ensure_not_referenced_by_any_line_item
		    unless line_items.empty?
		      errors.add(:base, 'line Items present')
		      throw :abort
		end
	end	
	
	validates :title, :description, :image_url, presence: true
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
								with:    %r{\.(gif|jpg|png)\Z}i,
								message: 'must be gif, jpg or png image.'
							   }
        validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
