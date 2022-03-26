class MicropostsController < ApplicationController
  # GET /microposts
  def index
    @micropost = Micropost.new
    @pagy, @microposts = pagy(Micropost.all)
  end

  # POST /microposts
  def create
    @micropost = Micropost.new(micropost_params, posted_at: Date.current)

    if @micropost.save
      redirect_to @micropost, flash: { success: '投稿に成功しました' }
    else
      flash.now[:error] = '投稿に失敗しました'
      render :new
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
