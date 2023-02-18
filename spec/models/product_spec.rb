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
    
    
  end
end