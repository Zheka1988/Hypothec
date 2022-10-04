module I18nMacros
  def t(*str)
    I18n.translate!(*str)
  end
end