using Distributed

@everywhere variablename = "allloghycos"
@everywhere datafilename = "$(results_dir)/trainingdata.jld2"
if !isfile(datafilename)
	if nworkers() == 1
		error("Please run in parallel: julia -p 32")
	end
	numsamples = 10
	@time allloghycos = SharedArrays.SharedArray{Float32}(numsamples, ns[2], ns[1]; init=A->samplehyco!(A; setseed=true))
	
	@time @JLD2.save datafilename allloghycos
end