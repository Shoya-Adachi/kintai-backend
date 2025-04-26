class Api::V1::AttendancePostsController < ApplicationController
  # before_action :authenticate_user! 

  def index
  end

  def show
    attendance = Kintai.find(params[:id])

    if attendance
      render json: {status: 'success', data: attendance}, status: :ok
    else
      render json: { status: 'error', errors: attendance.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def search
    conditions = params.permit(:user_id, :date).to_h

    attendance = Kintai.where(conditions)

    if attendance
      render json: {status: 'success', attendance: attendance}, status: :ok
    else
      render json: { status: 'error', errors: attendance.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    attendance = Kintai.build(
      user_id: params[:user_id],      
      date: Date.today,  # 今日の日付
      entry_time: params[:start_time],
      leaving_time: nil  # 退社時間は未設定
    )

    if attendance.save
      render json: { status: 'success', data: attendance }, status: :created
    else
      render json: { status: 'error', errors: attendance.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    attendance = Kintai.find(params[:id])

    if attendance.update(leaving_time: params[:end_time])
      render json: { status: 'success', data: attendance }, status: :ok
    else
      render json: { status: 'error', errors: attendance.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 送られてくるパラメータの許可
  # def attendance_params
  #   params.require(:attendance).permit(:start_time, :end_time)
  # end
end
