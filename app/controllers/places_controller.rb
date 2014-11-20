class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  respond_to :html
  load_and_authorize_resource

  def index
    @places = Place.desc(:created_at).paginate(:page => params[:page], :per_page => 16)
  end

  def show
    @comment = Comment.new
    session[:reply_page] = url_for(@place)
    set_seo_meta("#{@place.title}", "#{@place.title}")
  end

  def new
    @place = Place.new
  end

  def region
    @places = Place.tagged_with_on(:regions,params[:region]).paginate(page:params[:page], per_page: 20)
    render action: 'index'
  end

  def edit
  end

  def create
    @place = Place.new(place_params)
    @place.save
    respond_with(@place)
  end

  def update
    @place.update(place_params)
    respond_with(@place)
  end

  def destroy
    @place.destroy
    respond_with(@place)
  end

  private
    def set_place
      @place = Place.find(params[:id])
    end

    def place_params
      params[:place]
    end
end
