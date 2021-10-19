class BoardsController < ApplicationController

    def index
        @boards = Board.all
    end

    def show
    end

    def new
        @board = Board.new
    end

    def create
        @board = Board.new(board_params)
        if @board.save
            redirect_to boards_path, notice: '保存しました'
        else
            flash.now[:error] = '保存に失敗しました'
            render :new
        end
        
    end

    def edit
    end

    def update
    end

    def destroy
    end
    
    private
    def board_params
        params.require(:board).permit(:name, :content)
    end
    
end
