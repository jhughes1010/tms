require 'digest/sha1'

class User < ActiveRecord::Base
  has_one :task
  has_many :pto
  has_many :sa #sas

  

  validates_presence_of   :name
  validates_uniqueness_of :name
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  validate  :password_non_blank
  
  
  def password
    @password
  end
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password= User.encrypted_password(self.password, self.salt)
  end
  def self.authenticate(name,password)
    user=self.find_by_name(name)
    if user
      expected_password=encrypted_password(password,user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  def self.requester_list
    find(:all, :order =>"fullname").map {|u| [u.fullname, u.id]}
  end
  def self.assignee_list
    find(:all, :order =>"fullname", :conditions => "department = '3210'").map {|u| [u.fullname, u.id]}
  end
  def self.get_te
  # self.group("fullname").having("department = '3210'").order("fullname")
    find(:all, :order =>"fullname", :conditions => "department = '3210'")
  end
  
  private
    def password_non_blank
    errors.add(:password, "missing password") if hashed_password.blank?
  end
  def self.encrypted_password(password,salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s    
  end

end

