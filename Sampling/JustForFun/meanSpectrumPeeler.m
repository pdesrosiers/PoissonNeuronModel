function varargout = meanSpectrumPeeler(varargin)
% MEANSPECTRUMPEELER MATLAB code for meanSpectrumPeeler.fig
%      MEANSPECTRUMPEELER, by itself, creates a new MEANSPECTRUMPEELER or raises the existing
%      singleton*.
%
%      H = MEANSPECTRUMPEELER returns the handle to a new MEANSPECTRUMPEELER or the handle to
%      the existing singleton*.
%
%      MEANSPECTRUMPEELER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEANSPECTRUMPEELER.M with the given input arguments.
%
%      MEANSPECTRUMPEELER('Property','Value',...) creates a new MEANSPECTRUMPEELER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before meanSpectrumPeeler_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to meanSpectrumPeeler_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help meanSpectrumPeeler

% Last Modified by GUIDE v2.5 23-Aug-2018 11:05:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @meanSpectrumPeeler_OpeningFcn, ...
                   'gui_OutputFcn',  @meanSpectrumPeeler_OutputFcn, ...
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


% --- Executes just before meanSpectrumPeeler is made visible.
function meanSpectrumPeeler_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to meanSpectrumPeeler (see VARARGIN)

handles.spectrumData = varargin{1};
axes(handles.axes)
plot(handles.spectrumData{101}.freq(2:end), handles.spectrumData{101}.mean(2:end))
hold on
plot(handles.spectrumData{100}.freq(2:end), handles.spectrumData{100}.mean(2:end))
xlim([0 50])
hold off

% Choose default command line output for meanSpectrumPeeler
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes meanSpectrumPeeler wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = meanSpectrumPeeler_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

index = round(get(hObject,'Value'));
set(handles.slider,'Value', index)
displayBananaPeel(handles, index);

guidata(hObject,handles)

function displayBananaPeel(handles, index)
axes(handles.axes)
plot(handles.spectrumData{101}.freq(2:end), handles.spectrumData{101}.mean(2:end))
hold on
plot(handles.spectrumData{index}.freq(2:end), handles.spectrumData{index}.mean(2:end))
xlim([0 50])
hold off
