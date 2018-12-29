class BlogsController < UsersController
  before_action :authenticate_user!, :only => [:show,:new,:create,:destroy,:create,:edit,:update]
  before_action :find_blog, :only => [:show,:destroy,:edit,:update]
  
  def show
    @blog = Blog.find_by(id:params[:id])
  end
  
  def new
    @blog = current_user.blogs.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      flash[:success] = "Blog created!"
      redirect_to @blog
    else
      @feed_items = []
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render  :edit
    end
  end
  
  def destroy
    if @blog.destroy
      redirect_to current_user
    else
      redirect_to @blog
    end
  end
  
  private

    def blog_params
      params.require(:blog).permit(:title,:image,:content)
    end
    
    def find_blog
      @blog = Blog.find(params[:id])
    end
    
end
