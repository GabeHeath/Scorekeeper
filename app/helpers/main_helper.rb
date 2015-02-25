module MainHelper


  def calculate_plays(date)
    return Play.where("date = ?", date).count
  end
end

