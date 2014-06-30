class LogSqlsController < ApplicationController
  before_action :set_log_sql, only: [:show, :edit, :update, :destroy]

  # GET /log_sqls
  # GET /log_sqls.json
  def index
    @log_sqls = LogSql.all
  end

  # GET /log_sqls/1
  # GET /log_sqls/1.json
  def show
  end

  # GET /log_sqls/new
  def new
    @log_sql = LogSql.new
  end

  # GET /log_sqls/1/edit
  def edit
  end

  # POST /log_sqls
  # POST /log_sqls.json
  def create
    @log_sql = LogSql.new(log_sql_params)

    respond_to do |format|
      if @log_sql.save
        format.html { redirect_to @log_sql, notice: 'Log sql was successfully created.' }
        format.json { render action: 'show', status: :created, location: @log_sql }
      else
        format.html { render action: 'new' }
        format.json { render json: @log_sql.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_sqls/1
  # PATCH/PUT /log_sqls/1.json
  def update
    respond_to do |format|
      if @log_sql.update(log_sql_params)
        format.html { redirect_to @log_sql, notice: 'Log sql was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @log_sql.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_sqls/1
  # DELETE /log_sqls/1.json
  def destroy
    @log_sql.destroy
    respond_to do |format|
      format.html { redirect_to log_sqls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log_sql
      @log_sql = LogSql.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_sql_params
      params.require(:log_sql).permit(:tms_log_sql, :tabla_log_sql, :operac_log_sql, :usuar_log_sql, :dat_antes_log_sql, :dat_desp_log_sql, :ope_det_log_sql)
    end
end
