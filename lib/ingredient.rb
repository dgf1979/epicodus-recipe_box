class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  validates :name, presence: true, uniqueness: true
  before_validation(:downcase_name)

private

  define_method(:downcase_name) do
    self.name = name.downcase
  end  
end
