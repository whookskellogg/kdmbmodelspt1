class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :year_released }
  validates :year_released, presence: true
  validates :rated, presence: true
  validates :studio_id, presence: true
  validate :studio_must_exist

  private

  def studio_must_exist
    return if self["studio_id"].nil? || Studio.where("id" => self["studio_id"]).exists?

    errors.add(:studio_id, "must refer to an existing studio")
  end
end
