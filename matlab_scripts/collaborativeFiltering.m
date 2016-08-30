fprintf('Loading movie ratings dataset.\n\n');

%  Load data
load ('movie_data.mat');

fprintf('Average rating for movie 1 (Toy Story): %f / 5\n\n', ...
        mean(Y(1, R(1, :))));

fprintf('Total number of ratings in the dataset: %d \n\n', ...
    sum(R(:)));

fprintf('The dataset is populated: %f percent \n\n', ...
    sum(R(:)) / (num_movies * num_users));

fprintf('On average, each user rated %f movies \n\n', ...
    mean(sum(R)));

%  Visualizing the ratings matrix by plotting it with imagesc
imagesc(Y);
ylabel('Movies');
xlabel('Users');
colorbar;


% Load movie list
movieList = loadMovies();

% Insert some of my own ratings based on movie indices in the list
my_ratings = zeros(10329, 1);

my_ratings(10077) = 4.5; % Nightcrawler
my_ratings(5727) = 4; % Before Sunset
my_ratings(8629) = 5; % Despicable Me
my_ratings(10256)= 5; % Inside Out
my_ratings(9225) = 4; % Hunger Games
my_ratings(9838)= 4.5; % Hunger Games: Catching Fire
my_ratings(9855)= 5; % Her
my_ratings(2378) = 5; % Crimes and Misdemeanors
my_ratings(8422)= 5; % Shutter Island
my_ratings(10267)= 4.5; % Black Mass
my_ratings(10090)= 4.5; % The Imitation Game

my_ratings(9971)= 3; % Maleficent
my_ratings(8630)= 3; % Inception
my_ratings(10284)= 3; % The Revenant
my_ratings(8630)= 3; % Inception

my_ratings(9915) = 1; % Interstellar
my_ratings(5619) = 2; % The Day After Tomorrow
my_ratings(7542) = 2; % No Country for Old Men
my_ratings(7820) = 2; % Pineapple Express
my_ratings(5682) = 2; % The Notebook
my_ratings(8805) = 2; % Tron: Legacy
my_ratings(9780) = 2; % Gravity
my_ratings(10138) = 1; % Kingsman: Secret Service

fprintf('\n\nNew user ratings:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0
        fprintf('Rated %0.1f for %s\n', my_ratings(i), ...
                 movieList{i});
    end
end

Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];

%  Normalize Ratings
[Ynorm, Ymean] = normalizeRatings(Y, R);

%  Useful Values
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 50;

fprintf('\nTraining collaborative filtering...\n');

% Set Initial Parameters (Theta, X)
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% Set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 150);

% Set Regularization
lambda = 1;
theta = fmincg (@(t)(costFunction(t, Ynorm, R, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and W
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');


p = X * Theta';
my_predictions = p(:,1) + Ymean;

[r, ix] = sort(my_predictions, 'descend');
fprintf('\nTop recommendations for you:\n');
for i=1:30
    j = ix(i);
    fprintf('Predicting rating %.1f for movie %s\n', my_predictions(j), ...
            movieList{j});
end
