class Vote < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user

  validates_presence_of :idea, :user
  validates_uniqueness_of :idea, scope: :user,
                                 message: 'You can only vote an idea once'
end
