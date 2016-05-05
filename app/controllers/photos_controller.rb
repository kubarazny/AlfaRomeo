class PhotosController < ApplicationController
    layout 'admin'

    before_action :check_login
    before_action :search_gallery

    def index
        @photo = @galleries.photos.sort
    end

    def new
        @photo = Photo.new(gallery_id: @galleries.id)
        @counter = Photo.count + 1
        @gallery = Gallery.order('position ASC')
    end

    def create
        @photo = Photo.new(photo_parameters)
        if @photo.save
            flash[:success] = "Zdjęcie zostało poprawnie dodane"
            redirect_to(action: 'index', gallery_id: @galleries.id)
        else
            @counter = Photo.count + 1
            @gallery = Gallery.order('position ASC')
            render('new')
        end
    end

    def show
        @photo = Photo.find(params[:id])
    end

    def edit
        @photo = Photo.find(params[:id])
        @counter = Photo.count
        @gallery = Gallery.order('position ASC')
    end

    def update
        @photo = Photo.find(params[:id])
        if @photo.update_attributes(photo_parameters)
            flash[:success] = 'Zdjęcie zostało poprawnie zmodyfikowane'
            redirect_to(action: 'show', id: @photo.id, gallery_id: @galleries.id)
        else
            @counter = Photo.count
            @gallery = Gallery.order('position ASC')
            render('edit')
        end
  end

    def delete
        @photo = Photo.find(params[:id])
    end

    def remove
        photo = Photo.find(params[:id]).destroy
        flash[:success] = "Zdjęcie '#{photo.name}' zostało poprawnie usunięte"
        redirect_to(action: 'index', gallery_id: @galleries.id)
  end

    private

    def photo_parameters
        params.require(:photo).permit(:gallery_id, :name, :position, :visibility, :photo, :description)
    end

    def search_gallery
        @galleries = Gallery.find(params[:gallery_id]) if params[:gallery_id]
    end
end
