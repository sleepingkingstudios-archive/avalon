# spec/support/factories/directory_factory.rb

FactoryGirl.define do
  sequence :directory_title do |index| "Directory #{index}"; end
  sequence :directory_slug  do
    FactoryGirl.generate(:directory_title).underscore.gsub /\s+/, '_'
  end # sequence
  
  factory :directory do
    title { generate :directory_title }
  end # factory
end # define
