module OpenTelemetry
  module Exporter
    module SolarWinds
      class SpanProcessor

        def initialize

        end

        def on_start(span, _parent_context)
          # puts "on_start:"
          # pp span.to_span_data
        end

        def on_finish(span)
          # puts "on_finish:"
          data = span.to_span_data

          data.trace_id = data.hex_trace_id
          data.span_id = data.hex_span_id
          data.parent_span_id = data.hex_parent_span_id

          # pp data
        end

        def flush

        end

      end
    end
  end
end