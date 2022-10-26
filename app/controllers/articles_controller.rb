#The index action is empty. When an action does not explicitly render a view
# (or otherwise trigger an HTTP response), Rails will automatically render a view
# that matches the name of the controller and action. Convention Over Configuration!
# Views are located in the app/views directory. So the index action will render
# app/views/articles/index.html.erb by default.

class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  # The new action instantiates a new article, but does not save it.
  def new
    @article = Article.new
  end

  #The create action instantiates a new article with values
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  #The edit action fetches the article from the database, and stores it in @article so that it can be used when building the form.
  def edit
    @article = Article.find(params[:id])
  end

  #The update action (re-)fetches the article from the database, and attempts to update it with the submitted form data filtered by article_params
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #The destroy action fetches the article from the database, and calls destroy on it.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
