class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:show,:index,:new]
  
  def index
    @users=User.all
    @blog = current_user.blogs.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end
  
  def new
    @blog = current_user.blogs.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def show
    @users=User.all
    @user=User.find(params[:id])
    @blogs = @user.blogs.paginate(page: params[:page], :per_page => 6)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
  
  private
   
    def blog_params
      params.require(:blog).permit(:title,:image,:content)
    end

end
