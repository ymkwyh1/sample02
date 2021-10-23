class TasksController < ApplicationController

    before_action :set_board, only: [:index, :show, :create, :edit, :update]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @tasks = @board.tasks.all
    end

    def new
        @task = current_user.tasks.build
    end

    def show
        @task = @board.tasks.find_by(id: params[:id])
        @comments = @task.comments.all
    end

    def create
        @task = current_user.tasks.build(task_params)
        @task.board_id = @board.id
        if @task.save
            redirect_to board_tasks_path(board_id: @board.id), notice: 'Saved!'
        else
            flash.now[:error] = 'Failed to save!'
            render :new
        end
    end

    def edit
        @task = @board.tasks.find_by(id: params[:id])
    end

    def update
        @task = @board.tasks.find_by(id: params[:id])
        if @task.update(task_params)
          redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: 'Updated!'
        else
          flash.now[:error] = 'Failed to update!'
          render :edit
        end
    end

    def destroy
        board = Board.find_by(id: params[:board_id])
        task = board.tasks.find_by(id: params[:id])
        task.destroy
        redirect_to board_tasks_path(board_id: board.id), notice: 'Deleted!'
    end


    private
    def task_params
        params.require(:task).permit(:name, :content, :eyecatch)
    end

    def set_board
        @board = Board.find_by(id: params[:board_id])
    end

end

