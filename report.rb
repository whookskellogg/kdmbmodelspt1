Role.delete_all
Movie.delete_all
Actor.delete_all
Studio.delete_all

Studio.create!("name" => "Warner Bros.")
studio = Studio.find_by("name" => "Warner Bros.")

movie_details = [
  ["Batman Begins", 2005],
  ["The Dark Knight", 2008],
  ["The Dark Knight Rises", 2012]
]

movie_details.each do |title, year_released|
  Movie.create!("title" => title, "year_released" => year_released,
                "rated" => "PG-13", "studio_id" => studio["id"])
end

cast = {
  "Batman Begins" => [
    ["Christian Bale", "Bruce Wayne"],
    ["Michael Caine", "Alfred"],
    ["Liam Neeson", "Ra's Al Ghul"],
    ["Katie Holmes", "Rachel Dawes"],
    ["Gary Oldman", "Commissioner Gordon"]
  ],
  "The Dark Knight" => [
    ["Christian Bale", "Bruce Wayne"],
    ["Heath Ledger", "Joker"],
    ["Aaron Eckhart", "Harvey Dent"],
    ["Michael Caine", "Alfred"],
    ["Maggie Gyllenhaal", "Rachel Dawes"]
  ],
  "The Dark Knight Rises" => [
    ["Christian Bale", "Bruce Wayne"],
    ["Gary Oldman", "Commissioner Gordon"],
    ["Tom Hardy", "Bane"],
    ["Joseph Gordon-Levitt", "John Blake"],
    ["Anne Hathaway", "Selina Kyle"]
  ]
}

cast.each do |title, cast_members|
  movie = Movie.find_by("title" => title)
  cast_members.each do |actor_name, character_name|
    Actor.create!("name" => actor_name) unless Actor.find_by("name" => actor_name)
    actor = Actor.find_by("name" => actor_name)
    Role.create!("movie_id" => movie["id"], "actor_id" => actor["id"],
                 "character_name" => character_name)
  end
end

puts "Movies"
puts "======"
puts

movie_details.each do |title, year_released|
  movie = Movie.find_by("title" => title, "year_released" => year_released)
  movie_studio = Studio.find_by("id" => movie["studio_id"])
  puts "#{movie['title'].ljust(22)} #{movie['year_released'].to_s.ljust(14)} #{movie['rated'].ljust(6)} #{movie_studio['name']}"
end

puts
puts "Top Cast"
puts "========"
puts

movie_details.each do |title, year_released|
  movie = Movie.find_by("title" => title, "year_released" => year_released)
  Role.where("movie_id" => movie["id"]).each do |role|
    actor = Actor.find_by("id" => role["actor_id"])
    puts "#{movie['title'].ljust(22)} #{actor['name'].ljust(21)} #{role['character_name']}"
  end
end
