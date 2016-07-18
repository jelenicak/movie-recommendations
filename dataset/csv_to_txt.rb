require "csv"

movies = {}

CSV.foreach("movies.csv") do |row|
  id = row[0].to_i
  name = row[1]

  movies[id] = name
end
movies.delete(0)

ratings = {}

CSV.foreach("ratings.csv") do |row|
  id = row[1].to_i
  rating = [row[0].to_i, row[2].to_f]
  ratings[id] = [] if ratings[id].nil?
  ratings[id] << rating
end

new_ratings = []
new_movies = []

movies.each_with_index do |(key, value), index|
  new_id = index + 1
  new_movies << "#{new_id} #{value}"
  movie_ratings = ratings[key]
  unless movie_ratings.nil?
    movie_ratings.map! { |r| [r[0], new_id, r[1]] }
    new_ratings.push(*movie_ratings)
  end
end

puts new_ratings.sort_by { |r| r[0] }[0..50].inspect

puts new_movies[0..50].inspect

puts "movies #{movies.count}"
puts "new movies #{new_movies.count}"
puts "ratings #{ratings.count}"
puts "new ratings #{new_ratings.count}"

output_movies = File.open("movies.txt", "w")
output_movies.write(new_movies.join("\n"))
output_movies.close

new_ratings = new_ratings.sort_by { |r| r[0] }
CSV.open("new_ratings.csv", "w") do |csv|
  new_ratings.each do |r|
    csv << r
  end
end

