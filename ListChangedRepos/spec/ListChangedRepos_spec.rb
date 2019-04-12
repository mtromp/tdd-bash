require 'rspec/bash'

LIST_CHANGED_REPOS_SCRIPT='./ListChangedRepos'

describe 'TestGitStatus' do
  include Rspec::Bash
  let(:stubbed_env) { create_stubbed_env }

  let!(:git_mock) { stubbed_env.stub_command('git') }

  context 'git repository is up-to-date' do
    before(:each) do
      git_mock.outputs('On branch master\nYour branch is up to date with \'origin/master\'.\n\nnothing to commit, working tree clean')
    end

    it 'exits with zero when git repo is up-to-date' do
      @stdout, @stderr, @status = stubbed_env.execute("#{LIST_CHANGED_REPOS_SCRIPT}")
      expect(@status.exitstatus).to be == 0
    end
  end
end
