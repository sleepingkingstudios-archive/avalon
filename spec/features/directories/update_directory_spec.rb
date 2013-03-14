# spec/features/create_directory_spec.rb

require 'spec_helper'

feature 'User updates a directory' do
  def update_directory directory, attributes
    parent_path = parent ? parent.path : ''
    
    visit "#{parent_path}/directories"
    expect(current_path).to be == "#{parent_path}/directories"
    
    click_link "edit-directory-#{directory.slug}-link"
    expect(current_path).to be == "#{directory.path}/edit"
    
    fill_in 'directory_title', :with => attributes[:title]
    
    click_button 'Update Directory'
  end # method create_directory
  
  let :directory do FactoryGirl.create :directory, :parent => parent; end
  
  context 'at top level' do
    let :parent do nil; end
    
    scenario 'with valid attributes' do
      attributes = FactoryGirl.attributes_for :directory
      update_directory directory, attributes
      
      directory = Directory.find_by :path => "/#{attributes[:title].parameterize.gsub(/\s+/, '_')}"
      attributes.each do |key, value|
        expect(directory[key]).to be == value
      end # each

      expect(current_path).to be == directory.path
    end # scenario
    
    scenario 'with invalid attributes' do
      cached, attributes = directory.attributes, { :title => '' }
      
      update_directory directory, attributes
      
      cached.each do |key, value|
        expect(directory[key]).to be == value
      end # each

      expect(current_path).to be == directory.path
    end # scenario
  end # context
  
  context 'with parent directory' do
    let :parent do FactoryGirl.create :directory; end
    
    scenario 'with valid attributes' do
      attributes = FactoryGirl.attributes_for :directory
      update_directory directory, attributes
      
      directory = Directory.find_by :path => "#{parent.path}/#{attributes[:title].parameterize.gsub(/\s+/, '_')}"
      attributes.each do |key, value|
        expect(directory[key]).to be == value
      end # each

      expect(current_path).to be == directory.path
    end # scenario
    
    scenario 'with invalid attributes' do
      cached, attributes = directory.attributes, { :title => '' }
      
      update_directory directory, attributes
      
      cached.each do |key, value|
        expect(directory[key]).to be == value
      end # each

      expect(current_path).to be == directory.path
    end # scenario
  end # context
end # feature
