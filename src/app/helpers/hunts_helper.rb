module HuntsHelper
  def display_hunt_result(hunt, output=:brief)
    return '' if hunt.pending? or hunt.working?
    parsed_result = JSON.parse(hunt.result)
    if hunt.failed?
      if output == :brief
        return parsed_result['error_message']
      elsif output == :detail
        return "Error Message: #{parsed_result['error_message']}"
      end
    elsif hunt.finished?
      if output == :brief
        return link_to parsed_result['seller_name'], parsed_result['product_url'], target: '_blank'
      elsif output == :detail
        return "Seller Name: #{parsed_result['seller_name']} Product Url: #{parsed_result['product_url']}"
      end
    else
      return 'mal-formed result'
    end
  end
end
