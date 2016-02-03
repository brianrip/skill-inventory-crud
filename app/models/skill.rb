class Skill
  attr_reader :id, :title, :status

  def initialize(data)
    @id     = data["id"]
    @title   =  data["title"]
    @status = data["status"]
  end

end
