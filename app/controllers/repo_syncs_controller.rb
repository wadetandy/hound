class RepoSyncsController < ApplicationController
  def create
    unless current_user.refreshing_repos?
      current_user.update_attribute(:refreshing_repos, true)

      RepoSynchronizationJob.new.perform(
        current_user,
        session[:github_token]
      )
    end

    head 201
  end
end
