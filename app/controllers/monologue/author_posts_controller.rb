class Monologue::AuthorPostsController < Monologue::ApplicationController
  before_filter :set_page, only: [:index, :search]
  before_filter :set_user, only: [:index, :search]
  before_filter :set_posts, only: [:index, :search]

  def search
    @posts = @posts.search(params[:text], @page)
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
    end
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
  end
 private

  def set_page
    @page = params[:page].nil? ? 1 : params[:page]
  end

  def set_user
    @user = Monologue::User.find(params[:user_id])
  end

  def set_posts
    @posts = @user.posts.page(@page).published
  end
end