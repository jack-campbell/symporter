class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :u_id, presence: true
  validates :description, presence: true, length: { maximum: 10000 }
  default_scope -> { order(created_at: :desc) }
  belongs_to :u
  scope :for_u, lambda { |u| joins(:us).where("u_id = ?", u.id)}
    has_attached_file :pic, :styles => 
        { :medium => "300x300>", :thumb => "100x100>" }
   has_attached_file :attach
  def self.search(query)
    where("name like ?", "%#{query}%") 
end
end