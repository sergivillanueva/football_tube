class PlayerParticipationDecorator < Draper::Decorator
  decorates_association :match
  
  def role
    object.role
  end
  
end