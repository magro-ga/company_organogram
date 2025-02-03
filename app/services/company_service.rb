class CompanyService
  def self.create_company(params)
    company = Company.new(params)

    if company.save
      { success: true, company: company }
    else
      { success: false, errors: company.errors.full_messages }
    end
  end

  def self.find_company(id)
    company = Company.find_by(id: id)

    if company
      { success: true, company: company }
    else
      { success: false, errors: ["Company not found"] }
    end
  end

  def self.find_company(id)
    company = Company.find_by(id: id)

    if company
      { success: true, company: company }
    else
      { success: false, errors: ["Company not found"] }
    end
  end

  def self.list_companies
    { success: true, companies: Company.all }
  end

  def self.update_company(id, params)
    company = Company.find_by(id: id)

    return { success: false, errors: ["Company not found"] } if company.nil?

    if company.update(params)
      { success: true, company: company }
    else
      { success: false, errors: company.errors.full_messages }
    end
  end

  def self.delete_company(id)
    company = Company.find_by(id: id)

    return { success: false, errors: ["Company not found"] } if company.nil?

    if company.destroy
      { success: true }
    else
      { success: false, errors: company.errors.full_messages }
    end
  end
end
