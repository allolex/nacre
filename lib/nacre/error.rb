class ApiError < Exception
end

class SearchResultsError < Exception
end

class InvalidJsonError < Exception
end

module Nacre
  class EmptyResourceError < Exception
  end
end
