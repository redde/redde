class Admin::ArticlesController < Admin::BaseController
  def index
    @articles = Article.all
  end


  def new
    @article = Article.new
    render 'edit'
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    redirect_or_edit(@article, @article.save)
  end

  def update
    @article = Article.find(params[:id])
    redirect_or_edit(@article, @article.update(article_params))
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path, notice: "#{Article.model_name.human} удален."
  end

  private

  def article_params
    params.require(:article).permit!
  end
end
