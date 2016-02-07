require_relative '../test_helper'

class UserCanDeleteAnExistingSkill < FeatureTest
  def test_existing_skill_is_deleted_successfully
    skill_inventory.create({
      title: 'Original Title',
      status: 'Original Status'
    })

    visit '/skills'

    assert page.has_content? 'Original Title'

    click_button 'Delete'
    assert_equal '/skills', current_path
    refute page.has_content? 'Original Title'
  end
end
