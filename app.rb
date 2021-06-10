require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

require_relative "config/application"

set :views, (proc { File.join(root, "app/views") })
set :bind, '0.0.0.0'


get '/' do
  # TODO
  # 1. fetch posts from database.
  @posts = Post.all.by_votes_descending
  # 2. Store these posts in an instance variable
  # 3. Use it in the `app/views/posts.erb` view

  erb :posts # Do not remove this line
end

# We create our backend route /post which will accept the submission from the form on the front end
get '/post' do
  # We can access the contents of the submitted form using the - params - keyword
  # It can be accessed like a hash, so we grab the title and url submitted from the form
  # And we create a new post and save it
  post = Post.new(title: params["title"], url: params["url"] )
  post.save

  # We don't want to have an associated View with this route, so we redirect the user to the home page
  redirect '/'
end

# We create the route that intercepts the "A" tag on our front end that is sending through a post id
get '/upvote' do
  # We create a new post, accessing the post id through params
  post = Post.find(params[:id])
  # We increment the votes and update
  post.update(votes: post.votes + 1)

  # We redirect to the home page
  redirect '/'
end
