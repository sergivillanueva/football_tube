class AddFirstLegAndSecondLegAndReplayToMatch < ActiveRecord::Migration
  def change
    add_reference :matches, :first_leg, index: true
    add_reference :matches, :second_leg, index: true
    add_reference :matches, :replay, index: true
  end
end
