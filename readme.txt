Please have all the files in the current working directory. 

To run 
		step 1: Training and Testing the CNN
	-> run starter_1e5_epoch10 for learning rate = 1e-5
	-> run starter_5e4_epoch10 for learning rate = 5e-4

		step 2: Augmenting dataset
	-> run call_for_augment_images for obtaining the augmented dataset as well as the histogram plots
		

		step 3.1: Wide network
		-> run call_for_128_images 
	-> run main_wide_config1_augmentedDataset for one structure of wide network on the augmented dataset
	-> run wide_config2 for another structure of wide network on the augmented dataset(config1 has been used for all results in the report)
	-> run main_wide_config1_originalDataset to check the wide netowrk on the original 17,000 images

			
		step 3.2: Skinny network
		-> run call_for_128_images (if not called before)
	-> run main_skinny_augmentedDataset for skinny network on the augmented dataset(85,000 images)
	-> run main_skinny_originalDataset for skinny network on the original dataset(17,000 images)


		extra credit 1: Alexnet
	-> run call_for_alexnet_images 
	-> run main_alexNet for transfer learning

		** extra credit 2: deepDreamImage **
		**   Called inside each network   **

		extra_credit 3: tSNE
	-> run tSNE_skinny for tSNE on skinnny network
	-> run tSNE_wide for tSNE on wide network


The data has not been included(data too big!). Please do email pug64@psu.edu if my data for augmentation and alexnet images are required. 