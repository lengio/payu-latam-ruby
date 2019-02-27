module PayU
  class Error < StandardError; end

  class NotFoundError < Error; end

  class UnauthorizedError < Error; end
end
