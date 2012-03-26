require "resque-async_job/version"

# This is similar to DelayedJob's `send_later`.
#
# Keep in mind that, unlike DelayedJob, only simple Ruby objects
# can be persisted.
#
# If it can be represented in JSON, it can be stored in a job.
module Resque
  
  # The module to include
  module AsyncJob
    
    
    def self.included(base)
      @@_queue= :default
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      # Set the default queue. chain method
      @@_queue= :default
      
      def queue(new_queue = nil)
        if new_queue 
          @@_queue = new_queue
          return self
        else 
          @@_queue 
        end
      end
  
      # This will be called by a worker when a job needs to be processed
      # work either for a class method or an instance method
      def perform(method, id=nil, *args)
        if id && id != 0
          find(id).send(method, *args)
        else
          if !id or id == 0
            self.send(method, *args)
          else
            self.send(method, id, *args)
          end
        end
      end
          
      def async(method, *args)
        Job.create(@@_queue, self, method, 0, *args)
        Plugin.after_enqueue_hooks(self).each do |hook|
          klass.send(hook, *args)
        end
      end
    end
    
    
    # Set the default queue. chain method
    def queue(new_queue = nil)
      if new_queue 
        @@_queue = new_queue
        return self
      else 
        @@_queue
      end
    end
  
    def async(method, *args)
      Job.create(@@_queue, self.class, method, self.id, *args)
      Plugin.after_enqueue_hooks(self.class).each do |hook|
        klass.send(hook, *args)
      end
    end
    
  end
  
end

if defined? ActiveRecord
  class ActiveRecord::Base
    include Resque::AsyncJob
  end
end
