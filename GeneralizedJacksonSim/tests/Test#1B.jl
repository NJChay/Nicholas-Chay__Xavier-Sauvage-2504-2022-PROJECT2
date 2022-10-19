include("c:\\Users\\User\\OneDrive\\MATH2504\\Proj2\\Nicholas-Chay__Xavier-Sauvage-2504-2022-PROJECT2\\GeneralizedJacksonSim\\src\\Task2.jl")

using Plots

p_star=0.1:0.01:0.9
p_nets1=[]

[push!(p_nets1,set_scenario(scenario1,p)) for p in p_star]




#100 time
TSSMQL1_100=[]
[push!(TSSMQL1_100,sim_net(net,max_time=10^2,warm_up_time=10)) for net in p_nets1]

ARE1_100=abs.((TSSMQL1_100.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))



ep1 = plot(p_star, ARE1_100, 
        xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^2",
        label = false, lw = 2, c = :black)



#1000 time
ARE1_1000=abs.((TSSMQL1.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ep2 = plot(p_star, ARE1_1000, 
        xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^3",
        label = false, lw = 2, c = :black)

#10000 time
TSSMQL1_10000=[]
[push!(TSSMQL1_10000,sim_net(net,max_time=10^4,warm_up_time=10^3)) for net in p_nets1]

ARE1_10000=abs.((TSSMQL1_10000.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ep3 = plot(p_star, ARE1_10000, 
xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^4",
label = false, lw = 2, c = :black)

#100000 time
TSSMQL1_105=[]
[push!(TSSMQL1_105,sim_net(net,max_time=10^5,warm_up_time=10^4)) for net in p_nets1]

ARE1_105=abs.((TSSMQL1_105.-TSSMQL.(qs[1]))./TSSMQL.(qs[1]))

ep4 = plot(p_star, ARE1_105, 
xlabel = "ρ*", ylabel = "Error", title="Scenario 1 10^5",
label = false, lw = 2, c = :black)

plot(ep1,ep2,ep3,ep4)