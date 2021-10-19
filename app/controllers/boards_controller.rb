class BoardsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
        @board = Board.find_by(id: params[:id])
    end

    def update
        @board = Board.find_by(id: params[:id])
        if @board.update(board_params)
            redirect_to boards_path, notice: '更新しました'
        else
            flash.now[:error] = '更新に失敗しました'
            render :edit
        end
    end

    def destroy
        board = Board.find_by(id: params[:id])
        board.destroy
        redirect_to boards_path, notice: '記事を削除しました'
    end
    
    private
    def board_params
        params.require(:board).permit(:name, :content)
    end
    
end
