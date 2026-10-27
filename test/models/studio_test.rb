require "test_helper"

class StudioTest < ActiveSupport::TestCase
  test "A studio cannot be saved without a name." do
    studio = Studio.new
    assert_not studio.save
  end

  test "Two studios cannot have the same name." do
    Studio.create!("name" => "Warner Bros.")
    duplicate = Studio.new("name" => "Warner Bros.")
    assert_not duplicate.save
  end

  test "I must be able to find all movies made by a studio." do
    studio = Studio.create!("name" => "Warner Bros.")
    movie = Movie.create!("title" => "Batman Begins", "year_released" => 2005,
                          "rated" => "PG-13", "studio_id" => studio["id"],
                          "director" => "Christopher Nolan")
    assert_equal [movie], Movie.where("studio_id" => studio["id"])
  end
end
