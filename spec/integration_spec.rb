require 'spec_helper'

feature "Add a store" do
  scenario "It will add a store to the list of stores" do
    visit('/')
    click_link 'Add a New Store'
    fill_in 'store_name', with: 'Test Store'
    click_button 'Submit'
    expect(page).to have_content('Test Store')
  end
end
