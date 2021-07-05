# frozen_string_literal: true

module ApplicationHelper

  def markdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end
end
