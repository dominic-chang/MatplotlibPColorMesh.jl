module MatplotlibPColorMesh
#export pcolormesh

# Write your package code here.
using Makie
using GeometryBasics

Makie.@recipe(PcolorMesh) do scene
	Attributes(
		pcolormap = :afmhot,
	)
end

function Makie.plot!(pcm::PcolorMesh{<:NTuple{3, AbstractMatrix{<:Real}}})
	X2d = pcm[1]
	Y2d = pcm[2]
	emission_data = pcm[3]

	# DefineMakie.Observables
	data = Makie.Observable(NTuple{2, Float32}[])
	msh = Makie.Observable{GeometryBasics.Mesh}()
	intvals = Makie.Observable(Float32[])

	# Helper function to update observables
	function update_plot(X2d, Y2d, emission_data)
		empty!(intvals[])
		empty!(data[])

		(h, w) = size(X2d)

		#z = vcat(hcat(emission_data, zeros(h - 1)), zeros(w)')
		z = emission_data

		for (xv, yv, intval) in zip(vec(X2d), vec(Y2d), vec(z))
			push!(intvals[], Float32(intval))
			push!(data[], (Float32(xv), Float32(yv)))
		end

		faces = decompose(QuadFace{GLIndex}, Tesselation(Rect(0, 0, 1, 1), size(X2d)))
		msh[] = GeometryBasics.Mesh(GeometryBasics.Point2f.(data[]), faces)

	end

	Makie.Observables.onany(update_plot, X2d, Y2d, emission_data)

	update_plot(X2d[], Y2d[], emission_data[])

	mesh!(pcm, msh, color = intvals, interpolate=true)#, colormap=pcm.colormap);

	pcm
end

#using PyCall
#np = pyimport("numpy")
#X2d, Y2d, emission_data = collect.(PyArray.(np.load((@__DIR__) * "/Sa+0.94_160.npy", allow_pickle = true)))
#pcolormesh(X2d, Y2d, emission_data)

end