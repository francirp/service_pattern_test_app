class ShowService < ApiService
  include ReadConcerns

  def root_key
    singular_key
  end
end
