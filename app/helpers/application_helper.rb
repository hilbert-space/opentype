module ApplicationHelper
  def stamp
    Time.now.to_i.to_s
  end

  def stamp_js
    'Math.random()'
  end

  def bookmark_href
    "javascript:void(#{ compress(bookmark_js) })"
  end

  def bookmark_js
    <<-CODE
(function(document) {
  if (window.toggleOpenType) {
    window.toggleOpenType();
    return;
  }

  var element = document.createElement('script');
  element.setAttribute('type', 'text/javascript');
  element.setAttribute('src', '#{ run_url(:js) }?' + #{ stamp_js });
  document.body.appendChild(element);

  element = document.createElement('link');
  element.setAttribute('rel', 'stylesheet');
  element.setAttribute('href', '#{ run_url(:css) }?' + #{ stamp_js });
  document.head.appendChild(element);
})(document)
    CODE
  end

  def run_url(extension)
    "//#{ host }/run.#{ extension }"
  end

  def host
    request.host || 'open.type.works'
  end

  def compress(code)
    @uglifier ||= Uglifier.new
    @uglifier.compile(code).gsub(/^!/, '').gsub(/;$/, '')
  end
end
