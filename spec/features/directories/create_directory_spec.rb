# spec/features/create_directory_spec.rb

require 'spec_helper'

feature 'User creates a directory' do
  def create_directory attributes
    parent_path = parent ? parent.path : ''
    
    visit "#{parent_path}/directories"
    expect(current_path).to be == "#{parent_path}/directories"
    
    click_link 'Create Directory'
    expect(current_path).to be == "#{parent_path}/directories/new"
    
    fill_in 'directory_title', :with => attributes[:title]
    
    click_button 'Create Directory'
  end # method create_directory
  
  context 'at top level' do
    let :parent do nil; end
    
    scenario 'with valid attributes' do
      attributes = FactoryGirl.attributes_for :directory
      create_directory attributes
      
      directory = Directory.find_by :path => "/#{attributes[:title].parameterize.gsub(/\s+/, '_')}"
      expect(directory.new_record?).to be false
      expect(directory.parent).to be parent

      expect(current_path).to be == directory.path
    end # scenario
    
    scenario 'with invalid attributes' do
      attributes = { :title => '' }
      
      create_directory attributes
      
      directory = Directory.where :path => "/#{attributes[:title].parameterize.gsub(/\s+/, '_')}"
      expect(directory).not_to exist

      expect(current_path).to be == '/directories'
      expect(page).to have_selector "form.new_directory"
    end # scenario
  end # context
  
  context 'with parent directory' do
    let :parent do FactoryGirl.create :directory; end
    
    scenario 'with valid attributes' do
      attributes = FactoryGirl.attributes_for :directory
      create_directory attributes
      
      directory = Directory.find_by :path => "#{parent.path}/#{attributes[:title].parameterize.gsub(/\s+/, '_')}"
      expect(directory.new_record?).to be false
      expect(directory.parent).to be == parent

      expect(current_path).to be == directory.path
    end # scenario
    
    scenario 'with invalid attributes' do
      attributes = { :title => '' }
      
      create_directory attributes
      
      directory = Directory.where :path => "#{parent.path}/#{attributes[:title].parameterize.gsub(/\s+/, '_')}"
      expect(directory).not_to exist

      expect(current_path).to be == "#{parent.path}/directories"
      expect(page).to have_selector "form.new_directory"
    end # scenario
  end # context
end # feature
