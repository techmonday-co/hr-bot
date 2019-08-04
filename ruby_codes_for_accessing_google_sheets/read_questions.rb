require 'openssl'
require 'net/http'
require 'json'

url = 'https://script.google.com/macros/s/AKfycbxnHw16ALzjTfPy7ezlHZkGDFh-yl-NDVjwGCRaAC4hEARDQgk/exec'

def fetch(uri_str)
  uri = URI.parse(uri_str)
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(uri.request_uri)
  request['Content-Type'] = 'application/json'

  response = https.request(request)
  case response
  when Net::HTTPSuccess then response
  when Net::HTTPRedirection then fetch(response['location'])
  else
    response.error!
  end
end

response = fetch(url)
p JSON.parse(response.body)