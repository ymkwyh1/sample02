class ProfilesController < ApplicationController

    def show
        @profile = current_user.profile
    end
    
    def edit
        @profile = current_user.profile || current_user.build_profile
    end
    
    def update
        @profile = current_user.profile || current_user.build_profile
        @profile.assign_attributes(profile_params)
        if @profile.save
            redirect_to profile_path, notice: 'プロフィール更新！'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end
    
    private
    def profile_params
        params.require(:profile).permit(
        :avatar,
        :nickname,
        :introduction,
        )
    end
    
end


