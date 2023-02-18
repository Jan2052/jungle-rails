require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'all 4 fields save successfully' do
      category = Category.create(name: 'Test Category')
      product = Product.new(
        name: 'Test Product',
        price: 100,
        quantity: 10,
        category: category
      )
      expect(product.save).to be true
    end
    
    it 'fails to save without a name' do
      category = Category.create(name: 'Flowers')
      product = Product.new(
        name: nil,
        price: 25,
        quantity: 20,
        category: category
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    
    it 'fails to save without a quantity' do
      category = Category.create(name: 'Flowers')
      product = Product.new(
        name: 'Testing',
        price: 25,
        quantity: nil,
        category: category
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it 'fails to save without a category' do
      product = Product.new(
        name: 'Testing',
        price: 25,
        quantity: 20,
        category: nil
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Category can't be blank")
      expect(product.errors.full_messages).to include("Category must exist")
    end

    it 'fails to save without a price' do
      category = Category.create(name: 'Flowers')
      product = Product.new(
        name: 'Testing',
        price: nil, #not sure how to check
        quantity: 20,
        category: category
      )
      expect(product.save).to be false #returns true
      expect(product.errors.full_messages).to include("Price must be greater than 0")
    end
  end
end