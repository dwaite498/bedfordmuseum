module IndexHelper
  def update_user(user)
    if Date.current.today? || Date.current.future?
      puts "cheese"
      # user.update(expires_at => expires_at + 1.year)
      # user.expires_at = user.expires_at + 1.year
    else
      puts "danish"
      # user.update(expires_at => DateTime.now + 1.year)
    end
  end
end
