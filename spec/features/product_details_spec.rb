require 'rails_helper'

RSpec.feature 'Visitor navigates to product detail page', type: :feature, js: true do
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
  scenario 'User click the product and see detail page' do
    visit root_path
    first('.product-image').click

    expect(page).to have_css 'article.product-detail'
    expect(page).to have_content('Description')
    expect(page).to have_content('Quantity')

    # DEBUG / VERIFY
    save_and_open_screenshot
  end
end
