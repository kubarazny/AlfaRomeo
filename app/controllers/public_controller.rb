class PublicController < ApplicationController
    layout 'public'

    def index
        @page = Page.where(visible: true).newest
        @articles = Article.where(visible: true).newest
        @galleries = Gallery.where(visible: true).newest
    end

    def articles
        @page_menu = Page.where(visible: true).last(10)
    end

    def galleries
        @gallery = Gallery.find(params[:gallery_id])
    end

    def categories
        @category = Category.find(params[:category_id])
    end

    def news
        @article = Article.find(params[:article_id])
    end

    def page
        @page = Page.find(params[:page_id])
    end
end
