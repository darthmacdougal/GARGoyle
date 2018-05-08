require 'GARGoyle/version'

module GARGoyle
  # Extends standard Hash class to include alphabetical topology sorting
  class SortedHash < Hash
    include TSort

    def tsort_each_node(&block)
      keys.sort.each(&block)
    end

    def tsort_each_child(node, &block)
      fetch(node, []).each(&block)
    end
  end

  # Takes in list of jobs and returns a list ordered by dependency (if any)
  # and then natural order
  class JobSequencer

    def process(jobs)
      sortable_jobs = SortedHash.new { |h, k| h[k] = [] }
      jobs.each do |k, v|
        k, v = k.to_s, v.to_s
        raise "Job and dependency can't be the same" if k == v
        sortable_jobs[k] << v
      end
      begin
        sortable_jobs.tsort.reject(&:empty?)
      rescue TSort::Cyclic
        raise 'There was a circular job dependency'
      end
    end
  end
end
