class ConfirmationInstructionEmail < Howitzer::Email
  subject 'Confirmation instructions'

  def confirm_my_account
    ConfirmationEmailPage.open(validate: false, token: token)
  end

  def confirmation_link
    res = plain_text_body[/Confirm my account \((.+?)\)/, 1]
    Howitzer::Log.info('Confirmation link was not found') if res.nil?
    res
  end

  def token
    confirmation_link[/confirmation_token=(.+)/, 1]
  end
end
