class TweetsController < ApplicationController

  get '/tweets' do
    redirect '/login' if !logged_in?
    @user = current_user
    @tweets = Tweet.all
    erb :"tweets/index"
  end

  get '/tweets/new' do
    redirect '/login' if !logged_in?
    erb :"tweets/new"
  end
  
  post '/tweets' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.new(params[:tweet])
    @tweet.user = current_user
    
    if @tweet.save
      redirect "tweets/#{@tweet.id}"
    else
      redirect 'tweets/new'
    end
  end
  
  get "/tweets/:id" do
    redirect '/login' if !logged_in? 
    @tweet = Tweet.find_by(params[:id])
    erb :"tweets/show_tweet"
  end
  
  get "/tweets/:id/edit" do
    redirect '/login' if !logged_in? 
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if current_user != @tweet.user
    erb :"tweets/edit_tweet"
  end
  
  patch "/tweets/:id" do
    redirect '/login' if !logged_in? 
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:tweet][:content])
    redirect "tweets/#{@tweet.id}/edit"
  end
  
  delete "/tweets/:id/delete" do 
    tweet = Tweet.find_by_id(params[:id])
    if current_user == tweet.user
      if tweet && tweet.destroy
        redirect '/tweets'
      else
        redirect "tweets/#{params[:id]}"
      end
    else
      redirect '/tweets'
    end
  end

end
