class UserDecorator < ApplicationDecorator
  def name
    object.nick_name || "Footballia user"
  end

  def unique_name
    object.nick_name || "Footballia user ##{object.created_at.to_i}"
  end
end
