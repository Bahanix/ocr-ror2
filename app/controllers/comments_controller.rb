class CommentsController < ApplicationController
  # Cette fonction est dans le ApplicationController,
  # Elle redirige l'utilisateur vers l'interfac de connexion
  # s'il n'est pas connecté
  before_action :authenticate_user!, only: [:create]

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = @current_user

    if @comment.save
      redirect_to @comment.advertisement, notice: 'Commentaire ajouté.'
    else
      @advertisement = @comment.advertisement
      render 'advertisements/show'
    end
  end

  private

    def comment_params
      # N'autorisez surtout pas user_id car il est automatiquement mis avec @current_user !
      params.require(:comment).permit(:content, :advertisement_id)
    end
end
