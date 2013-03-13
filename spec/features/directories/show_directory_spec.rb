# spec/features/directories/show_directory_spec.rb

require 'spec_helper'

feature 'visiting a root directory' do
  let :directory do FactoryGirl.build Directory; end
  let :path do "/#{directory.slug}"; end
  
  scenario 'User visits an invalid Directory' do
    visit path
    
    expect(current_path).to be == '/'
  end # describe
  
  scenario 'User visits an existing Directory' do
    directory.save!
    
    visit path
    
    expect(current_path).to be == path
    
    expect(page).to have_text directory.title
  end # scenario
end # feature
