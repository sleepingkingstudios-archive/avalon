# spec/views/directories/new_spec.rb

require 'spec_helper'

describe 'directories/new' do
  let :directory do Directory.new attributes; end
  let :page do Capybara.string(rendered); end
  
  before :each do
    assign :directory, directory
    render
  end # before each
  
  context 'with no attributes' do
    let :attributes do {}; end
    let :form do page.find("form#new_directory_#{directory.id}"); end
    
    specify 'has the create directory form' do
      expect(rendered).to have_selector "form#new_directory_#{directory.id}"
    end # specify
    
    specify { expect(form).to have_button 'Create Directory' }
    
    specify { expect(form).to have_field 'directory_title', :with => attributes[:title] }
  end # context
end # describe
