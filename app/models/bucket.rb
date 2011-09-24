class Bucket < ActiveRecord::Base

  has_and_belongs_to_many :orders

  #matching logic goes in here
  def match

    #list all of the sell orders in the bucket in order of price (lowest first)  and when equal time they enetered the system (oldest first)
    #list all the buy orders in the bucket in order of price (highest first) and when equal time they entered the system (oldest first)

    #first putting all orders in their respective arrays
    sellOrders = []
    buyOrders = []
    self.orders.each { |o|
      if o.isSell
	sellOrders.push o
      else
        buyOrders.push o
      end
    }

    #now we should sort the arrays
    #or should we? cause we dont need the completely sort the array we just need max of each??
    #buyOrders.sort!
    #sellOrders.sort!

    #getting the best sell and buy order in the bucket
    bestSell = sellOrders.max
    bestBuy  = buyOrders.max

    #setting the gap for the bucket
    currentGap = 0
    if bestSell.price > bestBuy.price
      currentGap = bestSell.price - bestBuy.price
    end

    if currentGap != self.gap
      puts "Before Gap: "+self.gap.to_s+" | current gap: "+currentGap.to_s
      self.gap = currentGap
      self.save
      #match each sell order with the top on the list of buy orders and each buy order with top on the list of sell orders and send notifications
      #we only want to inform others if the gap has changed we also want to inform the new user of the gap or not we only want to inform him if he changed the gap
      buyOrders.each { |o|
        o.user.new_gap(currentGap,o,bestSell)
      }

      sellOrders.each { |o|
        o.user.new_gap(currentGap,o,bestBuy)
      }

    end   

  end

  #tradeShouldHappen methiod to remove the orders that just confirmed to exchange
  #two orders should be passed as parameter
    
end
