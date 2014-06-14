module CommonHelper
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
  var script = document.createElement('script');
  script.setAttribute('type','text/javascript');
  script.setAttribute('charset','UTF-8');
  script.setAttribute('src','#{ application_js_url }?'+#{ stamp_js });
  document.body.appendChild(script);
})(document)
    CODE
  end

  def application_js_url
    "//#{ server_address }/application.js"
  end

  def compress(code)
    @uglifier ||= Uglifier.new
    @uglifier.compile(code).gsub(/^!/, '').gsub(/;$/, '')
  end
end
