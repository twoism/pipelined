class PostObserver < ActiveRecord::Observer
  observe :post

  def after_create(record)
    Rails.logger.info "post_observer:after_create:#{record}"
  end
end
