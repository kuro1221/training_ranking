class RankingService
  PERIODS = %w[weekly monthly total].freeze

  def initialize(training_menu, period: "total", now: Time.zone.now)
    @training_menu = training_menu
    @period = PERIODS.include?(period) ? period : "total"
    @now = now
  end

  def call
    records = @training_menu.training_records
    records = case @period
    when "weekly"
                range = @now.beginning_of_week(:monday)..@now.end_of_week(:monday)
                records.where(recorded_at: range)
    when "monthly"
                range = @now.beginning_of_month..@now.end_of_month
                records.where(recorded_at: range)
    else
                records
    end

    records
      .joins(:user)
      .group("users.id", "users.name")
      .select("users.id AS user_id, users.name AS name, SUM(training_records.count) AS total_count")
      .order("total_count DESC")
      .map.with_index(1) do |r, index|
        { rank: index, user_id: r.user_id, name: r.name, total_count: r.total_count.to_i }
      end
  end
end
