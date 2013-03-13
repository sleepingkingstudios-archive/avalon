# spec/features/directories/list_directory_spec.rb

require 'spec_helper'

feature 'listing all root directories' do
  scenario 'User visits root directory list' do
    [*0..2].each do FactoryGirl.create :directory; end
    
    visit '/directories'
    
    expect(current_path).to be == '/directories'
    expect(page).to have_text "Root Directory"
  end # scenario
  
  describe 'with empty namespaced directory' do
    let :directory do FactoryGirl.create Directory; end
    
    scenario 'User visits namespaced directory list' do
      visit "#{directory.path}/directories"
      
      expect(current_path).to be == "#{directory.path}/directories"
      expect(page).to have_text directory.title
    end # scenario
  end # describe
end # feature
