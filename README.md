Link Directory App (part 1) - setup 
=================

Download the basic starter project (includes Twitter Bootstrap), unpack, and place in the files in folder of choice

Create new application
----------------------
- CD into the new folder
- Update Gems: *bundle install*
- Fire up the server: *rails server*
- Navigate to: http://localhost:3000/ - you should see the “Welcome to your first app!” page

Model-Controller Setup
----------------------
- Create Model: *rails generate model Post url:string title:string*
- Create Controller: *rails generate controller Post new*
- Create the database: *rake db:migrate*
- Start Rails console: *rails c*
- Add a row to the database: *Post.create({url:"http://www.google.com", title:"Google"})*
- Add a few more …
- Double check that your data was added using the SQLite Database Browser
- Create this blank web page under app/views/post: index.html.erb
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

<br />
<br />


Link Directory App (part 2) - Data Modeling / Commenting
=================

In this second part, we'll be adding on the ability to add comments (in the backend) as well as a *Show* page. On this page, there will be a clickable link for the specific url, the number of comments, and a list if all comments. The index page will be updated to add a link to the *Show* page as well as the total # of comments. 

## Show Page

- CD into the project folder
- Fire up the server: *rails server*
- Navigate to: http://localhost:3000/
- Create a blank web page under app/views/post called show.html.erb and add the following code:

		<br/>
		<p><b><%= @post.title %></b></p>
		<p><%= link_to @post.url, @post.url %></p>
		<%= link_to "Back to the Directory", "/" %>
- Now update index.html.erb:
		
		<br/>
		<h1>All Posts</h1>
		<% @posts.each do |post| %>
			<li>
				<%= post.title %> - <%= link_to 'Show', post %>
			</li>
		<% end %>
		<br />
- Create Model for the comments: *rails generate model Comment content:text*
- Add the association between comments and post (1 post can have many comments). Open create_comments.rb migration and update the code:
	
		class CreateComments < ActiveRecord::Migration
  			def change
    			create_table :comments do |t|
      				t.text :content
					t.belongs_to :post
      				t.timestamps
    			end
  			end
		end
- Refresh http://localhost:3000/ - and take a look around

## Data Modeling

- Create the new entity - rails generate model Comment content:text post_id:integer
- Update the database: *rake db:migrate*
- Start Rails console: *rails c*
- Add a row to the database: *Comment.create({content:"testing", post_id:1})*
- Double check that the new entity was added using the SQLite Database Browser
- Edit the post.rb and comment.rb files to add in the one-to-many association:

		class Post < ActiveRecord::Base
  			attr_accessible :title, :url
  			has_many :comments
		end
		class Comment < ActiveRecord::Base
  			belongs_to :post
		end
- Now update index.html.erb to show the total # of posts for each link -

		<br/>
		<h1>All Posts</h1>
		<% @post.each do |post| %>
		<li>
			<p><%= post.title %> - <%= link_to 'Show', post %><br >
			Total Comments: <%= post.comments.count %><p/>
		</li>
		<% end %>
		<br />
- Refresh http://localhost:3000/ to see your changes


## Update Show

Now we need to update the *Show* page to add the total comments and a listing of each comment. 

- First, update routes.rb -

		CourseProject::Application.routes.draw do
  			root :to => "post#index"
    		resources :post do
    			resources :comments
    		end
		end
- Now you can update show.html.erb with the following code:

		<br/>
		<p><b><%= @post.title %></b></p>
		<p><%= link_to @post.url, @post.url %><br />
		Total Comments: <%= @post.comments.count %><br />
		<ul>
			<% @post.comments.each do |comment| %>
			<li>
				<%= comment.content %>
			</li>
			<% end %>
		</ul>
		<%= link_to "Back to the Directory", "/" %>
- Double-check http://localhost:3000/ and test everything out.
- Next time I'll show you how to add some CSS styling.


Link Directory App (part 3) - Styling
=================

Okay - let's add in some basic styling to make this look a little better. Since this project includes the Twitter Bootstrap, I'll just be using [Bootswatch](http://bootswatch.com/) to change the CSS styling. 

Now, if you're like me and don't do much designing, you can just look at the CSS for one of the style templates and copy the entire stylesheet and paster it to application.css.scss.

I then added a margin to the top of the conatiner class so that the text *Navigation* is easier to read:

	.container,
	.navbar-static-top .container,
	.navbar-fixed-top .container,
	.navbar-fixed-bottom .container {
 	 margin-top:13px;
 	 width: 940px;
	}

Next I updated index.html.erb to make the logical layout of posts and comments look a bit nicer:

	.container,
	.navbar-static-top .container,
	.navbar-fixed-top .container,
	.navbar-fixed-bottom .container {
	  margin-top:13px;
	  width: 940px;
	}

Finally I updated show.html.erb to, again, make the logical layout look a little nicer:

<br/>
<h1>Link</h1>
<br />
<%= link_to @post.title, @post.url %> (<%= @post.comments.count %> comment)<br />


	<ul>
	<% @post.comments.each do |comment| %>
			
			<li>
				<%= comment.content %>
			</li>
		
	<% end %>
	</ul>
	
	<%= link_to "Back to the Directory", "/" %>












