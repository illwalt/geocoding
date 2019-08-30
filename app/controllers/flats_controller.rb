class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]

  def index
    @flats = Flat.geocoded #returns flats with coordinates

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: render_to_string(partial: "map_box", locals: { flat: flat })
      }
    end
  end

  def show
  end

  def new
    @flat = Flat.new
  end

  def edit
  end

  def create
    @flat = Flat.new(flat_params)
      if @flat.save
        redirect_to @flat, notice: 'Flat was successfully created.'
      else
        render :new
      end
  end

  def update
      if @flat.update(flat_params)
        redirect_to @flat, notice: 'Flat was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @flat.destroy
      redirect_to flats_url, notice: 'Flat was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
      params.require(:flat).permit(:name, :address)
    end
end
