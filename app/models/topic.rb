class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
    # scope :visible_to, -> { where(public: true) }
    scope :visible_to, -> (user) { user ? all : where(public: true) } 

    scope :publicly_viewable,  -> {where(public: true)}
    scope :privately_viewable, -> {where(public: false)}



    # def self.publicly_viewable
    #   Topic.where(public: true)
    # end
end
