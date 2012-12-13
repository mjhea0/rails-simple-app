Link Directory App (part 1)
=================

Download the basic starter project (includes Twitter Bootstrap), unpack, and place in the files in folder of choice

Create new application
----------------------
- CD into the new folder
- Fire up the server: *rails server*
- Navigate to: http://localhost:3000/ - you should see the “Welcome to your first app!” page

Model-Controller Setup
----------------------
- Update Gems: *bundle install*
- Create Model: *rails generate model Post url:string title:string*
- Create Controller: *rails generate controller Post new*
- Create the database: *rake db:migrate*
- Start Rails console: *rails c*
- Add a row to the database: *Post.create({url:"http://www.google.com", title:"Google"})*
- Add a few more …
- Double check that your data was added using the SQLite Database Browser
- Create these blank web pages under app/views/post: index.html.erb
- Update: *rake db:migrate*
- Update route.rb in Sublime (the routes fille is used to dispath incoming urls and match them to the controller or action)

        root :to => "post#index"
        resources :post
        
- Update /app/controllers/post_controller.rb in Sublime. Replace code with:

            class PostController < ApplicationController
                def index
                    @posts = Post.all
                end
                def show
                    @post = Post.find(params[:id])
                end
            end

- Update /app/views/post/index.html.erb with:

        <br/>
        <h1>All Posts</h1>
        <% @posts.each do |post| %>
        <li>
         	<%= link_to post.title, post.url %>
        </li>
        <% end %>
        <br />
        
- Refresh http://localhost:3000/ - you should see your links
