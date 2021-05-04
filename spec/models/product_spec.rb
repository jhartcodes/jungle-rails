require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'Can save a new product successfully' do
      it 'after saving, the new product should exist in db' do
        @category = Category.create(name:'testCategory')
        @product = Product.create(name: 'testProduct', description: 'desc', category_id:Category.find_by(name: 'testCategory').id, quantity: 2, image: '#', price: 3000)
        expect(Product.find_by(name: 'testProduct').name).to eq 'testProduct'
      end
    end
    it "should return an error message 'Name can't be blank' if name is nil" do
      @category = Category.create(name:'testCategory')
      @product = Product.create(name: nil, description: 'desc', category_id:Category.find_by(name: 'testCategory').id, quantity: 2, image: '#', price: 3000)
      expect(@product.errors.full_messages[0]).to eq "Name can't be blank"
    end
    it "should return 'Price can't be blank' and 'Price cents is not a number' if theres no price" do
      @category = Category.create(name:'testCategory')
      @product = Product.create(name: 'testProduct', description: 'desc', category_id:Category.find_by(name: 'testCategory').id, quantity: 2, image: '#', price: nil)
      expect(@product.errors.full_messages[0]).to eq "Price cents is not a number"
      expect(@product.errors.full_messages[1]).to eq "Price is not a number"
      expect(@product.errors.full_messages[2]).to eq "Price can't be blank"
    end
    it "should return 'Quantity can't be blank' if theres no quantity" do
      @category = Category.create(name:'testCategory')
      @product = Product.create(name: 'testProduct', description: 'desc', category_id:Category.find_by(name: 'testCategory').id, quantity: nil, image: '#', price: 3000)
      expect(@product.errors.full_messages[0]).to eq "Quantity can't be blank"
    end
    it "should return 'Category can't be blank' if theres no Category" do
      @category = Category.create(name:'testCategory')
      @product = Product.create(name: 'testProduct', description: 'desc', category_id: nil, quantity: 2, image: '#', price: 3000)
      expect(@product.errors.full_messages[0]).to eq "Category can't be blank"
    end
  end
end  




