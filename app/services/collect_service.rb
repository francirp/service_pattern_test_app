class CollectService < ApiService
  include ReadConcerns

  private

  def root_key
    plural_key
  end
end
