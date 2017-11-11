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
    # @return [Array]
    #
    def merge_sort(a, sentinel_flag)
      merge_sort_support(a, 0, a.length - 1, sentinel_flag)
      a
    end

    # Insertion Sort Routine
    # @param a [Array]
    # @return [Array]
    #
    def insertion_sort(a)
      n = a.length
      j = 1
      while j < n
        i = j-1
        key = a[j]
        while i >=0 && key < a[i]
          a[i+1] = a[i]
          i -= 1
        end
        a[i+1] = key
        j += 1
      end
      a
    end

    # Selection Sort Routine
    # @param a [Array]
    # @return [Array]
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
      a
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
      tmp_arr_1_len, tmp_arr_2_len = prep_tmp_arr_len(p, q, r)
      tmp_arr_1, tmp_arr_2 = prep_tmp_arrays(a, p, q, tmp_arr_1_len, tmp_arr_2_len)
      tmp_arr_1[tmp_arr_1_len + 1] = tmp_arr_2[tmp_arr_2_len + 1] = MAX_VALUE
      i, j, k = 1, 1, p
      while k <= r
        if tmp_arr_1[i] <= tmp_arr_2[j]
          a[k] = tmp_arr_1[i]
          i += 1
        else
          a[k] = tmp_arr_2[j]
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
      tmp_arr_1_len, tmp_arr_2_len = prep_tmp_arr_len(p, q, r)
      tmp_arr_1, tmp_arr_2 = prep_tmp_arrays(a, p, q, tmp_arr_1_len, tmp_arr_2_len)
      options = {
          a: a, tmp_arr_1: tmp_arr_1, tmp_arr_2: tmp_arr_2, tmp_arr_1_len: tmp_arr_1_len,
          tmp_arr_2_len: tmp_arr_2_len, p: p
      }
      sort_subarrays(options)
    end

    # Sorts subarrays into the original array and combines results
    # @param options [Hash]
    # @return [NIL]
    #
    def sort_subarrays(options)
      tmp_arr_1_len, tmp_arr_2_len, a, tmp_arr_1, tmp_arr_2 =
          options[:tmp_arr_1_len], options[:tmp_arr_2_len], options[:a], options[:tmp_arr_1], options[:tmp_arr_2]
      tmp_arr_1_loop, tmp_arr_2_loop, orig_arr_loop = compare_elements_and_copy(options)
      options_hash = {
          max_len: tmp_arr_1_len, orig_arr: a, tmp_arr: tmp_arr_1, orig_arr_loop: orig_arr_loop,
          tmp_arr_loop: tmp_arr_1_loop
      }
      orig_arr_loop = iterate_and_copy(options_hash)
      options_hash = {
          max_len: tmp_arr_2_len, orig_arr: a, tmp_arr: tmp_arr_2, orig_arr_loop: orig_arr_loop,
          tmp_arr_loop: tmp_arr_2_loop
      }
      iterate_and_copy(options_hash)
    end


    # Compares elements of two sub arrays and copies them into a single array
    # @param options [Hash]
    # @return [Array]
    #
    def compare_elements_and_copy(options)
      a, tmp_arr_1, tmp_arr_2, tmp_arr_1_len, tmp_arr_2_len, p = options[:a], options[:tmp_arr_1],
          options[:tmp_arr_2], options[:tmp_arr_1_len], options[:tmp_arr_2_len], options[:p]
      i, j, k = 1, 1, p
      while i <= tmp_arr_1_len && j <= tmp_arr_2_len
        if tmp_arr_1[i] <= tmp_arr_2[j]
          a[k] = tmp_arr_1[i]
          i += 1
        else
          a[k] = tmp_arr_2[j]
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
      tmp_arr_loop, max_len, a, tmp_arr, orig_arr_loop =  options[:tmp_arr_loop], options[:max_len],
          options[:orig_arr], options[:tmp_arr], options[:orig_arr_loop]
      while tmp_arr_loop <= max_len
        a[orig_arr_loop] = tmp_arr[tmp_arr_loop]
        orig_arr_loop += 1
        tmp_arr_loop += 1
      end
      orig_arr_loop
    end

    # Evaluates length of subarrays
    # @param p [Integer]
    # @param q [Integer]
    # @param r [Integer]
    # @return [Array]
    #
    def prep_tmp_arr_len(p, q, r)
      [
        q - p + 1,
        r - q
      ]
    end

    # Copies elements from subarrays into temp arrays and returns temp arrays
    # @param tmp_arr_1_len [Integer]
    # @param tmp_arr_2_len [Integer]
    # @param p [Integer]
    # @param q [Integer]
    # @param a [Array]
    # @return [Array]
    #
    def prep_tmp_arrays(a, p, q, tmp_arr_1_len, tmp_arr_2_len)
      tmp_arr_1, tmp_arr_2 = [], []
      (1..tmp_arr_1_len).each { |x| tmp_arr_1[x] = a[p + x - 1] }
      (1..tmp_arr_2_len).each { |x| tmp_arr_2[x] = a[q + x] }
      [ tmp_arr_1, tmp_arr_2 ]
    end
  end
end
