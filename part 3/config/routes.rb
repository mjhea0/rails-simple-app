CourseProject::Application.routes.draw do
   	root :to => "post#index"
    resources :post do
    	resources :comments
    end
end
