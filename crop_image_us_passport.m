image = imread('./test_photo.png');
figure; imshow(image);
disp("slect the top pixel location of the head ((cross horizontal middle of the face))")
uphead_idx = ginput(1);
disp("slect the bottom pixel location of the head")
downhead_idx = ginput(1);
disp("slect the pixel location of the eye (only vertical index matters)")
eye_idx = ginput(1);

face_height = ceil(max(downhead_idx - uphead_idx));
pix_per_mm = ceil(face_height/32);
down_idx = ceil(eye_idx(2)) + pix_per_mm*30;
left_idx = max(ceil(uphead_idx(1)) - ceil(pix_per_mm*25.5),1);

im_height = pix_per_mm*51;
im_width = pix_per_mm*51;
up_idx = down_idx - im_height;

image_crop = image(up_idx:(up_idx+im_height-1), left_idx:(left_idx+im_width-1),:);
figure; imshow(image_crop);
mkdir('./us_passport_photo')
imwrite(uint8(image_crop), './us_passport_photo/photo_us.jpg');


in_mm = 25.4;
width = ceil(6*in_mm*pix_per_mm);  height = ceil(4*in_mm*pix_per_mm);
full_image = [];
full_image_col = cat(1, image_crop, image_crop);
for i = 1:3
    full_image = cat(2, full_image, full_image_col);
end
figure; imshow(uint8(full_image));
imwrite(uint8(full_image), './us_passport_photo/4in_by_6in_photo_us.jpg')

