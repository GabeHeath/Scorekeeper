module CommentsHelper
  def highlight_comment(comment_id, param_id)
    if comment_id == param_id
      return "background-color: #d9edf7".html_safe
    end
  end
end
