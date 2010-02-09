class LoginController < ApplicationController
  
  def create_user
    session[:user_id] = nil
    verify_recaptcha :private_key => '6Lc5zAoAAAAAANG3q9wbYeznpWgex0IMqGHejtdd'
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash.now[:notice] = "User #{@user.name} was successfully created"
      session[:user_id] = User.last.id
      redirect_to root_url
    end
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:user][:name], params[:user][:password])
      if user
        session[:user_id] = user.id
        if params[:remember_me] 
          userId = (user.id).to_s  
          cookies[:remember_me_id] = { :value => userId, :expires => 30.days.from_now }
        end
      else
        flash[:login_message] = "Sorry, that's not the right password and username."
      end
      if session[:original_uri].nil?
        redirect_to root_url
      else
        redirect_to session[:original_uri]
      end
    end
  end

  def logout
    session[:user_id] = nil
    if cookies[:remember_me_id] then cookies.delete :remember_me_id end
    redirect_to root_url
  end
  
  def update_profile
    @update_user = @current_user
    puts params[:update_user]
    if request.post? and @update_user.update_attributes(params[:update_user])
       redirect_to profile_url(:id => @current_user)
    end
  end

  def change_password
     @update_user = @current_user
     if request.post? and @update_user.update_attributes(params[:change_password])
       redirect_to profile_url(:id => @current_user)
     end   
  end

  def change_profile_picture
     @update_user = @current_user
     # if request.post? and @update_user.update_attributes(params[:change_password])
     #   redirect_to profile_url(:id => @current_user)
     # end   
  end

  def index
    redirect_to root_url
  end

  def delete_user
  end

  def list_users
    @designs = Design.all
  end

end
