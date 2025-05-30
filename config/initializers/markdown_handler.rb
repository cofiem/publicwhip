# frozen_string_literal: true

require "redcarpet"

class BootstrapTableRenderer < Redcarpet::Render::HTML
  def table(header, body)
    "<table class=\"table\"><thead>#{header}</thead><tbody>#{body}</tbody></table>"
  end
end

module MarkdownHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def self.call(template, source)
    compiled_source = erb.call(template, source)
    "Redcarpet::Markdown.new(BootstrapTableRenderer, tables: true).render(begin;#{compiled_source};end.to_s).html_safe"
  end
end

ActionView::Template.register_template_handler :md, MarkdownHandler
