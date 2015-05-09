module NacreConfigHelper
  def nacre_user_id
    ENV["NACRE_USER_ID"]
  end

  def nacre_email
    ENV["NACRE_EMAIL"]
  end

  def nacre_password
    ENV["NACRE_PASSWORD"]
  end
end
