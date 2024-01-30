# GoCertify Tech Task - Ruby on Rails App
This repository contains the GoCertify Tech Task, a Ruby on Rails.

## Table of Contents
- [GoCertify Tech Task - Ruby on Rails App](#gocertify-tech-task---ruby-on-rails-app)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Database Setup](#database-setup)
  - [Usage](#usage)
  - [Approach](#approach)
    - [Planning](#planning)
  - [Self Evaluation](#self-evaluation)
  - [Loom Video](#loom-video)


## Installation

1. Ensure that you have Ruby and Ruby on Rails installed on your machine. You can install them using tools like [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv).

2. Clone the repository onto your machine
   `git clone https://github.com/JamesRClarke/gocertify-tech-task.git`

3. Navigate into the directory and install dependencies
   `cd gocertify-tech-task && bundle`

## Database Setup
To set up the database run:

`rails db:create`

`rails db:migrate`

`rails db:seed`

## Usage
To run:
`bin/dev`

Navigate to: `http://localhost:3000/`

## Approach

### Planning

I first broke down the problem into 5 different steps.
The steps I came up with were as follows:


1. Build Campaign model
    - title description:text state:integer, published_at:datetime, position:integer
    - in the model create an enum for the state, default being draft =
    -  validate position to be unique
    -  create service to handle ‘repositioning’ in the case a published_at needs to be altered

2. Create seeds
   -  generate 15 campaign, all with fake data ( use faker gem to help)
   -  let’s say 8 published, 4 drafts, 3 archived

3.  Build query
    - create filtering (perhaps a scope or a Query Class) to order each “state scoped” collection of campaigns by position number

4. Build table
   -  design table
   -  iterate over each grouped campaign collection to place into a table

5. Build modal
   - Using turbo and stimulus to build functionality of a modal
   - Make the modal dynamic so it can not only be used for campaigns, but for any conent we could put inside it
   - use helper or perhaps interpolation to change colour of text
   - design modal


I wrote this rough plan down so when I started the task I had easy broken steps to follow to achieve all the listed requirments.


## Self Evaluation

The implementation on a the peroid of time suggested I think was solid and demonstrates an MVP version of what this feature could be.

The design is clean, all boxes were checked it works as expected.

A few things given more time and trying to extend on I would do:

  - For the gathering of the Campaigns, I could've used scopes, however, I think a Query class i.e. CampaignQuery, with methods built in here for filtering data and holding business logic like the ordering of the campaigns by a specific state name as this might not be commonly used.

  - I had trouble with the setup and getting TailwindCSS classes working on my machine (perhaps it's ok on others) and unfortnatley wrote inline styles in the SVG, I could've used a class or resolved the issue

  - Only wrote test for something which was not specified on the requirments, my curiosity took over and wanted to implement a solution for this. Could've spent more time on the other things to improve overall quality. I did think tests for all code written in a 2 hour time frame might not be the best use of the time, so I decided against, however, in production 'environment' tests would've been my first action.

## Loom Video

[Loom Video Link](https://www.loom.com/share/79d39adae051491092bfe84e308944dd)