class Post < ActiveRecord::Base

  def sanitize!
    self.sanitized_at = DateTime.now
    save!
  end

  def process!
    self.processed_at = DateTime.now
    save!
  end

  def autopost!
    self.autoposted_at = DateTime.now
    save!
  end
end
