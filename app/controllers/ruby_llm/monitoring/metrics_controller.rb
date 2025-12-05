module RubyLLM::Monitoring
  class MetricsController < ApplicationController
    before_action :set_resolution
    before_action :set_time_range

    def index
      @events = Event.group(:provider, :model)
        .group_by_minute(:created_at, range: @time_range, n: @resolution.in_minutes.to_i)

      @metrics = [
        build_metric_series(title: "Throughput", data: aggregate_metric(@events.count)),
        build_metric_series(title: "Cost", data: aggregate_metric(@events.sum(:cost)), unit: "money"),
        build_metric_series(title: "Response time", data: aggregate_metric(@events.average(:duration), default_value: 0), unit: "ms")
      ]
    end

    private

    def aggregate_metric(aggregated_data, default_value: nil)
      aggregated_data
        .group_by { |(provider, model, _), _| [ provider, model ] }
        .transform_values do |entries|
          entries.map do |(_, _, timestamp), value|
            [ timestamp.to_i * 1000, value || default_value ]
          end
        end
    end

    def build_metric_series(title:, data:, unit: nil)
      {
        title: title,
        unit: unit,
        series: data.map { |k, v| { name: k.join("/"), data: v } }
      }.compact
    end

    def filter_param
      {
        filter: {
          created_at_start: @created_at_start,
          created_at_end: @created_at_end,
          resolution: @resolution
        }
      }.compact
    end

    def set_resolution
      @resolution = params.dig(:filter, :resolution).try(:to_i).try(:minutes) || 1.minute
    end

    def set_time_range
      @created_at_start = params.dig(:filter, :created_at_start).try(:in_time_zone) || 2.hours.ago
      @created_at_end = params.dig(:filter, :created_at_end).try(:in_time_zone)

      @time_range = @created_at_start..@created_at_end
    end
  end
end
