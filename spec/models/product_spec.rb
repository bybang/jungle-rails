require 'rails_helper'
require 'product'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save successfully when fields are set' do
      @category = Category.new(name: 'Electronics')
      @product = Product.new(
        name: Faker::Device.model_name,
        description: Faker::Hipster.paragraph(4),
        quantity: 3,
        price: 987.65,
        category: @category
      )
      @product.save!

      expect(Product.find(@product)).to be_present
    end
    it 'should give an error when name does not exist' do
      @category = Category.new(name: 'Electronics')
      @product = Product.new(
        name: nil,
        description: Faker::Hipster.paragraph(4),
        quantity: 3,
        price: 987.65,
        category: @category
      )
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'should give an error when price does not exist' do
      @category = Category.new(name: 'Electronics')
      @product = Product.new(
        name: Faker::Device.model_name,
        description: Faker::Hipster.paragraph(4),
        quantity: 3,
        price: nil,
        price_cents: nil,
        category: @category
      )
      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'should give an error when quantity does not exist' do
      @category = Category.new(name: 'Electronics')
      @product = Product.new(
        name: Faker::Device.model_name,
        description: Faker::Hipster.paragraph(4),
        quantity: nil,
        price: 987.65,
        category: @category
      )
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should give an error when category does not exist' do
      @category = Category.new(name: 'Electronics')
      @product = Product.new(
        name: Faker::Device.model_name,
        description: Faker::Hipster.paragraph(4),
        quantity: 3,
        price: 987.65,
        category: nil
      )
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
