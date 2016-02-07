require_relative '../test_helper'

class UserCanCreateANewSkill < FeatureTest
  def test_skill_creation_with_valid_attributes
    visit '/skills/new'

    fill_in 'skill[title]', with: 'Example Skill'
    fill_in 'skill[status]', with: 'Example Status'
    click_button 'Add'

    assert_equal '/skills', current_path

    within '#skills' do
      assert page.has_content? 'Example Skill'
    end
  end
end
