%% set path and preparation
jadd_path;

<<<<<<< HEAD
disp(['Loading saved workspace from ' outputPath 'session_low.mat...']);
load([outputPath 'session_low.mat']);
=======
disp('Loading saved workspace...');
load(fullfile(outputPath, 'session_low.mat'));
>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62
disp('Loaded!');

jadd_path;

ds.msc.output_dir = outputPath;
ds.msc.mesh_aligned_dir = [outputPath 'aligned/'];

%% Compute the edges in the MST with higher number of points
pa_tmp = localize(ga);
pa.R = pa_tmp.R;

k         = 2; % Which level to run next
pa.A      = upper_triangle( ds.n );
pa.pfj    = fullfile(ds.msc.output_dir, 'jobs', 'high', filesep); % 'pfj' stands for path for jobs
tmpR  = pa.R;
tmpP  = pa.P;
f = @(ii, jj) locgpd(ds.shape{ii}.X{k}, ds.shape{jj}.X{k}, pa.R{ii,jj}, ones(ds.N(k)), pa.max_iter);

% Remember to remove all previous jobs in the output/jobs folder!
% system(['rm -rf ' pa.pfj '/*']);
touch(pa.pfj);
pa = compute_alignment(pa, f, n_jobs, use_cluster);

<<<<<<< HEAD
disp(['Saving current workspace at ' outputPath 'session_high.mat...']);
save([outputPath 'session_high.mat'], '-v7.3');
=======
disp('Saving current workspace...');
save(fullfile(outputPath, 'session_high.mat'), '-v7.3');
>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62
disp('Saved!');
