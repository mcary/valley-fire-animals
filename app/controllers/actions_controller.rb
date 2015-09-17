class ActionsController < ApplicationController
  def reunite
    report = Report.find params[:id]
    report.update_attribute(:reunited, true)
  end
end
