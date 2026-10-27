require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "A movie cannot be saved without a title." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.new("year_released" => 2005, "rated" => "PG-13", "studio_id" => studio["id"],
                      "director" => "Christopher Nolan")
    assert_not movie.save
  end

  test "A movie cannot be saved without a release year." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.new("title" => "Batman Begins", "rated" => "PG-13", "studio_id" => studio["id"],
                      "director" => "Christopher Nolan")
    assert_not movie.save
  end

  test "A movie cannot be saved without a rating." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.new("title" => "Batman Begins", "year_released" => 2005, "studio_id" => studio["id"],
                      "director" => "Christopher Nolan")
    assert_not movie.save
  end

  test "A movie must be linked to an existing studio." do
    missing_studio_id = Studio.maximum("id").to_i + 1
    movie = Movie.new("title" => "Batman Begins", "year_released" => 2005,
                      "rated" => "PG-13", "studio_id" => missing_studio_id,
                      "director" => "Christopher Nolan")
    assert_not movie.save
  end

  test "Two movies cannot have the same title and release year." do
    studio = Studio.create!("name" => "Warner Bros.")
    Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                  "rated" => "PG-13", "studio_id" => studio["id"],
                  "director" => "Christopher Nolan")
    duplicate = Movie.new("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"],
                          "director" => "Christopher Nolan")
    assert_not duplicate.save
  end

  test "I must be able to find a movie's studio." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"],
                          "director" => "Christopher Nolan")
    assert_equal studio, Studio.find_by("id" => movie["studio_id"])
  end

  test "I must be able to find every cast member's name and the character they play in a movie." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"],
                          "director" => "Christopher Nolan")
    actor = Actor.create!("name" => "Christian Bale")
    Role.create!("movie_id" => movie["id"], "actor_id" => actor["id"], "character_name" => "Bruce Wayne")
    role = Role.where("movie_id" => movie["id"]).first
    assert_equal [ ["Christian Bale", "Bruce Wayne"] ],
                 [[Actor.find_by("id" => role["actor_id"])["name"], role["character_name"]]]
  end

  test "A movie cannot be saved without a director." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.new("title" => "Batman Begins", "year_released" => 2005,
                      "rated" => "PG-13", "studio_id" => studio["id"])
    assert_not movie.save
  end

  test "Given a movie, I can find the name of its director." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"],
                          "director" => "Christopher Nolan")
    assert_equal "Christopher Nolan", movie["director"]
  end
end
