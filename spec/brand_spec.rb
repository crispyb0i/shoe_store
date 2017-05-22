require('spec_helper')

describe(Brand) do

  it("capitalizes the brand names") do
    test_brand = Brand.create({:name => "hello kitty"})
    expect(test_brand.name()).to(eq("Hello Kitty"))
  end
end
