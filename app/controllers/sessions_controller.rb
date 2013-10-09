class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.authenticate(params[:login], params[:password])
		if user
			
			session[:user_id] = user.id
			redirect_to nowe_szukanie_path, :notice => "Poprawnie zalogowano jako: #{user.login}"
		else
			flash.now.alert = "Nieprawidlowy login albo haslo"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Wylogowany"
	end
	
end
