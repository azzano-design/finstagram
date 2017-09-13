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

get '/posts/new' do 
    @post = Post.new
    erb(:"posts/new")
end

post '/posts' do 
    photo_url = params[:photo_url]
    @post = Post.new({photo_url: photo_url, user_id: current_user.id})
    
    if @post.save
        redirect(to('/'))
    else
        erb(:"posts/new")
    end
end

get '/posts/:id' do
  @post = Post.find(params[:id])   # find the post with the ID from the URL
  erb(:"posts/show")               # render app/views/posts/show.erb
end

post '/comments' do
  # point values from params to variables
  text = params[:text]
  post_id = params[:post_id]

  # instantiate a comment with those values & assign the comment to the `current_user`
  comment = Comment.new({ text: text, post_id: post_id, user_id: current_user.id })

  # save the comment
  comment.save

  # `redirect` back to wherever we came from
  redirect(back)
end

post '/likes' do
  # point values from params to variables
  post_id = params[:post_id]

  # instantiate a comment with those values & assign the comment to the `current_user`
  like = Like.new({ post_id: post_id, user_id: current_user.id })

  # save the comment
  like.save

  # `redirect` back to wherever we came from
  redirect(back)
end

delete '/likes/:id' do
    like = Like.find(params[:id])
    like.destroy
    redirect(back)
end
    