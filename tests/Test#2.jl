
function sim_arrivals(scenario)
    total_events = sim_net(scenario)
    arrivals=[]

    for ev in total_events
        if typeof(ev)==ArrivalEvent
        push!(arrivals,ev) 
        end
    end

    by_queue=zeros(scenario.L)

    for i in arrivals 
        by_queue[i.queue]=by_queue[i.queue]+1
    end

return by_queue./10^4
end

println("scenario1")
println("Theory:")
println((I - scenario1.P') \ scenario1.α_vector)
println("Sim:")
println(sim_arrivals(scenario1))

println("\nscenario2")
println("Theory:")
println((I - scenario2.P') \ scenario2.α_vector)
println("Sim:")
println(sim_arrivals(scenario2))

println("\nscenario3")
println("Theory:")
println((I - scenario3.P') \ scenario3.α_vector)
println("Sim:")
println(sim_arrivals(scenario3))

println("\nscenario4")
println("Theory:")
println((I - scenario4.P') \ scenario4.α_vector)
println("Sim:")
println(sim_arrivals(scenario4))