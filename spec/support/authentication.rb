module Authentication
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      provider: "spotify",
      uid: "adamhundley",
      info: {
        name: "Adam Hundley",
        screen_name: "adamhundley",
        email: "adamhundley@gmail.com",

        urls: {
          spotify: "https://open.spotify.com/user/adamhundley"
        },
        image: "https://scontent.xx.fbcdn.net/hprofile-xfp1/v/t1.0-1/p200x200/12049656_10100204503401754_3715087154579945830_n.jpg?oh=f7d96813ab87b164df6f41f4265d7d7b&oe=57B548E1"
      },
      credentials: {
        token: "token",
        refresh_token: 1461029417
      },
      extras: {
        raw_info: {
          href: "https://api.spotify.com/v1/users/adamhundley"
        }
      }
    })
  end
end
