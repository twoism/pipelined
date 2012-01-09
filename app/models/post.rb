class Post < ActiveRecord::Base

  def sanitize!
    sanitized_at = DateTime.now
    save!
  end

  def process!
    processed_at = DateTime.now
    save!
  end

  def autopost!
    autoposted_at = DateTime.now
    save!
  end
end
