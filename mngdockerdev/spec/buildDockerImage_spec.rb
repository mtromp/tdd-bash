require 'rspec/bash'

BUILD_IMAGE_SCRIPT='./buildDockerImage'
describe 'TestBuildDockerImage' do
  include Rspec::Bash
  let(:stubbed_env) { create_stubbed_env }

  context 'help message is displayed' do
    it 'exits zero when run' do
      @stdout, @stderr, @status = stubbed_env.execute(BUILD_IMAGE_SCRIPT)
      expect(@status.exitstatus).to eq 0
    end
    it 'returns help message' do
      @stdout, @stderr, @status = stubbed_env.execute(BUILD_IMAGE_SCRIPT)
      expect(@stdout).to include('buildDockerImage')
    end
  end

end
