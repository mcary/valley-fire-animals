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
    @reports = apply_pagination apply_filters Report.reorder("created_at desc")
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
      if @report.update(report_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:summary, :description, :report_type, :reporter_name, :reporter_contact_info, :photo, :animal_type_id)
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
      if params[:animal_type_id].present?
        animal_type_id = params[:animal_type_id].to_s
        animal_type_id = nil if animal_type_id == "none"
        query = query.where(animal_type_id: animal_type_id)
      end
      query
    end

    def apply_pagination(query)
      query.page(params[:page]).per(30)
    end
end
