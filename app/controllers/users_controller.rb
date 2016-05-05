class UsersController < ApplicationController
    layout 'admin'

    before_action :check_login

    def index
        @user = User.sort
    end

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_parameters)
        if @user.save
            flash[:success] = "Użytkownik został poprawnie dodany"
            redirect_to(action: 'index')
        else
            render('new')
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_parameters)
            flash[:success] = 'Użytkownik został poprawnie zmodyfikowany'
            redirect_to(action: 'index')
        else
            render('edit')
        end
    end

    def delete
        @user = User.find(params[:id])
   end

    def remove
        user = User.find(params[:id]).destroy
        flash[:success] = "Użytkownik '#{user.user}' został poprawnie usunięty"
        redirect_to(action: 'index')
    end

    def user_parameters
        params.require(:user).permit(:name, :surname, :email, :user, :password, :password_confirmation)
    end
end
