class GoalTrimmer

  def initialize(goal)
    @goal = goal
  end

  def output_file
    "/tmp/#{@goal.player.full_name.parameterize}-#{@goal.id}.mp4"
  end

  def start_time
    @goal.video_start_position
  end

  def end_time
    @goal.video_end_position
  end

  def input_file
    @goal.video.source_file.url
  end

  def generate_source_file
    movie = FFMPEG::Movie.new(File.join(Rails.root.join('public'), input_file))
    movie.transcode(output_file, "-vcodec libx264 -acodec aac -ss #{start_time} -to #{end_time} -strict experimental")
    return output_file
  end

  def remove_tmp_file
    File.delete(output_file) if File.exist?(output_file)
  end
end
