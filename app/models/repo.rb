class Repo < ActiveRecord::Base
  has_many :builds
  has_many :memberships, dependent: :destroy
  belongs_to :owner
  has_many :users, through: :memberships

  alias_attribute :name, :full_github_name

  validates :full_github_name, uniqueness: true, presence: true
  validates :github_id, uniqueness: true, presence: true

  def self.active
    where(active: true)
  end

  def self.find_or_create_with(attributes)
    repo = find_by(full_github_name: attributes[:full_github_name]) ||
      find_by(github_id: attributes[:github_id]) ||
      Repo.new

    repo.update!(attributes)

    repo
  end

  def self.find_and_update(github_id, repo_name)
    repo = find_by(github_id: github_id)

    if repo && repo.full_github_name != repo_name
      repo.update(full_github_name: repo_name)
    end

    repo
  end

  def activate
    update(active: true)
  end

  def deactivate
    update(active: false)
  end

  def exempt?
    true
  end

  def total_violations
    Violation.joins(:build).where(builds: { repo_id: id }).count
  end

  private

  def organization
    if full_github_name
      full_github_name.split("/").first
    end
  end
end
