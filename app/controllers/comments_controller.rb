class CommentsController < ApplicationController

  before_filter :require_login, except: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    @comment.save
    flash.notice = "Comment '#{@comment.body}' was created!"
    redirect_to article_path(@comment.article)
  end

  def destroy
  #  @article = Article.find(params[:id])
  #  @article.destroy
  #  flash.notice = "Article '#{@article.title}' was destroyed."
  #  redirect_to articles_path
  #
  @article = Article.find(params[:article_id])
  @comment = Article.find(params[:article_id]).comments.find(params[:id])
  @comment.destroy
  flash.notice = "Comment deleted."
  redirect_to article_path(@article)

  end


  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
