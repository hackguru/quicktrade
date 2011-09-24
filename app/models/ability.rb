class Ability
  include CanCan::Ability
  
  def initialize(user)
   
   if user
     can :create, Order
     can :manage, Order do |order|
       order.try(:user) == user
     end
   else	
     can :read, Order
   end
  end
end
