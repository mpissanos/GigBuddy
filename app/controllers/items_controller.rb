class ItemsController < ApplicationController

  get "/items" do
    if !logged_in?
      redirect "/login"
    else
      @items = current_user.items.all
      erb :"/items/index"
    end
  end

  get "/items/new" do
    if !logged_in?
      redirect "/login"
    else
      erb :"/items/new"
    end
  end

  
  post "/items" do
    if params.values.any? {|value| value == ""}
    flash[:message] = "Please fill out all fields"
      erb :'items/new'
    else
      @item = Item.create(item_name: params[:item_name],brand: params[:brand], user_id: current_user.id)
      @item.save
      redirect "/items/#{@item.id}"
    end
  end

  get "/items/:id" do
    if !logged_in?
      redirect "/login"
    else
      @item = Item.find_by_id(params[:id])
      erb :"/items/show"
    end
  end

 
  get "/items/:id/edit" do
    if !logged_in?
      redirect "/login"
    else
      @item = Item.find_by_id(params[:id])
      erb :"/items/edit"
    end
  end

  
  patch "/items/:id" do
    @item = Item.find_by_id(params[:id])
    if !logged_in?
      redirect "/login"
    else
      if params.values.any? {|value| value == ""}
        flash[:message] = "Please fill out all fields"
        erb :"/items/edit"
      else
        @item.user = current_user
        @item.update(item_name: params[:item_name], brand: params[:brand])
        @item.save
        redirect "items/#{@item.id}"
      end
    end
  end

  
  delete "/items/:id/delete" do
    if !logged_in?
      redirect "/login"
    else
      @item = Item.find(params[:id])
      @item.delete
      redirect '/items'
    end
  end

end
