class ResetPasswordConfirmationEmail < Howitzer::Email
  SUBJECT = "Reset password instructions"

  def confirm_my_account
    Howitzer::Web::Page.visit confirmation_link
  end

  def confirmation_link
    res = plain_text_body[/Change my password \((.+?)\)/, 1]
    log.error("Confirmation link was not found") if res.nil?
    res
  end
end
