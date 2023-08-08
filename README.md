# Lunch and Learn 

## Overview

This project exposes an API that serves data for different functionalities related to recipes, learning resources, user registration, favorites, and more. It implements CRUD functionality, authentication, and integrates with multiple external APIs.
The purpose of this project is to simulate the real-world challenge of developing an application based on the requirements of a front end team.

## Table of Contents
- [Learning Goals](#learning-goals)
- [Tech & Tools Used](#tech--tools-used)
- [Developer Set Up](#developer-set-up)
- [How to Run Test Suite](#how-to-run-test-suite)
- [Available Endpoints](#available-endpoints)

# Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Implement basic authentication
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)

# Tech & Tools Used
### Built With
- Ruby
- Rails
- RSpec
- Postman
- PostgreSQL

### Gems Used:
- Faraday
- Figaro
- Pry
- SimpleCov
- Shoulda Matchers
- Webmock
- VCR
- Bcrypt
- JSONAPI Serializer
- Factory Bot
- Capybara

# Developer Set Up
1. Fork and clone this repository
2. cd into the root directory
3. Run ```bundle install```
4. Run ```bundle exec figaro install```
5. Run ```rails db:{create,migrate}```
6. To run this server, run ```rails s``` in the terminal
7. To stop the local server, use ```ctl + c```
8. Sign up for the following (no cost) APIs:
  [REST Countries API](https://restcountries.com/) | [Edamam API](https://developer.edamam.com/edamam-recipe-api) | [Youtube API](https://developers.google.com/youtube/v3) | [Unsplash API](https://unsplash.com/developers)

# How to Run Test Suite
After set up:
- Run ```bundle exec rspec```

# Available Endpoints
- Get recipes for a particular country
- Get learning resources for a particular country
- Register a new user
- Login a user
- Add favorite recipes to a user
- Get a list of user favorites
- Delete a user favorite

