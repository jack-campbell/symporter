class Product < ActiveRecord::Base
   validates :u_id, presence: true
    default_scope -> { order(created_at: :desc) }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :name, presence: true, length: { maximum: 10000 }
  belongs_to :u
  scope :for_u, lambda { |u| joins(:us).where("u_id = ?", u.id)}
    has_attached_file :pic, :styles => 
        { :medium => "300x300>", :thumb => "100x100>" }
   has_attached_file :attach
  def self.search(query)
    where("name like ?", "%#{query}%") 
end
end