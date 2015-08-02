class PlayerDecorator < Draper::Decorator
  decorates_association :country
  
  def name
    object.name
  end
  
  def full_name
    object.full_name
  end
  
end