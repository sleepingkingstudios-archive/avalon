class Directory
  include Mongoid::Document
  
  field :title, :type => String
  field :slug,  :type => String
  field :path,  :type => String
  
  belongs_to :parent, :class_name => "Directory", :inverse_of => :children
  has_many :children, :class_name => "Directory", :inverse_of => :parent
  
  validates :title, :presence => true
  validates :slug,  :presence => true, :uniqueness => { :scope => :parent }
  
  before_validation do |record|
    self[:slug] = slugify(record.title)
    self[:path] = (parent ? parent.path : '') + "/#{self.slug}"
  end # before validation
  
private
  def slugify string
    string ? string.parameterize.gsub(/\s+/, '_') : nil
  end # method slugify
  
  private :path=, :slug=
end # model Directory
