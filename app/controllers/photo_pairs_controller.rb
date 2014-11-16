class PhotoPairsController < ApplicationController
  before_action :load_photo_pair, except: [:index, :gallery, :new, :create]
  before_action :set_request_variant

  def index
    @photo_pairs = policy_scope(PhotoPair.order(:created_at))
  end

  def gallery
    @photo_pairs = policy_scope(PhotoPair.where(published: true).order(:created_at))
  end

  def new
    @photo_pair = PhotoPair.new
    authorize @photo_pair
  end

  def create
    @photo_pair = PhotoPair.new(photo_pair_params)
    authorize @photo_pair
    if @photo_pair.save
      redirect_to photo_pairs_path, notice: "Successfully created photo pair."
    else
      render :new
    end
  end

  def update
    if @photo_pair.update_attributes(photo_pair_params)
      redirect_to photo_pairs_path, notice: "Successfully updated photo pair."
    else
      render :edit
    end
  end

  def destroy
    @photo_pair.destroy
    redirect_to photo_pairs_path, notice: "Successfully destroyed photo pair."
  end

  private

  def photo_pair_params
    params.require(:photo_pair).permit(
      :caption,
      :before_photo,
      :before_photo_cache,
      :after_photo,
      :after_photo_cache,
      :published
    )
  end

  def load_photo_pair
    @photo_pair = PhotoPair.find params[:id]
    authorize @photo_pair
  end

  def set_request_variant
    request.variant = :mobile if browser.mobile?
  end
end
