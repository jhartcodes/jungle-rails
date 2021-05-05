require 'rails_helper'

RSpec.feature "Clicking products navigates to product page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Can navigate to product:ID on click" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    click_link('Details', match: :first)
    sleep 1
    puts page.html
    save_screenshot
    expect(page).to have_text 'Description'
  end

end