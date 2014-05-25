module UsersHelper
  def link_to_twitter name
    link_to "@#{name.downcase}", "https://twitter.com/#{name.downcase}"
  end
end
