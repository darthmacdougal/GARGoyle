require "GARGoyle/version"

module GARGoyle
  # Takes in list of jobs and returns a list ordered by dependency (if any)
  # and then natural order
  class JobSequencer
    def process(jobs)
      sequence = []
      sequence + jobs.keys.collect(&:to_s)
    end
  end
end
