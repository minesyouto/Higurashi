class ResultsController < ApplicationController
  before_action :set_result, only: %i[ show edit update destroy ]

  # GET /results or /results.json
  def index
    @results = Result.all.order(date: :asc)
    #日毎の収支
    @payment_results = []
    #総回転数
    @total_game = []
    #トータルビタ回数
    @total_branch = []
    #トータルビタ成功数
    @total_success = []
    #トータル運命分岐成功数
    @total_branch_success = []
    #トータル運命分岐回数
    @total_cz = []
    #日付と収支を入れる配列
    #折れ線グラフ表示用の配列
    @chart = []
    @total_payment = 0
    @results.each do |result|
      date_payment = []
      payment = result.collect.to_i - result.investment.to_i
      @payment_results << payment
      @total_payment += payment
      total_game = result.game.to_i
      @total_game << total_game
      total_branch = result.total_branch.to_i
      @total_branch << total_branch
      total_success = result.total_branch_success.to_i
      @total_success << total_success
      total_cz_success = result.success.to_i
      @total_branch_success << total_cz_success
      total_cz = result.branch.to_i
      @total_cz << total_cz
      date_payment.push(result.date,@total_payment)
      @chart << date_payment
    end
    @payment_result = @payment_results.sum
    @total_game = @total_game.sum
    @sum_total_branch = @total_branch.sum
    @sum_total_success = @total_success.sum
    @sum_success = @sum_total_success.to_f / @sum_total_branch.to_f * 100
    @sum_total_cz_success = @total_branch_success.sum
    @sum_total_cz = @total_cz.sum
    @total_cz_success = @sum_total_cz_success.to_f / @sum_total_cz.to_f * 100
    #日付と収支のデータを配列にまとめ、それを配列に格納する
  end

  # GET /results/1 or /results/1.json
  def show
  end
  
  def chart
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results or /results.json
  def create
    @result = Result.new(result_params)
    

    respond_to do |format|
      if @result.save!
        format.html { redirect_to root_path, notice: "Result was successfully created." }
        format.js { @status = "success"}
        @results = Result.all.order(date: :asc)
    #日毎の収支
    @payment_results = []
    #総回転数
    @total_game = []
    #トータルビタ回数
    @total_branch = []
    #トータルビタ成功数
    @total_success = []
    #トータル運命分岐成功数
    @total_branch_success = []
    #トータル運命分岐回数
    @total_cz = []
    #日付と収支を入れる配列
    #折れ線グラフ表示用の配列
    @chart = []
    @total_payment = 0
    @results.each do |result|
      date_payment = []
      payment = result.collect.to_i - result.investment.to_i
      @payment_results << payment
      @total_payment += payment
      total_game = result.game.to_i
      @total_game << total_game
      total_branch = result.total_branch.to_i
      @total_branch << total_branch
      total_success = result.total_branch_success.to_i
      @total_success << total_success
      total_cz_success = result.success.to_i
      @total_branch_success << total_cz_success
      total_cz = result.branch.to_i
      @total_cz << total_cz
      date_payment.push(result.date,@total_payment)
      @chart << date_payment
    end
    @payment_result = @payment_results.sum
    @total_game = @total_game.sum
    @sum_total_branch = @total_branch.sum
    @sum_total_success = @total_success.sum
    @sum_success = @sum_total_success.to_f / @sum_total_branch.to_f * 100
    @sum_total_cz_success = @total_branch_success.sum
    @sum_total_cz = @total_cz.sum
    @total_cz_success = @sum_total_cz_success.to_f / @sum_total_cz.to_f * 100
    #日付と収支のデータを配列にまとめ、それを配列に格納する
    pp @total_game
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js { @status = "fail"}
      end
    end
  end
  

  # PATCH/PUT /results/1 or /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: "Result was successfully updated." }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1 or /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: "Result was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def result_params
      params.require(:result).permit(:date,:game, :investment, :collect, :branch, :success, :total_branch, :total_branch_success, :user_id)
    end
end
