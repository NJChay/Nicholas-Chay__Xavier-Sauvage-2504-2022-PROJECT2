p_star=0.1:0.01:0.9
p_nets1,p_nets2,p_nets3,p_nets4=[],[],[],[]

[push!(p_nets1,set_scenario(scenario1,p)) for p in p_star]

[push!(p_nets2,set_scenario(scenario2,p)) for p in p_star]

[push!(p_nets3,set_scenario(scenario3,p)) for p in p_star]

[push!(p_nets4,set_scenario(scenario4,p)) for p in p_star]


TSSMQL1=[]
[push!(TSSMQL1,sim_net(net)) for net in p_nets1]

TSSMQL2=[]
[push!(TSSMQL2,sim_net(net)) for net in p_nets2]


TSSMQL3=[]
[push!(TSSMQL3,sim_net(net)) for net in p_nets3]


TSSMQL4=[]
[push!(TSSMQL4,sim_net(net)) for net in p_nets4]



pl1 = plot(p_star, TSSMQL1, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 1 Sim",
        label = false, lw = 2, c = :black)
    
pl2 = plot(p_star, TSSMQL2, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 2 Sim",
        label = false, lw = 2, c = :black)

pl3 = plot(p_star, TSSMQL3, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 3 Sim",
        label = false, lw = 2, c = :black)

pl4 = plot(p_star, TSSMQL4, 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 4 Sim",
        label = false, lw = 2, c = :black)
    
    
plot(pl1,pl2,pl3,pl4) 
