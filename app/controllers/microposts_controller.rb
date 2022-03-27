class MicropostsController < ApplicationController
  # GET /microposts
  def index
    @micropost = Micropost.new
    pagainated_all_microposts
  end

  # POST /microposts
  def create
    @micropost = Micropost.new(micropost_params)

    if @micropost.save
      redirect_to microposts_path, flash: { success: '投稿に成功しました' }
    else
      pagainated_all_microposts
      flash[:error] = '投稿に失敗しました'
      render :index
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def micropost_params
    params.require(:micropost).permit(:content, :posted_at)
  end

  def pagainated_all_microposts
    @pagy, @microposts = pagy(Micropost.all.order(id: :desc))
  end
end
