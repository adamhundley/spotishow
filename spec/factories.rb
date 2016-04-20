FactoryGirl.define do
  factory :user_artist do
    user nil
    artist nil
  end
  factory :artist do
    name "John Mayer"
    spotify_id "MyString"
    spotify_uri "MyString"
    spotify_popularity 1
    spotify_image_url "MyString"
    bit_image_url "MyString"
    website "MyString"
    facebook_url "MyString"
    facebook_tour_url "MyString"
  end
  factory :user do
    email "adamhundley@gmail.com"
    uid "adamhundley"
    name "Adam Hundley"
    nickname "MyString"
    spotify "MyString"
    image "MyString"
    token "MyString"
    refresh_token "MyString"
    token_expire "2016-04-18 18:34:14"
    url "MyString"
  end
end
