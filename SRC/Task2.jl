using Plots

p_star_grid =0.1:0.01:0.9

qs=[[set_scenario(s,p,1.0) for p in p_star_grid] for s in [scenario1,scenario2,scenario3,scenario4]]

function TSSMQL(net::NetworkParameters)
    λ_base = (I - net.P') \ net.α_vector #Solve the traffic equations
    ρ_base = λ_base ./ net.μ_vector #Determine the load ρ  
    return sum(ρ_base ./ (1 .-ρ_base)) 
end


tp1 = plot(p_star_grid, TSSMQL.(qs[1]), 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 1",
        label = false, lw = 2, c = :black)#, xlim = (0,1),ylim=(0,20))

tp2 = plot(p_star_grid, TSSMQL.(qs[2]), 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 2",
        label = false, lw = 2, c = :black)#, xlim = (0,1),ylim=(0,20))

tp3 = plot(p_star_grid, TSSMQL.(qs[3]), 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 3",
        label = false, lw = 2, c = :black)#, xlim = (0,1),ylim=(0,20))

tp4 = plot(p_star_grid, TSSMQL.(qs[4]), 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 4",
        label = false, lw = 2, c = :black)#, xlim = (0,1),ylim=(0,20))

plot(tp1,tp2,tp3,tp4)