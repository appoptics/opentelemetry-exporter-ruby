
module Opentelemetry
  module Exporter
    # SolarWinds contains code to send traces via the SolarWinds reporter
    module SolarWinds
    end
  end
end

require "opentelemetry/sdk"
require "opentelemetry/exporter/solarwinds/exporter"
require "opentelemetry/exporter/solarwinds/span_processor"
require "opentelemetry/exporter/solarwinds/version"
