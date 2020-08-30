class Tweet < ApplicationRecord
  validates :content, presence: true


  belongs_to :user
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user

  # paginates_per 50
  paginates_per 6

  scope :tweets_for_me, -> (user){where(user_id: user.arr_friends_id)}


  def is_liked?(user)
    if self.liking_users.include?(user)
      true
    else
      false
    end
  end

  def remove_like(user)
    Like.where(user: user, tweet: self).first.destroy
  end

  def add_like(user)
    Like.create(user: user, tweet: self)
  end

  def like_icon(user)
    if is_liked?(user)
      'fas fa-heart'
    else
      'far fa-heart'
    end
  end

  def count_rt
    Tweet.where(rt_ref: self.id).count

  end

  def is_retweet?
    rt_ref ? true : false

  end

  def tweet_ref
    Tweet.find(self.rt_ref)

  end
end
