It looks like I need write permission to the `research_notes/` directory. Could you grant write access so I can save the file? The content is fully prepared — comprehensive research notes covering:

**Chapter 5 (CNN):**
- Why CNNs exist (MLP limitations for images)
- Convolution operation with flashlight analogy, multi-channel convolution, 1×1 conv
- Padding (valid/same/full), stride, output size formula
- Pooling (max, average, GAP) and pooling vs. strided conv debate
- Full architecture evolution: LeNet → AlexNet → VGG → GoogLeNet → ResNet → DenseNet → EfficientNet → MobileNet (with key innovations, parameter counts, and comparison table)
- Receptive field mechanics
- Transposed convolution (deconvolution) and checkerboard artifacts
- U-Net architecture with skip connections
- Applications: classification, object detection (R-CNN, YOLO, SSD), segmentation (semantic/instance/panoptic)
- BatchNorm in CNNs, data augmentation, transfer learning

**Chapter 6 (RNN):**
- Why sequential data needs RNNs, core RNN mechanics with "passing a note" analogy
- Input-output patterns (one-to-one through many-to-many)
- Vanishing/exploding gradient with telephone game analogy
- LSTM in full detail: all 3 gates with formulas, plain-English explanations, concrete examples, conveyor belt analogy
- GRU: 2 gates, comparison table with LSTM
- Bidirectional RNN with "bank" fill-in-the-blank example
- Seq2Seq: encoder-decoder, bottleneck problem, teacher forcing, beam search
- Applications across NLP, time series, speech/audio
- Practical considerations: stacking, dropout, gradient clipping, truncated BPTT
- RNN decline and Transformer rise
