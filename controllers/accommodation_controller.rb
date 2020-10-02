require './lib/accommodation_service'
require './lib/user_service'

class AccommodationController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)
  
  enable :sessions
  register Sinatra::Flash

  before do
    @user = UserService.current_user
  end

  get '/accommodations' do
    @accommodation_list = AccommodationService.all
    erb :accommodations
  end

  get '/accommodations/create' do
    erb :accommodation_create
  end

  post '/accommodations/create' do
    host = UserService.current_user
    AccommodationService.create(name: params[:name], description: params[:description], location: params[:location], price: params[:price], from_date: params[:from_date], to_date: params[:to_date], host_id: host.id)
    p params
    #TODO add Availabilty.create method to deal with dates
    redirect '/'
  end

  get '/accommodations/:id' do
    @accommodation = AccommodationService.find(params[:id])
    erb :accommodation_details
  end

  run! if app_file == $0

end