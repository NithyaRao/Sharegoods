module RequestsHelper
  def bool_to_glyph(value)
      value ? "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>".html_safe : "<span aria-hidden='true'></span>".html_safe
  end
end
