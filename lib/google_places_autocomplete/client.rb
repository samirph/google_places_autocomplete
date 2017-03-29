module GooglePlacesAutocomplete

  class Client
    include Typhoeus
    Base_uri="https://maps.googleapis.com/maps/api/place"
    format "json"

    attr_reader :api_key

    def initialize(options={})
      @api_key = options[:api_key] || GooglePlaces.api_key
    end

    def autocomplete(options={})
      sensor = options.delete(:sensor) || false
      types  = options.delete(:types)
      language  = options.delete(:language) || nil
      input  = options.delete(:input)
      offset = options.delete(:offset) || nil
      radius = options.delete(:radius) || nil
      lat = options.delete(:lat) || nil
      lng = options.delete(:lng) || nil
      location = [lat,lng].join(',') if lat && lng
      sw_bounds = [options[:sw_bounds].delete(:lat),options[:sw_bounds].delete(:lng)].join(',') if options[:sw_bounds] && options[:sw_bounds][:lat] && options[:sw_bounds][:lng]
      ne_bounds = [options[:ne_bounds].delete(:lat),options[:ne_bounds].delete(:lng)].join(',') if options[:ne_bounds] && options[:ne_bounds][:lat] && options[:ne_bounds][:lng]
      bounds = [sw_bounds,ne_bounds].join('|') if sw_bounds && ne_bounds
      components = options.delete(:components) || nil
      user_ip = options.delete(:user_ip) ||  nil
      quota_user = options.delete(:quota_user) || nil

      options = {
        :location => location,
        :radius => radius,
        :language => language,
        :sensor => sensor,
        :input => input,
        :offset => offset,
        :bounds => bounds,
        :components => components,
        :userIp => user_ip,
        :quotaUser => quota_user
      }

      if types
        types = (types.is_a?(Array) ? types.join('|') : types)
        options.merge!(:types => types)
      end

      options = options.delete_if {|key, value| value.nil?}
      mashup(Typhoeus.get(Base_uri+"/autocomplete/json", :params => options.merge(self.default_options)))
    end

    def details(options={})
      placeid = options.delete(:placeid)
      reference = options.delete(:reference)

      if placeid
        options = {
          placeid: placeid
        }
      else
        options = {
          reference: reference
        }
      end

      mashup(Typhoeus.get(Base_uri+"/details/json", :params => options.merge(self.default_options)))
    end

    protected

    def default_options
      { :sensor => false, :key => @api_key }
    end

    def mashup(response)
      body = JSON.parse response.response_body
      case response.code
        when 200
          if body.is_a?(Hash)
            body
          else
            {}
          end
        end
      end
    end

end
