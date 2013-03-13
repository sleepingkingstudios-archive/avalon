# spec/routing/directories_spec.rb

require 'spec_helper'

describe 'routing for directories' do
  let :controller do 'directories'; end
  let :route_hash do {
    :controller => controller,
    :action     => action,
  }; end # let
  
  describe 'at top-level' do
    let :namespace do ''; end
    
    describe :index do
      let :path   do "#{namespace}/directories"; end
      let :action do 'index'; end
      
      specify { expect(get path).to route_to route_hash }
    end # describe
  end # describe
  
  describe 'inside a namespace' do
    let :namespace do FactoryGirl.generate :directory_slug; end
    let :route_hash do super().update :path => namespace; end
    
    describe :index do
      let :path   do "#{namespace}/directories"; end
      let :action do 'index'; end
      
      specify { expect(get path).to route_to route_hash }
    end # describe
    
    describe :show do
      let :path   do "#{namespace}/"; end
      let :action do 'show'; end
      
      specify { expect(get path).to route_to route_hash }
    end # describe
  end # describe
end # describe
