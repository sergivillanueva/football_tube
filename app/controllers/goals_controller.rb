class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role

  def set_video_start_position
    @goal = Goal.find(params[:goal_id])
    @goal.video_start_position = params[:position]

    if @goal.save
      render json: { status: :ok, code: 1, view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    else
      render json: { status: :error, code: 0, view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    end
  end

  def set_video_end_position
    @goal = Goal.find(params[:goal_id])

    @goal.video_end_position = params[:position]

    if @goal.save
      render json: { status: :ok, code: 1, view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    else
      render json: { status: :error, code: 0, view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    end
  end

  def toggle_kind
    @goal = Goal.find(params[:goal_id])

    case params[:kind]
    when 'super_goal'
      @goal.super_goal = !@goal.super_goal
    when 'header'
      @goal.header = !@goal.header
    when 'outside_the_box'
      @goal.outside_the_box = !@goal.outside_the_box
    when 'free_kick'
      @goal.free_kick = !@goal.free_kick
    end

    if @goal.save
      render json: { status: :ok, code: 1, view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    else
      render json: { status: :error, code: 0, view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    end
  end

  def set_video_id
    @goal = Goal.find(params[:goal_id])
    @goal.video_id = params[:video_id]

    if @goal.save
      render json: { status: :ok, code: 1, view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    else
      render json: { status: :error, code: 0 , view: render_to_string(:template => "matches/_admin_goal", :locals => {:goal => @goal}, layout: false ) }
    end
  end
end
