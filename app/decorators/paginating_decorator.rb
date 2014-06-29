class PaginatingDecorator < Draper::CollectionDecorator
  # support for will_paginate
  delegate :current_page, :total_pages, :limit_value, :model_name, :total_count
end