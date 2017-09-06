helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

get '/' do 
    @posts = Post.order(created_at: :desc)
    erb(:index)
end

get '/signup' do            # if user goes to signup
    @user = User.new        # setup empty @user object
    erb(:signup)            # render app/views/signup.erb
end

post '/signup' do
    #grab form entry
    email = params[:email]
    avatar_url = params[:avatar_url]
    username = params[:username]
    password = params[:password]
    
    #initiate a user
    @user = User.new({email: email, avatar_url: avatar_url, username: username, password: password})
    
    #if validations pass, save user
    if @user.save
        redirect to('/login')
    else
        erb(:signup)
    end
end

get '/login' do            
    erb(:login)        
end

post '/login' do
    username = params[:username]
    password = params[:password]
    
    #1 find user by username
    user = User.find_by(username: username)
    
    #2 if user exists
    if user && user.password == password
        #set user id to session
        session[:user_id] = user.id
        redirect to('/')
    else
        @error_message = "Login Failed"
        erb(:login)
    end
end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
end
