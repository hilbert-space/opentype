module CommonHelper
  def timestamp
    @timestamp ||= Time.now.to_i.to_s
  end
end
