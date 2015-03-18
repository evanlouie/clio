class ApplicationController < ActionController::Base

  before_filter :authenticate_user!

  private

  def symbolfy_array(string_array)
    return nil if string_array.nil?
    return string_array.split(',').map {|str| str.to_sym} if string_array.is_a?(String)
    return string_array.map{|str| str.to_sym}
  end
end
