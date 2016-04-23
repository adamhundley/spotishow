class ShowFinder < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(user)
    UserShowCreator.new(user)
  end
end
