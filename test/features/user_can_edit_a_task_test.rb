require_relative '../test_helper'

class UserCanEditAnExistingSkill < FeatureTest
  def test_existing_task_is_updated_with_new_information
    skill_inventory.create({ title: 'Original Title',
                         status: 'Original Status' })

    id = skill_inventory.all.first.id

    visit "/skills/#{id}/edit"


    fill_in 'skill[title]', with: 'Updated Title'
    fill_in 'skill[status]', with: 'Updated Status'
    click_button 'Submit'

    assert_equal "/skills/#{id}", current_path
    within 'h2' do
      assert page.has_content? 'Updated Title'
    end
    within 'p' do
      assert page.has_content? 'Updated Status'
    end
  end
end
