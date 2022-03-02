require 'appoptics_apm'
require 'bson'

module OpenTelemetry
  module Exporter
    module SolarWinds
      class Exporter
        SUCCESS = OpenTelemetry::SDK::Trace::Export::SUCCESS
        FAILURE = OpenTelemetry::SDK::Trace::Export::FAILURE
        private_constant(:SUCCESS, :FAILURE)

        def initialize
          @stopped = false
          @reporter = AppOpticsAPM.reporter
          # TODO disable tracing if no reporter
        end

        def export(span_data)
          return FAILURE if @stopped

          span_data.each_with_index do |span, n|
            puts n
            send_span(span)
          end

          SUCCESS
        rescue StandardError => e
          OpenTelemetry.handle_error(exception: e, message: 'unexpected error in SolarWinds::Exporter#export')
          FAILURE
        end

        def force_flush(_timeout: nil)
          SUCCESS
        end

        def shutdown(_timeout: nil)
          @stopped = true
          SUCCESS
        end

        private

        def send_span(span)
          require 'byebug'
          byebug
          # OpenTelemetry::Solarwinds::Exporter::Otel::sendEvent(sw_start(span))
          event = start_event(span).to_bson.to_s
          # Otel::sendEvent(event.to_bson.to_s)
          span
          pp span
        end
      end

      def sw_start(span)
        # compose the event with all the kvs
        evt = {
          "Proto" => 'http',
          "HTTPMethod" => "GET",
          "TID" => "10576",
          "Port" => "61010@",
          "_V" => "1",
          "SampleRate" => "1000000",
          "Label" => "entry",
          "Service" => "maia_test",
          "op_id" => "AA28DD2E4B2D9B9A",
          "Layer" => "rack",
          "sw.trace_context" => "00-a476c5e9d9a840458d29bfd630345611-aa28dd2e4b2d9b9a-01",
          "HostID" => "a2b029ab2e5027644f60c70968f6e02b5dc1d70b",
          "Backtrace" => "/code/solarwinds_apm/lib/appoptics_apm/inst/rack.rb:97:in `collect' /code/solarwinds_apm/lib/appoptics_apm/inst/rack.rb:156:in `sample' /code/solarwinds_apm/lib/appoptics_apm/inst/rack.rb:49:in `block in call' /code/solarwinds_apm/lib/appoptics_apm/inst/rack.rb:144:in `propagate_tracecontext' /code/solarwinds_apm/lib/appoptics_apm/inst/rack.rb:48:in `call' /root/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/railties-6.1.4.4/lib/rails/engine.rb:539:in `call' /root/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/puma-5.6.1/lib/puma/configuration.rb:252:in `call' /root/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/puma-5.6.1/lib/puma/request.rb:77:in `block in handle_request' /root/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/puma-5.6.1/lib/puma/thread_pool.rb:340:in `with_force_shutdown' /root/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/puma-5.6.1/lib/puma/request.rb:76:in `handle_request' /root/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/puma-5.6.1/lib/puma/server.rb:441:in `process_client' /root/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/puma-5.6.1/lib/puma/thread_pool.rb:147:in `block in spawn_thread'",
          "ProcessID" => "10529",
          "Timestamp_u" => "1644965867379619",
          "URLQueryString" => "''",
          "ThreadID" => "0x00007f861ac7cdb8",
          "URL" => "/posts",
          "ClientIP" => "72.28.0.1",
          "URLPath" => "/posts",
          "X-Trace" => "2BA476C5E9D9A840458D29BFD63034561100000000AA28DD2E4B2D9B9A01",
          "HTTP-Host" => "127.0.0.1",
          "SampleSource" => "6",
          "Hostname" => "ao_ruby_ubuntu",
          "Ruby.Solarwinds.Exporter.Version" => "5.0.0"
        }

      end

    end
  end
end
