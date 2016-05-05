class ArticlesController < ApplicationController
    layout 'admin'

    before_action :check_login
    before_action :search_page

    def index
        @article = @pages.articles.sort
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new(page_id: @pages.id)
        @page = @pages.category.pages.sort
        @counter = Article.count + 1
    end

    def create
        @article = Article.new(article_parameters)
        if @article.save
            flash[:success] = 'Artykuł został poprawnie dodany'
            redirect_to(action: 'index', page_id: @pages.id)
        else
            @counter = Article.count + 1
            @page = Page.order('position ASC')
            render('new')
        end
    end

    def edit
        @article = Article.find(params[:id])
        @page = Page.order('position ASC')
        @counter = Article.count
    end

    def update
        @article = Article.find(params[:id])
        if @article.update_attributes(article_parameters)
            flash[:success] = 'Artykuł został poprawnie zmodyfikowany'
            redirect_to(action: 'show', id: @article.id, page_id: @pages.id)
        else
            @counter = Article.count
            @page = Page.order('position ASC')
            render('edit')
        end
      end

    def delete
        @article = Article.find(params[:id])
    end

    def remove
        article = Article.find(params[:id]).destroy
        flash[:success] = "Artykuł '#{article.name}' został poprawnie usunięty"
        redirect_to(action: 'index', page_id: @pages.id)
    end

    private

    def article_parameters
        params.require(:article).permit(:name, :position, :visible, :page_id, :photo, :content)
    end

    def search_page
        @pages = Page.find(params[:page_id]) if params[:page_id]
    end
end
