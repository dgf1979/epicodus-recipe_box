class Category < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  validates :name, presence: true, uniqueness: true
  before_validation(:upcase_name)

  private

  define_method(:upcase_name) do
    self.name = name.upcase
  end

end
