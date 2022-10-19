"""
Compute the maximal value by which we can scale the α_vector and be stable.
"""
function maximal_alpha_scaling(net::NetworkParameters)
    λ_base = (I - net.P') \ net.α_vector #Solve the traffic equations
    ρ_base = λ_base ./ net.μ_vector #Determine the load ρ  
    return minimum(1 ./ ρ_base) #Return the maximal value by 
end

max_scalings = round.(maximal_alpha_scaling.([scenario1, scenario2, scenario3, scenario4]),digits=3)

"""
Use this function to adjust the network parameters to the desired ρ⋆ and c_s
"""
function set_scenario(net::NetworkParameters, ρ::Float64, c_s::Float64 = 1.0)
    (ρ ≤ 0 || ρ ≥ 1) && error("ρ is out of range")  
    max_scaling = maximal_alpha_scaling(net)
    net = @set net.α_vector = net.α_vector*max_scaling*ρ
    net = @set net.c_s = c_s
    return net
end;

#Adjust scenario 4 for a desired ρ and c_s, adjusted_net is the adjusted network
adjusted_net = set_scenario(scenario4, 0.7, 2.4)

#We can check by solving the traffic equations
λ = (I - adjusted_net.P') \ adjusted_net.α_vector #Solve the traffic equations
ρ = λ ./ adjusted_net.μ_vector #This is the vector of ρ values
ρ_star= maximum(ρ) #\star + [TAB]

