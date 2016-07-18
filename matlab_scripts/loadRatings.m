function [Y, R] = loadRatings()

run('importRatings.m')

num_users = 668;
num_movies = 10329;

Y = zeros(num_movies, num_users);

for i = 1:length(newratings)
    user = newratings(i, 1);
    movie = newratings(i, 2);
    rating = newratings(i, 3);
    Y(movie, user) = rating;
end

R = logical(Y);

save('movie_data.mat', 'R', 'Y', 'num_movies', 'num_users');

end