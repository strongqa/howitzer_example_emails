class ResetPasswordConfirmationEmail < Howitzer::Email
  subject 'Reset password instructions'

  def reset_password
    ChangePasswordPage.open(token: token)
  end

  def reset_password_link
    res = plain_text_body[%r{<a href="([^"]+)">Change my password</a>}, 1]
    Howitzer::Log.info('Confirmation link was not found') if res.nil?
    res
  end

  def token
    reset_password_link[/reset_password_token=(.+)/, 1]
  end
end
