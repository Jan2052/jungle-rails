require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'all 4 fields save sucessfully' do
    category = Category.create(name: 'Flowers')
    product = Product.new(
      name: 'Testing',
      price: 25,
      quantity: 20,
      category: category
    )
    expect(product.save).to be true
  end









  
end

#validates :name , prescence: true
#validates :price , prescence: true
#validates :quantity , prescence: true
#validates :category , prescence: true