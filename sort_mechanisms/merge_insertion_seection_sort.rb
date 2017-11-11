# Used for namespacing
#
module SortMechanisms
  # Includes methods for Insertion, Merge and Selection Sort
  #
  module MergeInsertionSelectionSort

    MAX_VALUE = (2 ** ((0.size * 8) - 2) - 1)
    MIN_VALUE = -(2 ** ((0.size * 8) - 2))

    # Merge Sort routine
    # @param a [Array]
    # @param sentinel_flag [Boolean]
    # @return [NIL]
    #
    def merge_sort(a, sentinel_flag)
      merge_sort_support(a, 0, a.length, sentinel_flag)
    end

    # Insertion Sort Routine
    # @param a [Array]
    # @return [NIL]
    #
    def insertion_sort(a)
      n = a.length
      j = 1
      while j < n
        i = j-1
        key = a[j]
        while i >=0 && key < a[j]
          a[i+1] = a[i]
          i -= 1
        end
        a[i+1] = key
        j += 1
      end
    end

    # Selection Sort Routine
    # @param a [Array]
    # @return [NIL]
    #
    def selection_sort(a)
      n = a.length
      j, k = 1, 1
      while j < n
        i = j-1
        k = j
        while k < n
          i = k  if a[k] < a[i]
          k += 1
        end
        swap(a, j-1, i) if i != j-1
        j += 1
      end
    end

    private

    # Swaps elements for given positions
    # @param a [Array]
    # @param x [Integer]
    # @param y [Integer]
    # @return [NIL]
    #
    def swap(a, x, y)
      tmp = a[x]
      a[x] = a [y]
      a[y] = tmp
    end

    # Support method for merge sort
    # @param a [Array]
    # @param p [Integer]
    # @param r [Integer]
    # @param sentinel_flag [Boolean]
    # @return [NIL]
    #
    def merge_sort_support(a, p, r, sentinel_flag)
      return if p >= r
      q = ((p + r)/2).floor
      merge_sort_support(a, p, q, sentinel_flag)
      merge_sort_support(a, q + 1, r, sentinel_flag)
      return merge_combine_with_sentinel(a, p, q, r) if sentinel_flag
      merge_combine_without_sentinel(a, p, q, r)
    end

    # Combines two sorted subarrays into one subarray in sorted order
    # @param a [Array]
    # @param p [Integer]
    # @param q [Integer]
    # @param r [Integer]
    # @return [NIL]
    #
    def merge_combine_with_sentinel(a, p, q, r)
      n1, n2 = prep_n1_n2(p, q, r)
      l, r = prep_tmp_arrays(a, p, q, n1, n2)
      l[n1+1] = r[n2+1] = MAX_VALUE
      i, j, k = 1, 1, p
      while k <= r
        if l[i] <= r[j]
          a[k] = l[i]
          i += 1
        else
          a[k] = r[j]
          j += 1
        end
        k += 1
      end
    end

    # Combines two sorted subarrays into one subarray in sorted order
    # @param a [Array]
    # @param p [Integer]
    # @param q [Integer]
    # @param r [Integer]
    # @return [NIL]
    #
    def merge_combine_without_sentinel(a, p, q, r)
      n1, n2 = prep_n1_n2(p, q, r)
      l, r = prep_tmp_arrays(a, p, q, n1, n2)
      options = {
          a: a, l: l, r: r, n1: n1, n2: n2, p: p
      }
      sort_subarrays(options)
    end

    # Sorts subarrays into the original array and combines results
    # @param options [Hash]
    # @return [NIL]
    #
    def sort_subarrays(options)
      n1, n2, a, l, r = options[:n1], options[:n2], options[:a], options[:l], options[:r]
      i, j, k = compare_elements_and_copy(options)
      options_hash = {
          loop: i, max_len: n1, orig_arr: a, tmp_arr: l, orig_arr_len: k, tmp_arr_len: i
      }
      k = iterate_and_copy(options_hash)
      options_hash = {
          loop: j, max_len: n2, orig_arr: a, tmp_arr: r, orig_arr_len: k, tmp_arr_len: j
      }
      iterate_and_copy(options_hash)
    end


    # Compares elements of two sub arrays and copies them into a
    # @param options [Hash]
    # @return [Array]
    #
    def compare_elements_and_copy(options)
      a, l, r, n1, n2, p = options[:a], options[:l], options[:r], options[:n1], options[:n2], options[:p]
      i, j, k = 1, 1, p
      while i <= n1 && j <= n2
        if l[i] <= r[j]
          a[k] = l[i]
          i += 1
        else
          a[k] = r[j]
          j += 1
        end
        k += 1
      end
      [i, j, k]
    end

    # Iterate over remaining elements in subarray and copy them
    # @param options [Hash]
    # @return [Integer]
    #
    def iterate_and_copy(options)
      loop, max_len, orig_arr, tmp_arr, orig_arr_len, tmp_arr_len =  options[:loop], options[:max_len],
          options[:orig_arr], options[:tmp_arr], options[:orig_arr_len], options[:tmp_arr_len]
      while loop<= max_len
        orig_arr[orig_arr_len] = tmp_arr[tmp_arr_len]
        orig_arr_len += 1
        tmp_arr_len += 1
      end
      orig_arr_len
    end

    # Evlautes length of subarrays
    # @param p [Integer]
    # @param q [Integer]
    # @param r [Integer]
    # @return [Array]
    #
    def prep_n1_n2(p, q, r)
      [
        q - p + 1,
        r - q
      ]
    end

    # Copies elements from subarrays into temp arrays and returns temp arrays
    # @param n1 [Integer]
    # @param n2 [Integer]
    # @param p [Integer]
    # @param q [Integer]
    # @param a [Array]
    # @return [Array]
    #
    def prep_tmp_arrays(a, p, q, n1, n2)
      l, r = [], []
      (1..n1).each { |x| l[x] = a[p + x - 1] }
      (1..n2).each { |x| r[x] = a[q + x] }
      [ l, r ]
    end
  end
end
