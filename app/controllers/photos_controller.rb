class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  protect_from_forgery except: [:create, :update]

  # GET /photos
  # GET /photos.json
  def index
    if params.key?(:sq)
      search_params = {}
      search_params.merge!(original_search_params)
      @photos = Photo.search(search_params).result(distinct: true).page(params[:page])
      @page_h1 = '検索結果'
    elsif params[:tag]
      @photos = Photo.tagged_with(params[:tag]).page(params[:page])
      @page_h1 = "タグ結果 - #{params[:tag]}"
    else
      @photos = Photo.page(params[:page])
      @page_h1 = '写真一覧'
    end
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
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
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

  def tag_cloud
    @tags = Photo.tag_counts_on(:tags)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:number, :place, :shot_date, :shot_time, :film, :camera, :lens, :capture_office, :comment, :volume, :path, :file_name, :md5, :file_size, :image, :image_cache, :remove_image, :tag_list)
    end

    def original_search_params
      ret = {}
      return ret unless params.key?(:sq)

      ret.merge!({ photo_number_cont_any: params[:sq][:photo_number].split(' ') }) if params[:sq].key?(:photo_number) && !params[:sq][:photo_number].blank?
      ret.merge!({ place_cont_any: params[:sq][:place].split(' ') }) if params[:sq].key?(:place) && !params[:sq][:place].blank?
      ret.merge!({ shot_date_cont_any: params[:sq][:shot_date].split(' ') }) if params[:sq].key?(:shot_date) && !params[:sq][:shot_date].blank?
      ret.merge!({ shot_time_cont_any: params[:sq][:shot_time].split(' ') }) if params[:sq].key?(:shot_time) && !params[:sq][:shot_time].blank?
      ret.merge!({ film_cont_any: params[:sq][:film].split(' ') }) if params[:sq].key?(:film) && !params[:sq][:film].blank?
      ret.merge!({ camera_cont_any: params[:sq][:camera].split(' ') }) if params[:sq].key?(:camera) && !params[:sq][:camera].blank?
      ret.merge!({ lens_cont_any: params[:sq][:lens].split(' ') }) if params[:sq].key?(:lens) && !params[:sq][:lens].blank?
      ret.merge!({ capture_office_cont_any: params[:sq][:capture_office].split(' ') }) if params[:sq].key?(:capture_office) && !params[:sq][:capture_office].blank?
      ret.merge!({ comment_cont_any: params[:sq][:comment].split(' ') }) if params[:sq].key?(:comment) && !params[:sq][:comment].blank?
      ret.merge!({ volume_cont_any: params[:sq][:volume].split(' ') }) if params[:sq].key?(:volume) && !params[:sq][:volume].blank?
      ret.merge!({ path_cont_any: params[:sq][:path].split(' ') }) if params[:sq].key?(:path) && !params[:sq][:path].blank?
      ret.merge!({ file_name_cont_any: params[:sq][:file_name].split(' ') }) if params[:sq].key?(:file_name) && !params[:sq][:file_name].blank?
      ret.merge!({ md5_cont_any: params[:sq][:md5].split(' ') }) if params[:sq].key?(:md5) && !params[:sq][:md5].blank?
      ret.merge!({ file_size_cont_any: params[:sq][:file_size].split(' ') }) if params[:sq].key?(:file_size) && !params[:sq][:file_size].blank?


      return ret
    end
end
