# Used for namespacing
#
module DynamicProgramming
  # Includes methods for finding minimum coins needed for making change
  # for "j" cents
  #
  class CoinChange
    
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
    #               | Sigma { 1 + C[j - d(i)] }     , j >= 1  [ When we choose a coin of denomination of d(i), number
    #               |         1<= i <- k                        of coins is increased by 1, and the value for which
    #               |                                           we are making change is decreased by d(i) ]
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
    #                      1 + C[10-10]  = 1 + C[0] = 1
    #                     }
    #              = 1
    #        C[35] = min { 1 + C[35-50] = Infinity,
    #                      1 + C[35-25] = 1 + C[10] = 2
    #                   }
    #
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
    # @param j [Numeric]
    # @return [Array]
    #
    def make_change_non_matrix(j)
    
    end
  end
end