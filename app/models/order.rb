class Order < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :buckets

  def <=>(another_order)

    raise ArgumentError, 'Only compare sell orders with sell and buy orders with buy!' unless (another_order.isSell == self.isSell) 

    if (self.isSell)
      if self.price > another_order.price
        -1
      elsif self.price < another_order.price
        1
      elsif self.created_at < another_order.created_at
        -1
      elsif self.created_at > another_order.created_at
        1
      else
        0
      end
    else
      if self.price < another_order.price
        -1
      elsif self.price > another_order.price
        1
      elsif self.created_at < another_order.created_at
        -1
      elsif self.created_at > another_order.created_at
        1
      else
        0
      end
    end
  end

end
