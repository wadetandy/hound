class RepoSynchronization
  pattr_initialize :user, :github_token
  attr_reader :user

  def start
    user.repos.clear
    repos = api.repos

    repo_list = []
    Repo.transaction do
      repos.each do |resource|
        attributes = repo_attributes(resource.to_hash)
        repo_list << Repo.find_or_create_with(attributes)
      end

      user.repos = repo_list
    end
  end

  private

  def api
    @api ||= GithubApi.new(github_token)
  end

  def repo_attributes(attributes)
    owner = upsert_owner(attributes[:owner])

    {
      private: attributes[:private],
      github_id: attributes[:id],
      full_github_name: attributes[:full_name],
      in_organization: attributes[:owner][:type] == GithubApi::ORGANIZATION_TYPE,
      owner: owner,
    }
  end

  def upsert_owner(owner_attributes)
    Owner.upsert(
      github_id: owner_attributes[:id],
      name: owner_attributes[:login],
      organization: owner_attributes[:type] == GithubApi::ORGANIZATION_TYPE
    )
  end
end
