
class TennisGame1

  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1_points = @p2_points = 0
  end
        
  def won_point(player_name)
    @p1_points += 1 if player_name == @player1_name
    @p2_points += 1 if player_name == @player2_name
  end
  
  def score
    return print_tied if tied?
    if advantage_or_win?
      return print_advantage unless print_advantage.nil?
      return print_win unless print_win.nil?
    end
    print_score
  end

  private

  def difference 
    @p1_points-@p2_points
  end

  def tied? 
    @p1_points == @p2_points
  end

  def print_tied
    EQUAL_RESULT.fetch(@p1_points, "Deuce")
  end

  def print_advantage
    return "Advantage " + @player1_name if (difference == 1)
    return "Advantage " + @player2_name if (difference == -1)
  end

  def print_win
    return "Win for " + @player1_name if (difference >= 2)
    return "Win for " + @player2_name 
  end

  def print_score
    "#{SCORES[@p1_points]}-#{SCORES[@p2_points]}"
  end

  def advantage_or_win?
    @p1_points >= 4 or @p2_points >= 4
  end

  EQUAL_RESULT = {
    0 => "Love-All",
    1 => "Fifteen-All",
    2 => "Thirty-All",
  }

  SCORES = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty",
  }  
end

class TennisGame2
  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1_points = @p2_points = 0
  end
      
  def won_point(player_name)
    player_name == @player1_name ? p1_score : p2_score
  end

  def score
    result = "Love"
    if tied?
      result = "Fifteen" if @p1_points == 1
      result = "Thirty" if @p1_points == 2
      result += "-All"
      result = "Deuce" if @p1_points >= 3
      return result
    end
    
    p1_result = p2_result = "Love"
    if between_zero_and_three?(@p1_points) && love?(@p2_points)
      p1_result = one_player_has_scored(@p1_points)
    end

    if between_zero_and_three?(@p2_points) && love?(@p1_points)
      p2_result = one_player_has_scored(@p2_points)
    end
    
    if (@p1_points>@p2_points && @p1_points < 4)
      p1_result="Thirty" if (@p1_points==2)
      p1_result="Forty" if (@p1_points==3)
      p2_result="Fifteen" if (@p2_points==1)
      p2_result="Thirty" if (@p2_points==2)
    end

    if (@p2_points>@p1_points && @p2_points < 4)
      p2_result="Thirty" if (@p2_points==2)
      p2_result="Forty" if (@p2_points==3)
      p1_result="Fifteen" if (@p1_points==1)
      p1_result="Thirty" if (@p1_points==2)
    end
    result = p1_result + "-" + p2_result

    result = "Advantage " + @player1_name if (@p1_points > @p2_points && @p2_points >= 3)
    result = "Advantage " + @player2_name if (@p2_points > @p1_points && @p1_points >= 3)
    result = "Win for " + @player1_name if (@p1_points>=4 && @p2_points>=0 && (@p1_points-@p2_points)>=2)
    result = "Win for " + @player2_name if (@p2_points>=4 && @p1_points>=0 && (@p2_points-@p1_points)>=2)
    result
  end

  def setp1_score(number)
    (0..number).each do |i|
        p1_score()
    end
  end

  def setp2_score(number)
    (0..number).each do |i|
      p2_score()
    end
  end

  def p1_score
    @p1_points +=1
  end
  
  def p2_score
    @p2_points +=1
  end

  private

  def one_player_has_scored(player_points)
    return "Fifteen" if (player_points==1)
    return "Thirty" if (player_points==2)
    return "Forty" if (player_points==3)
  end

  def tied?
    @p1_points == @p2_points 
  end

  def between_zero_and_three?(player_points)
   (0..3).include?(player_points) 
  end

  def love?(player_points)
    player_points == 0
  end 
end

class TennisGame3
  def initialize(player1_name, player2_name)
    @p1N = player1_name
    @p2N = player2_name
    @p1 = 0
    @p2 = 0
  end
      
  def won_point(n)
    if n == @p1N
        @p1 += 1
    else
        @p2 += 1
    end
  end
  
  def score
    if (@p1 < 4 && @p2 < 4) && (@p1 + @p2 < 6)
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[@p1]
      @p1 == @p2 ? s + "-All" : s + "-" + p[@p2]
    else
      if (@p1 == @p2)
        "Deuce"
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1-@p2)*(@p1-@p2) == 1 ? "Advantage " + s : "Win for " + s
      end
    end
  end
end
