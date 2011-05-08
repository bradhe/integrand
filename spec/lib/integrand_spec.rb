require 'spec_helper'

describe Integrand::Application do
  describe 'configuration stuff' do
    it 'should have a source_dir configured' do
      Integrand::Application.source_dir.should_not be_empty
    end
  end
end
