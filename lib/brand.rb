class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:stores)

    validates(:name, :uniqueness => {case_sensitive: false}, :presence => true, :length => {:maximum => 100})

  before_save(:capitalize)

  private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end
