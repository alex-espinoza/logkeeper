class Page < ActiveRecord::Base
  belongs_to :logbook

  has_many :entries

  validates_inclusion_of :is_posted, :in => [true, false]
  validates_length_of :name, :within => 1..100
  validates_presence_of :logbook_id
  validates_presence_of :name
  validates_presence_of :scheduled_at

  def schedule_next_page(logbook, time)
    scheduled_time = time.beginning_of_day + 1.day
    page = Page.create!(:logbook => logbook, :scheduled_at => scheduled_time, :name => scheduled_time.strftime('%A, %B %-d, %Y'))
    page.post_next_page
  end

  def post_next_page
    self.update_attributes(:is_posted => true)
    schedule_next_page(logbook, scheduled_at)
  end

  handle_asynchronously :post_next_page, :run_at => Proc.new { |p| p.scheduled_at }

  private

  def self.create_first_page(logbook)
    time = Time.zone.now
    page = Page.create!(:logbook => logbook, :scheduled_at => time, :name => time.strftime('%A, %B %-d, %Y'), :is_posted => true)
    page.schedule_next_page(logbook, time)
  end
end