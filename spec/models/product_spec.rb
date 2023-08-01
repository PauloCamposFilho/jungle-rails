require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'returns valid when all required attributes are present' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: 1234,
        quantity: 10,
        category_id: @category.id
      )
      expect(@product).to be_valid
    end

    it 'returns invalid without a name' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(
        # name: 'Test Product',
        price_cents: 1234,
        quantity: 10,
        category_id: @category.id
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'returns invalid without a price' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        # price_cents: 1234,
        quantity: 10,
        category_id: @category.id
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include(
        "Price cents is not a number",
        "Price is not a number",
        "Price can't be blank"
      )
    end

    it 'returns invalid without a quantity' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: 1234,
        # quantity: 10,
        category_id: @category.id
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'returns invalid without a category' do
      @product = Product.new(
        name: 'Test Product',
        price_cents: 1234,
        quantity: 10,
        # category_id: @category.id
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include(
        "Category must exist",
        "Category can't be blank"
      )
    end
  end
end
