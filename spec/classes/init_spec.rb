require 'spec_helper'
describe 'hostnamefacts' do

  context 'with defaults for all parameters' do
    it { should contain_class('hostnamefacts') }
  end
end
