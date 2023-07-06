function varargout = diagResult(varargin)
% DIAGRESULT MATLAB code for diagResult.fig
%      DIAGRESULT, by itself, creates a new DIAGRESULT or raises the existing
%      singleton*.
%
%      H = DIAGRESULT returns the handle to a new DIAGRESULT or the handle to
%      the existing singleton*.
%
%      DIAGRESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIAGRESULT.M with the given input arguments.
%
%      DIAGRESULT('Property','Value',...) creates a new DIAGRESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before diagResult_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to diagResult_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help diagResult

% Last Modified by GUIDE v2.5 20-May-2015 00:51:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @diagResult_OpeningFcn, ...
                   'gui_OutputFcn',  @diagResult_OutputFcn, ...
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

%%
% --- Executes just before diagResult is made visible.
function diagResult_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to diagResult (see VARARGIN)
load diagnosisResult;
%Symptoms=num2str(Symptoms);
[n,~]=size(Result_DB2);
%San=Sanitate;
if San==0 
    San='No sanitation required.';
else
    San='Sanitation required!';
end
Name=Result_DB2(n,1:30);
handles.text5.String=['Symptoms: ', Name];
handles.text3.String= ['   FmF:';'    FS:';'   Trs:';'   Age:';'    SC:';'ITofUC:';'VSinTC:';'   SCS:';...
    '    EL:';'  RIEL:';'   Sex:';'   VCO:';'    BP:';'    OP:';];

handles.text6.String=Symptoms;

handles.text7.String=['Result:  ',Result1,' (',San,')'];
handles.pushbutton2.Visible='On';
handles.pushbutton3.Visible='On';
%handles.text3.String={handles.text3.String, Diagnosis;}
% Choose default command line output for diagResult
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes diagResult wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%%

% --- Outputs from this function are returned to the command line.
function varargout = diagResult_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

%%
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load diagnosisResult;
%Symptoms=num2str(Symptoms);
Change=inputdlg('Please enter the output of this symptom(1-6). 1=TF 2=TS 3=TI 4=TT 5=CO 6=Normal','Enter one output');
Change=str2double(Change);
if isempty(Change)
    %errordlg('You have entered invalid output!! Please try again.','Error');
    handles.pushbutton2.Visible='Off';
    return
elseif isnan(Change)||Change<=0||Change>6
    errordlg('You have entered invalid output!! Please try again.','Error');
    handles.pushbutton2.Visible='Off';
    return;
end
if Change==1
     Change=[1 0 0 0 0 0 ];
     handles.pushbutton2.Visible='Off';
elseif Change==2
    Change=[0 1 0 0 0 0];
    handles.pushbutton2.Visible='Off';
elseif Change==3
    Change=[0 0 1 0 0 0];
    handles.pushbutton2.Visible='Off';
elseif Change==4
    Change=[0 0 0 1 0 0];
    handles.pushbutton2.Visible='Off';
elseif Change==5
    Change=[0 0 0 0 1 0];
    handles.pushbutton2.Visible='Off';
elseif Change==6
    Change=[0 0 0 0 0 1];
    handles.pushbutton2.Visible='Off';
end
Change=Change';
load trachoma;
trac_Target_Rep=horzcat(trac_Target_Rep,Change);
trac_Input_Rep=horzcat(trac_Input_Rep,Symptoms);
freshI=horzcat(freshI,Change);
freshO=horzcat(freshO,Symptoms);
save diagnosisResult freshI freshO trac_Target_Rep trac_Input_Rep '-append';
save trachoma freshI freshO trac_Target_Rep trac_Input_Rep '-append';
clear trachoma diagnosisResult;
msgbox({'Thank you for your cooperation.' 'It will be further analyzed and learnt in advance.'});
if strcmp(handles.pushbutton2.Visible,'On')==1
    handles.pushbutton2.Visible='Off';
end
pause(2);
close;
%%

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load diagnosisResult;
load trachoma;
trac_Input_Rep=horzcat(trac_Input_Rep,Symptoms);
trac_Target_Rep=horzcat(trac_Target_Rep,round(Diagnosis));
save diagnosisResult trac_Input_Rep trac_Target_Rep '-append';
save trachoma trac_Input_Rep trac_Target_Rep '-append';

clear trachoma diagnosisResult;
set(hObject,'Visible','Off');
msgbox({'Thank you for your cooperation.' 'It will be further analyzed and learnt in advance.'});
pause(3);
close;
%%


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(diagResult,'PaperPositionMode','auto');
set(diagResult,'InvertHardcopy','off');
printpreview(diagResult);