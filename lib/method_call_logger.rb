require "method_call_logger/version"

class Class
  def method_call_logging(option={})
    Class.add_proc(
      proc {|event, file, line, id, binding, klass|
        if event == "call" && klass == self
          if id != :initialize
            msg = "#{self.to_s}##{id.to_s}"
            unless binding.local_variables.empty?
              msg += "("
              msg += binding.local_variables.map{|vname|
                        "#{vname}:#{binding.local_variable_get(vname).inspect}"
                      }.join(", ")
              msg += ")"
            end
            logger = binding.receiver.instance_variable_get(:@logger)
            if option[id]
              logger.log(option[id], msg)
            else
              logger.debug(msg)
            end
          end
        end
      }
    )
  end

  def self.add_proc(proc_filter)
    unless defined?(@proc_list)
      @proc_list = []
      set_trace_func(
        proc {|*args|
          @proc_list.each{|_proc| _proc.call(*args)}
        }
      )
    end
    @proc_list.push(proc_filter)
  end
end
