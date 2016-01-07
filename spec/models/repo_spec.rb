require "rails_helper"

describe Repo do
  it { should have_many :builds }
  it { should validate_presence_of :full_github_name }
  it { should validate_presence_of :github_id }
  it { should belong_to :owner }
  it { should have_many(:users).through(:memberships) }
  it { should have_many(:memberships).dependent(:destroy) }

  it "validates uniqueness of github_id" do
    create(:repo)

    expect(subject).to validate_uniqueness_of(:github_id)
  end

  describe "#exempt?" do
    it "returns true" do
      repo = Repo.new(full_github_name: "thoughtbot/hound")

      expect(repo).to be_exempt
    end
  end

  describe "#activate" do
    it "updates repo active value to true" do
      repo = create(:repo, active: false)

      repo.activate

      expect(repo.reload).to be_active
    end
  end

  describe "#deactivate" do
    it "updates repo active value to false" do
      repo = create(:repo, active: true)

      repo.deactivate

      expect(repo.reload).not_to be_active
    end
  end

  describe ".find_or_create_with" do
    context "with existing github name" do
      it "updates attributes" do
        repo = create(:repo, github_id: 1)
        new_attributes = { github_id: 2, full_github_name: repo.name }

        Repo.find_or_create_with(new_attributes)
        repo.reload

        expect(Repo.count).to eq 1
        expect(repo.name).to eq new_attributes[:full_github_name]
        expect(repo.github_id).to eq new_attributes[:github_id]
      end
    end

    context "with existing github id" do
      it "updates attributes" do
        repo = create(:repo, full_github_name: "foo")
        new_attributes = { github_id: repo.github_id, full_github_name: "bar" }

        Repo.find_or_create_with(new_attributes)
        repo.reload

        expect(Repo.count).to eq 1
        expect(repo.github_id).to eq new_attributes[:github_id]
        expect(repo.name).to eq new_attributes[:full_github_name]
      end
    end

    context "with new repo" do
      it "creates repo with attributes" do
        repo = Repo.find_or_create_with(attributes_for(:repo))

        expect(Repo.count).to eq 1
        expect(repo.reload).to be_present
      end
    end
  end

  describe ".find_and_update" do
    context "when repo name doesn't match db record" do
      it "updates the record" do
        new_repo_name = "new/name"
        repo = create(:repo, name: "foo/bar")

        Repo.find_and_update(repo.github_id, new_repo_name)
        repo.reload

        expect(repo.full_github_name).to eq new_repo_name
      end
    end
  end

  def without_exempt_organizations
    allow(ENV).to receive(:[]).with("EXEMPT_ORGS")
  end
end
