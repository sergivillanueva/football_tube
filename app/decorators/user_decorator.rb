class UserDecorator < ApplicationDecorator
  def name
    return object.nick_name if object.nick_name.present?
    "Footballia user"
  end

  def unique_name
    return object.nick_name if object.nick_name.present?
    "Footballia user ##{object.created_at.to_i}"
  end
end
