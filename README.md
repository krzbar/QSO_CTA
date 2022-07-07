# QSO_CTA

These are the R scripts and numerical results accompanying Bartoszek, and Pułka "Convergence and simulation of centred kernel quadratic stochastic operators".

The R setup for the manuscript was as follows: R version  4.0.3 (2020-10-10) Platform: x86_64-pc-linux-gnu (64-bit) Running under: openSUSE Leap 15.2

The exact output can depend on the random seed. However, in the script we have the option of rerunning the analyses as it was in the manuscript, i.e. the random seeds that were used to generate the results are saved, included and can be read in. 

The code is divided into several directories with scripts, random seeds and result files.
In order to run the analyses one runs source("CKQSOsim_torun.R") in R. In the file CKQSOsim_setups.R one defines the all the simulation setups that one wants. The list with the setups has to be passed to the variable l_do_setups (in CKQSOsim_torun.R). A setup is a list with the following fields:

1) n: the number of generation

2) pop_size: the sample size

3) delta: value of delta in Thm. 4

4) alpha: value of alpha in Thm. 4

5) rG: sampling function of the kernel distribution

6) rG_pop: sampling function of the kernel distribution for Alg. 1, the population simulation algorithm, needs to take in as parameters the trait values of the two parents

7) vG: variance of G distribution

8) rF: sampling function of the initial distribution

9) vF: variance of F distribution

10) m: mean value of F distribution

11) otherparams: a list with possible stearing parameters, at the moment it is unused

12) b_dosimul: logical, should the simulation be performed (TRUE) or its results read in from an RData file (FALSE, RData file is automatically constructed based as c_fileprefix.RData

13) b_doplot: logical, should plots of the simulation be done (TRUE)

14) b_dosave: logical, should the results be saved (TRUE), unused at the moment

15) c_fileprefix: the prefix for result and plot files

16) res_exact: result of Alg. 2 simulation (unused)

17) res_approxBT: result of Alg. 3 simulation with the Bonferroni type correction (unused)

18) res_approxBT: result of Alg. 3 simulation without the Bonferroni type correction (unused)

19) res_popAlg=NULL: result of Alg. 1 simulation (unused)

20) legendpos: position of the legends for the plots 

21) b_replicate: logical, should a new simulation be done (FALSE) or should the simulation be replicated based on read-in random seeds (from c_fileprefix.RData file)

22) b_save_seeds: logical, should the random seeds be saved (TRUE) or not (FALSE)

23) b_exact: logical, should the simulations according to Alg. 2 be run (TRUE)

24) b_approxBT: logical, should the simulations according to Alg. 3  with the Bonferroni type correction be run (TRUE)

25) b_approxBF: logical, should the simulations according to Alg. 3  without the Bonferroni type correction be run (TRUE)

26) b_popAlg: logical, should the simulations according to Alg. 1 be run (TRUE)

The result and plot files are all in the same directory as the scripts. The output files have been moved to the Results folder for clarity here. However, in order to replicate the study, all the RData files need to be copied from the Results folder into the directory where the R scripts R. This is in order for them to be able to read in the Random seeds.

