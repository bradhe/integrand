module IntegrationHelper
  def build_status(integration)
    return "(#{integration.last_build.status})" unless integration.last_build.nil?
    return ""
  end
end
