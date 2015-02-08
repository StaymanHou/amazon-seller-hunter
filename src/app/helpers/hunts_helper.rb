module HuntsHelper
  def display_hunt_result(hunt)
    parsed_result = JSON.parse(hunt.result)
    return '' if hunt.pending?
    return parsed_result['error_message'] if hunt.failed?
    return "<a href=\"#{parsed_result['product_url']}\">#{parsed_result['seller_name']}</a>"
  end
end
