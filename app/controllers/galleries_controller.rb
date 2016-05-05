class GalleriesController < ApplicationController
    layout 'admin'

    before_action :check_login

    def index
        @gallery = Gallery.sort
    end

    def new
        @gallery = Gallery.new
        @counter = Gallery.count + 1
    end

    def create
        @gallery = Gallery.new(gallery_parameters)
        if @gallery.save
            flash[:success] = 'Galeria została poprawnie dodana'
            redirect_to(action: 'index')
        else
            @counter = Gallery.count +1
            render('new')
        end
    end

    def show
        @gallery = Gallery.find(params[:id])
    end

    def edit
        @gallery = Gallery.find(params[:id])
        @counter = Gallery.count
    end

    def update
        @gallery = Gallery.find(params[:id])
        if @gallery.update_attributes(gallery_parameters)
            flash[:success] = 'Galeria została poprawnia zmodyfikowany'
            redirect_to(action: 'show', id: @gallery.id)
        else
            @counter = Gallery.count
            render('edit')
        end
    end

    def delete
        @gallery = Gallery.find(params[:id])
    end

    def remove
        gallery = Gallery.find(params[:id]).destroy
        flash[:success] = "Galeria '#{gallery.name}' została poprawnie usunięta"
        redirect_to(action: 'index')
  end

    def gallery_parameters
        params.require(:gallery).permit(:name, :position, :visible, :description, :photo)
    end
end
