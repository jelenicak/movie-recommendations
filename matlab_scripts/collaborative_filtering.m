fprintf('Loading movie ratings dataset.\n\n');

%  Load data
load ('movie_data.mat');

disp(R(1:100, 1:100));

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