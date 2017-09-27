class GetGithubUserDataJob < ApplicationJob
  queue_as :default

  def perform(summary_id)
    summary = Summary.find(summary_id)
    summary.get_user
    summary.get_repos
    summary.save
  end
end
