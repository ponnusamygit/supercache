module Supercache
  class DashboardController < ActionController::Base
    layout 'supercache/application'

    before_filter :load_cache, only: :flip
    before_filter :leave_out_query, only: :leave_out_flip

    def index
      @ar_cache = cache.read(:ar_supercache)
      @http_cache = cache.read(:http_supercache)
    end

    def leave_out_flip
      queries = cache.read(:except)
      if queries.try(:include?, @query)
        queries.delete @query
      else
        queries.push @query
      end
      cache.write(:except, queries)
    end

    def flip
      if cache.read(@cache)
        cache.delete(@cache)
      else
        cache.write(@cache, true)
      end
      redirect_to :root
    end

    private

    def cache
      Rails.cache
    end

    def load_cache
      @cache = params[:cache]
    end

    def leave_out_query
      # @query = Digest::SHA1.hexdigest(args[0].path.to_s + args[0].body.to_s)
    end

  end
end