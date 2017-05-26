class AddTeamIdToGoal < ActiveRecord::Migration
  def change
    add_reference :goals, :team, index: true

    # Destroy orphaned goals (fixed from now on)
    Goal.all.select{|a| !a.match.present?}.each do |g|
      g.destroy
    end

    puts "orphaned goals destroyed"

    # Assign teams
    Goal.all.each do |g|
      g.set_team_id
      g.save
    end
  end
end
