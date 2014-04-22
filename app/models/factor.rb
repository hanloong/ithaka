class Factor < ActiveRecord::Base
  belongs_to :area
  belongs_to :project

  has_many :influence, dependent: :destroy

  after_create :setup_factor

  def setup_factor
    Idea.all.each do |i|
      Influence.create(idea: i, factor: self, score: 0)
    end
  end
end
