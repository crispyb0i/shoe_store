require('spec_helper')

describe(Store) do
  it("capitalizes the store names") do
    test_store = Store.create({:name => "test shoe store"})
    expect(test_store.name()).to(eq("Test Shoe Store"))
  end

  describe('#new_brands_add') do
    it('takes a list of brands and addsthem to a store') do
      test_store = create_test_store
      brand1 = Brand.create({name: "brand 1"})
      brand2 = Brand.create({name: "brand 2"})
      brand3 = Brand.create({name: "brand 3"})
      test_string = "#{brand1.name}, #{brand2.name}, #{brand3.name}"
      test_store.new_brands_add(test_string)
      expect(test_store.brands).to(eq([brand1, brand2, brand3]))
    end
  end
end
