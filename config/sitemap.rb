# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
# for examples of multiple hosts and folders.
host "www.ithaka.io"

sitemap :site do
  url root_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url new_user_registration_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url new_user_session_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url page_url('how-it-works'), last_mod: Time.now, change_freq: "daily", priority: 1.0
  url page_url('about'), last_mod: Time.now, change_freq: "daily", priority: 1.0
end

ping_with "http://#{host}/sitemap.xml"
