class AdvertisementsController < ApplicationController
  # Cette fonction est dans le ApplicationController,
  # Elle redirige l'utilisateur vers l'interfac de connexion
  # s'il n'est pas connecté
  before_action :authenticate_user!, only: [:create]

  # Cette fonction évite de répéter plusieurs fois une ligne de code
  # Elle est en bas de ce présent fichier.
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
    @comment = Comment.new
    @comment.advertisement = @advertisement
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
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    def advertisement_params
      # N'autorisez surtout pas user_id car il est automatiquement mis avec @current_user !
      params.require(:advertisement).permit(:title, :content)
    end
end
