using StatsBase,Plots
using Distributions, Random
using DataStructures
import Base: isless
include("Gamma.jl")
include("networks.jl")
include("Computation.jl")
"""
Runs a discrete event simulation of an Open Generalized Jackson Network `net`. 

The simulation runs from time `0` to `max_time`. 

Statistics about the total mean queue lengths are recorded from `warm_up_time` 
onwards and the estimated value is returned.

This simulation does NOT keep individual customers state, it only keeps the state 
which is the number of items in each of the nodes.
"""


abstract type Event end
abstract type State end

# Captures an event and the time it takes place
struct TimedEvent
    event::Event
    time::Float64
end

# Comparison of two timed events - this will allow us to use them in a heap/priority-queue
isless(te1::TimedEvent, te2::TimedEvent) = te1.time < te2.time

"""
    new_timed_events = process_event(time, state, event)

Generate an array of 0 or more new `TimedEvent`s based on the current `event` and `state`.
"""
function process_event end # This defines a function with zero methods (to be added later)

# Generic events that we can always use

struct EndSimEvent <: Event end

struct LogStateEvent <: Event end


mutable struct QueueState <: State
    number_in_queues::Array 
end

struct NewArrivals <: Event end

struct RecurArrivals <: Event 
    queue::Int
end

struct ArrivalEvent <: Event
        queue::Int
end
struct EndOfServiceEvent <: Event 
        queue::Int
end


function sim_net(net::NetworkParameters; max_time = 10^3, warm_up_time = 10^2, seed::Int64 = 42, Test2::Int64=0)


    priority=[]
    states=[]
    times=[]


    function record(time,state,queue)
        if time> warm_up_time
        push!(times, time)
        push!(states, copy(state.number_in_queues))
        [push!(priority,ev.event) for ev in queue]
        end
        return nothing 
    end


    function process_event(time::Float64, state::State, ls_event::LogStateEvent)
        #println("Logging state at time $time.")
        #println(state.number_in_queues)
        return []
    end

    function process_event(time::Float64, state::State, es_event::EndSimEvent)
        #println("Ending simulation at time $time.")
        return []
    end

    function simulate(init_state::State, init_timed_event::TimedEvent
        ; 
        max_time::Float64 = 10.0, 
        log_times::Vector{Float64} = Float64[],
        callback = (time, state) -> nothing)

        # The event queue
        priority_queue = BinaryMinHeap{TimedEvent}()

        # Put the standard events in the queue
        push!(priority_queue, init_timed_event)
        push!(priority_queue, TimedEvent(EndSimEvent(), max_time))
        for log_time in log_times
            push!(priority_queue, TimedEvent(LogStateEvent(), log_time))
        end

        # initialize the state
        state = deepcopy(init_state)
        time = 0.0

        # Callback at simulation start
        callback(time, state,init_timed_event)

        # The main discrete event simulation loop - SIMPLE!
        while true
            # Get the next event
            timed_event = pop!(priority_queue)

            # Advance the time
            time = timed_event.time

            # Act on the event
            new_timed_events = process_event(time, state, timed_event.event) 

            # If the event was an end of simulation then stop
            if timed_event.event isa EndSimEvent
            break 
            end

            # The event may spawn 0 or more events which we put in the priority queue 
            for nte in new_timed_events
            push!(priority_queue,nte)
            end

            # Callback for each simulation event
            callback(time, state, new_timed_events)
        end
end;
    
    #Set the random seed
    Random.seed!(seed)
    
    # First dispatch of customers
    function process_event(time::Float64, state::State, ::NewArrivals)
        new_timed_events = TimedEvent[]
        for i in 1:net.L
            if net.α_vector[i] > 0
        
                push!(new_timed_events,TimedEvent(RecurArrivals(i),time+ 1/net.α_vector[i]))
            end
        end
        return new_timed_events
    end

    #Adds a new customer in each queue per the arrival rate 
    function process_event(time::Float64, state::State, ev::RecurArrivals)
        i=ev.queue
        new_timed_events = TimedEvent[]
        push!(new_timed_events,TimedEvent(RecurArrivals(i),time + 1/net.α_vector[i]))
        push!(new_timed_events,TimedEvent(ArrivalEvent(i),time))
        return new_timed_events
    end

    #handles the arrival of a customer from another queue
    function process_event(time::Float64, state::State, ev::ArrivalEvent)
        i=ev.queue
        state.number_in_queues[i] += 1
        new_timed_events = TimedEvent[]

        state.number_in_queues[i] == 1 && push!(new_timed_events,TimedEvent(EndOfServiceEvent(i), time + rand(rate_scv_gamma(net.μ_vector[i],net.c_s))))

        return new_timed_events
    end
    
    # Process an end of service event 
    function process_event(time::Float64, state::State, ev::EndOfServiceEvent)
        i=ev.queue

        state.number_in_queues[i] -= 1

        @assert state.number_in_queues[i] ≥ 0


        new_timed_events = TimedEvent[]

        #Creating a weighted array of next queue probabilities including leaving 
        
        sprawl=net.P[i,:]
        push!(sprawl,1-sum(sprawl))

        #picks a result 

        next=sample(1:net.L+1,Weights(sprawl))

        if next<=net.L
            push!(new_timed_events,TimedEvent(ArrivalEvent(next), time))
        end

        #checks if there is a new customer in the next queue
        if state.number_in_queues[i] ≥ 1
            push!(new_timed_events, TimedEvent(EndOfServiceEvent(i), time + rand(rate_scv_gamma(net.μ_vector[i],net.c_s)))) 
        end
        return new_timed_events
    
    end

    simulate(QueueState(zeros(net.L)), TimedEvent(NewArrivals(),0.0),max_time=float(max_time), callback=record)


    #create_anim(times,states)

    TSSMQL = sum(sum(states)./length(states))
    if Test2==1
        output=priority
    else
        output=TSSMQL
    end 
    return output
end;

function create_anim(times,states)
    anim = Animation()
    n=length(times)
    for i in 1:n
        plot(states[i],line = :stem, lw = 10, 
            label=false, ylim = (0,50), title="Time = $(round(times[i],digits=2))",
         xlabel = "Queue index", ylabel="Number in queue")
        frame(anim)
    end
    gif(anim, "graph.gif", fps = 20)
    return nothing
end