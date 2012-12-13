Link Directory App
=================

Download the basic starter project (includes Twitter Bootstrap), unpack, and place in the files in folder of choice

Create new application
----------------------
- CD into the new folder
- Fire up the server: *rails server*
- Navigate to: http://localhost:3000/ - you should see the “Welcome to your first app!” page

Model-Controller Setup
----------------------
- Update Gems: *bundle update*
- Create Model: *rails generate model Post url:string title:string*
- Create Controller: *rails generate controller Post new*
- Create the database: *rake db:migrate*
- Start Rails console: *rails c*
- Add a row to the database: *Post.create({url:"http://www.google.com", title:"Google"})*
- Add a few more …
- Double check that your data was added using the SQLite Database Browser
- Create these blank web pages under app/views/post: index.html.erb and show.html.erb
- Update: *rake db:migrate*
- Update route.rb in Sublime:

        root :to => "post#index"
        resources :post
- Update Controller:
- Open /app/controllers/post_controller.rb in Sublime and replace code with:

class PostController < ApplicationController
def index
@posts = Post.all
 	end
 	def show
		@post = Post.find(params[:id])
	end
end

8.	Update views
a.	Update /app/views/post/index.html.erb

<br/>
<h1>All Posts</h1>

<% @posts.each do |post| %>
 <tr>
 <td><%= post.title %></td>
    <td><%= link_to 'Show', post %></td><br/>
  </tr>
<% end %>
</table>

<br />

b.	Update /app/views/posts/show.html.erb

<br/>
<p><b><%= @post.title %></b></p>
<p><%= @post.url %></p>
<%= link_to "Back", posts_path %>

9.	Refresh http://localhost:3000/ - you should see your links
