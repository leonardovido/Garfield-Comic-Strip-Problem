function hf = image_show_resize(image)

hf=figure;hf.Units='points';
imshow(image);
[hf.Position(4),hf.Position(3),~]=size(image);
hf.Position(3:4)=hf.Position(3:4);
end

