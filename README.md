#  Jan2017 Github Viewer

This project was made as an interview assignment. Provided was a brief set of requirements and 2 target UI screenshots. I will make the following assumptions to complete the project.

## Goals
* 2 view application.
* First screen with a list of trending projects and a search bar
* Second screen with details of the selected project

## Assumptions
* So I firstly needed to clean up with the client about what they wanted in terms of data. Github doesn't provide trending in their API. We agreed apon getting the next best thing which is the most starred projects created in the last 7 days
* I'm not going to care how this gets displayed on iPad
* They seem to be very focused on MVVM so thats what we will be using
* The search will be a server side call rather than a local filter
* No data will display until you search because query needs a term
* Im not going to render the markdown
* Not going to worry about cache invalidation
* I'm not going to track down the image or unicode you have for forks. Its not an easy one to find and its not what github uses themselves
