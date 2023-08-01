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
      @product.valid?
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it 'returns invalid without a price' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        # price_cents: 1234,
        quantity: 10,
        category_id: @category.id
      )
      @product.valid?
      expect(@product.errors[:price]).to include("can't be blank")
    end

    it 'returns invalid without a quantity' do
      @category = Category.create(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: 1234,
        # quantity: 10,
        category_id: @category.id
      )
      @product.valid?
      expect(@product.errors[:quantity]).to include("can't be blank")
    end

    it 'returns invalid without a category' do
      @product = Product.new(
        name: 'Test Product',
        price_cents: 1234,
        quantity: 10,
        # category_id: @category.id
      )
      @product.valid?
      expect(@product.errors[:category]).to include("can't be blank")
    end
  end
end
