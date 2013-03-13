# spec/views/directories/new_spec.rb

require 'spec_helper'
require 'views/directories/form_examples'

describe 'directories/new' do
  let :directory do Directory.new attributes; end
  let :page do Capybara.string(rendered); end
  
  before :each do
    assign :directory, directory
    render
  end # before each
  
  context 'with no attributes' do
    let :attributes do {}; end
    
    it_behaves_like :directory_form
  end # context
  
  context 'with defined attributes' do
    let :attributes do FactoryGirl.attributes_for :directory; end
    
    it_behaves_like :directory_form
  end # context
end # describe
