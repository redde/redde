module Redde
  module Presence
    class View
      attr_reader :obj, :user_id
      TTL = 15

      def initialize(obj, user_id)
        @obj = obj
        @user_id = user_id
      end

      def self.viewers_of(obj)
        Redis.current.keys("#{obj.class.name}:#{obj.id}:*").map do |key|
          key.split(':').last.to_i
        end
      end

      def view
        Redis.current.set(key, 1)
        Redis.current.expire(key, TTL)
      end

      def key
        "#{obj.class.name}:#{obj.id}:#{user_id}"
      end
    end
  end
end
