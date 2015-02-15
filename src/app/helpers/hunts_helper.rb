module HuntsHelper
  class ResultFormatter
    def initialize(hunt)
      @parsed_result = JSON.parse(hunt.result)
    end

    def failed_msg
    end

    def finished_msg
    end
  end

  class BriefResultFormatter < ResultFormatter
    include ActionView::Helpers::UrlHelper

    def failed_msg
      @parsed_result['error_message']
    end

    def finished_msg
      link_to @parsed_result['seller_name'], @parsed_result['product_url'], target: '_blank'
    end
  end

  class DetailResultFormatter < ResultFormatter
    def failed_msg
      "Error Message: #{@parsed_result['error_message']}"
    end

    def finished_msg
      "Seller Name: #{@parsed_result['seller_name']} Product Url: #{@parsed_result['product_url']}"
    end
  end

  module ResultFormatterFactory
    def self.get_formatter(hunt, format)
      if format == :brief
        return BriefResultFormatter.new(hunt)
      elsif format == :detail
        return DetailResultFormatter.new(hunt)
      else
        fail 'Unknown output format'
      end
    end
  end

  def display_hunt_result(hunt, format = :brief)
    formatter = ResultFormatterFactory.get_formatter(hunt, format)
    if hunt.pending? || hunt.working?
      return ''
    elsif hunt.failed?
      formatter.failed_msg
    elsif hunt.finished?
      formatter.finished_msg
    else
      return 'mal-formed result'
    end
  end
end
