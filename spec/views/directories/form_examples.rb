# spec/views/directories/form_examples.rb

shared_examples_for :directory_form do
  specify 'has the create directory form' do
    expect(page).to have_selector "form.new_directory"
  end # specify
  
  let :form do page.find("form.new_directory"); end
  
  specify { expect(form).to have_button 'Create Directory' }
  
  specify { expect(form).to have_field 'directory_title', :with => attributes[:title] }
end # shared examples
