class BuildRunner
  pattr_initialize :payload

  def run
    if relevant_pull_request?
      track_subscribed_build_started
      create_pending_status
      upsert_owner
      repo.builds.create!(
        violations: violations,
        pull_request_number: payload.pull_request_number,
        commit_sha: payload.head_sha,
      )
      commenter.comment_on_violations(priority_violations)
      create_success_status
      track_subscribed_build_completed
    end
  end

  def relevant_pull_request?
    pull_request.merged?
  end

  def pull_request
    @pull_request ||= PullRequest.new(payload, token)
  end

  def token
    @token ||= user_token || ENV["HOUND_GITHUB_TOKEN"]
  end

  def user_token
    user_with_token = repo.users.where.not(token: nil).sample
    user_with_token && user_with_token.token
  end

  def repo
    @repo ||= Repo.active.
      find_and_update(payload.github_repo_id, payload.full_repo_name)
  end
end
