function varargout = OutilDeGestionGraphicalUserInterfaceTable(varargin)
% OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE MATLAB code for OutilDeGestionGraphicalUserInterfaceTable.fig
%      OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE, by itself, creates a new OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE or raises the existing
%      singleton*.
%
%      H = OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE returns the handle to a new OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE or the handle to
%      the existing singleton*.
%
%      OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE.M with the given input arguments.
%
%      OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE('Property','Value',...) creates a new OUTILDEGESTIONGRAPHICALUSERINTERFACETABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OutilDeGestionGraphicalUserInterfaceTable_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OutilDeGestionGraphicalUserInterfaceTable_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OutilDeGestionGraphicalUserInterfaceTable

% Last Modified by GUIDE v2.5 03-Dec-2014 16:00:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OutilDeGestionGraphicalUserInterfaceTable_OpeningFcn, ...
                   'gui_OutputFcn',  @OutilDeGestionGraphicalUserInterfaceTable_OutputFcn, ...
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


% --- Executes just before OutilDeGestionGraphicalUserInterfaceTable is made visible.
function OutilDeGestionGraphicalUserInterfaceTable_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OutilDeGestionGraphicalUserInterfaceTable (see VARARGIN)

% Choose default command line output for OutilDeGestionGraphicalUserInterfaceTable
handles.output = hObject;

% UIWAIT makes decisionTable wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% create the tables based on user input and save the output data to be
% returned to blackjackGUI
amount = varargin(1);
amount = amount{1,1};
temperature = varargin(2);
temperature = temperature{1,1};
method = varargin(3);
method = method{1,1};
if method == 1
    ctemp = OutilDeGestionV2(amount, temperature, false);
else
    ctemp = OutilDeGestionPurge(amount,temperature,800,270,4,false);
end
tubenumber = ctemp(1);
% combine data with blank lines
 MCH4 = 16.05;
 MH2O = 18.02;
 MO2 = 32;
 MCO = 28.01;
 MCO2 = 44.01;
 MH2 = 2.02;
 MN2 = 28.02;
 MAr = 39.95;
 MNH3 = 17.04;
 fact = 0.0864; %Passe de secondes en jours et divise par 1000000 pour passer de grammes a des Tonnes 
 chemicalData = [repmat({' '},1,2);
     {ctemp(2)},{ctemp(2)*fact*MCH4};
     {ctemp(3)},{ctemp(3)*fact*MH2O};
     repmat({' '},1,2);
     {ctemp(4)},{ctemp(4)*fact*MCH4};
     {ctemp(5)},{ctemp(5)*fact*MO2};
     repmat({' '},1,2);
     repmat({' '},1,2);
     {ctemp(6)},{ctemp(6)*fact*MCH4};
     {ctemp(7)},{ctemp(7)*fact*MH2O};
     {ctemp(8)},{ctemp(8)*fact*MCO};
     {ctemp(9)},{ctemp(9)*fact*MCO2};
     {ctemp(10)},{ctemp(10)*fact*MH2};
     {ctemp(11)},{ctemp(11)*fact*MO2};
     {ctemp(12)},{ctemp(12)*fact*MN2};
     {ctemp(13)},{ctemp(13)*fact*MAr};
     repmat({' '},1,2);
     repmat({' '},1,2);
     {ctemp(14)},{ctemp(14)*fact*MCO};
     {ctemp(15)},{ctemp(15)*fact*MCO2};
     {ctemp(16)},{ctemp(16)*fact*MN2};
     {ctemp(17)},{ctemp(17)*fact*MH2};
     {ctemp(18)},{ctemp(18)*fact*MAr};
     {ctemp(19)},{ctemp(19)*fact*MH2O};
     repmat({' '},1,2);
     repmat({' '},1,2);
     {ctemp(20)},{ctemp(20)*fact*MCO2};
     {ctemp(21)},{ctemp(21)*fact*MN2};
     {ctemp(22)},{ctemp(22)*fact*MH2};
     {ctemp(23)},{ctemp(23)*fact*MAr};
     {ctemp(24)},{ctemp(24)*fact*MH2O};
     repmat({' '},1,2);
     repmat({' '},1,2);
     {ctemp(25)},{ctemp(25)*fact*MN2};
     {ctemp(26)},{ctemp(26)*fact*MH2};
     {ctemp(27)},{ctemp(27)*fact*MAr};
     {ctemp(28)},{ctemp(28)*fact*MNH3}];
set(handles.tablo,'data',chemicalData); 
set(handles.tubes,'String',tubenumber);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OutilDeGestionGraphicalUserInterfaceTable wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OutilDeGestionGraphicalUserInterfaceTable_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function tubes_Callback(hObject, eventdata, handles)
% hObject    handle to tubes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tubes as text
%        str2double(get(hObject,'String')) returns contents of tubes as a double


% --- Executes during object creation, after setting all properties.
function tubes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tubes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
