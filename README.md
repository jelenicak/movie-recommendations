# Movie Recommendations

This repository contains collaborative filtering recommendation algorithm
written in Matlab applied to the [small MovieLens
dataset](http://grouplens.org/datasets/movielens/latest/).


### MovieLens Dataset
I decided I want to use the MovieLens dataset, because it contains all the
latest movies and I wanted to try it out myself. The dataset has been tidied up -
I have generated new movie IDs to remove gaps and updated the corresponding
ratings so I can use them in Matlab more easily.

- number of users: 668
- number of movies: 10.329
- number of ratings: 105.339
- each user rated 158 movies on average

I have used some of the existing code from Coursera Machine Learning course,
mostly for calculating the cost function.

### Parameters
What I learned is that tweaking the following parameters influences the value of
the cost function:

- number of features: larger values prevent underfitting
- regularization: larger values prevent overfitting

The number of features the model will learn affect how much information it will
gather from the dataset. I have tried using from 30 to 60 features on a model.
Using 50 features to train the model happened to be the best fit.

When choosing regularization parameter lambda, smaller values can lead to
overfitting or high variance. That is the case when a model has a very low cost
function value, but fails to generalize well. I have tried lambda values from 0.3
to 3.0 and using 1.0 was the best fit.

### Testing?
I evaluated my recommendations by inserting some of the movies I've watched and
providing ratings for them in the `collaborativeFiltering.m` script. As a result,
the model predicted some of the movies I have actually already watched and liked
in the past. Also, I tried out different parameter combinations and chose the
ones for which the cost function returned the smallest values.

[This article](https://www.microsoft.com/en-us/research/publication/evaluating-recommender-systems/)
presents all the different means of evaluating recommender systems.
