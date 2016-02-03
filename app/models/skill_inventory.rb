require          'yaml/store'
require_relative 'skill'

class SkillInventory
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(skill) #a way to access a file
    database.transaction do
      database['skills'] ||= []
      database['total']  ||= 0
      database['total']  +=  1
      database['skills'] << { "id" => database['total'], "title" => skill[:title], "status" => skill[:status] }
    end
  end

  def raw_tasks
    database.transaction do
      database['skills'] || []
    end
  end

  def all
    raw_tasks.map { |data| Skill.new(data)}
  end

  def raw_task(id)
    raw_tasks.find { |skill| skill["id"] == id.to_i }
  end

  def find(id)
    Skill.new(raw_task(id))
  end

  def update(skill, id)
    database.transaction do
      target_task = database["skills"].find { |skill| skill["id"] == id.to_i }
      target_task["title"]   = skill["title"]
      target_task["status"] = skill["status"]
    end
  end

  def delete(id)
    database.transaction do
      database["skills"].delete_if { |skill| skill["id"] == id.to_i }
    end
  end


end
