class User < ActiveRecord::Base
validates :email, presence: true, uniqueness: true

has_many(
  :shortened_urls,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "Shortened_URL"
)

has_many(
  :visits,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "Visit"
)

has_many(
   :visited_urls,
    # { distinct },
   through: :visits,
   source: "Shortened_URL"
 )


end
