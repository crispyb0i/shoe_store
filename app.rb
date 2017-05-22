require('pry')
require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @brands = Brand.all
  @stores = Store.all
  erb(:index)
end

get('/stores/') do
  @store = Store.find(params[:id])
  erb(:index)
end

get('/stores/new') do
  erb(:store_form)
end

post('/stores') do
  store_name = params.fetch('store_name')
  brand_name = params.fetch('brand_names')
  brand_price = params.fetch('price')

  new_store = Store.create({name: store_name})
    if Brand.find_by(name: brand_name).nil?
      new_store.brands.create(name: brand_name, price: brand_price)
    else
      new_store.brands.push(brand_name)
    end
  redirect("/stores/#{new_store.id}")
end

get('/stores/:id') do
  @store = Store.find(params[:id])
  @brands = @store.brands
  erb(:stores)
end

patch('/stores/:id') do
  id = params[:id]
  store = Store.find(id)
  store_name = params.fetch('store_name')
  brand_names = params.fetch('brand_names')
  @brands = Brand.all()
  @store = Store.find(params.fetch("id").to_i)
  @store.update({name: store_name})
  @store.brands.delete_all
  @store.brands.update({name: brand_names})
  @store.new_brands_add(brand_names)

  redirect("/stores/#{id}")
end

delete('/stores/:id') do
  id = params[:id]
  store = Store.find(id)

  store.brands.delete
  store.destroy

  redirect('/')
end

get('/stores/:id/edit') do
  @store = Store.find(params[:id])

  store_brand = @store.brands
  @brands = []
  store_brand.each() do |brand|
    @brands.push(brand.name)
  end
  @brands = @brands.join(', ')
  erb(:store_edit)
end

get('/brands/new') do
  erb(:brand_form)
end

post('/brands') do
  brand_name = params.fetch('brand_name')
  brand_price = params.fetch('brand_price')
  brand = Brand.create({name: brand_name, price: brand_price})
  redirect("/")
end

get('/brands/:id') do
  @brand = Brand.find(params[:id])
  @stores = @brand.stores
  erb(:brands)
end

patch('/brands/:id') do
  @brand = Brand.find(params[:id])
  @stores = @brand.stores
  price = params.fetch('brand_price')
  @brand.update({price: price})
  erb(:brands)
end
