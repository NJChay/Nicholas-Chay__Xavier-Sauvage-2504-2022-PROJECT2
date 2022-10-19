

println("\nTesting Arrival Rates of different c values\n")

function sim_arrivals(scenario)
    total_events = sim_net(scenario,max_time=10^4,Test2=1)
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

println("c = 0.1")
println("Theory:")
println((I - scenario1.P') \ scenario1.α_vector)
println("Sim:")
c1=@set scenario1.c_s = 0.1
println(sim_arrivals(c1))

println("\nc = 0.5")

c2=@set scenario1.c_s = 0.5
println(sim_arrivals(c2))

println("\nc = 2")
c3=@set scenario1.c_s = 2.0
println(sim_arrivals(c3))

println("\nc = 5")
c4=@set scenario1.c_s = 5.0
println(sim_arrivals(c4))