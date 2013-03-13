# spec/features/create_directory_spec.rb

require 'spec_helper'

feature 'User creates a directory' do
  context 'at top level' do
    scenario 'with valid attributes' do
      visit '/directories'
      expect(current_path).to be == '/directories'
      
      click_link 'Create Directory'
      expect(current_path).to be == '/directories/new'
      
      attributes = FactoryGirl.attributes_for :directory
      
      fill_in 'directory_title', :with => attributes[:title]
      
      click_button 'Create Directory'
      
      directory = Directory.find_by :path => "/#{attributes[:title].parameterize.gsub(/\s+/, '_')}"
      expect(directory.new_record?).to be false
      
      expect(current_path).to be == directory.path
    end # scenario
  end # context
end # feature
