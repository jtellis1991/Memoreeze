# frozen_string_literal: true

class StaticController < ApplicationController
  def xml_config
    respond_to do |format|
      format.xml do
        tool_config = IMS::LTI::ToolConfig.new(
          title: "SRS App",
          launch_url: launch_url,
        )

      render xml: tool_config.to_xml
      end
    end
  end
end
