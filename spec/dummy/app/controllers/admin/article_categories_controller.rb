class Admin::ArticleCategoriesController < Admin::BaseController
  def index
    @article_categories = ArticleCategory.order(:position)
  end

  def sort
    params[:pos].each_with_index do |id, idx|
      p = ArticleCategory.find(id)
      p.update(position: idx)
    end
    render nothing: true
  end

  def new
    @article_category = ArticleCategory.new
    render 'edit'
  end

  def edit
    @article_category = ArticleCategory.find(params[:id])
  end

  def create
    @article_category = ArticleCategory.new(article_category_params)
    redirect_or_edit(@article_category, @article_category.save)
  end

  def update
    @article_category = ArticleCategory.find(params[:id])
    redirect_or_edit(@article_category, @article_category.update(article_category_params))
  end

  def destroy
    @article_category = ArticleCategory.find(params[:id])
    @article_category.destroy
    redirect_to admin_article_categories_path, notice: "#{ArticleCategory.model_name.human} удален."
  end

  private

  def article_category_params
    params.require(:article_category).permit!
  end
end
