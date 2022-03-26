class MicropostsController < ApplicationController
  # GET /microposts
  def index
    @micropost = Micropost.new
    @pagy, @microposts = pagy(Micropost.all.order(id: :desc))
  end

  # POST /microposts
  def create
    @micropost = Micropost.new(micropost_params)

    if @micropost.save
      redirect_to microposts_path, flash: { success: '投稿に成功しました' }
    else
      redirect_to microposts_path, flash: { error: '投稿に失敗しました' }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def micropost_params
    params.require(:micropost).permit(:content, :posted_at)
  end
end
