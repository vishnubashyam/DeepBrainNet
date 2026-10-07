# DeepBrainNet

Convolutional Neural Network trained for age prediction using a large (n=11,729) set of MRI scans from a highly diversified cohort spanning different studies, scanners, ages, ethnicities and geographic locations around the world.

Files are in HDF5 (`.h5`) format for easy use in Keras. Model files initialize the architecture and the pre-trained weights.

Other files can be found here: https://upenn.box.com/v/DeepBrainNet

Use `test.sh` in the `Script` folder to perform brain age prediction on T1 brain scans.

- Run `test.sh -h` to see required parameters.

## Data Requirements

- T1 scans must be in NIfTI format.
- Scans should be skull-stripped and linearly registered.

## Frequently Asked Questions

### Which image space/orientation should I use?

DeepBrainNet expects each input T1 image to already be skull-stripped and linearly registered before running `Script/test.sh`. The repository sample inputs follow that convention and are named `Data/Subject*_T1_BrainAligned.nii.gz`.

`Script/Slicer.py` converts each NIfTI volume into 80 axial JPG slices by reading `data[:, :, 45 + x]`. Because the script slices the array as stored in the NIfTI file, input orientation and registration are important: use the same preprocessing convention for all subjects, and visually verify that the generated slices in `tmp/Test/` have the expected orientation before relying on predictions.

### How do I convert input data to NIfTI?

Use a medical-image conversion tool before running DeepBrainNet:

- DICOM series: use [`dcm2niix`](https://github.com/rordenlab/dcm2niix) to convert to `.nii` or `.nii.gz`.
- Other neuroimaging formats: tools from [`MRtrix3`](https://github.com/MRtrix3/mrtrix3), FSL, ANTs, or FreeSurfer may be able to convert them.
- Non-volumetric formats such as AVI, JPEG, PPT, or TIFF are not direct substitutes for a 3D T1 MRI volume. They need to originate from a valid anatomical scan and be reconstructed/converted into a correctly oriented NIfTI volume before use.

After conversion, skull-strip and linearly register the T1 image, then pass the directory of aligned NIfTI files with `test.sh -d`.

### What are the ages for the bundled sample data?

The ground-truth ages for the four bundled examples are listed in `Sample_Data.csv`:

| ID | Age |
| --- | ---: |
| Subject1 | 57.75 |
| Subject2 | 45.39 |
| Subject3 | 52.24 |
| Subject4 | 58.32 |

Predicted ages from `pred.csv` can be compared against these values to confirm that the environment and preprocessing are working as expected.

### Which model architecture should I use?

The repository ships `Models/DBN_model.h5` as the default model used by the example script. Additional model files are available through the Box link above.

For reproducibility, start with the bundled `Models/DBN_model.h5` and the sample data. If an external `.h5` model from Box does not load, first re-download it and verify that the download completed successfully. Keras/TensorFlow `.h5` files can also be sensitive to library versions, so using a legacy Keras/TensorFlow environment similar to the one referenced by `Script/test.sh` may be necessary for older model files.

### Where can I download the full training dataset?

This repository includes four example T1 scans in `Data/` and their ages in `Sample_Data.csv`. It does not include the full training dataset. The paper describes a large multi-study training cohort, but users should not expect the complete training data to be downloadable from this repository.

### Which Python, Keras, and TensorFlow versions should I try?

`Script/test.sh` was written for a legacy environment and loads `python/anaconda/3.5.6+tensorflow-gpu+pillow` before running `Model_Test.py`. If a modern TensorFlow/Keras environment cannot load an `.h5` model, retry with a legacy stack compatible with Keras 2.x / TensorFlow 1.x, or use a maintained container/pipeline that pins those dependencies.

If you download a model from Box and see `OSError: Unable to open file (file signature not found)`, the downloaded file is often not the real HDF5 payload. Re-download the model from the Box page and verify the file size before loading it.

### Does this repository provide data augmentation code?

No. The prediction path slices each preprocessed NIfTI image into 80 JPG files and runs inference with the selected `.h5` model. There is no training or data-augmentation pipeline in this repository.

### Where is the paper?

The open-access paper is available here: https://academic.oup.com/brain/article/143/7/2312/5863667
