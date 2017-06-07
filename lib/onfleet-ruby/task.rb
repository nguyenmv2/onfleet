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
      '/tasks'
    end

    def complete
      # CURRENTLY DOESN'T WORK
      url = "#{self.url}/#{self.id}/complete"
      params = {"completionDetails" => {"success" => true }}
      Onfleet.request(url, :post, params)
      true
    end

    def self.list query_params={}
      if query_params.empty?
        query_params['from'] = (Time.zone.now - 1.month).to_i * 1000
      end

      name_value_pairs = query_params.map do |key, value|
        "#{key}=#{value}"
      end

      api_url = "#{self.api_url}/all?#{name_value_pairs.join('&')}"

      json_response = Onfleet.request(api_url, :get)
      json_response.deep_symbolize_keys!
      tasks_array = json_response[:tasks]
      tasks_array.compact.map do |listObj|
        Util.constantize("#{self}").new(listObj)
      end
    end
  end
end
