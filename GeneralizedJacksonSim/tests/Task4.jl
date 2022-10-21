
using LinearAlgebra


#~5 mins

seeds=[40,41,42,43,44]

#resorts a vecter of vectors for each position 
function resort(vec)::Vector{Vector{Number}}
        resorted=[]
        for i in 1:length(vec[1])
                new=[]
                for v in vec 
                        push!(new,v[i])
                end
                push!(resorted,new)
        end
        return resorted
end
        
        

function multiplot(scenario,num,seed_list)
        p_star=0.1:0.01:0.9
        p_nets1,p_nets2,p_nets3,p_nets4,p_nets5=[],[],[],[],[]

        [push!(p_nets1,set_scenario(scenario,p,0.1)) for p in p_star]

        [push!(p_nets2,set_scenario(scenario,p,0.5)) for p in p_star]

        [push!(p_nets3,set_scenario(scenario,p)) for p in p_star]

        [push!(p_nets4,set_scenario(scenario,p,2.0)) for p in p_star]

        [push!(p_nets5,set_scenario(scenario,p,5.0)) for p in p_star]


        total_lines=[]
        TSSMQL1,TSSMQL2,TSSMQL3,TSSMQL4,TSSMQL5=[],[],[],[],[]

        #creates a confidence inteval for each value of c 

        for total in zip([TSSMQL1,TSSMQL2,TSSMQL3,TSSMQL4,TSSMQL5],[p_nets1,p_nets2,p_nets3,p_nets4,p_nets5])
                for sseed in seed_list
                        v1=[]
                        [push!(v1,sim_net(net,seed=sseed)) for net in total[2]]
                        push!(total[1],v1)

                        
                end
                resorted=resort(total[1])
                        means=mean.(resorted)
                        sd=std.(resorted)
                        cf=[means.+sd,means,means.-sd]

                push!(total_lines,cf)
                        
        end

        #plots each set of three lines

         p = plot(p_star, total_lines[1], 
               xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario $num "
             , lw = 2,legend=:topleft, label = "0.1",legendfont=font(6),color=:gold)

             plot!(p_star, total_lines[2], 
             xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario $num "
           , lw = 2,legend=:topleft, label = "0.5" ,colour=:red)

           plot!(p_star, total_lines[3], 
           xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario $num "
         , lw = 2,legend=:topleft, label = "1.0" ,colour=:purple)

           plot!(p_star, total_lines[4], 
            xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario $num "
          , lw = 2,legend=:topleft, label = "2.0",colour=:green)

         plot!(p_star, total_lines[5], 
         xlabel = "ρ*", ylabel = "TSSMQL", title="Scenario $num "
         , lw = 2,legend=:topleft, label = "5.0",colour=:blue)



return p
end

p1=multiplot(scenario1,1,seeds)
p2=multiplot(scenario2,2,seeds)
p3=multiplot(scenario3,3,seeds)
p4=multiplot(scenario4,4,seeds[1:2])#trials reduced as scenario4 is very time expensive
plot(p1,p2,p3,p4)