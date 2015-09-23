class ActionsController < ApplicationController
  def reunite
    @report = Report.find params[:id]
    if @report.update(reunite_params)
      redirect_to @report, notice: 'Report was successfully updated.'
    else
      render :reunite_form
    end
  end

  def reunite_form
    @report = Report.find params[:id]
  end

  private

  def reunite_params
    params.require(:report).permit(
      :reuniter_is_reporter,
      :reuniter_name,
      :reuniter_email,
      :reuniter_comment,
    ).merge(
      reunited: true,
      reunited_at: Time.now,
    )
  end
end
