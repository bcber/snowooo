class Admin::PlacesController < Admin::ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy, :up, :down ,:recommend]

  # GET /admin/places
  # GET /admin/places.json
  def index
    @places = Place.desc(:created_at).paginate(page: params[:page], per_page: 10)
  end

  # GET /admin/places/1
  # GET /admin/places/1.json
  def show
  end

  # GET /admin/places/new
  def new
    @place = Place.new
    3.times { @place.place_images.build }
  end

  # GET /admin/places/1/edit
  def edit
    @place.place_images.build
  end

  # POST /admin/places
  # POST /admin/places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to admin_places_path, notice: '创建成功.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/places/1
  # PATCH/PUT /admin/places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: '编辑成功' }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/places/1
  # DELETE /admin/places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to admin_places_path, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # up
  def up
    if @place.update(up_at: Time.now)
      redirect_to admin_places_path
    end
  end

  def down
    if @place.update(up_at: Time.new(1970))
      redirect_to admin_places_path
    end
  end

  #recommend
  def recommend
    if @place.update(recommend_at: Time.now)
      redirect_to admin_places_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params[:place].permit(:name, :region_list,:site,:description, :level ,:cover,:remote_cover_url, :show_map,:address,:phone,:coordinate,{
          place_images_attributes: [:id,:_destroy, :original,:remote_original_url ]
      })
    end
end
