module VocabulariesHelper
  def emphasize_not_found(any_string)
    tag.div any_string, class: any_string == 'not found' ? 'text-danger' : nil
  end
end
