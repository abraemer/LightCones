### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 2b39b6c0-4255-4008-8413-bda1ea656650
begin
	import Pkg
	Pkg.add(url="https://github.com/mkm2/LightCones.git")
	using LightCones
end

# ╔═╡ 313705be-481a-11ed-17bb-f130b983a175
using LinearAlgebra,Plots,JLD2,Statistics,PlutoUI

# ╔═╡ 89e38344-a7c8-4581-ab5e-2e031d1b05a2
TableOfContents()

# ╔═╡ 01b54b4d-47dc-4a57-9490-b691de6fd997
begin
		function disorder_mean(A::Array{Float64,4},n_shots)
			return mean(A[:,:,1:n_shots,:];dims=3)[:,:,1,:]
		end
		
		function disorder_std(A::Array{Float64,4},n_shots)
			return std(A[:,:,1:n_shots,:];dims=3)[:,:,1,:]
		end

		function disorder_mean(A::Array{Float64,3},n_shots)
			return mean(A[:,:,1:n_shots];dims=3)[:,:,1]
		end
		
		function disorder_std(A::Array{Float64,3},n_shots)
			return std(A[:,:,1:n_shots];dims=3)[:,:,1]
		end

		function state_mean(A::Array{Float64,4},n_states)
			return mean(A[:,:,:,1:n_states];dims=4)[:,:,:,1]
		end

		function state_std(A::Array{Float64,4},n_states)
			return std(A[:,:,:,1:n_states];dims=4)[:,:,:,1]
		end

		function state_mean(A::Array{Float64,3},n_states)
			return mean(A[:,:,1:n_states];dims=3)[:,:,1]
		end

		function state_std(A::Array{Float64,3},n_states)
			return std(A[:,:,1:n_states];dims=3)[:,:,1]
		end
	
		#function pos_mean(A)
		#	return mean(A;dims=2)[:,1]
		#end
		
		#function reduce_by_last(A)
			#return A[:,:,1]
		#end
end

# ╔═╡ 264929c4-375e-4146-a61c-9ce0782433d9
begin
	N = 13
	path = pwd() *"/test/"
	shots = 50
	states = 50
	trange = 0:0.1:5
	T = length(trange)
end

# ╔═╡ 9c6e9d29-8041-494a-b30b-ff042cad3fe5
md"# No disorder h=0"

# ╔═╡ da94efac-baa7-4b7f-a049-554b026da248
begin
	f_df = "7273734_N13_BS.jld2"
	f_sf = "7273738_N13_BS.jld2"
	f_m = "7273742_N13_BS.jld2"
	
	jobids_df = load(path*f_df,"jobid")
	params_df = load(path*f_df,"params")
	data_df = 2*ones(T,N,shots,states)-2*load(path*f_df,"data")

	jobids_sf = load(path*f_sf,"jobid")
	params_sf = load(path*f_sf,"params")
	data_sf = 2*ones(T,N,shots,states)-2*load(path*f_sf,"data")

	jobids_m = load(path*f_m,"jobid")
	params_m = load(path*f_m,"params")
	data_m = 2*ones(T,N,shots*states)-2*load(path*f_m,"data")

	size(data_m)
end

# ╔═╡ 69a6f50b-fb91-4e66-b2e4-8cc8c59accc1
std(data_m[:,:,1];dims=3)

# ╔═╡ 4e5a645a-f930-4179-898a-7861584e5bb2
n_m = 2500

# ╔═╡ 2291487f-b9a7-4d05-9cf8-ab326e285d68
state_mean(disorder_mean(data_sf,50),50)

# ╔═╡ 162feefd-1c8b-4d21-bf80-f662b47a319f
begin
	#df_mean =  
	sf_mean = state_mean(disorder_mean(data_sf,shots),states)
	m_mean = disorder_mean(data_m,shots*states)

	sf_std = Vector{Matrix{Float64}}(undef,states)
	m_std = Vector{Matrix{Float64}}(undef,shots)

	for i in 1:states
		sf_std[i] = state_std(disorder_mean(data_sf,shots),i)/sqrt(50*i)
	end
	for i in 1:shots
		m_std[i] = disorder_std(data_m,50*i)/sqrt(50*i)
	end
end

# ╔═╡ 081ef8da-667a-4fc6-95be-1f0e2fb51412
plot(trange,sf_mean,ribbon=sf_std[2])

# ╔═╡ 2e714e7b-b376-4833-bda0-f914787c0511
plot(trange,m_mean,ribbon=m_std[1])

# ╔═╡ c309b799-b9da-4b1c-90e7-b99ec5b0d516
disorder_mean(data_sf,3)

# ╔═╡ b6b888c7-b46f-49d0-8115-e755ec272027


# ╔═╡ 0c32ce58-58b4-4c29-b9d8-8de92849cea0
plot(mean(disorder_std(data_m,n_m);dims=1))

# ╔═╡ aa5f26ed-c2f7-4191-8260-0865d5d610a0
mean(disorder_std(data_m,n_m);dims=2)

# ╔═╡ cc9e8551-6291-41fb-b0dd-36f4c2f2849d
md"# Weak disorder h=4"

# ╔═╡ 4357fec9-fec3-428e-99d4-210bf6150695


# ╔═╡ d407860a-5fc0-4928-bbb9-a86f79e29e86


# ╔═╡ d9c874bf-37b5-4a5d-b1f0-880016ee7302
md"# Strong disorder h=12"

# ╔═╡ 9e78403a-600f-48f0-bfd7-82c3893fd63b


# ╔═╡ ff2f277f-2d0e-448a-979d-4050b35a0983


# ╔═╡ Cell order:
# ╠═313705be-481a-11ed-17bb-f130b983a175
# ╠═2b39b6c0-4255-4008-8413-bda1ea656650
# ╠═89e38344-a7c8-4581-ab5e-2e031d1b05a2
# ╠═01b54b4d-47dc-4a57-9490-b691de6fd997
# ╠═264929c4-375e-4146-a61c-9ce0782433d9
# ╠═9c6e9d29-8041-494a-b30b-ff042cad3fe5
# ╠═69a6f50b-fb91-4e66-b2e4-8cc8c59accc1
# ╠═da94efac-baa7-4b7f-a049-554b026da248
# ╠═4e5a645a-f930-4179-898a-7861584e5bb2
# ╠═2291487f-b9a7-4d05-9cf8-ab326e285d68
# ╠═162feefd-1c8b-4d21-bf80-f662b47a319f
# ╠═081ef8da-667a-4fc6-95be-1f0e2fb51412
# ╠═2e714e7b-b376-4833-bda0-f914787c0511
# ╠═c309b799-b9da-4b1c-90e7-b99ec5b0d516
# ╠═b6b888c7-b46f-49d0-8115-e755ec272027
# ╠═0c32ce58-58b4-4c29-b9d8-8de92849cea0
# ╠═aa5f26ed-c2f7-4191-8260-0865d5d610a0
# ╠═cc9e8551-6291-41fb-b0dd-36f4c2f2849d
# ╠═4357fec9-fec3-428e-99d4-210bf6150695
# ╠═d407860a-5fc0-4928-bbb9-a86f79e29e86
# ╠═d9c874bf-37b5-4a5d-b1f0-880016ee7302
# ╠═9e78403a-600f-48f0-bfd7-82c3893fd63b
# ╠═ff2f277f-2d0e-448a-979d-4050b35a0983
