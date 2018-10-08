<<<<<<< HEAD
# Puente Alignment
Orignally written for the MST-based Generalized Dataset Procrustes Distance by Jesús Puente; this current version contains experimental features involving two synchronization-based alignment algorithms (spectral/SDP relaxation).

MATLAB Code originally written by Jesús Puente (jparrubarrena@gmail.com); currently maintained by Tingran Gao (trgao10@math.duke.edu) and Julie Winchester (julia.m.winchester@gmail.com). This code has also been ported to R by Christopher Glynn (glynn@stat.duke.edu) under the name [*auto3dgm*](https://stat.duke.edu/~sayan/auto3dgm/).
=======
# auto3dgm-matlab-gorgon
MST-based Generalized Dataset Procrustes Distance by Jesús Puente

MATLAB Code originally written by Jesús Puente (jparrubarrena@gmail.com); forks of this code include [PuenteAlignment](https://github.com/trgao10/PuenteAlignment), maintained by Tingran Gao (trgao10@math.duke.edu), and [auto3dgm-matlab-gorgon](https://github.com/JuliaWinchester/auto3dgm-matlab-gorgon), maintained by Julie Winchester (julia.m.winchester@gmail.com). This code has also been ported to R by Christopher Glynn (glynn@stat.duke.edu) under the name [*auto3dgm*](https://stat.duke.edu/~sayan/auto3dgm/).
>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62

auto3dgm-matlab-gorgon is a fork of auto3dgm with a focus on providing improved user experience and additional functionality both upstream and downstream frmo the core workflow. The latest commits can be found in the [dev](https://github.com/JuliaWinchester/auto3dgm-matlab-gorgon/tree/dev) branch, but users are encouraged to clone the [master](https://github.com/JuliaWinchester/auto3dgm-matlab-gorgon) branch as it contains stable milestone releases. PuenteAlignment and auto3dgm-matlab-gorgon both have the same core MST-based alignment functionality. Auto3dgm-matlab-gorgon does not currently include the two spectral relaxation alignment algorithms included in the current PuenteAlignment version. Auto3dgm-matlab-gorgon does implement two new features currently: user control over how overall mesh alignment is handled after all sample meshes are aligned to each other, and principal components analysis of partial procrustes tangent shape coordinates. These new features are described below. This branch also has a number of smaller user experience improvements, such as support for OSX local analyses or more flexible directory formatting in jadd_path.m.

#### Overall mesh alignment

Users can control the overall alignment of surface meshes (after meshes are aligned to each other) by setting the 'align_to' field in jadd_path.m. If this value is set to the name of a surface mesh file in the current analysis, then all meshes will be aligned to that mesh's orientation in 3D coordinate space. If 'align_to' is set to 'auto' or blank (''), auto3dgm will attempt to derive a semi-standardized overall alignment for all meshes. Principal axes of shape variation are derived for all sample vertex point clouds concatenated, and each mesh is rotated so that first, second, and third principal axes of shape variation correspond to Y, X, and Z coordinate axes respectively.

#### PCA of partial procrustes tangent shape coordinates

If the 'do_tangent_pca' field in jadd_path.m is set to 1, then auto3dgm carries out a principal components analysis of partial procrustes tangent shape coordinates.  The method used for the tangent space projection is that of Dryden and Mardia's (1993, 1998, 2016) paper and textbook for unit-scaled shape data, but using the calculations from Rohlf's (1999) description of 'Kendall tangent space coordinates'. Several files are saved with PCA results, including a basic scatter plot of PC1 and PC2, PC scores per individual, eigenvalues and percent variance explained per PC, and eigenvectors per PC.

-----------
## Using auto3dgm-matlab-gorgon

The current version of auto3dgm-matlab-gorgon supports standard sequential execution on any matlab installation or parallel computation on a cluster managed by Sun Grid Engine (SGE). Follow the instructions below for installation and usage of this software.

1. Get the current version of auto3dgm-matlab-gorgon. Either download the repository files directly to the desired path, or if `git` is installed simply `cd` into your desired path, then type

        git clone https://github.com/JuliaWinchester/auto3dgm-matlab-gorgon.git
        
<<<<<<< HEAD
2. Find script `jadd_path.m` in the folder *PuenteAlignment/code/*, and set paths and parameters there. If you assign an email address to the varialbe `email_notification`, a notification will be sent automatically to that email address whenever a cluster job completes or aborts.
3. Launch `MATLAB`, `cd` into the folder *PuenteAlignment/code/*, type in `clusterPreprocess` and press `ENTER`. All jobs should then be submitted to the cluster. Use `qstat` to monitor job status.
4. After all jobs are completed, type in `clusterMapLowRes` and press `ENTER`.
5. After all jobs are completed, type in `clusterReduceLowRes` and press `ENTER`. This generates low-resolution alignment results in the `output` folder you specified in `jadd_path.m`.
6. Type in `clusterMapHighRes` and press `ENTER` to submit high-resolution alignment jobs to the cluster. Use `qstat` to monitor job status.
7. After all jobs are completed, type in `clusterReduceHighRes` and press `ENTER`. This generates high-resolution alignment results in the `output` folder you specified in ```jadd_path.m```.
=======
2. Find the script `jadd_path.m` in the folder *auto3dgm-matlab-gorgon/code/*, and set paths and parameters there. If you are using parallel computation and assign an email address to the variable `email_notification`, a notification will be sent automatically to that email address whenever a cluster job completes or aborts.

3. Launch `MATLAB` and `cd` into the folder *auto3dgm-matlab-gorgon/code/*. If sequential non-cluster analysis is desired, type `main` to run the script `main.m`. If parallel cluster analysis is desired, type `clusterMain` to run the script `clusterMain.m`. Jobs should be submitted to the cluster subsequently. Use `qstat` to monitor job status. Analysis is complete when job `clusterRun` is finished. 

The script `clusterRun.m` automates the four major steps of auto3dgm parallel computation. It is also possible to run these four steps manually following these instructions.

1. Launch `MATLAB`, `cd` into the folder *auto3dgm-matlab-gorgon/code/*, and type `clusterMapLowRes`. Low-resolution alignment jobs should then be submitted to the cluster. Use `qstat` to monitor job status.

2. After all jobs are completed, type `clusterReduceLowRes`. This generates low-resolution alignment results in the `output` folder specified in `jadd_path.m`.

3. Type `clusterMapHighRes` to submit high-resolution alignment jobs to the cluster. 

4. After all jobs are completed, type in `clusterReduceHighRes`. This generates high-resolution alignment results in the `output` folder specified in `jadd_path.m`.
>>>>>>> d0dddb3294f936c1d498fdc04e0fae58610afc62

-----------
#### WebGL-based Alignment Visualization
After the alignment process is completed, the result can be visualized using a javascript-based viewer located under the folder *viewer/*. See [here](http://www.math.duke.edu/~trgao10/research/auto3dgm.html) for an online demo.

1. Move all output files ending with "_aligned.obj" from the subfolder *aligned/* (under your output folder) to the subfolder *viewer/aligned_meshes/*.
2. Set up an HTTP server under the folder *viewer/*. (If you already placed the folder *viewer/* somewhere with HTTP services, feel free to skip this step.) For instance, you can `cd viewer/` and type into the terminal `python -m SimpleHTTPServer 8000` if you are using Python 2.x, or equivalently `python -m http.server 8000` if you have Python 3.x.
3. Launch your browser and direct it to `http://localhost:8000/auto3dgm.html`.

-----------
#### Mosek License File
You will need a mosek license for using the fast linear programming routine for pairwise alignments. If you have an academic/institutional email address, you are eligible for a [free academic license](https://www.mosek.com/resources/academic-license) from [mosek.com](https://www.mosek.com/). Upon receiving the mosek license, simply drop it under the folder `PuenteAlignment/software/mosek/`.

-----------
#### Please Cite:

Boyer, Doug M., et al. *A New Fully Automated Approach for Aligning and Comparing Shapes.* The Anatomical Record 298.1 (2015): 249-276.

Puente, Jesús. *Distances and Algorithms to Compare Sets of Shapes for Automated Biological Morphometrics.* PhD Thesis, Princeton University, 2013.
