class BoardsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @boards = Board.all
    end

    def show
    end

    def new
        @board = current_user.boards.build
    end

    def create
        @board = current_user.boards.build(board_params)
        if @board.save
            redirect_to boards_path, notice: 'Saved!'
        else
            flash.now[:error] = 'Failed to save!'
            render :new
        end
        
    end

    def edit
        @board = current_user.boards.find_by(id: params[:id])
    end

    def update
        @board = current_user.boards.find_by(id: params[:id])
        if @board.update(board_params)
            redirect_to boards_path, notice: 'Updated!'
        else
            flash.now[:error] = 'failed to update!'
            render :edit
        end
    end

    def destroy
        board = current_user.boards.find_by(id: params[:id])
        board.destroy
        redirect_to boards_path, notice: 'Deleted!'
    end
    
    private
    def board_params
        params.require(:board).permit(:name, :content)
    end
    
end
