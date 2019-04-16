require 'rspec/bash'

SCRIPT='./ListChangedRepos'

MASTER_BRANCH="On branch master\nYour branch is up to date with \'origin/master\'.\n\n"
CLEAN_DIR="nothing to commit, working tree clean"
DIRTY_DIR="Changes not staged for commit:\n"
ADD_HELP="(use git add <file>... to update what will be committed)\n"
CHECKOUT_HELP="(use git checkout -- <file>... to discard changes in working directory)\n"
MASTER_AHEAD="On branch master\nYour branch is ahead of \'origin/master\' by 1 commit.\n"
PUSH_HELP="  (use \"git push\" to publish your local commits)\n\n"

PWD_DIRECTORY='/Users/mtromp/workspace'

describe 'TestGitStatus' do
  include Rspec::Bash
  let(:stubbed_env) { create_stubbed_env }

  let!(:git_mock) { stubbed_env.stub_command('git') }
  let!(:pwd_mock) { stubbed_env.stub_command('pwd') }

  context 'git repository is up-to-date' do
    before(:each) do
      git_mock.with_args('status')
        .outputs("#{MASTER_BRANCH}#{CLEAN_DIR}")
    end

    it 'exits with zero when git repo is up-to-date' do
      @stdout, @stderr, @status = stubbed_env.execute("#{SCRIPT}")
      expect(@status.exitstatus).to be == 0
    end
    it 'does not print anything to stdout' do
      @stdout, @stderr, @status = stubbed_env.execute("#{SCRIPT}")
      expect(@stdout).to be_empty
    end
  end

  context 'git repository has changed files' do
    before(:each) do
      git_mock.with_args('status')
        .returns_exitstatus(0)
        .outputs("#{MASTER_BRANCH}#{DIRTY_DIR}#{ADD_HELP}#{CHECKOUT_HELP}")
      pwd_mock.outputs("#{PWD_DIRECTORY}")
    end

    it 'prints directory when repo has changed files' do
      @stdout, @stderr, @status = stubbed_env.execute("#{SCRIPT}")
      expect(@stdout).to be == "#{PWD_DIRECTORY}\n"
    end
  end
  context 'git repository is ahead of remote' do
    before(:each) do
      git_mock.with_args('status')
              .returns_exitstatus(0)
              .outputs("#{MASTER_AHEAD}#{PUSH_HELP}#{CLEAN_DIR}")
      pwd_mock.outputs("#{PWD_DIRECTORY}")
    end

    it 'prints directory when local commits exist' do
      @stdout, @stderr, @status = stubbed_env.execute("#{SCRIPT}")
      expect(@stdout).to be == "#{PWD_DIRECTORY}\n"
    end
  end
end
