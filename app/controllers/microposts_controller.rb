class MicropostsController < ApplicationController
  # GET /microposts
  def index
    @micropost = Micropost.new
    @microposts = Micropost.order(id: :desc).page(params[:page])
  end

  # POST /microposts
  def create
    @micropost = Micropost.new(micropost_params)

    if @micropost.save
      redirect_to microposts_path, flash: { success: '投稿に成功しました' }
    else
      @microposts = Micropost.order(id: :desc).page(params[:page])
      flash[:error] = '投稿に失敗しました'
      render :index
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def micropost_params
    params.require(:micropost).permit(:content, :posted_at)
  end
end
