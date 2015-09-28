class Sponsor < User
  def company_name
    last_name
  end
end
