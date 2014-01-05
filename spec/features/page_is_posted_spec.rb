require 'spec_helper'

feature 'Page is posted' do
  let!(:user) { FactoryGirl.create(:existing_user) }
  let!(:organization) { FactoryGirl.create(:existing_organization) }
  let!(:organization_user) { FactoryGirl.create(:organization_user_connection, :organization => organization, :user => user) }
  let!(:logbook) { FactoryGirl.create(:existing_logbook, :organization => organization) }

  after(:each) { Timecop.return }

  scenario 'at the beginning of each day and enqueues next post' do
    Timecop.freeze(Time.utc(2014, 1, 4, 5, 0, 0))
    logbook.create_first_page
    sign_in_as(user.email, user.password)
    move_time_forward_by_days(3)
    click_link 'Bombay Reservoir'
    click_link 'Maintenance Records'

    expect(page).to have_content('Tuesday, January 7, 2014')
    expect(Page.count).to eq(5)
    expect(Delayed::Job.count).to eq(1)
    expect(logbook.posted_pages.count).to eq(4)
  end

  def move_time_forward_by_days(number)
    number.times do
      Timecop.travel(1.day)
      Timecop.freeze(Time.now)
      Delayed::Worker.new.work_off
    end
  end
end