module MarkdownHelper
  def mark(&block)
    captured = capture(&block)
    text = captured.strip_heredoc

    markdown_instance.render(text.to_s)
                     .html_safe # rubocop:disable Rails/OutputSafety
  end

  private

  def markdown_instance
    # https://github.com/vmg/redcarpet?tab=readme-ov-file#and-its-like-really-simple-to-use
    @markdown_instance ||= Redcarpet::Markdown.new(TailwindMarkdownRender)
  end

  class TailwindMarkdownRender < Redcarpet::Render::HTML
    # https://github.com/vmg/redcarpet?tab=readme-ov-file#block-level-calls

    def header(text, header_level)
      # TODO: support multiple header levels
      "<h#{header_level} class='font-bold text-lg'>#{text}</h#{header_level}>"
    end

    def list(contents, list_type)
      tag = list_type == :unordered ? 'ul' : 'ol'

      "<#{tag} class='max-w-md space-y-1 list-disc list-inside '>#{contents}</#{tag}>"
    end
  end
end
