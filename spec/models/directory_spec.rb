# spec/models/directory_spec.rb

require 'spec_helper'

describe Directory do
  specify { expect(described_class).to construct.with(0..1).arguments }
  
  let :attributes do FactoryGirl.attributes_for :directory; end
  let :instance do described_class.new attributes; end
  
  describe 'validation' do
    describe 'requires a title' do
      let :attributes do super().tap { |hsh| hsh.delete :title }; end
      
      specify { expect(instance).to have_errors.on(:title).
        with_message("can't be blank") }
    end # describe
    
    describe 'requires a slug' do
      let :attributes do super().tap { |hsh| hsh.delete :title }; end
      
      specify { expect(instance).to have_errors.on(:slug).
        with_message("can't be blank") }
    end # describe
  end # describe
  
  specify { expect(instance).to have_accessor(:title).with(attributes[:title]) }
  specify { expect(instance).to have_mutator(:title=).with(FactoryGirl.generate :directory_title) }
  
  specify { expect(instance).to have_accessor(:slug) }
  specify { expect(instance).not_to have_mutator(:slug=) }
  
  specify { expect(instance).to have_accessor(:path) }
  specify { expect(instance).not_to have_mutator(:path=) }
  
  context 'saved' do
    let :instance do super().tap { |rec| rec.save! }; end
    let :expected_slug do attributes[:title].parameterize.gsub(/\s+/, '_'); end
    
    specify { expect(instance).to have_accessor(:slug).with(expected_slug) }
    
    specify { expect(instance).to have_accessor(:path).with("/#{instance.slug}")}
  end # context
  
  describe 'parent-children relations' do
    let :children do [*0..2].map do FactoryGirl.create :directory; end; end
    
    specify { expect(instance).to have_accessor(:parent).with(nil) }
    specify { expect(instance).to have_accessor(:children).with([]) }
    
    context 'setting the parents' do
      before :each do children.each do |child| child.parent = instance; end; end
      
      specify { expect(instance.children).to be == children }
      specify { children.each { |child| expect(child.parent).to be instance } }
    end # context
    
    context 'setting the children' do
      before :each do instance.children = children; end
      
      specify { expect(instance.children).to be == children }
      specify { children.each { |child| expect(child.parent).to be instance } }
    end # context
  end # describe
  
  describe 'with an ancestry chain' do
    let :ancestors do [].tap do |ary| [*0..2].each do
      ary << FactoryGirl.create(:directory, :parent => ary.last)
    end; end; end # each; tap; let
    
    let :instance do super().tap { |rec| rec.parent = ancestors.last; rec.save! }; end
    let :path do '/' + (ancestors.map(&:slug) << instance.slug).join('/'); end
    
    specify { expect(instance.path).to be == path }
  end # describe
  
  describe 'normalizes slugs' do
    let :attributes do super().update :title => "Zweihänder"; end
    let :instance do super().tap { |rec| rec.save }; end
    
    specify { expect(instance.slug).to be == "zweihander" }
  end # describe
end # describe
