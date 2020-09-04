# DeepBrainNet
Convolutional Neural Network trained for age prediction using a large (n=11,729) set of MRI scans from a highly diversified cohort spanning different studies, scanners, ages, ethnicities and geographic locations around the world.

Files are in HDF5(.h5) format for easy use in Keras. Model files initalize the architecture and the pre-trained weights.

Other file can be found here: https://upenn.box.com/v/DeepBrainNet




Use test.sh in the Script folder to perform brain age prediction on T1 brain scans.

- Run test.sh -h to see required parameters

----Data Requirements----

- T1 scans must be in nifti format
- Scans shoud be skull-striped and linearly registered
