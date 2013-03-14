# spec/views/directories/index_spec.rb

require 'spec_helper'

describe 'directories/index' do
  def self.shared_examples
    context do
      let :directory_title do directory.nil? ? "Root Directory" : directory.title; end
      
      specify 'shows directory title' do
        if directory.nil?
          expect(rendered).to have_text "Root Directory"
        else
          expect(rendered).to have_text directory.title
        end # if-else
      end # specify
      
      specify 'lists parent directory' do
        next if directory.nil?
        
        if directory.parent.nil?
          expect(rendered).to have_text "Parent Directory"
        else
          expect(rendered).to have_text directory.parent.title
        end # if-else
      end # specify
      
      specify 'lists child directories' do
        children = directory.nil? ?
          Directory.where(:parent => nil).to_a :
          directory.children
        
        expect(rendered).to have_text "Child Directories"
        
        if children.empty?
          expect(rendered).to have_text "There are no child directories."
        else
          children.each do |child|
            update_directory_path = "#{child.path}/edit"
            expect(rendered).to have_text child.title
            expect(rendered).to have_link "Update",  :href => update_directory_path
            expect(rendered).to have_link "Destroy", :href => child.path
          end # each
        end # if-else
      end # specify
      
      specify 'has create directory link' do
        new_directory_path = (directory.nil? ? '' : directory.path) + '/directories/new'
        expect(rendered).to have_link 'Create Directory', :href => new_directory_path
      end # specify
    end # context
  end # method shared_examples
  
  before :each do
    assign :directory, directory
    render
  end # before each
  
  context 'with the root directory' do
    let :directory do nil; end
    
    shared_examples
    
    context 'with top-level directories created' do
      let :directory do super().tap { |parent|
        [*0..2].map { FactoryGirl.create :directory, :parent => parent }
      }; end # tap, let
      
      shared_examples
    end # context
  end # context
  
  context 'with a top-level directory' do
    let :directory do FactoryGirl.create :directory; end
    
    shared_examples
    
    context 'with top-level directories created' do
      let :directory do super().tap { |parent|
        [*0..2].map { FactoryGirl.create :directory, :parent => parent }
      }; end # tap, let
      
      shared_examples
    end # context
  end # context
  
  context 'with a nested directory' do
    let :parent do FactoryGirl.create :directory; end
    let :directory do FactoryGirl.create :directory, :parent => parent; end
    
    shared_examples
    
    context 'with top-level directories created' do
      let :directory do super().tap { |parent|
        [*0..2].map { FactoryGirl.create :directory, :parent => parent }
      }; end # tap, let
      
      shared_examples
    end # context
  end # context
end # describe
