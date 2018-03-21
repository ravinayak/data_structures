require_relative '../sort_flight_tickets/node'
# Used for namespacing
#
module SortFlightTickets
  # Class to sort tickets
  #
  class TicketArrange
    # Attribute Accessor
    #
    attr_accessor :input_ticket_arr, :output_ticket_arr, :src_destination_hash

    # Initialize
    #
    def initialize(input_ticket_arr)
      @input_ticket_arr = input_ticket_arr
      @src_destination_hash = {}
    end

    # Sort tickets
    # @return [Array]
    #
    def sort_tickets
      iterate_and_prep_hash
      node = prep_start_airport
      prep_output_arr(node)
    end

    # Finds the keys in hash and returns the node which is source
    # @return [Node]
    #
    def prep_start_airport
      start_airport = nil
      self.src_destination_hash.keys.each do |key|
        node = node_for_key(key)
        start_airport = node if node.src_destination_sym == :src
      end
      self.src_destination_hash = {}
      start_airport
    end

    # Display Logic
    # @param node [Node]
    # @return [Array]
    #
    def prep_output_arr(node)
      return [] if node.nil?
      output_arr = []
      begin
        output_arr << [node.value, node.next_node.value]
        node = node.next_node
      end until node.next_node.nil?
      output_arr
    end

    # Iterates over the input array and prepares a hash
    # Prepares nodes and connects them together to prepare a
    # graph
    # @return [Array]
    #
    def iterate_and_prep_hash
      self.input_ticket_arr.each do |src_destination_arr|
        src_node = node_for_key(src_destination_arr[0], :src)
        destination_node = node_for_key(src_destination_arr[1], :destn)
        src_node.next_node = destination_node
      end
    end

    # Creates a new element node if key does not exist in hash or finds and removes if it exists
    # @param key [String]
    # @param src_destination [Symbol]
    # @return [Node]
    #
    def node_for_key(key, src_destination = nil)
      return self.src_destination_hash.delete(key) if self.src_destination_hash.key?(key)
      self.src_destination_hash[key] = ::SortFlightTickets::Node.new(key, src_destination)
    end
  end
end

# require '/Users/ravinayak/projects/data_structures/sort_flight_tickets/ticket_arrange.rb'
# input_ticket_arr = [['LAX', 'PDX'], ['SFO', 'LAX'], ['SEA', 'JFK'], ['PDX', 'SEA']]
# st = SortFlightTickets::TicketArrange.new(input_ticket_arr)
# st.iterate_and_prep_hash
# output = [['SFO', 'LAX'], ['LAX', 'PDX'], ['PDX', 'SEA'], ['SEA', 'JFK']]