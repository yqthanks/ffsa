# FFSA
fragmentation-free spatial allocation (spatial optimization)

*Descriptions of inputs, outputs are within each script

To get spatial allocation result using Hierarchical Fragmentation Eliminator here, you will need an integer programming solver (e.g., from ampl or cplex)

Steps:
1. Get integer programming solution without spatial constraints (in 2d format: a choice value on each grid cell).
2. Run hfe.m in matlab. You will need the IP solution from step 1, and additionally specify a minimum area and minimum width as described in the script.
3. hfe.m gives the fragmentation-free space partitioning. Run getFFSA to get final results with choice assignment. Here you will need to edit the script to specify your integer programming solver (instructions are inside the script).

For any questions, feel free to contact xiexx347 at umn dot edu
