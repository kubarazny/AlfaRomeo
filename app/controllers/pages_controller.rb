class PagesController < ApplicationController
    layout 'admin'

    before_action :check_login
    before_action :search_category

    def index
        @pages = @categories.pages.sort
    end

    def show
        @page = Page.find(params[:id])
    end

    def new
        @page = Page.new(category_id: @categories.id)
        @category = Category.order('position ASC')
        @counter = Page.count + 1
    end

    def create
        @page = Page.new(page_parameters)
        if @page.save
            flash[:success] = 'Strona została poprawnie dodana'
            redirect_to(action: 'index', category_id: @categories.id)
        else
            @counter = Page.count + 1
            @category = Category.order('position ASC')
            render('new')
        end
    end

    def edit
        @page = Page.find(params[:id])
        @category = Category.order('position ASC')
        @counter = Page.count
    end

    def update
        @page = Page.find(params[:id])
        if @page.update_attributes(page_parameters)
            flash[:success] = 'Strona została poprawnie zmodyfikowana'
            redirect_to(action: 'show', id: @page.id, category_id: @categories.id)
        else
            @counter = Page.count
            @category = Category.order('position ASC')
            render('edit')
        end
    end

    def delete
        @page = Page.find(params[:id])
    end

    def remove
        page = Page.find(params[:id]).destroy
        flash[:success] = "Strona '#{page.name}' została poprawnie usunięta"
        redirect_to(action: 'index', category_id: @categories.id)
    end

    private

    def page_parameters
        params.require(:page).permit(:name, :position, :visible, :category_id)
    end

    def search_category
        @categories = Category.find(params[:category_id]) if params[:category_id]
    end
end
