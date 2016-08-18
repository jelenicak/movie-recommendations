function movieList = loadMovies()

  %% Read the fixed movieulary list
  % fid = fopen('movie_ids.txt');
  fid = fopen('movies.txt');

  % Store all movies in cell array movie{}
  n = 10329;  % Total number of movies

  movieList = cell(n, 1);
  for i = 1:n
      % Read line
      line = fgets(fid);
      % Word Index (can ignore since it will be = i)
      [idx, movieName] = strtok(line, ' ');
      % Actual Word
      movieList{i} = strtrim(movieName);
  end
  fclose(fid);

end
