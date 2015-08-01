class PreviewImageGenerator
  @@matches_folder = "#{Rails.public_path}/cache/matches/"
  @@size = "640x360"

  @@mini_matches_folder = "#{Rails.public_path}/cache/matches/mini/"
  @@mini_size = "146x82"

  def initialize(match)
    @match = match
  end

  def generate_mini_preview_image
    image_path = path "mini"
    return image_path if File.exist? image_path
    return draw image_path, "mini"
  end

  def generate_preview_image
    image_path = path
    return image_path if File.exist? image_path
    return draw image_path
  end

  private

  def path version = "big"
    folder = version == "big" ? @@matches_folder : @@mini_matches_folder
    image_name = Digest::MD5.hexdigest "#{@match.home_team.name}#{@match.home_team.id}#{@match.away_team.name}#{@match.away_team.id}"
    image_path = "#{folder}#{image_name}.png"
    image_path
  end

  def draw image_path, version = "big"
    half_size = [@@size.split("x")[0].to_i / 2, @@size.split("x")[1]].join("x")

    home_team_logo = MiniMagick::Image.open "#{Rails.public_path}/#{@match.home_team.logo.medium.url}"
    away_team_logo = MiniMagick::Image.open "#{Rails.public_path}/#{@match.away_team.logo.medium.url}"

    # TODO refactor this code by adding new carrierwave logo version instead of these fucking team logo temp files

    home_team_path = "#{Rails.public_path}/cache/tmp/#{Digest::MD5.hexdigest @match.home_team.name}.png"
    img = MiniMagick::Image.new home_team_path
    img.run_command(:convert, "-size", half_size, "xc:transparent", img.path)
    img = img.composite(home_team_logo) do |c|
      c.compose "Over"
      c.gravity "Center"
    end
    img.write home_team_path

    away_team_path = "#{Rails.public_path}/cache/tmp/#{Digest::MD5.hexdigest @match.away_team.name}.png"
    img = MiniMagick::Image.new away_team_path
    img.run_command(:convert, "-size", half_size, "xc:transparent", img.path)
    img = img.composite(away_team_logo) do |c|
      c.compose "Over"
      c.gravity "Center"
    end
    img.write away_team_path

    img = MiniMagick::Image.new image_path
    img.run_command(:convert, "-size", @@size, "xc:transparent", img.path)
    img = img.composite(MiniMagick::Image.open Rails.root.join('app', 'assets', 'images', 'grass.png')) do |c|
      c.compose "Over"
      c.geometry "+0+0"
    end
    img = img.composite(MiniMagick::Image.open home_team_path) do |c|
      c.compose "Over"
      c.geometry "+0+0"
    end
    img = img.composite(MiniMagick::Image.open away_team_path) do |c|
      c.compose "Over"
      c.geometry "+320+0"
    end

    img.resize @@mini_size if version == "mini"

    img.write image_path
    img.path
  end
end
