class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  http_basic_authenticate_with(
    name: "admin",
    password: ENV.fetch("ADMIN_PASSWORD"),
    except: [:index, :show, :new, :create]
  )

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.reorder("reports.created_at desc").includes(:animal_type)
    @reports = apply_filters @reports
    respond_to do |format|
      format.html { @reports = apply_pagination @reports }
      format.csv do
        render text: csv_content(@reports),
          content_type: "text/csv; charset=utf-8; header=present"
      end
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      attrs = admin_report_params

      if !@report.reunion_confirmed && attrs[:reunion_confirmed]
        @report.reunion_confirmed_at = Time.now
      end

      if @report.update(attrs)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_reunited
    @report = Report.find params[:id]
    attrs = {
      reunited: nil,
      reunited_at: nil,
      reuniter_is_reporter: nil,
      reuniter_name: nil,
      reuniter_email: nil,
      reuniter_comment: nil,
    }
    if @report.update_attributes(attrs)
      redirect_to @report, notice: 'Report is no longer reunited.'
    else
      render 'reports/edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(
        :summary,
        :description,
        :location_id,
        :report_type,
        :reporter_name,
        :reporter_contact_info,
        :reporter_email,
        :photo,
        :animal_type_id,
      )
    end

    def admin_report_params
      admin_params = params.require(:report).permit(
        :reunion_confirmed,
        :reunion_confirmed_by,
        :reunion_confirmation_notes,
      )
      report_params.merge(admin_params)
    end

    require 'csv'
    def csv_content(reports)
      columns1 = %w{
        id
        report_type
      }
      columns2 = %w{
        summary
        description
        reporter_name
        reporter_contact_info
        created_at
        updated_at
        photo_file_name
        photo_content_type
        photo_file_size
        photo_updated_at
      }
      columns3 = %w{
        reunited
        reuniter_is_reporter
        reuniter_name
        reunited_at
        reuniter_comment
      }
      reports = reports.
        includes(:animal_type, :location)

      CSV.generate do |csv|
        csv << (
          columns1.map(&:humanize) +
          ["Animal type name", "Location name"] +
          columns2.map(&:humanize) +
          ["Photo URL"] +
          columns3.map(&:humanize)
        )
        reports.each do |report|
          csv << (
            columns1.map {|column| report.send(column) } +
            [report.animal_type_name, report.location_name] +
            columns2.map {|column| report.send(column) } +
            [(report.photo.url(:medium) if report.photo.present?)] +
            columns3.map {|column| report.send(column) }
          )
        end
      end
    end

    def apply_filters(query)
      reports = Report.arel_table
      # Warning: O(n*m) conditions: n=words, m=fields
      if params[:words].present?
        words = params[:words].split(/\W/) # A word is alphanum or "_"
        query = words.inject(query) do |ch, word|
          fields = [:summary, :description, :reporter_name]
          conds = fields.map {|f| reports[f].matches("%#{word}%") }
          disjunction = conds.inject(conds.pop) do |disj, cond|
            disj.or(cond)
          end
          ch.where(disjunction)
        end
      end
      if params[:report_type].present?
        query = query.where(report_type: params[:report_type].to_s)
      end
      if params[:reunited].present?
        matching_values = params[:reunited] == "true" ? true : [false, nil]
        query = query.where(reunited: matching_values)
      end
      if params[:reunion_confirmed].present?
        matching_values =
          params[:reunion_confirmed] == "true" ?  true : [false, nil]
        query = query.where(reunion_confirmed: matching_values)
      end
      if params[:animal_type_id].present?
        animal_type_id = params[:animal_type_id].to_s
        animal_type_id = nil if animal_type_id == "none"
        query = query.where(animal_type_id: animal_type_id)
      end
      if params[:location_id].present?
        location_id = params[:location_id].to_s
        location_id = nil if location_id == "none"
        query = query.where(location_id: location_id)
      end
      query
    end

    def apply_pagination(query)
      query.page(params[:page]).per(30)
    end
end
