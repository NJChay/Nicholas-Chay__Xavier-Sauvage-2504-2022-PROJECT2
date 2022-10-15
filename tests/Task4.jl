

p_star=0.1:0.01:0.9
p_nets1,p_nets2,p_nets3,p_nets4,p_nets5=[],[],[],[],[]

[push!(p_nets1,set_scenario(scenario1,p,0.1)) for p in p_star]

[push!(p_nets2,set_scenario(scenario1,p,0.5)) for p in p_star]

[push!(p_nets3,set_scenario(scenario1,p)) for p in p_star]

[push!(p_nets4,set_scenario(scenario1,p,2.0)) for p in p_star]

[push!(p_nets5,set_scenario(scenario1,p,5.0)) for p in p_star]


TSSMQL1=[]
[push!(TSSMQL1,sim_net(net,max_time=10^3,warm_up_time=10^2)) for net in p_nets1]

TSSMQL2=[]
[push!(TSSMQL2,sim_net(net)) for net in p_nets2]

TSSMQL3=[]
[push!(TSSMQL3,sim_net(net)) for net in p_nets3]

TSSMQL4=[]
[push!(TSSMQL4,sim_net(net)) for net in p_nets4]

TSSMQL5=[]
[push!(TSSMQL5,sim_net(net)) for net in p_nets5]

p1 = plot(p_star, [TSSMQL1,TSSMQL2,TSSMQL3,TSSMQL4,TSSMQL5], 
        xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario 1"
        , lw = 2,label = ["0.1" "0.5" "1.0" "2.0" "5.0"])

