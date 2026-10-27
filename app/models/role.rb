class Role < ApplicationRecord
  validates :character_name, presence: true
  validates :movie_id, presence: true
  validates :actor_id, presence: true
  validates :character_name, uniqueness: { scope: [:movie_id, :actor_id] }
  validate :movie_must_exist
  validate :actor_must_exist

  private

  def movie_must_exist
    return if self["movie_id"].nil? || Movie.where("id" => self["movie_id"]).exists?

    errors.add(:movie_id, "must refer to an existing movie")
  end

  def actor_must_exist
    return if self["actor_id"].nil? || Actor.where("id" => self["actor_id"]).exists?

    errors.add(:actor_id, "must refer to an existing actor")
  end
end
