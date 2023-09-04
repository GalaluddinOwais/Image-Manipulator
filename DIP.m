function varargout = DIP(varargin)
% DIP MATLAB code for DIP.fig
%      DIP, by itself, creates a new DIP or raises the existing
%      singleton*.
%
%      H = DIP returns the handle to a new DIP or the handle to
%      the existing singleton*.
%
%      DIP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIP.M with the given input arguments.
%
%      DIP('Property','Value',...) creates a new DIP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DIP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DIP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DIP

% Last Modified by GUIDE v2.5 13-May-2022 05:12:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DIP_OpeningFcn, ...
                   'gui_OutputFcn',  @DIP_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before DIP is made visible.
function DIP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DIP (see VARARGIN)

% Choose default command line output for DIP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




function varargout = DIP_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

global imageChosen;
global image;

image=cat(3,uint8([0 255 255 0 255 0 0  ;0 0 0 122 0 0 0;77 122 122 11 55 223 234]),uint8([32 243 25 32 215 43 154  ;12 2 43 22 222 111 213;33 120 123 168 153 23 134]),uint8([0 25 23 125 234 23 1  ;213 54 4 152 65 43 1;77 12 12 112 155 123 24]));
imageChosen=image;
imshow(image)


%undo stack
global stack ;
stack = java.util.Stack();

% --- 0000000000000000000000000000000000000000000000000000000000000
function pushbutton1_Callback(hObject, eventdata, handles)
global image;
global stack ;
stack = java.util.Stack();
global imageChosen;
[file,path] = uigetfile({'*.png';'*.jpg'});
if path~=0
image=imread([path file]);
imageChosen=image;
end
imshow(image)



% --- Executes on slider movement.
function tt_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function tt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function pushbutton2_Callback(hObject, eventdata, handles)
global image;
global stack
stack.push(double(image));

global imageChosen;
image=imageChosen;
imshow(image)



function t_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global image;
global stack
stack.push(double(image));


[m,n] = size(image);

for c=1:str2double(get(findobj(0,'tag','t'),'string'))
for i = 2:m-1
for j = 2:n-1
image(i,j)=(double(image(i,j)) +double(image(i-1,j)) +  double(image(i-1,j-1)) + double(image(i,j-1))   + double(image(i-1,j+1))+  double(image(i,j+1)) +  double(image(i+1,j-1))  +  double(image(i+1,j)) +  double(image(i+1,j+1)))/9;
end
end
end
imshow(image)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global image;
global stack
stack.push(double(image));

[m,n] = size(image);

for c=1:str2double(get(findobj(0,'tag','t'),'string'))
for i = 2:m-1
for j = 2:n-1
image(i,j)=median([double(image(i,j)) double(image(i-1,j))   double(image(i-1,j-1))  double(image(i,j-1))    double(image(i-1,j+1))  double(image(i,j+1))   double(image(i+1,j-1))    double(image(i+1,j))   double(image(i+1,j+1))]);
end
end
end
imshow(image)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global image;
global stack
stack.push(double(image));

[x y] = size(image);
min=255;
max=0;
 
for i=1:x 
        for j=1:y
          if image(i,j)>max
              max=image(i,j);
          end
          if image(i,j)<min
              min=image(i,j);
          end
        end
end

sMin=get(findobj(0,'tag','slider7'),'Value')*255;
sMax=get(findobj(0,'tag','slider8'),'Value')*255;
for i=1:x 
        for j=1:y
           image(i,j)=((sMax-sMin)/double(max-min))*(double(image(i,j))-double(min))+sMin;
        end
end
imshow(image)


function tttt_Callback(hObject, eventdata, handles)
% hObject    handle to tttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tttt as text
%        str2double(get(hObject,'String')) returns contents of tttt as a double


% --- Executes during object creation, after setting all properties.
function tttt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ttt_Callback(hObject, eventdata, handles)
% hObject    handle to ttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ttt as text
%        str2double(get(hObject,'String')) returns contents of ttt as a double


% --- Executes during object creation, after setting all properties.
function ttt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));


image = uint8(image./(get(findobj(0,'tag','slider4'),'Value')*255))*255;
imshow(image)




function ttttt_Callback(hObject, eventdata, handles)
% hObject    handle to ttttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ttttt as text
%        str2double(get(hObject,'String')) returns contents of ttttt as a double


% --- Executes during object creation, after setting all properties.
function ttttt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ttttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
global bits;
bits=4;
function pushbutton7_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

global bits
[x y] = size(image);

for i=1:x 
        for j=1:y 
    a = dec2bin(image(i,j),8);
    a(bits:8)='0';
  image(i,j)=  bin2dec(a);
        end
end
imshow(image)


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on  button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
global bits
bits = menu('gray levels','2','4','8','16','32','64','128')+1


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

a  = size(size(image));
if a(2)==3 
m1 = image(1:str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:str2double(get(findobj(0,'tag','ttttttt'),'string')):end,1);

m2 = image(1:str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:str2double(get(findobj(0,'tag','ttttttt'),'string')):end,2);

m3 = image(1:str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:str2double(get(findobj(0,'tag','ttttttt'),'string')):end,3);
image = cat(3,m1,m2,m3);


else

image = image(1:str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:str2double(get(findobj(0,'tag','ttttttt'),'string')):end);


end
imshow(image)



function tttttt_Callback(hObject, eventdata, handles)
% hObject    handle to tttttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tttttt as text
%        str2double(get(hObject,'String')) returns contents of tttttt as a double


% --- Executes during object creation, after setting all properties.
function tttttt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tttttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ttttttt_Callback(hObject, eventdata, handles)
% hObject    handle to ttttttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ttttttt as text
%        str2double(get(hObject,'String')) returns contents of ttttttt as a double


% --- Executes during object creation, after setting all properties.
function ttttttt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ttttttt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

a  = size(size(image));
if a(2)==3 
m1 = image(1:1/str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:1/str2double(get(findobj(0,'tag','ttttttt'),'string')):end,1);

m2 = image(1:1/str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:1/str2double(get(findobj(0,'tag','ttttttt'),'string')):end,2);

m3 = image(1:1/str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:1/str2double(get(findobj(0,'tag','ttttttt'),'string')):end,3);
image = cat(3,m1,m2,m3);

else

image = image(1:1/str2double(get(findobj(0,'tag','tttttt'),'string')):end, 1:1/str2double(get(findobj(0,'tag','ttttttt'),'string')):end);


end
imshow(image)
% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

[file,path] = uigetfile({'*.png';'*.jpg'});
if path~=0
    imageToSubtract=imread([path file]);


[x y]=size(image);
[xx yy]=size(imageToSubtract);
if x ~= xx || y ~= yy
msgbox('sizes dont match!');
else
image=(imageToSubtract-image)+(image-imageToSubtract);
imshow(image)
end
end

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

image = 255-image;
imshow(image)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

image = im2double(image);
image=str2double(get(findobj(0,'tag','y'),'string'))*log(1+image);
image=uint8(image.*255);
imshow(image)


function y_Callback(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y as text
%        str2double(get(hObject,'String')) returns contents of y as a double


% --- Executes during object creation, after setting all properties.
function y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));


image = im2double(image);
image=str2double(get(findobj(0,'tag','y'),'string'))*image.^2;
image=uint8(image.*255);
imshow(image)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

[file,path] = uigetfile({'*.png';'*.jpg'});
if path~=0
    imageToAdd=imread([path file]);



[x y]=size(image);
[xx yy]=size(imageToAdd);
if x ~= xx || y ~= yy
msgbox('sizes dont match!');
else
image=(imageToAdd+image);
imshow(image)
end
end

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

dimage = double(image);
[x,y]=size(dimage);
mask = [0,1,0;1,-4,1;0,1,0];
edges = dimage;
for i=2:x-1
 for j=2:y-1
     temp = mask.*dimage(i-1:i+1,j-1:j+1);
     edges(i, j)= sum(temp(:));
end
end
image = uint8(image)-uint8(edges);
imshow(image);


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

dimage = double(image);
[x,y]=size(dimage);
mask = [0,1,0;1,-4,1;0,1,0];
edges = dimage;
for i=2:x-1
 for j=2:y-1
     temp = mask.*dimage(i-1:i+1,j-1:j+1);
     edges(i, j)= sum(temp(:));
end
end
image =uint8(edges);
imshow(image);



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
global image;
global stack
stack.push(double(image));

[m,n] = size(image);

for c=1:str2double(get(findobj(0,'tag','t'),'string'))
for i = 2:m-1
for j = 2:n-1
image(i,j)=(double(image(i,j))*4+ double(image(i-1,j))*2+double(image(i-1,j-1))+  double(image(i,j-1))*2+    double(image(i-1,j+1))+  double(image(i,j+1))*2 +  double(image(i+1,j-1))+    double(image(i+1,j))*2+   double(image(i+1,j+1)))/16;
end
end
end
imshow(image)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

dimage = double(image);
[x,y]=size(dimage);
ma = [-1,-2,-1;0,0,0;1,2,1];
sk = [-1,0,1;-2,0,2;-1,0,1];
edges = dimage;
for i=2:x-1
 for j=2:y-1
     te = ma.*dimage(i-1:i+1,j-1:j+1);
     mp = sk.*dimage(i-1:i+1,j-1:j+1);
     edges(i, j)= abs(sum(te(:)))+abs(sum(mp(:)));
end
end
image =uint8(edges);
imshow(image);


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

dimage = double(image);
[x,y]=size(dimage);
sk = [-1,0,1;-2,0,2;-1,0,1];
edges = dimage;
for i=2:x-1
 for j=2:y-1
    
     mp = sk.*dimage(i-1:i+1,j-1:j+1);
     edges(i, j)= +abs(sum(mp(:)));
end
end
image =uint8(edges);
imshow(image);



% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

dimage = double(image);
[x,y]=size(dimage);
ma = [-1,-2,-1;0,0,0;1,2,1];
edges = dimage;
for i=2:x-1
 for j=2:y-1
     te = ma.*dimage(i-1:i+1,j-1:j+1);
     edges(i, j)= abs(sum(te(:)));
end
end
image =uint8(edges);
imshow(image);


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
global image

new = image;
[x y] = size(new);
figure
for b=1:8
for i=1:x 
        for j=1:y 
    a = dec2bin(image(i,j),8);
   new(i,j)=str2num(a(b)).*255;
        end
end
subplot(2,4,b)
imshow(new)

end


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

[x y] = size(image);
    new = image;
for c=1:str2double(get(findobj(0,'tag','t'),'string'))
    for i=2:x-1
        for j=2:y-1
            M = image(i-1:i+1,j-1:j+1);
            Min = min(M(:));
            new(i,j) = Min;
        end
    end
image=new;
end

imshow(image)
% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

    [x y] = size(image);
    new = image;
for c=1:str2double(get(findobj(0,'tag','t'),'string'))
    for i=2:x-1
        for j=2:y-1
            M = image(i-1:i+1,j-1:j+1);
            Max = max(M(:));
            new(i,j) = Max;
        end
    end
image=new;
end

imshow(image)


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
global image 

[x y] = size(image)
list = zeros(1,256)
for i=1:x
for j=1:y
          list(image(i,j)+1)=list(image(i,j)+1)+1;
end
end
figure(1)
stem([0:255],list(1:1:end),'m.','color','green','lineWidth',4)
set(gca,'Color','k')


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
global image 
global stack
stack.push(double(image));

[x y] = size(image);
list = zeros(1,256);
for i=1:x
for j=1:y
list(image(i,j)+1)=list(image(i,j)+1)+1;
end
end
for i = 256:-1:1
list(i)=sum(list(1:i));
end
mul=255/(x*y);
for i=1:x
for j=1:y
image(i,j)=list(image(i,j)+1)*mul;
end
end
imshow(image)


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
global image

t=findobj(0,'tag','pushbutton36');
tt=findobj(0,'tag','text1');
set(t,'string','click before 3');
pause(1)
set(t,'string','click before 2');
pause(1)
set(t,'string','click before 1');
pause(1)
set(t,'string','pick color');
p=get(gca,'CurrentPoint');
a  = size(size(image));
if a(2)==3 
m1= image(uint8(p(1,2)),uint8(p(1,1)),1);
m2= image(uint8(p(1,2)),uint8(p(1,1)),2);
m3= image(uint8(p(1,2)),uint8(p(1,1)),3);
set(tt,'string',strcat('R:',num2str(m1),'  G:',num2str(m2),'  B:',num2str(m3)));

set(t,'BackgroundColor',[double(m1)/255,double(m2)/255,double(m3)/255]);

else
 pix =   image(uint8(p(1,2)),uint8(p(1,1)));
set(tt,'string',num2str(pix));
set(t,'BackgroundColor',[double(pix)/255,double(pix)/255,double(pix)/255]);

end


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
global image
global stack
stack.push(double(image));

image = rgb2gray(image);
imshow(image)


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
global image
[file,path] = uiputfile({'*.png';'*.jpg'});
  imwrite(image,[path file]);


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
global stack
global image
global imageChosen;


if stack.size ~= 0
image=uint8(stack.pop());
imshow(image)
else
image=imageChosen;
imshow(image)
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
