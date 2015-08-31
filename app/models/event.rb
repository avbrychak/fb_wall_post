class Event < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :runner_id
  after_create :make_fb_post

end
