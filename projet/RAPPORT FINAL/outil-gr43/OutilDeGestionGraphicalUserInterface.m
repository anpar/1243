function varargout = OutilDeGestionGraphicalUserInterface(varargin)
% OUTILDEGESTIONGRAPHICALUSERINTERFACE MATLAB code for OutilDeGestionGraphicalUserInterface.fig
%      OUTILDEGESTIONGRAPHICALUSERINTERFACE, by itself, creates a new OUTILDEGESTIONGRAPHICALUSERINTERFACE or raises the existing
%      singleton*.
%
%      H = OUTILDEGESTIONGRAPHICALUSERINTERFACE returns the handle to a new OUTILDEGESTIONGRAPHICALUSERINTERFACE or the handle to
%      the existing singleton*.
%
%      OUTILDEGESTIONGRAPHICALUSERINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OUTILDEGESTIONGRAPHICALUSERINTERFACE.M with the given input arguments.
%
%      OUTILDEGESTIONGRAPHICALUSERINTERFACE('Property','Value',...) creates a new OUTILDEGESTIONGRAPHICALUSERINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OutilDeGestionGraphicalUserInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OutilDeGestionGraphicalUserInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OutilDeGestionGraphicalUserInterface

% Last Modified by GUIDE v2.5 17-Dec-2014 13:44:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OutilDeGestionGraphicalUserInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @OutilDeGestionGraphicalUserInterface_OutputFcn, ...
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


% --- Executes just before OutilDeGestionGraphicalUserInterface is made visible.
function OutilDeGestionGraphicalUserInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OutilDeGestionGraphicalUserInterface (see VARARGIN)

% Choose default command line output for OutilDeGestionGraphicalUserInterface
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%SET BASIC METHOD TO THE FIRST ONE!!!!!!!!
handles.method = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OutilDeGestionGraphicalUserInterface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OutilDeGestionGraphicalUserInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in calculatebutton.
function calculatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of calculatebutton
method = handles.method;
amount = get(handles.amount,'String');
temperature = get(handles.temperature,'String');

amount = str2num(amount);
temperature = str2num(temperature);
if isempty(amount) || isempty(temperature)
    errordlg({'Please enter valid values for the amount of ammonia and the temperature!'; 'A valid value is a number (example : 1000) and nothing else.'},'Value Entered Error')
else
    OutilDeGestionGraphicalUserInterfaceTable(amount,temperature,method);
end



% --- Executes on selection change in popupbutton.
function popupbutton_Callback(hObject, eventdata, handles)
% hObject    handle to popupbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupbutton contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupbutton


% --- Executes during object creation, after setting all properties.
function popupbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function basicstratoutput_Callback(hObject, eventdata, handles)
% hObject    handle to basicstratoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of basicstratoutput as text
%        str2double(get(hObject,'String')) returns contents of basicstratoutput as a double


% --- Executes during object creation, after setting all properties.
function basicstratoutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to basicstratoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amount_Callback(hObject, eventdata, handles)
% hObject    handle to amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amount as text
%        str2double(get(hObject,'String')) returns contents of amount as a double

% amountValue = get(hObject,'String');
% if ~ismember(str2double(amountValue),cardNums)
%     set(hObject,'String','')
% end

% --- Executes during object creation, after setting all properties.
function amount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temperature_Callback(hObject, eventdata, handles)
% hObject    handle to temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperature as text
%        str2double(get(hObject,'String')) returns contents of temperature as a double

% temperatureValue = get(hObject,'String');
% if ~ismember(str2double(temperatureValue),cardNums)
%     set(hObject,'String','')
% end


% --- Executes during object creation, after setting all properties.
function temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in methodchoice.
function methodchoice_Callback(hObject, eventdata, handles)
% hObject    handle to methodchoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns methodchoice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from methodchoice
handles.method = get(hObject,'Value');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function methodchoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to methodchoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
