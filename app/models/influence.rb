class Influence < ActiveRecord::Base
  belongs_to :idea
  belongs_to :factor

  delegate :name, to: :factor
  delegate :is_negative, to: :factor
  delegate :calculate_influence, to: :idea

  after_save :calculate_influence
end
