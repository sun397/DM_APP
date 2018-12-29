class User < ApplicationRecord
  validates :email, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :blogs, dependent: :destroy
  
  def feed
    Blog.where("user_id = ?", id)
  end
end
