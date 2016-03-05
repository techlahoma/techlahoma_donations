module ApplicationHelper

  def cents_to_dollars(cents)
    number_to_currency(cents.to_f/100)
  end

  def add_page_class klass
    @page_classes ||= []
    @page_classes.push klass
  end

  def page_class
    (@page_classes || []).join(" ")
  end

end
