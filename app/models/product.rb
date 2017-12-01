class Product < ApplicationRecord
  
  validates :name, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}

  belongs_to :supplier
  # def supplier
  #   Supplier.find_by(id: self.supplier_id)
  # end

  has_many :images
  # def images
  #   Image.where(product_id: self.id)
  # 
  has_many :orders
  has_many :category_products
  has_many :categories, through: :category_products



  def in_stock
    true
  end 
  

  def is_discounted
    if price < 50 
      return true
    else
      return false
    end 
  end 

  def tax
    tax = price * 0.09
    return tax.round(2)
  end

  def total
    price + tax
  end

  def as_json
    {
      id: id,
      name: name,
      
      description: description,
      price: price,
      is_discounted: is_discounted,
      tax: tax,
      total: total,
      in_stock: in_stock,
      supplier: supplier.as_json,
      created_at: created_at,
      updated_at: updated_at,
      categories: categories.as_json
    }
  end 

end
