using Distributions, Statistics

"""
A convenience function to make a Gamma distribution with desired rate (inverse of shape) and SCV.
"""
rate_scv_gamma(desired_rate::Float64, desired_scv::Float64) = Gamma(1/desired_scv, desired_scv/desired_rate)

μ = 7.4
c_s = 4.0
dist = rate_scv_gamma(μ, c_s)

