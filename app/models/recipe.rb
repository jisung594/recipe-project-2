class Recipe < ApplicationRecord
  def category_title=(title)
     self.category = Category.find_or_create_by(title: title)
   end

   def category_title
      self.category ? self.category.title : nil
end

    belongs_to :category, optional: true
    belongs_to :user
    has_many :ingredients, dependent: :destroy
    has_many :directions, dependent: :destroy
    accepts_nested_attributes_for :ingredients,
                                  allow_destroy: true,
                                  reject_if: proc { |attributes| attributes['name'].blank? }


    accepts_nested_attributes_for :directions,
                                  allow_destroy: true,
                                  reject_if: proc { |attributes| attributes['step'].blank? }
    # accepts_nested_attributes_for :categories,
    #                               allow_destroy: true,
    #                               reject_if: proc { |attributes| attributes['title'].blank? }


    validates :title, :description, :image, presence: true

    has_attached_file :image, styles: { medium: "400x400#"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  end
