class CommentsController < ApplicationController

    before_action :set_board
    before_action :set_task
    before_action :authenticate_user!

    def new
        @comment = current_user.comments.build
    end

    def create
        @comment = current_user.comments.build(comment_params)
        @comment.task_id = @task.id
        if @comment.save
            redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: 'Saved!'
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

    def set_board
        @board = Board.find_by(id: params[:board_id])
    end

    def set_task
        @task = Task.find_by(id: params[:task_id])
    end

end