class CategoriesController < ApplicationController
    layout 'admin'

    before_action :check_login
    def index
        @categories = Category.sort
    end

    def show
        @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
        @counter = Category.count + 1
    end

    def create
        @categories = Category.new(category_parameters)
        if @categories.save
            flash[:success] = 'Kategoria została poprawnie dodana'
            redirect_to(action: 'index')
        else
            @counter = Category.count + 1
            render('new')
        end
    end

    def edit
        @category = Category.find(params[:id])
        @counter = Category.count
    end

    def update
        @category = Category.find(params[:id])
        if @category.update_attributes(category_parameters)
            flash[:success] = 'Kategoria została poprawnie zmodyfikowana'
            redirect_to(action: 'show', id: @category.id)
        else
            @counter = Category.count
            render('edit')
        end
    end

    def delete
        @category = Category.find(params[:id])
    end

    def remove
        category = Category.find(params[:id]).destroy
        flash[:success] = 'Kategoria została poprawnie usunięta'
        redirect_to(action: 'index')
    end

    private

    def category_parameters
        params.require(:category).permit(:name, :position, :visible)
    end
end
