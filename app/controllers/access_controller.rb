class AccessController < ApplicationController
    layout 'admin'

    before_action :check_login, except: [:login, :logging, :logout]

    def index
    end

    def login
    end

    def logging
        if params[:user].present? && params[:password].present?
            admin_search = User.where(user: params[:user]).first
            if admin_search
                admin_authorization = admin_search.authenticate(params[:password])
            end
        end

        if admin_authorization
            session[:user_id] = admin_authorization.id
            session[:user] = admin_authorization.user
            flash[:success] = "Zostałeś poprawnie zalogowany"
            redirect_to(action: 'index')
        else
            flash[:danger] = 'Błąd: złe hasło lub login'
            redirect_to(action: 'login')
        end
      end

    def logout
        session[:user_id] = nil
        session[:user] = nil
        flash[:success] = 'Zostałeś poprawnie wylogowany'
        redirect_to(action: 'login')
    end
  end
