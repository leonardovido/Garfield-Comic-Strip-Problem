# Garfield Comic Strip Problem

| Contribution   |
| :---   |
| Michael Irvine               |
| Leonardo Villamil Dominguez  |
| Paul Zapotezny-Anderson      |

This project addresses a variation on the Garfield comic problem. That is, to re-orientate the comic and place all instances of Garfield on a blackened background, while retaining foreground elements so that the comic remains readable.

A four-stage solution is proposed: re-orientate the comic and crop the image to the comic; find the frames of the comic; detect if Garfield is present in each frame; and to blacken the background of Garfield in the frame if Garfield is present. (See pptx file)

The solution employs are broad range of image processing techniques which include: Thresholding, Morphological Operations, 1D Feature Extraction, Canny Edge Detection, Unsupervised Machine Learning and the application of Masks and Overlays.

The proposed solution was visually evaluated against assessment criteria for the successful operation of each stage, using items from the provided Training, Test and Validation sets (15, 10 and 15 items, respectively). The solution was able to achieve a very high success rate with 100% for both Training and Test sets, and 80% for the Validation set.

Of the three failures, two were attributable to an unanticipated feature, a skewed input comic, which did not appear in the Training and Test dataset, and for which the solution did not accommodate. The third failure was a result of foreground elements having a very similar colour to the background, resulting in foreground elements becoming blackened. Here, the conditions represent a peculiar corner case which poses a challenge to the proposed solution.

Recommendations for further work include accommodating all aspects of the affine transform within the re-orientation stage, and to explore alternative colour representations to improve the performance of colour segmentation under adverse conditions.