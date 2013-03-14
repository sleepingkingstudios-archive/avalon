# spec/features/destroy_directory_spec.rb

require 'spec_helper'

feature 'User destroys a directory' do
  def destroy_directory
    parent_path = parent ? parent.path : ''
    
    visit "#{parent_path}/directories"
    expect(current_path).to be == "#{parent_path}/directories"
    
    click_link "destroy-directory-#{directory.slug}-link"
  end # method destroy_directory
  
  let :directory do FactoryGirl.create :directory, :parent => parent; end
  
  context 'at top level' do
    let :parent do nil; end
    
    scenario do
      path = directory.path
      destroy_directory
      
      directory = Directory.where :path => path
      expect(directory).not_to exist
      
      expect(current_path).to be == '/'
    end # scenario
  end # context
  
  context 'with a parent directory' do
    let :parent do FactoryGirl.create :directory; end
    
    scenario do
      path = directory.path
      destroy_directory
      
      directory = Directory.where :path => path
      expect(directory).not_to exist
      
      expect(current_path).to be == parent.path
    end # scenario
  end # context
end # feature
