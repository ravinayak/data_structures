# Used for namespacing
#
module DynamicProgramming
  # Includes methods for finding minimum coins needed for making change
  # for "j" cents
  #
  class CoinChange
    
    # Attribute Accessors
    #
    attr_accessor :j, :denomination_arr, :denomination_arr_matrix, :coin_change_arr, :minimum_coin_arr, :coin_change_matrix
    
    # Initialize method
    # @param denomination_arr [Array] Array of available denominations of coins
    # @param j [Numeric] Amount whose change is to be made
    #
    def initialize(j, denomination_arr)
      @j = j
      @denomination_arr = denomination_arr
      @denomination_arr_matrix = denomination_arr.dup
      @coin_change_arr = []
      @minimum_coin_arr = []
      @coin_change_matrix = nil
    end
    
    # Problem Statement =>
    #
    #   a.  let D = { d1, d2, ..., dk } be a finite set of distinct coin denominations.
    #       Example: d1 = 25 cents, d2 = 10 cents, d3 = 5 cents and d4 = 1 cent
    #   b.  Assume each d(i) is an integer and d1 > d2 > d3 ... > dk
    #   c.  Each denomination is available in unlimited quantity
    #
    #   Then make change for n cents, using a minimum total number of coins
    #   Assume that dk = 1, so that there is always a solution
    #
    #   Greedy algorithms may work for some coin sets, but may not work for
    #   others. For the coin set { 25 cents, 10 cents, 5 cents, 1 cent }, the greedy method
    #   always finds the optimal solution
    #
    #   If D = { 25 cents, 10 cents, 1 cent } and n = 30 cents. Greedy method would produce a solution:
    #     25 cents + 5 * 1 cents, which is not as good as 3 * 10 cents
    #
    #
    # Characterize the nature of DP solution =>
    #
    #   Let C(j) =  Minimum number of coins needed to make change for "j" cents using coins of
    #               denominations d1, d2, d3,....., dk
    #
    #   Then we can define C(j) as follows -
    #               | Infinity                      , j < 0   [ When we have to make change for -ve total, even
    #               |                                           infinite coins cannot suffice]
    #       C(j) =  |   0,                          , j = 0   [ When we have to make change for 0 cents,
    #               |                                           we do not need any coins]
    #               | 1 + min { C[j - d(i)] }       , j >= 1  [ When we choose a coin of denomination of d(i), number
    #               | 1<=i<= k                          of coins is increased by 1, and the value for which
    #               |                                           we are making change is decreased by d(i)]
    #               |
    #
    # The coding solution is easier and more efficient when it is calculated in a bottom-up fashion because it avoids
    # the extra overhead of function calls that happen in a top-down approach.
    #
    # Example =>
    #     Consider coin set = { 50 cents, 25 cents, 10 cents, 1 cent }
    #         C[0] = 0
    #         C[1] = min { 1 + C[1-50]  = Infinity,
    #                      1 + C[1-25]  = Infinity,
    #                      1 + C[1-10]  = Infinity,
    #                      1 + C[1-1]   = 1 + C[0] = 1
    #                     }
    #              = 1
    #        C[10] = min { 1 + C[10-50]  = Infinity,
    #                      1 + C[10-25]  = Infinity,
    #                      1 + C[10-10]  = 1 + C[0] = 1,
    #                      1 + C[10-1]   = 1 + C[9] = 10
    #                     }
    #              = 1
    #        C[35] = min { 1 + C[35-50] = Infinity,
    #                      1 + C[35-25] = 1 + C[10] = 2,
    #                      1 + C[35-10] = 1 + C[25] = 2,
    #                      1 + C[35-1]  = 1 + C[34] = 35
    #                   }
    #              = 2
    # Given a problem of making change for "n" cents, and the smallest denomination possible for a coin as 1 cent,
    # we can only have "n" sub-problems to solve.
    # i.e. Make change for following
    #     n, n-1, n-2, n-3, n-4,...., 3, 2, 1
    #
    # If we have coins of "m" denominations, then we can solve each sub problem maximum in "m" ways. In most cases
    # the number of solutions possible will be less than "m", as for many the value will be negative (assuming we use
    # a coin of certain denomination) and hence not feasible
    #
    # Time Complexity of DP Problem = Number of Sub problems * Choices for each sub-problem
    #
    # 1 sub-problem => m ways ; n sub-problems => n * m ways
    #
    # Time Complexity of Making Change Problem = O(mn)
    #
    #
    # Finds minimum coins needed and also the exact denomination of coins
    # needed for making change for "j" cents
    # @return [Array]
    #
    def make_change_non_matrix
      return [nil, nil] if @j < 0
      return [0, []] if @j == 0
      i = 1
      @minimum_coin_arr[0], @coin_change_arr[0] = 0, 0
      while i <= @j
        @minimum_coin_arr[i] = nil
        @denomination_arr.each do |denomination|
          if i >= denomination &&
            (@minimum_coin_arr[i].nil? || (@minimum_coin_arr[i] > 1 + @minimum_coin_arr[i - denomination]))
            @minimum_coin_arr[i] = 1 + @minimum_coin_arr[i - denomination]
            @coin_change_arr[i] = denomination
          end
        end
        i += 1
      end
      print_non_matrix_solution
    end
    
    # Prints the non matrix solution -
    #   1.  Minimum number of coins needed for making change for "j" cents
    #   2.  Coin denominations needed for making change for "j" cents
    # @return [NIL]
    #
    def print_non_matrix_solution
      puts " Minimum number of coins needed to make change for #{j} cents :: #{@minimum_coin_arr[@j]}"
      print " Coins needed to make change :: "
      i = @j
      while i > 0
        print @coin_change_arr[i].to_s + ' '
        i = i - @coin_change_arr[i]
      end
      puts
      puts " [ Minimum Number of Coins, Coin Change Array ] :: #{[@minimum_coin_arr[@j], @coin_change_arr]}"
    end
    
    # Alternate Approach ::
    #
    # Let K = { d1, d2, d3, d4, d5, ....., d(k) } such that coin denominations are in sorted order
    #           d1 < d2 < d3 < d4 < ..... < d(k); d1 = 1 cent
    #
    # Let C[i,j] =  Minimum number of coins needed to make change for "j" cents using coins of
    #               denominations 1, 2, 3,..., i
    # Then, C[i,j] = Two possible cases
    #                   i.  When we select coin of denomination "i"
    #                   ii. When we do not select coin of denomination "i" [=> we use coins upto i-1 denomination]
    #       C[i, j] = min { C[i-1,j], 1 + C[i, j-d(i)] }
    #
    # Then we can define C[i, j] as follows
    #
    #                 |   Infinity                            ,   j < 0
    #                 |     0                                 ,   j = 0
    #                 |     0                                 ,   i = 0 [No coins of any denominations are available]
    #                 |   min { C[i-1,j], 1 + C[i, j-d(i)] }  ,   Select or not select coin of denomination "i"
    #                 |   1<=i<=k
    #
    # Implementing the solution requires that we define use cases for following -
    #   1.  Making change for "0" cents using coins of any denominations 1, 2, 3, ..., k
    #   2.  Making change for any amount 1, 2, 3, ..., j cents using "0" coins
    #   3.  When current coin denomination is greater than change value, then we keep looking
    #       for smaller coin denominations unless we find an entry in array for that coin
    #       denomination and change amount OR a coin denomination which can be  used to make
    #       change for the given amount.
    #         ex: - Consider denomination_arr = [1, 4, 6]
    #               C[3, 2] => Coin of denomination 3 = 6 > 2
    #                       => Look for smaller denomination
    #                           =>  Coin of denomination 2 = 4 > 2 [Consider C[2,2] is not defined]
    #                       => Look for smaller denomination
    #                           =>  Coin of denomination 1 = 1 < 2
    #                       = C[1,2]
    #
    # These use cases are essential to define to address the use cases -
    #   1.  When selection of coin of a particular denomination results in "0" amount to change, i.e
    #       we make an exact selection for amount to change. C[i, j-d(i)] = C[i, 0]
    #   2.  When we consider selection of coins of denomination value "1", we consider a case where
    #       we do not select coin of denomination value "1". C[0, j]
    #
    # We run a loop for 1 to j and 1 to k. It is important not to start from "0" for coin denominations,
    # because that could result in -ve index [i-1] = [-1]. So, j iteration should start from "1"
    #
    # Denomination Array would ideally not have "0" value coin denomination defined. But we need a row
    # corresponding to "0". So we should insert "0" at "0th" position.
    #
    #
    # Finds minimum number of coins needed to make change for "j" cents using matrix method
    # @return [Array]
    #
    def make_change_matrix
      # Insert "0" at "0th" position in the denomination array
      @denomination_arr_matrix.unshift(0)
      
      # Declare a 2D array for Coin Change Matrix where
      #   a.  row = denomination array length
      #   b.  column = "j" length
      @coin_change_matrix = Array.new(@denomination_arr_matrix.length) {Array.new(@j + 1)}
      # Oth row corresponds to minimum number of coins needed to make change for 1,2,3.., i cents
      # using "0" coins and is set to the amount to be made change of
      (0..@j).each {|i| @coin_change_matrix[0][i] = i}
      
      # 0th column corresponds to minimum number of coins needed to make change for "0" amount using
      # "0" coins, and is set to "0"
      @denomination_arr_matrix.length.times {|i| @coin_change_matrix[i][0] = 0}

      (1..@j).each do |change_amount|
        # we use "..." to avoid the last element in range which is length of denomination array
        @denomination_arr_matrix.each_with_index do |denomination_amount, index|
          next if index.zero?
          if change_amount >= denomination_amount
            min_value = [
              @coin_change_matrix[index - 1][change_amount],
              1 + @coin_change_matrix[index][change_amount - denomination_amount]
            ].min
            @coin_change_matrix[index][change_amount] = min_value
          else
            # Case where coin denomination is greater in value than amount to be changed,
            # hence we look for smaller index, reducing by 1 at a time until we find a value
            # in C[i,j] which is populated
            #
            @coin_change_matrix[index][change_amount] = @coin_change_matrix[index - 1][change_amount]
          end
        end
      end
      print_matrix_solution
    end
    
    # Prints Matrix Solution
    #   1.  Minimum number of coins needed for making change for "j" cents
    #   2.  Coin denominations needed for making change for "j" cents
    # @return [NIL]
    #
    def print_matrix_solution
      minimum_coins = @coin_change_matrix[@denomination_arr_matrix.length - 1][@j]
      puts " Minimum number of coins needed to make change for #{j} cents :: #{minimum_coins}"
      print " Coins needed to make change :: "
      change_amount, row = @j, @denomination_arr_matrix.length - 1
      while change_amount > 0
        if change_amount >= @denomination_arr_matrix[row]
          if (1 + @coin_change_matrix[row][change_amount - @denomination_arr_matrix[row]]) <=
            @coin_change_matrix[row - 1][change_amount]
            # In this case the coin denomination is selected and hence we print it
            print @denomination_arr_matrix[row].to_s + '  '
            change_amount = change_amount - @denomination_arr_matrix[row]
          else
            # when coin of denomination is not selected, we look at the immediately previous smaller coin
            # denomination if it is smaller than amount to be changed and can be used. This does not result in
            # immediate selection of coin denomination
            row = row - 1
          end
        else
          # when change amount is less than current coin denomination, we simply look at the immediately
          # previous smaller coin denomination if it was used to make the change, in code, this amounts
          # to decreasing index by 1
          row = row - 1
        end
      end
    end
  end
end

# To run coin change problem
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/coin_change'
# j, denomination_arr = 1079, [1, 10, 25, 50]
# coin_change = DynamicProgramming::CoinChange.new(j, denomination_arr)
# coin_change.make_change_matrix
#