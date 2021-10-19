class TasksController < ApplicationController

    def index
        @board = Board.find_by(id: params[:board_id])
        @tasks = @board.tasks.all
    end

    def new
        @board = Board.find_by(id: params[:board_id])
        @task = @board.tasks.build
    end

    def create
        @board = Board.find_by(id: params[:board_id])
        @task = @board.tasks.build(task_params)
        @task.user_id = current_user.id
        if @task.save
            redirect_to board_tasks_path(board_id: @board.id), notice: '保存しました'
        else
            flash.now[:error] = '保存に失敗しました'
            render :new
        end
    end

    def edit
        @board = current_user.boards.find_by(id: params[:board_id])
        @task = @board.tasks.find_by(id: params[:id])
    end

    def update
        @board = current_user.boards.find_by(id: params[:board_id])
        @task = @board.tasks.find_by(id: params[:id])
        if @task.update(task_params)
          redirect_to board_tasks_path(board_id: @board.id), notice: '更新しました'
        else
          flash.now[:error] = '更新に失敗しました'
          render :edit
        end
    end

    def destroy
        @board = current_user.boards.find_by(id: params[:board_id])
        task = @board.tasks.find_by(id: params[:id])
        task.destroy
        redirect_to board_tasks_path(board_id: @board.id), notice: '記事を削除しました'
    end


    private
    def task_params
        params.require(:task).permit(:name, :content)
    end

end