class SummariesController < ApplicationController
  GITHUB_API_URL="https://api.github.com"

  def search
    redirect_to summary_path(params[:q])
  end

  def show
    @username = params[:username]
    @user = get_user(@username)
    @repos = get_repos(@username)
    @languages = get_languages(@repos)
  end

  private

  def get_user(username)
    url = "#{GITHUB_API_URL}/users/#{username}"
    response = HTTParty.get(url)
  end

  def get_repos(username)
    url = "#{GITHUB_API_URL}/users/#{username}/repos"
    response = HTTParty.get(url)
    response.sort do |a, b|
      b["pushed_at"].to_date <=> a["pushed_at"].to_date
    end
  end

  def get_languages(repos)
    repos
      .map { |repo| repo["language"] }
      .reject { |lang| lang.blank? }
      .uniq
      .sort
      .join(", ")
  end
end
