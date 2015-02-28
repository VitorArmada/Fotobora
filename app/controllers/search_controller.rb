class SearchController < ApplicationController

  def index
    if not(params[:q].blank?)
      @query = params[:q]

      query_normalized = params[:q].upcase

      @users = User.select{ |x| x.email.upcase.include? query_normalized }.sort_by { |x| x.email }

      @photos = []

      Photo.all.each do |p|
        if p.address.upcase.include? query_normalized
          @photos << p
        elsif p.user.email.upcase.include? query_normalized 
          @photos << p
        end
      end
      @photos = @photos.sort_by { |x| x.created_at }
     
     else
      @query = ''
      @users = []
      @photos = []
    end
  end

end
