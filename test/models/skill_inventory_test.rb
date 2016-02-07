require_relative "../test_helper"

class SkillInventoryTest < Minitest::Test
  include TestHelpers

  def create_skills(num)
    num.times do |i|
      skill_inventory.create(
         title: "title#{i+1}",
        status: "status#{i+1}"
      )
    end
  end

  def test_can_create_a_skill
    skill_inventory.create(
       title: "title1",
      status: "skill1"
    )

    skill = skill_inventory.all.first

    assert skill.id
    assert_equal "title1", skill.title
    assert_equal "skill1", skill.status
  end

  def test_it_finds_all_skills
    create_skills(3)

    assert_equal 3, skill_inventory.all.count

    skill_inventory.all.each_with_index do |skill, index|
      assert_equal Skill, skill.class
      assert_equal "title#{index+1}", skill.title
      assert_equal "status#{index+1}", skill.status
    end
  end
  # #
  def test_it_finds_a_specific_skill
    create_skills(3)
    ids = skill_inventory.all.map { |skill| skill.id }

    ids.each_with_index do |id, index|
      skill = skill_inventory.find(id)
      assert_equal id, skill.id
      assert_equal "title#{index+1}", skill.title
      assert_equal "status#{index+1}", skill.status
    end
  end
  #
  def test_it_updates_a_skill_record
    create_skills(2)

    new_data = {
      :title => "NEW title",
      :status => "NEW status"
    }
    id = skill_inventory.all.last.id
    skill_inventory.update(new_data, id)

    updated_skill = skill_inventory.find(id)

    assert_equal new_data[:title], updated_skill.title
    assert_equal new_data[:status], updated_skill.status
  end
  #
  def test_it_deletes_a_skill_record
    create_skills(3)

    initial_count = skill_inventory.all.count

    id = skill_inventory.all.last.id
    skill_inventory.delete(id)

    final_count = skill_inventory.all.count

    assert_equal 1, (initial_count - final_count)
  end
end
