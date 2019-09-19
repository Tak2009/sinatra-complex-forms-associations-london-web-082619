class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end
  
  # New
  get '/owners/new' do 
    @pets = Pet.all # for owner to select his/her(has many) pets when owner instance created
    erb :'/owners/new'
  end

  # Create recieve data from New
  post '/owners' do
    @owner = Owner.create(params[:owner])
        if !params[:pet][:name].empty?
          @owner.pets << Pet.create(name: params[:pet][:name])
        end
    redirect to "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  # Show
  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
   ####### bug fix
   if !params[:owner].keys.include?(:pet_ids)
    params[:owner][:pet_ids] = []
    end
    #######
 
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])
    if !params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    redirect "owners/#{@owner.id}"
  end
end