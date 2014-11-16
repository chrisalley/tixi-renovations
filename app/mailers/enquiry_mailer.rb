class EnquiryMailer < ActionMailer::Base
  default from: 'info@tixirenovations.com'

  def new_enquiry_email(enquiry)
    @enquiry = enquiry
    mail to: 'info@tixirenovations.com', subject: 'New Enquiry'
  end
end
