class SnowbindingsController < ApplicationController
  before_action :set_snowbinding, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    style ||= params[:style]
    if style and Snowbinding::STYLES.include? style
      @snowbindings = Snowbinding.send(style.to_sym)
      @style = style
    else
      @snowbindings = Snowbinding.all
      flash[:alert] = 'no such style' if style
    end
    @snowbindings = @snowbindings.paginate(:page => params[:page], :per_page => 16)
    respond_with @snowbindings
  end

  def show
    respond_with(@snowbinding)
  end

  def new
    @snowbinding = Snowbinding.new
    respond_with(@snowbinding)
  end

  def edit
  end

  def create
    @snowbinding = Snowbinding.new(snowbinding_params)
    @snowbinding.save
    respond_with(@snowbinding)
  end

  def update
    @snowbinding.update(snowbinding_params)
    respond_with(@snowbinding)
  end

  def destroy
    @snowbinding.destroy
    respond_with(@snowbinding)
  end

  private
    def set_snowbinding
      @snowbinding = Snowbinding.find(params[:id])
    end

    def snowbinding_params
      params[:snowbinding]
    end
end
