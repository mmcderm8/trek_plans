class UserMailer < ApplicationMailer
  default from: 'trekplan.welcomer@gmail.com'

  def new_review(review)
    @activity = Activity.find(review.activity_id)
    @email = @activity.creator.email
    mail(
      to: @email,
      subject: 'Someone has reviewed your activity on Trek Plan!'
      )
  end
end
