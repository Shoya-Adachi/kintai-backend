class Api::V1::AttendancePostsController < ApplicationController
  # before_action :authenticate_user! 

  def index
    attendance = Kintai.all
    render json: attendance.map { |post|
      {date: post.date, startTime: post.entry_time, endTime: post.leaving_time}
    }
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
      date: Date.today,  
      entry_time: params[:start_time],
      leaving_time: nil  
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

  def destroy
    attendance = Kintai.find(params[:id])

    if attendance
      attendance.destroy
      head :no_content
    else
      render json: { error: 'AttendancePost not found' }, status: :not_found
    end
  end
end
