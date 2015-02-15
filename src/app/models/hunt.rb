class Hunt < ActiveRecord::Base
  enum condition: [:new_book, :used_book]
  enum status: [:pending, :working, :finished, :failed]
  validates :isbn, format: {
    with: /\A(\d{3}-)?\d{10}\z/,
    message: 'only allows ISBN-13 or ISBN-10'
  }
  after_initialize :default_values

  private

  def default_values
    self.status ||=  :pending
    self.result ||= '{}'
  end
end
