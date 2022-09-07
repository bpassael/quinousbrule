class MailCountersController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def update
    @mail_counter = MailCounter.first
    @mail_counter.count += 1
    @mail_counter.save!

    # respond_to do |format|
    #   format.html { redirect_to mail_counter_path }
    #   format.text { render partial: "partials/community", locals: {mail_counter: @mail_counter}, formats: [:html] }
    # end
  end

end
