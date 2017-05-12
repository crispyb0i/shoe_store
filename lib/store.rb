require 'pry'

class Store < ActiveRecord::Base
  has_and_belongs_to_many(:brands)

  validates(:name, :uniqueness => {case_sensitive: false}, :presence => true, :length => {:maximum => 100})

  before_save(:capitalize)

  def new_brands_add (brand)
    brands= brand.split(',')
    brands.each do |brand|
      brand_match = Brand.find_by(name: brand)
      if Brand.find_by(name: brand).nil?
        self.brands.create(name: brand)
      else
        self.brands.push(brand_match)
       end
    end
  end


  private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end
