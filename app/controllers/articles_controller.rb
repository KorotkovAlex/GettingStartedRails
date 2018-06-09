class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'admin', except: [:index, :show]

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def index
    # logger.info 'after=' + params[:after] (per: params[:per], after: params[:after])
    list = Articles::Index.new(after: params[:after], before: params[:before])

    logger.info '==================='

    logger.info "params[:after] = #{params[:after]}"
    logger.info "cursor = #{list.cursor}"
    logger.info "cursor_first = #{list.cursor_first}"
    logger.info "can_load_more = #{list.can_load_more}"

    logger.info '==================='

    @articles = list
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :text)
    end
end
