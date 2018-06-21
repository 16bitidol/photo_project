class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :twitter_create]
  before_action :twitter_client, only: [:twitter_create]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create

    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_path, notice: '写真のアップロードできました！' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def twitter_create
    media_url = File.join(root_url(only_path: false), @photo.picture_url)
    media = open(media_url)
    @client.update_with_media("テスト", media) if @client
    flash[:notice] = "#{@photo.title} をつぶやきました。"

    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id] || params[:photo_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :picture)
    end

   def twitter_client
     return @client = nil if session[:user_id].blank?

     user = User.find(session[:user_id])
     @client = Twitter::REST::Client.new do |config|
       config.consumer_key = user.consumer_key
       config.consumer_secret = user.consumer_secret
       config.access_token = user.token
       config.access_token_secret = user.secret
     end
  end
end
