class GoalController < ApplicationController

def create
        @goal = Goal.new(params[:goal])
        if @goal.save
            flash[:notice] = "Goal successfully saved!"
        else
            flash[:error] = "Goal was not saved"
        end
end

def new
    @goal = Goal.new(params[:goal])
    flash[:error] = "why heres"
end

end