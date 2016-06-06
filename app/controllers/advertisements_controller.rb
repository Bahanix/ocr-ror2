class AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: [:show, :publish]

  # GET /advertisements
  def index
    if @current_user.try(:admin?)
      @advertisements = Advertisement.all
    else
      @advertisements = Advertisement.published
     end
  end

  # GET /advertisements/1
  def show
  end

  # GET /advertisements/new
  def new
    @advertisement = Advertisement.new
  end

  # POST /advertisements
  def create
    @advertisement = Advertisement.new(advertisement_params)
    @advertisement.user = @current_user
    @advertisement.state = "waiting"

    if @advertisement.save
      redirect_to @advertisement, notice: 'Annonce créée, en attente de publication par un administrateur.'
    else
      render :new
    end
  end

  # POST /advertisements/1/publish
  def publish
    unless @current_user.try(:admin?)
      flash[:error] = "Accès interdit"
      return redirect_to request.referrer || root_path
    end

    @advertisement.update state: :published
    redirect_to @advertisement, notice: 'Annonce publiée'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertisement_params
      params.require(:advertisement).permit(:title, :content)
    end
end
