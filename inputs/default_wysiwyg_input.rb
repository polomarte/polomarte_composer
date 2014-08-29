class DefaultWysiwygInput < Formtastic::Inputs::Wysihtml5Input
  def input_html_options
    super.merge({
      commands: [:bold, :italic, :underline, :ul, :ol, :link],
      blocks:   :barebone})
  end
end
