Monologue::Engine.routes.draw do
  root to:  "posts#index"
  get "/page/:page", to:  "posts#index", as:  "posts_page"
  get "/feed" => "posts#feed", as:  "feed", defaults: {format: :rss}
  get "/search" => "posts#search", as: "search"

  get "/tags/:tag" =>"tags#show", as: "tags_page"

  namespace :admin, path: "monologue" do
    get "/" => "posts#index", as:  "" # responds to admin_url and admin_path
    get "/page/:page", to:  "posts#index", as:  "posts_page"
    get "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    resources :sessions
    resources :posts
    resources :users
    get "comments" => "comments#show", as: "comments"

    match "/post/preview"=>"posts#preview", :as=>"post_preview", :via => [:put, :post]
  end

  get "author/:user_id/posts" => "author_posts#index", as: "author_posts"
  get "author/:user_id/posts/page/:page" => "author_posts#index", as: "author_posts_page"
  get "*post_url" => "posts#show", as:  "post"
end
