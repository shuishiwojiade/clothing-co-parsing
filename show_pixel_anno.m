function show_pixel_anno
% SHOW_PIXEL_ANNO visualization of pixel-level annotations
% Wei YANG 2014
% platero.yang (at) gmail.com
dirPath = './annotations/pixel-level/';
targetPath = './output/annotations/pixel-level/';

filepaths = dir(fullfile(dirPath,'*.mat'));
for i = 1:length(filepaths)
imname = filepaths(i).name;
load('label_list', 'label_list'); % load label list
load(imname, 'groundtruth'); % load an pixel-level annotation

% get image-level labels name
cur_labels = unique(groundtruth);
label_names = cell(1, length(cur_labels));
for i = 1:length(cur_labels)
    label_names(i) = label_list( cur_labels(i)+1 );
end
colors = colormap( jet(length(label_list)) );   % set color map

gt_image = zeros(size(groundtruth, 1), size(groundtruth, 2), 3);

for labelidx = 1:length(cur_labels)
    [rows cols] = find(groundtruth == cur_labels(labelidx));
    
    curcolor = colors(cur_labels(labelidx)+1, :);
    for i=1:length(rows)
        gt_image(rows(i), cols(i), 1) = curcolor(1);
        gt_image(rows(i), cols(i), 2) = curcolor(2);
        gt_image(rows(i), cols(i), 3) = curcolor(3);
    end
end
% imshow(gt_image); hold on; title('Ground Truth');
imwrite(gt_image, sprintf('%d.jpg', i), 'jpg'); 

end


