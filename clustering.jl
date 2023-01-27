# Classify elements using DSB ------------------------------------------------
using Clustering
points = randn(2, 1000);
points[:,1:500] = randn(2,500); points[:,501:1000]=randn(2,500)+3.0*ones(2,500)
# DBSCAN clustering, clusters with less than 20 points will be discarded:
clusters = dbscan(points, 1.0, min_neighbors = 100   , min_cluster_size = 20)

plot(points[1,:],points[2,:],lt=:scatter)
plot!(points[1,clusters[1].core_indices],points[2,clusters[1].core_indices],lt=:scatter)
plot!(points[1,clusters[2].core_indices],points[2,clusters[2].core_indices],lt=:scatter)
# -----------------------------------------------------------------------------


# Classify segments using kmeans
using Clustering
km = kmeans(f_tfhm,2,tol=1e-50)
ikm = assignments(km)
ckm = km.centers;
plot(f_tfhm[:,:],c=ikm[:]',lw=0.5,legend=false,ylim=(5e-18,5e-15),alpha=0.2)
plot!(ckm[:,:],c=[1 2],lw=3)

# T-test between the two groups
m=size(f_tfhm,1);
pvals=zeros(m)
for j in 1:m
    pvals[j]=pvalue( UnequalVarianceTTest(f_tfhm[j,findall(ikm.==1)] , f_tfhm[j,findall(ikm.==2)]) );
end
plot(pvals.<1e-3,lt=:bar)

t,chdat=read_channel(id,dt,900,fl);
writedlm("../4_outputs/ch"*string(id)*".dat",[t chdat]," ");
writedlm("../4_outputs/ch"*string(id)*"_tfhm.dat",tfhm," ");
writedlm("../4_outputs/ch"*string(id)*"_tfhm.dat",tfhm," ");
writedlm("../4_outputs/km_ch"*string(id)*"_tfhm_k1.dat",f_tfhm[:,findall(ikm.==1)]);
writedlm("../4_outputs/km_ch"*string(id)*"_tfhm_k2.dat",f_tfhm[:,findall(ikm.==2)]);
writedlm("../4_outputs/km_ch"*string(id)*"_idx.dat",[t[f_idx] ikm]);
writedlm("../4_outputs/km_ch"*string(id)*"_centers.dat",ckm);
writedlm("../4_outputs/km_ch"*string(id)*"_pvals.dat",pvals);

# Silhouette validation of k-means
# using LinearAlgebra
# s=size(f_tfhm,2)
# dists=zeros(s,s);
# for i in 1:s
#     for j in 1:s
#         dists[i,j]=norm(f_tfhm[:,j]-f_tfhm[:,i]);
#     end
# end
# sil=silhouettes(km,dists)
# mean(sil)
#
