module Onfleet
  class Task < OnfleetObject
    include Onfleet::Actions::Create
    include Onfleet::Actions::Save
    include Onfleet::Actions::Update
    include Onfleet::Actions::Get
    # include Onfleet::Actions::List
    include Onfleet::Actions::Delete
    include Onfleet::Actions::QueryMetadata

    def self.api_url
      'tasks'
    end

    def complete
      # CURRENTLY DOESN'T WORK
      url = "#{self.url}/#{id}/complete"
      params = { 'completionDetails' => { 'success' => true } }
      Onfleet.request(url, :post, params)
      true
    end

    def self.list query_params={}
      if query_params.empty?
        query_params['from'] = (Time.zone.now - 1.week).to_i * 1000
      end

      has_more = true
      last_id = nil
      found_tasks = []

      while has_more do
        query_params['lastId'] = last_id unless last_id.nil?
        tasks_response = task_request(query_params)

        tasks_array = tasks_response[:tasks].compact
        tasks_array.each do |listObj|
          found_tasks << Util.constantize("#{self}").new(listObj)
        end

        has_more = tasks_response.has_key?(:lastId)
        last_id = tasks_response[:lastId]
      end

      return found_tasks
    end

    def self.task_request(query_params = {})
      name_value_pairs = query_params.map do |key, value|
        "#{key}=#{value}"
      end

      api_url = "#{self.api_url}/all?#{name_value_pairs.join('&')}"

      json_response = Onfleet.request(api_url, :get)

      return json_response.deep_symbolize_keys
    end
  end
end

