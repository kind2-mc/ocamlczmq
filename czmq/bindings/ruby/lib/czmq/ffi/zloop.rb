################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

module CZMQ
  module FFI

    # event-driven reactor
    # @note This class is 100% generated using zproject.
    class Zloop
      # Raised when one tries to use an instance of {Zloop} after
      # the internal pointer to the native object has been nullified.
      class DestroyedError < RuntimeError; end

      # Boilerplate for self pointer, initializer, and finalizer
      class << self
        alias :__new :new
      end
      # Attaches the pointer _ptr_ to this instance and defines a finalizer for
      # it if necessary.
      # @param ptr [::FFI::Pointer]
      # @param finalize [Boolean]
      def initialize(ptr, finalize = true)
        @ptr = ptr
        if @ptr.null?
          @ptr = nil # Remove null pointers so we don't have to test for them.
        elsif finalize
          @finalizer = self.class.create_finalizer_for @ptr
          ObjectSpace.define_finalizer self, @finalizer
        end
      end
      # @param ptr [::FFI::Pointer]
      # @return [Proc]
      def self.create_finalizer_for(ptr)
        Proc.new do
          ptr_ptr = ::FFI::MemoryPointer.new :pointer
          ptr_ptr.write_pointer ptr
          ::CZMQ::FFI.zloop_destroy ptr_ptr
        end
      end
      # @return [Boolean]
      def null?
        !@ptr or @ptr.null?
      end
      # Return internal pointer
      # @return [::FFI::Pointer]
      def __ptr
        raise DestroyedError unless @ptr
        @ptr
      end
      # So external Libraries can just pass the Object to a FFI function which expects a :pointer
      alias_method :to_ptr, :__ptr
      # Nullify internal pointer and return pointer pointer.
      # @note This detaches the current instance from the native object
      #   and thus makes it unusable.
      # @return [::FFI::MemoryPointer] the pointer pointing to a pointer
      #   pointing to the native object
      def __ptr_give_ref
        raise DestroyedError unless @ptr
        ptr_ptr = ::FFI::MemoryPointer.new :pointer
        ptr_ptr.write_pointer @ptr
        __undef_finalizer if @finalizer
        @ptr = nil
        ptr_ptr
      end
      # Undefines the finalizer for this object.
      # @note Only use this if you need to and can guarantee that the native
      #   object will be freed by other means.
      # @return [void]
      def __undef_finalizer
        ObjectSpace.undefine_finalizer self
        @finalizer = nil
      end

      # Create a new callback of the following type:
      # Callback function for reactor socket activity
      #     typedef int (zloop_reader_fn) (                
      #         zloop_t *loop, zsock_t *reader, void *arg);
      #
      # @note WARNING: If your Ruby code doesn't retain a reference to the
      #   FFI::Function object after passing it to a C function call,
      #   it may be garbage collected while C still holds the pointer,
      #   potentially resulting in a segmentation fault.
      def self.reader_fn
        ::FFI::Function.new :int, [:pointer, :pointer, :pointer], blocking: true do |loop, reader, arg|
          loop = Zloop.__new loop, false
          reader = Zsock.__new reader, false
          result = yield loop, reader, arg
          result = Integer(result)
          result
        end
      end

      # Create a new callback of the following type:
      # Callback function for reactor events (low-level)
      #     typedef int (zloop_fn) (                            
      #         zloop_t *loop, zmq_pollitem_t *item, void *arg);
      #
      # @note WARNING: If your Ruby code doesn't retain a reference to the
      #   FFI::Function object after passing it to a C function call,
      #   it may be garbage collected while C still holds the pointer,
      #   potentially resulting in a segmentation fault.
      def self.fn
        ::FFI::Function.new :int, [:pointer, :pointer, :pointer], blocking: true do |loop, item, arg|
          loop = Zloop.__new loop, false
          result = yield loop, item, arg
          result = Integer(result)
          result
        end
      end

      # Create a new callback of the following type:
      # Callback for reactor timer events
      #     typedef int (zloop_timer_fn) (              
      #         zloop_t *loop, int timer_id, void *arg);
      #
      # @note WARNING: If your Ruby code doesn't retain a reference to the
      #   FFI::Function object after passing it to a C function call,
      #   it may be garbage collected while C still holds the pointer,
      #   potentially resulting in a segmentation fault.
      def self.timer_fn
        ::FFI::Function.new :int, [:pointer, :int, :pointer], blocking: true do |loop, timer_id, arg|
          loop = Zloop.__new loop, false
          result = yield loop, timer_id, arg
          result = Integer(result)
          result
        end
      end

      # Create a new zloop reactor
      # @return [CZMQ::Zloop]
      def self.new()
        ptr = ::CZMQ::FFI.zloop_new()
        __new ptr
      end

      # Destroy a reactor
      #
      # @return [void]
      def destroy()
        return unless @ptr
        self_p = __ptr_give_ref
        result = ::CZMQ::FFI.zloop_destroy(self_p)
        result
      end

      # Register socket reader with the reactor. When the reader has messages, 
      # the reactor will call the handler, passing the arg. Returns 0 if OK, -1
      # if there was an error. If you register the same socket more than once, 
      # each instance will invoke its corresponding handler.                   
      #
      # @param sock [Zsock, #__ptr]
      # @param handler [::FFI::Pointer, #to_ptr]
      # @param arg [::FFI::Pointer, #to_ptr]
      # @return [Integer]
      def reader(sock, handler, arg)
        raise DestroyedError unless @ptr
        self_p = @ptr
        sock = sock.__ptr if sock
        result = ::CZMQ::FFI.zloop_reader(self_p, sock, handler, arg)
        result
      end

      # Cancel a socket reader from the reactor. If multiple readers exist for
      # same socket, cancels ALL of them.                                     
      #
      # @param sock [Zsock, #__ptr]
      # @return [void]
      def reader_end(sock)
        raise DestroyedError unless @ptr
        self_p = @ptr
        sock = sock.__ptr if sock
        result = ::CZMQ::FFI.zloop_reader_end(self_p, sock)
        result
      end

      # Configure a registered reader to ignore errors. If you do not set this,
      # then readers that have errors are removed from the reactor silently.   
      #
      # @param sock [Zsock, #__ptr]
      # @return [void]
      def reader_set_tolerant(sock)
        raise DestroyedError unless @ptr
        self_p = @ptr
        sock = sock.__ptr if sock
        result = ::CZMQ::FFI.zloop_reader_set_tolerant(self_p, sock)
        result
      end

      # Register low-level libzmq pollitem with the reactor. When the pollitem  
      # is ready, will call the handler, passing the arg. Returns 0 if OK, -1   
      # if there was an error. If you register the pollitem more than once, each
      # instance will invoke its corresponding handler. A pollitem with         
      # socket=NULL and fd=0 means 'poll on FD zero'.                           
      #
      # @param item [::FFI::Pointer, #to_ptr]
      # @param handler [::FFI::Pointer, #to_ptr]
      # @param arg [::FFI::Pointer, #to_ptr]
      # @return [Integer]
      def poller(item, handler, arg)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_poller(self_p, item, handler, arg)
        result
      end

      # Cancel a pollitem from the reactor, specified by socket or FD. If both
      # are specified, uses only socket. If multiple poll items exist for same
      # socket/FD, cancels ALL of them.                                       
      #
      # @param item [::FFI::Pointer, #to_ptr]
      # @return [void]
      def poller_end(item)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_poller_end(self_p, item)
        result
      end

      # Configure a registered poller to ignore errors. If you do not set this,
      # then poller that have errors are removed from the reactor silently.    
      #
      # @param item [::FFI::Pointer, #to_ptr]
      # @return [void]
      def poller_set_tolerant(item)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_poller_set_tolerant(self_p, item)
        result
      end

      # Register a timer that expires after some delay and repeats some number of
      # times. At each expiry, will call the handler, passing the arg. To run a  
      # timer forever, use 0 times. Returns a timer_id that is used to cancel the
      # timer in the future. Returns -1 if there was an error.                   
      #
      # @param delay [Integer, #to_int, #to_i]
      # @param times [Integer, #to_int, #to_i]
      # @param handler [::FFI::Pointer, #to_ptr]
      # @param arg [::FFI::Pointer, #to_ptr]
      # @return [Integer]
      def timer(delay, times, handler, arg)
        raise DestroyedError unless @ptr
        self_p = @ptr
        delay = Integer(delay)
        times = Integer(times)
        result = ::CZMQ::FFI.zloop_timer(self_p, delay, times, handler, arg)
        result
      end

      # Cancel a specific timer identified by a specific timer_id (as returned by
      # zloop_timer).                                                            
      #
      # @param timer_id [Integer, #to_int, #to_i]
      # @return [Integer]
      def timer_end(timer_id)
        raise DestroyedError unless @ptr
        self_p = @ptr
        timer_id = Integer(timer_id)
        result = ::CZMQ::FFI.zloop_timer_end(self_p, timer_id)
        result
      end

      # Register a ticket timer. Ticket timers are very fast in the case where   
      # you use a lot of timers (thousands), and frequently remove and add them. 
      # The main use case is expiry timers for servers that handle many clients, 
      # and which reset the expiry timer for each message received from a client.
      # Whereas normal timers perform poorly as the number of clients grows, the 
      # cost of ticket timers is constant, no matter the number of clients. You  
      # must set the ticket delay using zloop_set_ticket_delay before creating a 
      # ticket. Returns a handle to the timer that you should use in             
      # zloop_ticket_reset and zloop_ticket_delete.                              
      #
      # @param handler [::FFI::Pointer, #to_ptr]
      # @param arg [::FFI::Pointer, #to_ptr]
      # @return [::FFI::Pointer]
      def ticket(handler, arg)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_ticket(self_p, handler, arg)
        result
      end

      # Reset a ticket timer, which moves it to the end of the ticket list and
      # resets its execution time. This is a very fast operation.             
      #
      # @param handle [::FFI::Pointer, #to_ptr]
      # @return [void]
      def ticket_reset(handle)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_ticket_reset(self_p, handle)
        result
      end

      # Delete a ticket timer. We do not actually delete the ticket here, as    
      # other code may still refer to the ticket. We mark as deleted, and remove
      # later and safely.                                                       
      #
      # @param handle [::FFI::Pointer, #to_ptr]
      # @return [void]
      def ticket_delete(handle)
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_ticket_delete(self_p, handle)
        result
      end

      # Set the ticket delay, which applies to all tickets. If you lower the   
      # delay and there are already tickets created, the results are undefined.
      #
      # @param ticket_delay [Integer, #to_int, #to_i]
      # @return [void]
      def set_ticket_delay(ticket_delay)
        raise DestroyedError unless @ptr
        self_p = @ptr
        ticket_delay = Integer(ticket_delay)
        result = ::CZMQ::FFI.zloop_set_ticket_delay(self_p, ticket_delay)
        result
      end

      # Set hard limit on number of timers allowed. Setting more than a small  
      # number of timers (10-100) can have a dramatic impact on the performance
      # of the reactor. For high-volume cases, use ticket timers. If the hard  
      # limit is reached, the reactor stops creating new timers and logs an    
      # error.                                                                 
      #
      # @param max_timers [Integer, #to_int, #to_i]
      # @return [void]
      def set_max_timers(max_timers)
        raise DestroyedError unless @ptr
        self_p = @ptr
        max_timers = Integer(max_timers)
        result = ::CZMQ::FFI.zloop_set_max_timers(self_p, max_timers)
        result
      end

      # Set verbose tracing of reactor on/off
      #
      # @param verbose [Boolean]
      # @return [void]
      def set_verbose(verbose)
        raise DestroyedError unless @ptr
        self_p = @ptr
        verbose = !(0==verbose||!verbose) # boolean
        result = ::CZMQ::FFI.zloop_set_verbose(self_p, verbose)
        result
      end

      # Start the reactor. Takes control of the thread and returns when the 0MQ  
      # context is terminated or the process is interrupted, or any event handler
      # returns -1. Event handlers may register new sockets and timers, and      
      # cancel sockets. Returns 0 if interrupted, -1 if cancelled by a handler.  
      #
      # @return [Integer]
      def start()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_start(self_p)
        result
      end

      # Ignore zsys_interrupted flag in this loop. By default, a zloop_start will 
      # exit as soon as it detects zsys_interrupted is set to something other than
      # zero. Calling zloop_ignore_interrupts will supress this behavior.         
      #
      # @return [void]
      def ignore_interrupts()
        raise DestroyedError unless @ptr
        self_p = @ptr
        result = ::CZMQ::FFI.zloop_ignore_interrupts(self_p)
        result
      end

      # Self test of this class.
      #
      # @param verbose [Boolean]
      # @return [void]
      def self.test(verbose)
        verbose = !(0==verbose||!verbose) # boolean
        result = ::CZMQ::FFI.zloop_test(verbose)
        result
      end
    end
  end
end

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################