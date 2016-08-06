class ResetPasswordConfirmationEmail < Howitzer::Email
  subject 'Reset password instructions'

  def confirm_my_account
    ChangePasswordPage.open(token: token)
  end

  def confirmation_link
    res = plain_text_body[/Change my password \((.+?)\)/, 1]
    log.error('Confirmation link was not found') if res.nil?
    res
  end

  def token
    confirmation_link[/reset_password_token=(.+)/, 1]
  end
end
