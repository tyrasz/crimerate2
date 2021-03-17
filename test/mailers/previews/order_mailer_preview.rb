# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def order
    user = User.last
    # This is how you pass value to params[:user] inside mailer definition!
    OrderMailer.with(user: user).order
  end
end
