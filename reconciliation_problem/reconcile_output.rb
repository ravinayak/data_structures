# Used for namespacing
# 
module ReconciliationProblem
  # Class to reconcile output
  #
  class ReconcileOutput
    # Attribute Accessors
    #
    attr_accessor :do_pos, :d1_trans, :d1_pos, :cash_stock_hash

    def initialize(do_pos, d1_pos, d1_trans)
      @cash_stock_hash = do_pos
      @d1_pos = d1_pos
      @d1_trans = d1_trans
    end

    def reconcile
      process_d1_trans
      output_hash = reconcile_support
      display(output_hash)
    end

    # Private Methods
    #
    private

    # Prints output hash to console
    # @param output_hash [Hash]
    # @return [NIL]
    #
    def display(output_hash)
      output_hash.each_pair { |key, val| puts "#{key}  #{val}"}
      nil
    end

    # Reconciliation Support method
    # @return [Hash]
    #
    def reconcile_support
      output_hash = {}
      self.d1_pos.each_pair { |key, val| process_diff(key, val, output_hash) }
      self.cash_stock_hash.each_key { |key| output_hash[key] = self.cash_stock_hash[key] }
      self.cash_stock_hash.clear
      output_hash
    end

    # Appends key to output hash if the difference is not zero
    # @param key [String]
    # @param d1_val [Integer]
    # @param output_hash [Hash]
    # @return [NIL]
    #
    def process_diff(key, d1_val, output_hash)
      diff = d1_val - find_val(key)
      output_hash[key] = diff unless diff == 0
      self.cash_stock_hash.delete(key)
      nil
    end

    # Process transactions on day1 to prepare and update hash
    #
    def process_d1_trans
      self.d1_trans.each_pair do |key, val|
        val_arr = val.split(/\s/)
        process_d1_trans_supp(key, val_arr)
      end
    end

    # Support method for processing transactions on day1
    #
    # @param key [String]
    # @param val_arr [Array]
    # @return [NIL]
    #
    def process_d1_trans_supp(key, val_arr)
      trans_type, stock_amt, cash_amt = val_arr[0], val_arr[1].to_i, val_arr[2].to_i
      case trans_type
        when 'SL'
          process_trans_for_stock(-stock_amt, cash_amt, key)
        when 'BY'
          process_trans_for_stock(stock_amt, -cash_amt, key)
        else

      end
      nil
    end

    # Processes transaction and updates cash
    # @param stock_amt [Integer]
    # @param cash_amt [Integer]
    # @param key [String]
    # @return [NIL]
    #
    def process_trans_for_stock(stock_amt, cash_amt, key)
      val = find_val(key)
      self.cash_stock_hash[key] = val + stock_amt
      adjust_cash(cash_amt)
      nil
    end

    # Adjusts cash for the given value input
    # @param amt [Integer]
    # @return [Integer]
    #
    def adjust_cash(amt)
      cash_val = find_val('Cash')
      self.cash_stock_hash['Cash'] = cash_val + amt
    end

    # Finds value for a key in cash stock hash and returns 0 if it
    # does not exist
    # @return [Integer]
    #
    def find_val(key)
      return 0 unless self.cash_stock_hash.key?(key)
      self.cash_stock_hash[key]
    end
  end
end

# require '/Users/ravinayak/projects/data_structures/reconciliation_problem/reconcile_output.rb'
# do_pos = { 'App' => 100, 'Goo' => 200, 'Cash' => 10 }
# d1_trans = { 'App' => 'SL 50 30000', 'Goo' => 'BY 10 10000', 'Mic' => 'BY 10 10000' }
# d1_pos = { 'App' => 50, 'Goo' => 220, 'Cash' => 10020 }
# ro = ReconciliationProblem::ReconcileOutput.new(do_pos, d1_pos, d1_trans)
# ro.reconcile
#
# rec_out
#   Goo 10
#   Mic 10
#   Cash 10