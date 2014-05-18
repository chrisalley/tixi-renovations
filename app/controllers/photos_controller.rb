class PhotosController < ApplicationController
  before_action :load_photo, except: [:index, :new, :create]

  def index
    @photos = policy_scope(Photo.order(:created_at))
  end

  def new
    @photo = Photo.new
    authorize @photo
  end

  def create
    @photo = Photo.new(photo_params)
    authorize @photo
    if @photo.save
      redirect_to photos_path, notice: "Successfully created photo."
    else
      render :new
    end
  end

  def update
    if @photo.update_attributes(photo_params)
      redirect_to photos_path, notice: "Successfully updated photo."
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice: "Successfully destroyed photo."
  end

  private

  def photo_params
    params.require(:photo).permit(
      :description,
      :photo,
      :photo_cache,
      :published
    )
  end

  def load_photo
    @photo = Photo.find params[:id]
    authorize @photo
  end
end
