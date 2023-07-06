function varargout = newPatient(varargin)
% NEWPATIENT MATLAB code for newPatient.fig
%      NEWPATIENT, by itself, creates a new NEWPATIENT or raises the existing
%      singleton*.
%
%      H = NEWPATIENT returns the handle to a new NEWPATIENT or the handle to
%      the existing singleton*.
%
%      NEWPATIENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWPATIENT.M with the given input arguments.
%
%      NEWPATIENT('Property','Value',...) creates a new NEWPATIENT or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newPatient_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newPatient_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newPatient

% Last Modified by GUIDE v2.5 04-Jul-2023 21:35:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newPatient_OpeningFcn, ...
                   'gui_OutputFcn',  @newPatient_OutputFcn, ...
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

% --- Executes just before newPatient is made visible.
function newPatient_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newPatient (see VARARGIN)

% Choose default command line output for newPatient
%handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes newPatient wait for user response (see UIRESUME)
% uiwait(handles.newPatient);


% --- Outputs from this function are returned to the command line.
function varargout = newPatient_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
%varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%    set(hObject,'BackgroundColor','white');
%end


function density_Callback(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density as text
%        str2double(get(hObject,'String')) returns contents of density as a double
%density = str2double(get(hObject, 'String'));
%if isnan(density)
%    set(hObject, 'String', 0);
%    errordlg('Input must be a number','Error');
%end

% Save the new density value
%handles.metricdata.density = density;
%guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%    set(hObject,'BackgroundColor','white');
%end



function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volume as text
%        str2double(get(hObject,'String')) returns contents of volume as a double
%volume = str2double(get(hObject, 'String'));
%if isnan(volume)
 %   set(hObject, 'String', 0);
 %   errordlg('Input must be a number','Error');
%end

% Save the new volume value
%handles.metricdata.volume = volume;
%guidata(hObject,handles)

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Check up all necessary variables are filled correctly
load trachoma;
load diagnosisResult;
load Sanitate;
if isempty(get(handles.edit4,'String'))||strcmp(get(handles.edit4,'String'),'Enter name of patient')==1
    errordlg('Please enter name of patient','Error');
    set(handles.edit4,'String','');
    return;
end
if get(handles.radiobutton7,'Value')==0&&get(handles.radiobutton11,'Value')==0
    errordlg('Please select sex of patient','Error');
    return;
end

NoF=str2double(get(handles.edit5,'String'));
if NoF==0||isnan(NoF)||isempty(NoF)
    errordlg('Please enter the number of family living with the patient.','Error');
    return;
end

Place=get(handles.edit6,'String');
if isempty(Place)||strcmp(Place,'Patient is from...')==1
    set(handles.edit6,'String','');
    errordlg('Please enter the patient''s place of residence.','Error');
    return;
end

Zonlist=cellstr(get(handles.popupmenu3,'String'));
Zon=Zonlist{get(handles.popupmenu3,'Value')};
if strcmp(Zon,'Temprate')==1
    Zon=0;
elseif strcmp(Zon,'Hot')==1
 Zon=1;
elseif strcmp(Zon,'Cold')==1
        Zon=2;
else
    errordlg('Please select zone of patient','Error');
    return;
end

Agelist=cellstr(get(handles.popupmenu1,'String'));
AgeS=Agelist{get(handles.popupmenu1,'Value')};
if strcmp(AgeS,'Select')
    errordlg('Please select age of patient','Error');
    return;
elseif strcmp(Zon,'Select zone')==1
    errordlg('Please select Zone of patient','Error');
    return;
end

Name=get(handles.edit4,'String');
Age=str2double(AgeS);
if isnan(Age)
    Age=0.5;
end

Sex=get(handles.radiobutton7,'Value');
FmF=get(handles.checkbox9,'Value');
FS=get(handles.checkbox2,'Value');
Trs=get(handles.checkbox3,'Value');
ITofUC=get(handles.checkbox4,'Value');
SC=get(handles.checkbox18,'Value');
VSinTC=get(handles.checkbox5,'Value');
SCS=get(handles.checkbox19,'Value');
EL=get(handles.checkbox6,'Value');
RIEL=get(handles.checkbox7,'Value');
VCO=get(handles.checkbox8,'Value');
BP=get(handles.checkbox10,'Value');
OP=get(handles.checkbox11,'Value');


Symptoms=[FmF;FS;Trs;Age;ITofUC;SC;VSinTC;SCS;EL;RIEL;Sex;VCO;BP;OP];
mynet=adapt(mynet,trac_Input_Rep,trac_Target_Rep);

Diagnosis=sim(mynet,Symptoms);
[~,index]=max(Diagnosis);
if index==6 
    dResult=0; 
else
    dResult=1;
end
switch index
    case 1
        Result1='TF (Trachoma Stage 1)';
    case 2
        Result1='TI (Trachoma Stage 2)';
    case 3
        Result1='TS (Trachoma Stage 3)';
    case 4
        Result1='TT (Trachoma Stage 4)';
    case 5 
        Result1='CO (Trachoma Stage 5)';
    case 6
        Result1='TN (Trachoma Negative)';
    otherwise
        Result1='Input out of range';
end
Residence=get(handles.edit6,'String');
PfR=get(handles.checkbox16,'Value');
SanitateData=[dResult;NoF;Zon;PfR];
San=sim(Sanitate,SanitateData);
%Round output to fit 0 or 1.
San=round(San);
%Save the result so it is accessed by Patientreconds window
save diagnosisResult San '-append'

SymptomsR=[num2str(FmF),num2str(FS),num2str(Trs),AgeS,num2str(ITofUC),num2str(SC),num2str(VSinTC),...
    num2str(SCS),num2str(EL),num2str(RIEL),num2str(Sex),num2str(VCO),num2str(BP),num2str(OP)];
Symp=SymptomsR(1);
for i=2:15
    if i==5
        Symp=strcat(Symp,SymptomsR(i));
    elseif i==3
        Symp=[Symp,'  ',SymptomsR(i)];
    else
        Symp=[Symp,'   ',SymptomsR(i)];
    end
end
k=length(Residence);
for i=1:15-k
    Residence=[Residence,' '];
end

k=length(Name);
for i=1:30-k
    Name=[Name,' '];
end
k=length(Result1);
for i=1:16-k
    Result1=[Result1,' '];
end
temp=horzcat(Name,' ',Symp,' ',Residence,' ',Result1);
%Result_DB2=vertcat(Result_DB2,temp);
save diagnosisResult Result1 Diagnosis Symptoms Result_DB2 '-append';
clear *;
diagResult;


%mass = handles.metricdata.density * handles.metricdata.volume;
%set(handles.mass, 'String', mass);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'String'),'Reset...')==1
    set(hObject,'String','Close');
handles.edit4.String='';
handles.checkbox2.Value = 0;
handles.checkbox3.Value = 0;
handles.checkbox4.Value = 0;
handles.checkbox5.Value = 0;
handles.checkbox6.Value = 0;
handles.checkbox7.Value = 0;
handles.checkbox8.Value = 0;
handles.checkbox9.Value = 0;
handles.checkbox10.Value = 0;
handles.checkbox11.Value = 0;
handles.checkbox12.Value = 0;
handles.checkbox13.Value = 0;
handles.checkbox14.Value = 0;
handles.checkbox15.Value = 0;
handles.checkbox16.Value = 0;
handles.checkbox18.Value = 0;
handles.checkbox19.Value = 0;
handles.radiobutton7.Value = 0;
handles.radiobutton11.Value= 0;
set(handles.popupmenu1,'Value',1);
set(handles.popupmenu2,'Value',1);
set(handles.popupmenu3,'Value',1);
handles.edit5.String = '';
handles.edit6.String = '';
else
close hidden;
end

% --- Executes when selected object changed in unitgroup.
function unitgroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in unitgroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%if (hObject == handles.english)
 %   set(handles.text4, 'String', 'lb/cu.in');
  %  set(handles.text5, 'String', 'cu.in');
   % set(handles.text6, 'String', 'lb');
%else
%    set(handles.text4, 'String', 'kg/cu.m');
%    set(handles.text5, 'String', 'cu.m');
%    set(handles.text6, 'String', 'kg');
%end

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
%if isfield(handles, 'metricdata') && ~isreset

%handles.metricdata.volume  = 0;

%set(handles.density, 'String', handles.metricdata.density);
%set(handles.volume,  'String', handles.metricdata.volume);
%set(handles.mass, 'String', 0);

%set(handles.unitgroup, 'SelectedObject', handles.english);

%set(handles.text4, 'String', 'lb/cu.in');
%set(handles.text5, 'String', 'cu.in');
%set(handles.text6, 'String', 'lb');

% Update handles structure
%guidata(handles.newPatient, handles);


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(hObject,'String','');
% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
%%handles.reset.String='Reset...';
%handles.edit4.String='';

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'String','Enter name of patient');

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%  set(hObject,'BackgroundColor','white');
%%end
handles.reset.String='Reset...';
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
   
    
% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.radiobutton7.Value==1
    set(handles.radiobutton7,'Value',0);
     hObject.Value=1;
elseif handles.radiobutton7.Value==0
    set(handles.radiobutton7,'Value',0);
     hObject.Value=1;
elseif get(hObject,'Value')==1
    handles.radiobutton11.Value=1;
    hObject.Value=0;
end
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.radiobutton11.Value==1
    set(handles.radiobutton11,'Value',0);
     hObject.Value=1;
    
elseif handles.radiobutton11.Value==0
    set(handles.radiobutton11,'Value',0);
     hObject.Value=1;
    
elseif get(hObject,'Value')==1
    handles.radiobutton11.Value=1;
    hObject.Value=0;
end
handles.reset.String='Reset...';
  


% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';


% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%    set(hObject,'BackgroundColor','white');
%end
handles.reset.String='Reset...';


% --- Executes on button press in checkbox3.
function checkbox3_Callback(~, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
handles.reset.String='Reset...';

% --- Executes on button press in checkbox5.
function checkbox5_Callback(~, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, ~, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(~, ~, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(~, ~, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox11.
function checkbox11_Callback(~, ~, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on button press in checkbox13.
function checkbox13_Callback(~, ~, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox13


% --- Executes on button press in checkbox14.
function checkbox14_Callback(~, ~, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox14


% --- Executes on button press in checkbox15.
function checkbox15_Callback(~, ~, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox15

function checkbox18_Callback(~, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.reset.String='Reset...';
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%   set(hObject,'BackgroundColor','white');
%end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

handles.reset.String='Reset...';
% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.reset.String='Reset...';
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox16


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.reset.String='Reset...';
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function newPatient_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when user attempts to close figure1.
function newPatient_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
delete(hObject);
function newPatient_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in checkbox19.
function checkbox19_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.reset.String='Reset...';
% Hint: get(hObject,'Value') returns toggle state of checkbox19


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit4.
function edit4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.edit4.String='';
