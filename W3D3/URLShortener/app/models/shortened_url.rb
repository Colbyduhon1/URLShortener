class Shortened_URL < ActiveRecord::Base
  validates :short_url, uniqueness: true, presence: true
  validates :long_url, :user_id,  presence: true

  belongs_to(
    :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
  )

  def self.random_code
    short_url = SecureRandom.urlsafe_base64
    if Shortened_URL.exists?(short_url)
      short_url = SecureRandom.urlsafe_base64
    else
      return short_url
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = Shortened_URL.random_code
    Shortened_URL.create!({:user_id => user.id, :long_url => long_url, :short_url => short_url })
  end



end
