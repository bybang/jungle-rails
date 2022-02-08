require 'rails_helper'

RSpec.feature 'Visitor click the add to cart button', type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |_n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They see My Cart(0) on the top nav bar count goes up' do
    visit root_path
    click_on('Add', match: :first)

    expect(page).to have_text('My Cart (1)')

    save_screenshot
  end
end
