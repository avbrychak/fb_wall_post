class Event < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :runner_id
  after_create :make_fb_post

  def make_fb_post
    user.facebook.put_wall_post('TEST', {:name => 'Test', :link => "https://www.youtube.com/watch?v=#{self.runner_id}"})
  end
end
