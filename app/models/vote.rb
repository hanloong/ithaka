class Vote < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user

  validates :idea, :user, presence: true
  validates :idea, uniqueness: { scope: :user,
                                 message: 'You can only vote an idea once' }
end
