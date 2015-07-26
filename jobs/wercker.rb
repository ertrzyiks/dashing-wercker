require "net/http"
require "json"

projects = [
  { :widget_id => 'wercker_project_1', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION', :branch => 'master' },
  { :widget_id => 'wercker_project_2', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION', :branch => 'development' }
]

API_ADDRESS= "https://app.wercker.com/api/v3"

def make_request(method, token)
    url = "#{API_ADDRESS}#{method}"
    uri = URI.parse(API_ADDRESS)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{token}"

    response = http.request(request)
    response_object = JSON.parse(response.body)

    response_object
end

def get_unknown_build
    data = {}
    data["result"] = "unknown"
    data["status"] = "unknown"
    data
end

def get_last_build(project, token)
    method = "/applications/#{project[:user]}/#{project[:application]}/builds?branch=#{project[:branch]}&limit=1"
    response = make_request(method, token);

    return get_unknown_build() if response.length == 0

    response.first
end

def get_status(project, token)
    last_build = get_last_build(project, token)

    {
        :class_name => "result-#{last_build["result"]} status-#{last_build["status"]}",
        :project => project,
        :build => last_build
    }
end

SCHEDULER.every '10s', :first_in => 0  do
  projects.each do |p|
    status = get_status(p, ENV['WERCKER_AUTH_TOKEN'])
    send_event(p[:widget_id], status)
  end
end
