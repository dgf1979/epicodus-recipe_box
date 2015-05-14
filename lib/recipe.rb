class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :ingredients
  validates :name, presence: true, uniqueness: true
  validates :rating, :inclusion => { :in => 0..5 }
  before_validation(:capitalize_name)
  before_validation(:check_rating)
private

   define_method(:capitalize_name) do
     words = self.name.split(" ")
     words.each do |word|
       word.capitalize!
     end
     self.name = words.join(" ")
   end

   define_method(:check_rating) do
     if self.rating == nil || self.rating < 0 || self.rating > 5
       self.rating = 0
     end
   end
end
