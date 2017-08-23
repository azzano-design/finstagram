def humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
        "#{time_ago_in_minutes / 60} hours ago"
    else
        "#{time_ago_in_minutes} minutes ago"
    end
end


get '/' do 
    @post_shark = {
        username: "sharky_j",
        avatar_url: "http://naserca.com/images/sharky_j.jpg",
        photo_url: "http://naserca.com/images/shark.png",
        humanized_time_ago: humanized_time_ago(15),
        like_count: 0,
        comment_count: 1,
        comments: [{ 
            username: "sharky_j",
            text: "sharky_j: Out for the long weekend... too embarassed to show ya'll the beach bod!"
        }]
    }
    @post_whale = {
        username: "kirk_whalum",
        avatar_url: "http://naserca.com/images/kirk_whalum.jpg",
        photo_url: "http://naserca.com/images/whale.jpg",
        humanized_time_ago: humanized_time_ago(60),
        like_count: 0,
        comment_count: 1,
        comments: [{ 
            username: "kirk_whalum",
            text: "kirk_whalum: #weekendvibes"
        }]
    }
    @post_marlin = {
        username: "marlin_peppa",
        avatar_url: "http://naserca.com/images/marlin_peppa.jpg",
        photo_url: "http://naserca.com/images/marlin.jpg",
        humanized_time_ago: humanized_time_ago(190),
        like_count: 0,
        comment_count: 1,
        comments: [{ 
            username: "marlin_peppa",
            text: "marlin_peppa: lunchtime! ;)"
        }]
    }
    [@post_shark, @post_whale, @post_marlin].to_s

    @posts = [@post_shark, @post_whale, @post_marlin]
    
erb(:index)

end