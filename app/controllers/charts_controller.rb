class ChartsController < ApplicationController
  before_action :check_admin_role, only: [:index]

  def index
    respond_to do |format|
      format.html do
        @registrations = [['Day', 'Registrations']] + User.where("created_at > ?", Date.today - 3.month).group_by{|a| a.created_at.to_date}.map{|k,v| [I18n.l(k, format: :short), v.count]}
      end
    end
  end
end
