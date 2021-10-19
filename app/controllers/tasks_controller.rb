class TasksController < ApplicationController

    def index
        @board = Board.find_by(params[:board_id])
        @tasks = @board.tasks.all
    end

    def new
    end

    def create
    end

end