module Tools
  def self.destroy_orphaned_goals
    Goal.all.select{|a| !a.match.present?}.each do |g|
      g.destroy
    end
  end

  def self.assign_teams_to_goals
    # It will assign competition too on save
    Goal.all.each do |g|
      g.set_team_id
      g.save
    end
  end

  def self.trim_goals
    Goal.where(source_file: nil).where.not(video_start_position: nil, video_end_position: nil, video_id: nil).each do |v|
      v.set_source_file
      v.save
    end
  end
end

