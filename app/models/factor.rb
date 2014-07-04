class Factor < ActiveRecord::Base
  belongs_to :area
  belongs_to :project

  has_many :influence, dependent: :destroy
  has_many :ideas, through: :project

  after_create :setup_factor

  default_scope -> { order(:name) }

  def setup_factor
    ideas.each do |i|
      Influence.create(idea: i, factor: self, score: 0)
    end
  end
end
