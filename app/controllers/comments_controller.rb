class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_match
  before_action :check_admin_role, only: [:destroy]

  def create
    @comment = @match.comment_threads.build(comment_params)
    @comment.user = current_user

    if @comment.save
      #Nick name is asked for users without it
      current_user.update_column(:nick_name, @comment.nick_name) if @comment.nick_name.present? && !current_user.name.present?
      flash[:notice] = t(".comment_created")
    else
      flash[:alert] = t(".comment_not_created")
    end

    redirect_to @match
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to @match, notice: "Comment deleted"
  end

  private

  def comment_params
    params.require(:comment).permit(
      :body,
      :title,
      :nick_name
    )
  end

  def fetch_match
    # User is already signed in, so check only her role
    @match = Match.friendly.find(params[:match_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: t("not_authorized")
  end
end
