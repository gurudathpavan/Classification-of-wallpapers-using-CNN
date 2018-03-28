# Classification-of-wallpapers-using-CNN

# Project 3 Description-2018
## Training a Convolutional Neural Network
Due: March 2nd
You will be training a CNN on the wallpaper images we previously classified in the last project.  You will be using the Matlab inbuilt CNN training functions (because of their ease).  You will learn how to augment the data, build a CNN, and train on the data.  Do not wait until the deadline for this project since some steps can take a while to run.  Start this project early.

# Data: Wallpaper Pattern Images
The dataset consists of 17,000 images, 1,000 images per group, and each image containing a wallpaper pattern.  The images are 256x256 and 1 channel (grayscale).  You will be training networks to discover these patterns.  The datasets are located in the "data/wallpapers/<train,test>/<group>/" folders.  The train and test images are in separate folders and within them, there are folders for each wallpaper group's images.  
  
  ![alt text](https://psu.instructure.com/courses/1930166/files/90578550/download?wrap=1 "Wallpaper")
  
##  Step 1: Training and Testing the CNN
This step is to get you familiar with the CNN interface and to train your first network.  The starter code comes complete with an example of a convolutional neural network.  The data is not augmented so this data is very separable (as seen by your last project).  You can adjust the setting if it doesn't run on your computer (such as decrease the batch size if your GPU doesn't have enough memory for the images).  This network should train quickly (getting above 10% accuracy after the second epoch).  You should train this for at least 10 epochs (though you are free to train it more if you like).    This should get around ~70%+-5% accuracy.  Is there anything you notice about what happens after you reduce the training rate?  

 

## Step 2: Augmenting the Training and Testing data
Now that you have quickly trained on the original patterns, the next step is to train and test on augmented patterns.  The purpose of this experiment will be to see if we can train the network to understand the patterns after the images have been rotated, scaled, translated, and reflected.  To do this, you will need to create new images from on the original dataset.  These images should also be cropped to 128x128 (so that you can scale the patterns more).  Because of the smaller image sizes, you will need to adjust the input to the network to take a [128, 128, 1] image.  You may use Matlab tools like imrotate and imresize for this project. You should allow for 360-degrees of rotation, any valid translation (don't translate off the image), and a scale range between 50% - 100% from the original 256x256 image.  Make sure to use a uniform scale (the same scale) for both x and y).  Make sure to describe any choices you make while applying these augmentations such as what you do at the border of the image.  In your report, show at least 5 examples per augmentation and then combining all augmentations.  Also, show the distribution of the augmentations with a histogram of the scales, rotations, and translations you have used.  

 ![alt text](https://psu.instructure.com/courses/1930166/files/90580210/download?wrap=1 "Original Wallpaper")
 ![alt text](https://psu.instructure.com/courses/1930166/files/90580220/download?wrap=1 "Original Wallpaper")  ![alt text](https://psu.instructure.com/courses/1930166/files/90580259/download?wrap=1 "Original Wallpaper")  ![alt text](https://psu.instructure.com/courses/1930166/files/90580278/download?wrap=1 "Original Wallpaper")

