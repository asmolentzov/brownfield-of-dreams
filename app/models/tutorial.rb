class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :thumbnail

  def self.bookmarked(user)
    Tutorial.includes(videos: :user_videos)
            .where(user_videos: {user_id: user})
            .order("videos.position")
  end
end
