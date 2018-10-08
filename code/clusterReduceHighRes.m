%% set path and preparation
jadd_path;

<<<<<<< HEAD
disp(['Loading saved workspace from ' outputPath 'session_high.mat...']);
load([outputPath 'session_high.mat']);
=======
disp('Loading saved workspace...');
load(fullfile(outputPath, 'session_high.mat'));
>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62
disp('Loaded!');

jadd_path;

ds.msc.output_dir   = outputPath;
ds.msc.mesh_aligned_dir = [outputPath 'aligned/'];
pa.pfj        = [ds.msc.output_dir 'jobs/high/'];

pa = reduce( ds, pa, n_jobs );

%% Globalization
<<<<<<< HEAD
% try using name mst?
mst     = graphminspantree(sparse(pa.d + pa.d'));
ga     = globalize(pa, mst, 1, type);
ga.k   = k; %%% here k=2 (set in clusterMapHighRes.m)
=======
% mst is the same as before
ga     = globalize( pa, mst , ds.base );
ga.k   = k;
>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62

%% Output higher resolution
write_obj_aligned_shapes(ds, ga);
write_off_global_alignment( fullfile(ds.msc.output_dir, 'alignment_high.off'), ds , ga, 1:ds.n, 10, [cos(theta) -sin(theta) 0 ; sin(theta) cos(theta) 0; 0 0 1]*[ 0 0 1; 0 -1 0; 1 0 0]*ds.shape{1}.U_X{k}',3.0,1);
write_morphologika( fullfile(ds.msc.output_dir, 'morphologika_unscaled_high.txt'), ds, ga );

<<<<<<< HEAD
=======
disp('Saving current workspace....');
system(['rm -rf ' fullfile(outputPath, 'session_high.mat')]);
save(fullfile(outputPath, 'session_high.mat'), '-v7.3');
disp('Saved!');

>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62
%% Compute all pairwise Procrustes distances
proc_d     = zeros( ds.n , ds.n );
for ii = 1 : ds.n
    for jj = ii : ds.n
        if( ii == jj )
            continue;
        end
        [tmpR, proc_d( ii, jj)] = jprocrustes( ds.shape{ii}.X{k}*ga.P{ii} , ds.shape{jj}.X{k}*ga.P{jj} );
    end
end
mst_proc_d = graphminspantree( sparse( proc_d + proc_d' ) );
proc_d = (proc_d+proc_d')/2;
<<<<<<< HEAD
save([outputPath 'GPDMat_high.mat'], 'proc_d');
% plot_tree( proc_d+proc_d' , mst_proc_d , ds.names , 'mds', ones(1,ds.n) , 'MDS procrustes distances' );

%% Update final GPD on cluster
pa_tmp = localize(ga);
pa.R = pa_tmp.R;

k         = 2; % Which level to run next
pa.A      = upper_triangle( ds.n );
pa.pfj    = [ds.msc.output_dir 'jobs/post/']; % 'pfj' stands for path for jobs
tmpR  = pa.R;
tmpP  = pa.P;
f = @(ii, jj) loclinassign(ds.shape{ii}.X{k}, ds.shape{jj}.X{k}, pa.R{ii,jj}, ones(ds.N(k)));

% Remember to remove all previous jobs in the output/jobs folder!
% system(['rm -rf ' pa.pfj '/*']);
touch(pa.pfj);
pa = compute_alignment(pa, f, n_jobs, use_cluster);

disp(['Saving current workspace at ' outputPath 'session_high.mat....']);
system(['rm -rf ' outputPath 'session_high.mat']);
save([outputPath 'session_high.mat'], '-v7.3');
disp('Saved!');
=======

if ds.n > 2
	plot_tree( proc_d , mst_proc_d , ds.names , 'mds', ones(1,ds.n) , 'MDS procrustes distances' );
	coords = mdscale(proc_d,3)';
	if size(coords,1) == 3
		write_off_placed_shapes( fullfile(ds.msc.output_dir,'map.off'), coords, ds, ga, eye(3), mst_proc_d);
	end
end

%% Optional outputting of procrustes distance matrix of rotated meshes
if do_procrustes_dist_output == 1
	names = matlab.lang.makeValidName(ds.names, 'ReplacementStyle', 'hex');
	d_table = array2table(proc_d, 'RowNames', names, 'VariableNames', names);
	writetable(d_table, fullfile(ds.msc.output_dir, 'proc_d.csv'));
end

%% Optional principal components analysis of partial procrustes tangent coordinates
if do_tangent_pca == 1
	tangent_pca(ds, ga, k);
end
>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62

disp('High-Resolution Alignment Completed');
