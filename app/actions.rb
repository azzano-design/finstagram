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
        "User #{username} saved!"
    else
        erb(:signup)
    end
end