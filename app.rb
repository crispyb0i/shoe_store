require('pry')
require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @brands = Brand.all
  @stores = Store.all
  erb(:index)
end

get('stores') do
  @store = Store.find(params[:id])
end

get('/stores/new') do
  erb(:store_form)
end

post('/stores') do
  store_name = params[:store_name]
  @store = Store.create(:name => store_name)
  @brands = Brand.all
  erb(:stores)
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
  @brands = Brand.all()
  @store = Store.find(params.fetch("id").to_i)
  @store.update({name: store_name})

  redirect("/stores/#{id}")
end

delete('/stores/:id') do
  id = params[:id]
  store = Store.find(id)

  store.brands.delete_all
  store.destroy

  redirect('/')
end

get('/stores/:id/edit') do
  @store = Store.find(params[:id])
  @brands = @store.brands

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
  brand = Brand.create({name: brand_name})

  redirect("/")
end
