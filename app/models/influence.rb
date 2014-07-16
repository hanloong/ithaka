class Influence < ActiveRecord::Base
  belongs_to :idea
  belongs_to :project
  belongs_to :factor

  delegate :name, to: :factor
  delegate :is_negative, to: :factor
  delegate :calculate_influence, to: :idea
  delegate :project, to: :idea
  delegate :manager?, to: :project
  after_save :calculate_influence

  scope :only_negative, -> { joins(:factor).where('factors.is_negative = true') }
  scope :only_positive, -> { joins(:factor).where('factors.is_negative = false') }

  def as_json(options={})
    super(only: [:id, :score], include: :factor)
  end
end
