require '../lib/opentelemetry/exporter/solarwinds'

require 'rubygems'
require 'bundler/setup'

Bundler.require

ENV['OTEL_TRACES_EXPORTER'] = 'console'
# ENV['OTEL_TRACES_EXPORTER'] = 'solarwinds'
exporter = OpenTelemetry::Exporter::SolarWinds::Exporter.new
span_processor = OpenTelemetry::SDK::Trace::Export::SimpleSpanProcessor.new(exporter)

OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Excon'
  c.add_span_processor(span_processor)
end

# To start a trace you need to get a Tracer from the TracerProvider
tracer = OpenTelemetry.tracer_provider.tracer('my_app_or_gem', '0.1.0')

# create a span
tracer.in_span('foo') do |span|
  # set an attribute
  span.set_attribute('platform', 'osx')
  # add an event
  span.add_event('event in bar')
  # create bar as child of foo
  tracer.in_span('bar') do |child_span|
    # inspect the span
    # pp child_span

    Excon.get('http://example.com')
  end
end