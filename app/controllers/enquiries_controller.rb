class EnquiriesController < ApplicationController
  before_action :load_enquiry, except: [:index, :new, :create]
  before_action :set_request_variant

  def index
    @enquiries = policy_scope(Enquiry.order(:last_name).page(params[:page]).per(100))
  end

  def new
    @enquiry = Enquiry.new
    authorize @enquiry
  end

  def create
    @enquiry = Enquiry.new(enquiry_params)
    authorize @enquiry
    if @enquiry.save
      EnquiryMailer.new_enquiry_email(@enquiry).deliver
      redirect_to root_url, notice: "Your enquiry has been submitted."
    else
      render :new
    end
  end

  def destroy
    @enquiry.destroy
    redirect_to enquiries_path, notice: "Successfully destroyed enquiry."
  end

  private

  def enquiry_params
    params.require(:enquiry).permit(
      :type_of_work,
      :first_name,
      :last_name,
      :telephone,
      :email_address,
      :address_line_1,
      :address_line_2,
      :city,
      :state,
      :postal_code
    )
  end

  def load_enquiry
    @enquiry = Enquiry.find params[:id]
    authorize @enquiry
  end
  
  def set_request_variant
    request.variant = :mobile if browser.mobile?
  end
end
