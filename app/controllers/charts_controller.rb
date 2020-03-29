class ChartsController < ApplicationController
  before_action :assign_user, only: %i[net_worth_graph expenses_pie_chart expenses_column_chart]

  # landing page demos
  
  def net_worth_demo
    render json: {"Tue, 01 Jan 2019"=>0.1586734e5, "Fri, 01 Feb 2019"=>0.2191908e5, "Fri, 01 Mar 2019"=>0.3425831e5, "Mon, 01 Apr 2019"=>0.4266992e5, "Wed, 01 May 2019"=>0.574668e5, "Sat, 01 Jun 2019"=>0.6265551e5, "Mon, 01 Jul 2019"=>0.7254844e5, "Thu, 01 Aug 2019"=>0.8838481e5, "Sun, 01 Sep 2019"=>0.9252975e5, "Tue, 01 Oct 2019"=>0.1000581e6, "Fri, 01 Nov 2019"=>0.11697328e6, "Sun, 01 Dec 2019"=>0.12130413e6}
  end

  def expenses_pie_chart_demo
    render json: {"Clothing"=>0.20454e3, "Restaurants"=>0.9888e2, "Entertainment"=>0.5977e2, "Groceries"=>0.14943e3}
  end

  def expenses_column_chart_demo
    render json: {"Jan 2019"=>0.484132e4, "Feb 2019"=>0.422839e4, "Mar 2019"=>0.320202e4, "Apr 2019"=>0.415266e4, "May 2019"=>0.400948e4}
  end

  # dashboard

  def net_worth_graph
    render json: @user.statements.group_by_month(:date).sum(:balance)
  end

  def expenses_pie_chart
    render json: @user.expenses.where(date: Date.current.beginning_of_month..Date.current.end_of_month).group(:category).sum(:amount)
  end

  def expenses_column_chart
    render json: @user.expenses.group_by_month(:date).sum(:amount)
  end

  private

  def assign_user
    @user = current_user
  end
end