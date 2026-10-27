require "test_helper"

class ActorTest < ActiveSupport::TestCase
  test "An actor cannot be saved without a name." do
    actor = Actor.new
    assert_not actor.save
  end

  test "Two actors cannot have the same name." do
    Actor.create!("name" => "Christian Bale")
    duplicate = Actor.new("name" => "Christian Bale")
    assert_not duplicate.save
  end

  test "I must be able to find every movie an actor appears in." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"])
    actor = Actor.create!("name" => "Christian Bale")
    Role.create!("movie_id" => movie["id"], "actor_id" => actor["id"], "character_name" => "Bruce Wayne")
    role = Role.where("actor_id" => actor["id"]).first
    assert_equal [movie], Movie.where("id" => role["movie_id"])
  end
end
