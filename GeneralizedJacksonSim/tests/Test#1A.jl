using Plots

p_star=0.1:0.01:0.9
p_nets1,p_nets2,p_nets3,p_nets4=[],[],[],[]

[push!(p_nets1,set_scenario(scenario1,p)) for p in p_star]

[push!(p_nets2,set_scenario(scenario2,p)) for p in p_star]

[push!(p_nets3,set_scenario(scenario3,p)) for p in p_star]

[push!(p_nets4,set_scenario(scenario4,p)) for p in p_star]


TSSMQL1=[]
[push!(TSSMQL1,sim_net(net,max_time=10^3,warm_up_time=10^2)) for net in p_nets1]

TSSMQL2=[]
[push!(TSSMQL2,sim_net(net,max_time=10^3,warm_up_time=10^2)) for net in p_nets2]

TSSMQL3=[]
[push!(TSSMQL3,sim_net(net,max_time=10^3,warm_up_time=10^2)) for net in p_nets3]

TSSMQL4=[]
[push!(TSSMQL4,sim_net(net,max_time=10^3,warm_up_time=10^2)) for net in p_nets4]


ARE1=abs.((TSSMQL1.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ARE2=abs.((TSSMQL2.-TSSMQL.(qs[2]))./TSSMQL.(qs[2]))

ARE3=abs.((TSSMQL3.-TSSMQL.(qs[3]))./TSSMQL.(qs[3]))

ARE4=abs.((TSSMQL4.-TSSMQL.(qs[4]))./TSSMQL.(qs[4]))


e1 = plot(p_star, ARE1, 
        xlabel = "ρ*", ylabel = "Error", title="Scenario 1 Error",
        label = false, lw = 2, c = :black)


e2 = plot(p_star, ARE2, 
                xlabel = "ρ*", ylabel = "Error", title="Scenario 2 Error",
                label = false, lw = 2, c = :black)
            


e3 = plot(p_star, ARE3, 
                xlabel = "ρ*", ylabel = "Error", title="Scenario 3 Error",
                label = false, lw = 2, c = :black)

    

e4 = plot(p_star, ARE4, 
                xlabel = "ρ*", ylabel = "Error", title="Scenario 4 Error",
                label = false, lw = 2, c = :black)

plot(e1,e2,e3,e4)
