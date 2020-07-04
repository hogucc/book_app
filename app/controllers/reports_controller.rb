class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user_report, only: [:edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find(params[:id])
    @user_id = @report.user_id
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
    @report = current_user.reports.build(report_params)

    if @report.save
      redirect_to @report, notice: t("reports.created.notice")
    else
      render :new
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("reports.updated.notice")
    else
      render :edit
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    redirect_to reports_url, notice: t("reports.deleted.notice")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_user_report
      @report = current_user.reports.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :content)
    end
end
