require "test_helper"

class RoleTest < ActiveSupport::TestCase
  test "A role must be linked to an existing movie." do
    actor = Actor.create!("name" => "Christian Bale")
    missing_movie_id = Movie.maximum("id").to_i + 1
    role = Role.new("movie_id" => missing_movie_id, "actor_id" => actor["id"], "character_name" => "Bruce Wayne")
    assert_not role.save
  end

  test "A role must be linked to an existing actor." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"])
    missing_actor_id = Actor.maximum("id").to_i + 1
    role = Role.new("movie_id" => movie["id"], "actor_id" => missing_actor_id, "character_name" => "Bruce Wayne")
    assert_not role.save
  end

  test "A role cannot be saved without a character name." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"])
    actor = Actor.create!("name" => "Christian Bale")
    role = Role.new("movie_id" => movie["id"], "actor_id" => actor["id"])
    assert_not role.save
  end

  test "Two roles cannot have the same movie, actor, and character name." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"])
    actor = Actor.create!("name" => "Christian Bale")
    attributes = { "movie_id" => movie["id"], "actor_id" => actor["id"], "character_name" => "Bruce Wayne" }
    Role.create!(attributes)
    duplicate = Role.new(attributes)
    assert_not duplicate.save
  end

  test "I must be able to find a role's actor." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"])
    actor = Actor.create!("name" => "Christian Bale")
    role = Role.create!("movie_id" => movie["id"], "actor_id" => actor["id"], "character_name" => "Bruce Wayne")
    assert_equal actor, Actor.find_by("id" => role["actor_id"])
  end

  test "I must be able to find a role's movie." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"])
    actor = Actor.create!("name" => "Christian Bale")
    role = Role.create!("movie_id" => movie["id"], "actor_id" => actor["id"], "character_name" => "Bruce Wayne")
    assert_equal movie, Movie.find_by("id" => role["movie_id"])
  end
end
