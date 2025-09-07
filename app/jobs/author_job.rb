class AuthorJob < ApplicationJob
  queue_as :default

  def perform(author)
    # Do something with the author
  end
end