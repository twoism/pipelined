class PostObserver < ActiveRecord::Observer
  observe :post

  def after_create(record)
    BunnyClient.instance.publish("posts.sanitize", record.id)
    Rails.logger.info "post_observer:after_create:#{record}"
  end

end
