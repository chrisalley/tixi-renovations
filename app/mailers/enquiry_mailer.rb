class EnquiryMailer < ActionMailer::Base
  default from: 'info@tixirenovations.com'
 
  def new_enquiry_email(enquiry)
    @enquiry = enquiry
    mail to: 'chris@chrisalley.info', subject: 'New Enquiry'
  end
end
