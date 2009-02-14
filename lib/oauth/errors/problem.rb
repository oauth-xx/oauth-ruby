module OAuth
  class Problem < OAuth::Error
    attr_reader :problem, :request, :params
    def initialize(problem, request = nil, params = {})
      @problem = problem
      @request = request
      @params  = params
    end

    def to_s
      problem
    end
  end
end