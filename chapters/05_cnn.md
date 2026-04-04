It seems write permission to the `chapters/` directory needs to be granted. Could you allow write access so I can save the file? The chapter is complete — approximately 4,500 words, following the guidelines template:

- **Opening question** — why fully connected networks fail on images (parameter explosion + no spatial awareness)
- **Core idea** — flashlight analogy from the Analogy Bank, translation invariance
- **Technical sections** covering:
  - Convolution operation with step-by-step explanation, formula with textual explanation before and after
  - Multiple channels and multiple filters, 1×1 convolution
  - Padding (valid/same) and stride, with output size formula
  - Pooling (max, average, GAP), pooling vs. strided conv debate
  - Receptive field mechanics and why stacking small filters beats large ones
  - Full CNN architecture pattern (conv → activation → pooling)
- **Variants and evolution** — LeNet → AlexNet → VGG → GoogLeNet/Inception → ResNet → DenseNet → EfficientNet → MobileNet, plus transposed convolution and U-Net (encoder/decoder)
- **Practical applications** — classification, object detection (YOLO, SSD), segmentation (semantic/instance), medical imaging, transfer learning and fine-tuning
- **Summary** and **bridge to Chapter 6** (RNNs) with the "passing a note" analogy
- All terms from the terminology table defined on first use (filter/kernel, feature map, convolution/conv, pooling, encoder, decoder, pre-training, fine-tuning, etc.)
- Cross-references in `[see: Chapter N]` format to Chapters 1, 2, and 4
