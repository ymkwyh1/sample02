class CommentsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def new
        @board = Board.find_by(id: params[:board_id])
        @task = Task.find_by(id: params[:task_id])
        @comment = current_user.comments.build
    end

    def create
        @board = Board.find_by(id: params[:board_id])
        @task = Task.find_by(id: params[:task_id])
        @comment = current_user.comments.build(comment_params)
        @comment.task_id = @task.id
        if @comment.save
            redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: '保存しました'
        else
            flash.now[:error] = 'Failed to save!'
            render :new
        end
    end

    private
    def comment_params
        params.require(:comment).permit(
            :content
            )
    end

end