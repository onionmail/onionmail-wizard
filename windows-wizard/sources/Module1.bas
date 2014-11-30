Attribute VB_Name = "Config"
DefLng A-Z


Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
                   (ByVal hWnd As Long, ByVal lpszOp As String, _
                    ByVal lpszFile As String, ByVal lpszParams As String, _
                    ByVal LpszDir As String, ByVal FsShowCmd As Long) _
                    As Long
                    
Private Declare Function GetDesktopWindow Lib "user32" () As Long
                                 
'Declare Function SHGetSpecialFolderLocation Lib "Shell32.dll" (ByVal hwndOwner As Long, ByVal nFolder As Long, pidl As ITEMIDLIST) As Long
'Declare Function SHGetPathFromIDList Lib "Shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Private Declare Function SHGetFolderPath Lib "shfolder" Alias "SHGetFolderPathA" (ByVal hwndOwner As Long, ByVal nFolder As Long, ByVal hToken As Long, ByVal dwFlags As Long, ByVal pszPath As String) As Long

Public Const MAX_PATH As Integer = 260
Global Const VALIDO = "1qazxsw23edcvfr45tgbnhy67ujmki89olp0"
Global Const VALID1 = VALIDO + "-_."

Global Pox As String
Global PAR As New Arrax

Const SW_SHOWNORMAL = 1
Const SE_ERR_FNF = 2&
Const SE_ERR_PNF = 3&
Const SE_ERR_ACCESSDENIED = 5&
Const SE_ERR_OOM = 8&
Const SE_ERR_DLLNOTFOUND = 32&
Const SE_ERR_SHARE = 26&
Const SE_ERR_ASSOCINCOMPLETE = 27&
Const SE_ERR_DDETIMEOUT = 28&
Const SE_ERR_DDEFAIL = 29&
Const SE_ERR_DDEBUSY = 30&
Const SE_ERR_NOASSOC = 31&
Const ERROR_BAD_FORMAT = 11&

Private Const CSIDL_ADMINTOOLS           As Long = &H30   '{user}\Start Menu _                                                        '\Programs\Administrative Tools
Private Const CSIDL_COMMON_ADMINTOOLS    As Long = &H2F   '(all users)\Start Menu\Programs\Administrative Tools
Private Const CSIDL_APPDATA              As Long = &H1A   '{user}\Application Data
Private Const CSIDL_COMMON_APPDATA       As Long = &H23   '(all users)\Application Data
Private Const CSIDL_COMMON_DOCUMENTS     As Long = &H2E   '(all users)\Documents
Private Const CSIDL_COOKIES              As Long = &H21
Private Const CSIDL_HISTORY              As Long = &H22
Private Const CSIDL_INTERNET_CACHE       As Long = &H20   'Internet Cache folder
Private Const CSIDL_LOCAL_APPDATA        As Long = &H1C   '{user}\Local Settings\Application Data (non roaming)
Private Const CSIDL_MYPICTURES           As Long = &H27   'C:\Program Files\My Pictures
Private Const CSIDL_PERSONAL             As Long = &H5    'My Documents
Private Const CSIDL_PROGRAM_FILES        As Long = &H26   'Program Files folder
Private Const CSIDL_PROGRAM_FILES_COMMON As Long = &H2B   'Program Files\Common
Private Const CSIDL_SYSTEM               As Long = &H25   'system folder
Private Const CSIDL_WINDOWS              As Long = &H24   'Windows directory or SYSROOT()
Private Const CSIDL_FLAG_CREATE = &H8000&                 'combine with CSIDL_ value to force
'Private Const MAX_PATH = 260

Private Const CSIDL_FLAG_MASK = &HFF00                    'mask for all possible flag values
Private Const SHGFP_TYPE_CURRENT = &H0                    'current value for user, verify it exists
Private Const SHGFP_TYPE_DEFAULT = &H1
Private Const S_OK = 0
Private Const S_FALSE = 1
Private Const E_INVALIDARG = &H80070057                   ' Invalid CSIDL Value
Global Const ACTION_WIZARD = ""

Public SERVERS As New Arrax
Public IPCounter As Integer
  
Public Type SHFILEOPSTRUCT
    hWnd As Long
    wFunc As Long
    pFrom As String
    pTo As String
    fFlags As Integer
    fAnyOperationsAborted As Long
    hNameMappings As Long
    lpszProgressTitle As Long ' only used if FOF_SIMPLEPROGRESS, sets dialog title
End Type
Public Declare Function SHFileOperation Lib "shell32.dll" Alias "SHFileOperationA" (lpFileOp As SHFILEOPSTRUCT) As Long
' Available Operations
Const FO_COPY = &H2 ' Copy File/Folder
Const FO_DELETE = &H3 ' Delete File/Folder
Const FO_MOVE = &H1 ' Move File/Folder
Const FO_RENAME = &H4 ' Rename File/Folder
' Flags
Const FOF_ALLOWUNDO = &H40 ' Allow to undo rename, delete ie sends to recycle bin
Const FOF_FILESONLY = &H80 ' Only allow files
Const FOF_NOCONFIRMATION = &H10 ' No File Delete or Overwrite Confirmation Dialog
Const FOF_SILENT = &H4 ' No copy/move dialog
Const FOF_SIMPLEPROGRESS = &H100 ' Does not display file names


Private blnTabellaCalcolata As Boolean
Private lngTabellaCRC(255) As Long

Private blnTabruttaCalcolata As Boolean
Private DeCrcTable(255) As Long

Private Const lngSemeCRC As Long = &HEDB88320
Private Const lngDefaultCRC As Long = &HFFFFFFFF

Global SuperRand As Long

Function ArleadyConfig(Srv$, Usr$) As Boolean
    db$ = PAR.IfItem("_USERDB", "wizard-usr.db")
    db$ = MapPath(db$)
    '8-4-4-4-12
    d0$ = Hex(SuperRand)
    
    St$ = HexP(CalcolaCRC(d0$ + LCase(Srv$ + vbCrLf + Usr$ + VALID1)))
    St$ = St$ + HexP(CalcolaCRC(d0$ + UCase(Srv$ + vbCrLf + Usr$ + vbTab + VALID1)))
    St$ = St$ + HexP(CalcolaCRC(UCase(Srv$ + vbCrLf + VALID1) + d0$))
    St$ = St$ + HexP(CalcolaCRC(UCase(St$ + Usr$ + vbCr + d0$ + vbTab + VALID1 + vbLf + Srv$)))
    St$ = St$ + String(32, 48)
    
    id$ = "{" + Mid(St$, 1, 8) + "-" + Mid(St$, 9, 4) + "-" + Mid(St$, 14, 4) + "-" + Mid(St$, 18, 4) + "-" + Mid(St$, 20, 12) + "}"
    
    txt$ = ""
    On Local Error GoTo rte1
        txt$ = Read(db$)
rsm:
On Local Error GoTo 0

    If InStr(txt$, id$) > 0 Then
        ArleadyConfig = True
        Exit Function
        End If
    
    Z = FreeFile
    Open db$ For Output As Z
    txt$ = txt$ + id$ + vbCrLf
    Print #Z, txt$;
    Close #Z
    ArleadyConfig = False
    Exit Function
rte1:
Resume rsm

End Function

Function HexP(ax) As String
    HexP = Hex(ax)
    HexP = Replace(HexP, "-", "")
End Function

Private Sub InizializzaTabella()
    Dim intBytes As Integer
    Dim intConta As Integer
    Dim lngTmpCRC As Long
    Dim lngValoreCRC As Long

    For intBytes = 0 To 255
        lngValoreCRC = intBytes
        For intConta = 0 To 7
            lngTmpCRC = (lngValoreCRC And &HFFFFFFFE) \ 2 And &H7FFFFFFF
            If lngValoreCRC And &H1 Then
                lngValoreCRC = lngTmpCRC Xor lngSemeCRC
            Else
                lngValoreCRC = lngTmpCRC
            End If
        Next intConta
        lngTabellaCRC(intBytes) = lngValoreCRC
    Next intBytes
    blnTabellaCalcolata = True
End Sub

Public Function CalcolaCRC(ByVal Buffer As String, Optional ByVal CRCPrecedente As Long = lngDefaultCRC, Optional UltimoCRC As Boolean = True) As Long
    Dim Carattere As Byte
    Dim Conta As Integer
    Dim Temp As Long
    Dim IndiceTabellaCRC As Long
    
    If blnTabellaCalcolata = False Then InizializzaTabella
    CalcolaCRC = CRCPrecedente
    For Conta = 1 To Len(Buffer)
        Carattere = Asc(Mid$(Buffer, Conta, 1))
        Temp = (CalcolaCRC And &HFFFFFF00) \ &H100 And &HFFFFFF
        IndiceTabellaCRC = Carattere Xor (CalcolaCRC And &HFF)
        CalcolaCRC = Temp Xor lngTabellaCRC(IndiceTabellaCRC)
    
    Next Conta
    If UltimoCRC = True Then CalcolaCRC = Not CalcolaCRC
End Function


Sub VBDelThree(ByRef strSource As String, visible As Boolean)

    Dim op As SHFILEOPSTRUCT
    With op
        .wFunc = FO_DELETE ' Set function
        .pTo = strSource
        .pFrom = strSource ' Set current path
        .fFlags = FOF_NOCONFIRMATION
    End With
    If visible Then op.fFlags = op.fFlags Or FOF_SIMPLEPROGRESS Else op.fFlags = op.fFlags Or FOF_SILENT
    ' Perform operation
    SHFileOperation op

End Sub

Sub XCopy(Src$, Dest$, mode$)
If Len(mode$) = 0 Then mode$ = UCase(PAR.IfItem("_XCOPYMODE", "DEF"))
f = 0
If mode$ = "XCOPY" Then
    Shell "xcopy /E /C /Q /Y " + Chr(34) + Src$ + Chr(34) + " " + Chr(34) + Dest$ + Chr(34), vbHide
    f = 1
    End If
    
If mode$ = "XCOPYV" Then
    Shell "xcopy /E /C /Q /Y " + Chr(34) + Src$ + Chr(34) + " " + Chr(34) + Dest$ + Chr(34), vbNormalFocus
    f = 1
    End If

If mode$ = "PROGRESS" Then
    VBCopyFolder Src$, Dest$, True
    f = 1
    End If
    
If f = 0 Then
    VBCopyFolder Src$, Dest$, False
    End If
    
End Sub

Sub VBCopyFolder(ByRef strSource As String, ByRef strTarget As String, visible As Boolean)

    Dim op As SHFILEOPSTRUCT
    With op
        .wFunc = FO_COPY ' Set function
        .pTo = strTarget ' Set new path
        .pFrom = strSource ' Set current path
        .fFlags = FOF_NOCONFIRMATION
    End With
    If visible Then op.fFlags = op.fFlags Or FOF_SIMPLEPROGRESS Else op.fFlags = op.fFlags Or FOF_SILENT
    ' Perform operation
    SHFileOperation op

End Sub

Function FileExists(ByVal Fname As String) As Boolean
    On Local Error Resume Next
    FileExists = Dir(Fname) <> ""
    If Not FileExists Then FileExists = Dir(Fname + "\") <> ""
    If Not FileExists Then FileExists = Dir(Fname, vbDirectory) <> ""
End Function

Sub DoConfig(Action As String, ServerName As String, Verbose As Boolean)
    Dim CheckIP As Boolean
    CheckIP = Len(ServerName) > 0
    Dim DoLock As Boolean
    DoLock = Verbose
    Dim newIP As Boolean
    Dim Fai As Boolean
    Dim oni As Arrax
    Set oni = New Arrax
    newIP = False
    
    Debug.Print "DoConfig '" + Action + "'"
    
    If CheckIP Then
        Pox = "Increasing counter"
        ip$ = LocalDHCP(ServerName, newIP)
        PAR.SetVal "IP", ip$
        Else
        ip$ = "127.0.0.1"
        newIP = False
        End If
    
    Pox = "Getting main config list"
    If Action <> "" Then Action1$ = "." + Action Else Action1$ = ""
    
    Dim Lst() As String
    ip$ = PAR.Item("_CONFIG" + Action1$)
    Lst = Split(ip$, ",")
    cx = UBound(Lst)
    'pat$ = PAR.Item("PATH")
    For ax = 0 To cx
        op$ = PAR.Item(Lst(ax) + ".OPT")
        If InStr(ip$, "IP") > 0 Then Fai = newIP Else Fai = True
        Append$ = ""
        
        If InStr(op$, "INC") > 0 Then
            Debug.Print "Include"
            Append$ = Read(MapPath(PAR.IfItem(Lst(ax) + ".INCLUDE", "_INCLUDE_")))
            End If
            
        If InStr(op$, "APP") > 0 Then
                For bx = 0 To 100
                t0$ = PAR.Item(Lst(ax) + ".WRITE" + CStr(bx))
                If t0$ = "" Then Exit For
                Append$ = Append$ + t0$ + vbCrLf
                Next
                End If
                
       ' Debug.Print "Conf "; Lst(ax), Fai
        fwin = 0
        If Fai Then
            lb$ = PAR.Item(Lst(ax) + ".CAPTION")
            If Verbose And lb$ <> "" Then Wizard.info = lb$: DoEvents
            lb$ = PAR.Item(Lst(ax) + ".WMSG")
            If lb$ <> "" Then
                Load API
                API.Etiquette lb$
                DoEvents
                fwin = 1
                End If
                
            Pox = "Getting configuration item named " + Lst(ax)
            Debug.Print "Wizard: " + lb$
            fi$ = PAR.Item(Lst(ax) + ".IN")
            If Len(fi$) Then
                If Asc(fi$) = 33 Then fi$ = Mid(fi$, 2) Else fi$ = MapPath(fi$)
        
                Fo$ = PAR.Item(Lst(ax) + ".OUT")
                If Asc(Fo$) = 33 Then Fo$ = Mid(Fo$, 2) Else Fo$ = MapPath(Fo$)
                
                Pox = "Configuring item named " + Lst(ax)
                FileConf fi$, Fo$, InStr(op$, "ACC") > 0, Append$, PAR.Item(Lst(ax) + ".EXEC")
                End If
            
            fi$ = PAR.Item(Lst(ax) + ".RUN")
            If Len(fi$) Then
                txt$ = ""
                TextProcessor txt$, fi$
                End If
                
            If fwin Then Unload API
            End If
        Next
        
    If Verbose Then
        Wizard.Command1.Left = (Wizard.Frame1.Width / 2) - (Wizard.Command1.Width / 2)
        Wizard.Command1.visible = True
        Wizard.info = PAR.IfItem("_COMPLETE", "Configuration complete")
        Wizard.infoend.visible = True
        End If
        
    If DoLock Then
        If PAR.Item("_LOCKFILE") <> "" Then
            Z = FreeFile
            Open MapPath(PAR.Item("_LOCKFILE")) For Output As Z
            Print #Z, 1
            Close #Z
            End If
    End If
    
    St$ = PAR.Item(Action + "._STARTEND")
    Debug.Print "StartEnd[`" + Action + "`] = `" + St$ + "`"
    If Len(St$) Then
        StartDoc MapPath(St$)
        Else
        St$ = PAR.Item("_STARTEND")
        Debug.Print "StartEnd `" + St$ + "`"
        If Len(St$) Then StartDoc MapPath(St$)
        End If
        
End Sub

Sub FileConf(fi$, Fo$, isClaws As Boolean, Append$, idx$)

    i = FreeFile
    Open fi$ For Input As #i
   
    txt$ = ""
    
    While Not EOF(i)
        Line Input #i, li$
        txt$ = txt$ + li$ + vbCrLf
        If Len(txt$) > 1048576 Then
            Close #i, #O
            Error 7
            End If
        Wend
    
    Close #i
    
    If Len(Append$) Then txt$ = txt$ + Append$ + vbCrLf
    
    O = FreeFile
    Open Fo$ For Output As #O
    Dim hacp As Boolean
    Dim canAcc As Boolean
    
    AccountPattern$ = PAR.Item("_ACCOUNTPATH")
    hacp = Len(AccountPattern$) > 0
    
    If isClaws Then
        CurAccount = 0
        
        For ax = 1 To 1000
            If Not hacp Then
                    canAcc = True
                    Else
                    st8$ = MapPath(Replace(AccountPattern$, "%#%", Chr(ax)))
                    canAcc = Not FileExists(st8$)
                    Debug.Print "AccDir"; ax, canAcc
                    End If
            
            If InStr(txt$, "[Account: " + CStr(ax) + "]") = 0 Then
                CurAccount = ax
                PAR.Rewind
                While PAR.Element(K$, V$)
                    a = Asc(K$ + " ")
                    If a = 35 Then
                        va$ = Replace(V$, "%#%", CStr(CurAccount))
                        ke$ = Mid(K$, 1)
                        PAR.SetVal ke$, va$
                        End If
                Wend
                PAR.SetVal "ACCOUNT", CStr(CurAccount)
              '  Debug.Print "Account ok"
            Exit For
            End If
        Next ax
        
        If CurAccount = 0 Then
            MsgBox "Too many accounts", vbCritical, "Error"
            End If
            
        End If
    
    PAR.Rewind
    While PAR.Element(K$, V$)
        If Asc(K$ + " ") <> 95 Then txt$ = Replace(txt$, "%" + K$ + "%", V$)
        Wend
     
    If Len(idx$) Then
        Debug.Print "FileConf TextProcessor `" + idx$ + "`"
        TextProcessor txt$, idx$
        End If
    
    Print #O, txt$
    Close #O
    txt$ = ""
    
End Sub

Function LocalDHCP(oni$, isNew As Boolean) As String
    isNew = False
    MagicNumber = &HF000F6C7
    oni$ = LCase(oni$)
    Z = FreeFile
    fil$ = MapPath(PAR.IfItem("_COUNTER", "wizard.cnt"))
    Open fil$ For Binary As Z
    Get #Z, 1, dd&
    If dd& <> MagicNumber Then
        SERVERS.Clear
        Randomize Timer
        IPCounter = Int(Rnd(Timer * 100) * 16384)
        Else
        Get #Z, , IPCounter
        SERVERS.Load Z
        End If
    Close #Z
    isNew = SERVERS.HasKey(oni$) = False
    
    ip$ = SERVERS.GetVal(oni$)
    If ip$ = "" Then
        IPCounter = 32767 And (IPCounter + 1&)
        ip$ = "127.0." + CStr(Int(IPCounter / 256) Mod 254) + "." + CStr(IPCounter Mod 254)
        SERVERS.SetVal oni$, ip$
        Open fil$ For Binary As Z
        dd& = MagicNumber
        Put #Z, 1, dd&
        Put #Z, , IPCounter
        SERVERS.Save Z
        Close #Z
        Else
    End If
    LocalDHCP = ip$
End Function

Function ToUnixTime(time As Date) As Long
ToUnixTime = DateDiff("s", DateSerial(1970, 1, 1), time)
End Function

Function ReadArray(fi$, parsable As Boolean) As String()
    Debug.Print "ReadArray `" + fi$ + "`"
    
    txt$ = Read(fi$)
    txt$ = Replace(txt$, vbCrLf, vbLf)
    If parsable Then
        txt$ = Replace(txt$, Chr(9), " ")
        For ax = 0 To 1000
            If InStr(txt$, "  ") = 0 Then Exit For
            txt$ = Replace(txt$, "  ", " ")
            Next ax
        End If
    
    Dim Lin() As String
    Lin = Split(txt$, vbLf)
    txt$ = ""
    If parsable Then
        u = UBound(Lin)
        For ax = 0 To u
            Lin(ax) = LTrim(RTrim(Lin(ax)))
            Lin(ax) = Replace(Lin(ax), "\#", Chr(8))
            Dim Tok() As String
            Tok = Split(Lin(ax), "#", 2)
            If UBound(Tok) > -1 Then Lin(ax) = Replace(Tok(0), Chr(8), "#")
            Next ax
        End If
        
    ReadArray = Lin
End Function

Function Read(fi$) As String
    i = FreeFile
    Open fi$ For Input As #i
   
    txt$ = ""
    
    While Not EOF(i)
        Line Input #i, li$
        txt$ = txt$ + li$ + vbCrLf
        If Len(txt$) > 1048576 Then
            Close #i, #O
            Error 7
            End If
        Wend
    
    Close #i
    Read = txt$
    
End Function

Public Function fGetSpecialFolder(lngCSIDL As Long, Status As Long) As String
    Dim strBuffer  As String
    Dim strPath    As String
    Dim lngReturn  As Long

    strPath = String(MAX_PATH, 0)
    lngReturn = SHGetFolderPath(0, lngCSIDL, 0, SHGFP_TYPE_CURRENT, strPath)
    
    Select Case lngReturn
        Case S_OK
            Status = 1
        
        Case S_FALSE
            Status = 0
        
        Case E_INVALIDARG
            Status = -1
        Case Else
            Stauts = -1
    End Select
    
    fGetSpecialFolder = Left$(strPath, InStr(1, strPath, Chr(0)) - 1)
    
End Function

Function StartDoc(DocName As String) As Long
    Dim Scr_hDC As Long
    Scr_hDC = GetDesktopWindow()
    Debug.Print "StartDoc `" + DocName + "`"
    StartDoc = ShellExecute(Scr_hDC, "Open", DocName, "", ".", SW_SHOWNORMAL)
End Function
    
Sub InitProc()

InizializzaTabella

PAR.SetVal "TIMESTAMP", ToUnixTime(Now)
PAR.SetVal "APPDATA", fGetSpecialFolder(CSIDL_APPDATA, St)
If St <> 1 Then
    MsgBox "Operating system incompatibility", vbCritical, "Error"
    End If
    
PAR.SetVal "CAPPDATA", fGetSpecialFolder(CSIDL_COMMON_APPDATA, St)
PAR.SetVal "HISTORY", fGetSpecialFolder(CSIDL_HISTORY, St)
PAR.SetVal "LOCALAPPDATA", fGetSpecialFolder(CSIDL_LOCAL_APPDATA, St)
PAR.SetVal "CAPPDATA", fGetSpecialFolder(CSIDL_COMMON_APPDATA, St)
    
Randomize Timer
t0$ = ""
cx = Len(VALIDO)
    For ax = 1 To 10
    r = Int(Rnd(ax + Timer * 100) * cx)
    r = 1 + (r Mod cx)
    t0$ = t0$ + Mid(VALIDO, r, 1)
    Next ax
    
PAR.SetVal "RANDOM", t0$
t0$ = ""
    
Pox = "Parsing configuration of wizard"

fi$ = MapPath(PAR.IfItem("_WIZARDFILE", "wizard.conf"))

If Not FileExists(fi$) Then
    MsgBox "Can't find the configuration file:" + vbCrLf + fi$, vbCritical, "Error"
    End
    End If
    
Z = FreeFile
Open fi$ For Input As Z
Dim Tok() As String
While Not EOF(Z)
    Line Input #Z, cmd$
    If Len(cmd$) Then
        cmd$ = LTrim(RTrim(cmd$))
        If cmd$ <> "" Then
            Tok = VBA.Split(cmd$, "=", 3, vbBinaryCompare)
            If UBound(Tok) < 1 Then Error 2
            cm$ = Tok(0)
            cm$ = LTrim(RTrim(cm$))
            li$ = Tok(1)
            li$ = LTrim(RTrim(li$))
            If cm$ = "@PATH" Then
                cm$ = "PATH"
                li$ = PAR.Item("PATH") + "\" + li$
                End If
            If cm$ = "@ENV" Then
                cm$ = li$
                li$ = Environ$(RTrim(Tok(2)))
                End If
                
            If cm$ = "@ADD" Then
                cm$ = li$
                li$ = PAR.Item(li$) + PAR.Item((RTrim(Tok(2))))
                End If
                
            If cm$ = "@_HELPDOC" Then
                cm$ = "_HELPDOC"
                li$ = MapPath(li$)
                End If
                
            PAR.SetVal cm$, li$
          '  Debug.Print ">", cm$, li$
            End If
        End If
    Wend
Close #Z

Dim ks() As String
ks = PAR.KeySet
mks = UBound(ks)
    For ax = 0 To mks
    V$ = PAR.ValId(ax)
   
            For bx = 0 To mks
            V$ = Replace(V$, "$" + ks(bx) + "$", PAR.ValId(bx))
            Next bx
        PAR.setValId ax, V$

    Next ax

St0$ = MapPath(PAR.IfItem("_MYPATHDATA", "!" + Environ$("APPDATA") + "\OnionMail"))

If Not FileExists(St0$) Then
    t0$ = Pox
    Pox = "Creating my app path `" + St0$ + "`"
    MkDir St0$
    Pox = t0$
    t0$ = ""
    End If

If PAR.Item("_LOCKFILE") <> "" Then
    fi$ = MapPath(PAR.Item("_LOCKFILE"))
    If FileExists(fi$) Then Kill fi$
    End If
    
fi$ = MapPath(PAR.IfItem("_RNDFILE", "uidgen.rnd"))
Debug.Print "RNDFILE `"; fi$; "`"

Z = FreeFile
Open fi$ For Binary As Z
Get #Z, 1, SuperRand

If SuperRand = 0 Then
    Randomize Timer
        
        For a = 0 To 8
        r = Int(Rnd(Timer * 100) * 256) And 255
        r = r * &H100000
        SuperRand = SuperRand Xor Int(SuperRand / 2) Xor r
        Next
        
        For ax = 0 To 4
        SuperRand = SuperRand Xor Int(Rnd(Timer * 100) * &H7FFFFFFF)
        Next ax
        
    Put #Z, 1, SuperRand
        For ax = 0 To 4
        c$ = Chr(255 And Int(Rnd(Timer * 100) * 256))
        Put #Z, , c$
        Next ax
        
    Get #Z, 1, SuperRand
    End If
    Get #Z, , dd&
    SuperRand = SuperRand Xor dd&
    Close #Z

End Sub

Sub TextProcessor(txt$, idx$)

    Dim Lin() As String
    Dim Rflag As Boolean
    Dim Looper As Arrax
    Dim MLooper As Arrax
    Dim Labels As Arrax
    Dim Regs As Arrax
    Set Regs = New Arrax
    Set Looper = New Arrax
    Set MLooper = New Arrax
    Set Looper = New Arrax
    Set Labels = New Arrax
    Debug.Print "TextProcessor `" + idx$ + "`"
    Lin = ReadArray(MapPath(idx$), True)
    Regs.SetVal "TEXT", txt$
    MaxLin = UBound(Lin)
    Dim Tok() As String
    Dim Bit(7) As Boolean
    Dim Stack(25)
    esp = 0
        For ax = 0 To MaxLin
            If Asc(Lin(ax) + " ") = &H3A Then
                Tok = Split(Lin(ax), " ")
                t0$ = LTrim(RTrim(Mid(Tok(0) + " ", 2)))
                Labels.SetVal t0$, CStr(ax)
                Looper.SetVal t0$, "0"
                If UBound(Tok) = 1 Then n0 = Val(Tok(1)) Else n0 = 3
                MLooper.SetVal t0$, CStr(n0)
                End If
        Next
     
     For eip = 0 To MaxLin
            
            Dim Lpar() As String
            cLin$ = Replace(Lin(eip), "\,", Chr(0))
            cLin$ = Replace(cLin$, Chr(9), " ")
            cLin$ = LTrim(RTrim(cLin$))
            If cLin$ <> "" Then
                Lpar = Split(cLin$, " ", 2)
                
                Debug.Print "S> "; eip, cLin$
                
                u = UBound(Lpar)
                cmd$ = UCase(LTrim(RTrim(Lpar(0))))
                
                If u > 0 Then
                    t0$ = Lpar(1)
                    Lpar = Split(cmd$ + "," + t0$, ",")
                    Else
                    ReDim Lpar(0)
                    End If
                
                u = UBound(Lpar)
                For ua = 0 To u
                    Lpar(ua) = Replace(Lpar(ua), Chr(0), ",")
                    Lpar(ua) = LTrim(RTrim(Lpar(ua)))
                    If ua = 0 Then Lpar(ua) = UCase(Lpar(ua))
                    Next ua
                                
                If cmd$ = "CALL" Or cmd$ = "CALLZ" Or cmd$ = "CALLNZ" Then iscall = 1 Else iscall = 0
                                
                If iscall Or cmd$ = "JMP" Or cmd$ = "JZ" Or cmd$ = "JNZ" Then
                    Dim jmpf As Boolean
                    Dim iscal As Boolean
                    jmpf = True
                    t0$ = Lpar(1)
                    
                    If cmd$ = "JZ" Then jmpf = Rflag
                    If cmd$ = "JNZ" Then jmpf = Not Rflag
                    If cmd$ = "CALLZ" Then jmpf = Rflag
                    If cmd$ = "CALLNZ" Then jmpf = Not Rflag
                        
                    If jmpf Then
                        
                        If iscall Then
                            If esp > UBound(Stack) Then
                                MsgBox "Stack Overflow", vbCritical, idx$
                                Error 1
                                End If
                            Stack(esp) = eip + 1
                            esp = esp + 1
                                                       
                            End If
                        
                        t1$ = Labels.Item(t0$)
                        eip = Val("0" + t1$)
                        Debug.Print , "JMP ", iscall, t0$, eip
                       
                        If t1$ = "" Then
                            MsgBox "Udefinited label jump " + t0 + " in " + idx$ + " line " + CStr(eip + 1), vbCritical, "Error"
                            Error 1
                            End If
                            
                        n0 = Val("0" + Looper.Item(t0$))
                        n0 = n0 + 1
                        Looper.SetVal t0$, CStr(n0)
                        If n0 > Val("0" + MLooper.IfItem(t0$, "3")) Then
                            MsgBox "Too many jump to " + t0$ + " in " + idx$ + " line " + CStr(eip + 1), vbCritical, "Error"
                            Error 1
                            End If
                        
                        End If
                    End If
                                
                If cmd$ = "RET" Then
                    esp = esp - 1
                    If esp < 0 Then
                        MsgBox "Stack Overflow", vbCritical, idx$
                        Error 1
                        End If
                    eip = Stack(esp) - 1
                    Debug.Print "ret", esp, eip
                    End If
                    
                If cmd$ = "SET" And u = 2 Then Regs.SetVal Lpar(1), Lpar(2)
                If cmd$ = "MOV" And u = 2 Then Regs.SetVal Lpar(1), Regs.Item(Lpar(2))
                If cmd$ = "MOVP" And u = 2 Then PAR.SetVal Lpar(1), Regs.Item(Lpar(2))
                If cmd$ = "MOVR" And u = 2 Then Regs.SetVal Lpar(1), PAR.Item(Lpar(2))
                If cmd$ = "MOVPP" And u = 2 Then PAR.SetVal Lpar(1), PAR.Item(Lpar(2))
                If cmd$ = "ADDI" And u = 2 Then Regs.SetVal Lpar(1), Regs.Item(Lpar(1)) + Lpar(2)
                If cmd$ = "ADDIU" And u = 2 Then Regs.SetVal Lpar(1), Regs.Item(Lpar(1)) + Lpar(2) + vbCrLf
                If cmd$ = "ADD" And u = 2 Then Regs.SetVal Lpar(1), Regs.Item(Lpar(1)) + Regs.Item(Lpar(2))
                If cmd$ = "ADDR" And u = 2 Then Regs.SetVal Lpar(1), Regs.Item(Lpar(1)) + Regs.Item(Lpar(2)) + vbCrLf
                If cmd$ = "LOAD" And u = 2 Then
                        Debug.Print "EXtrn Load `" + Lpar(2) + "`"
                        Regs.SetVal Lpar(1), Read(MapPath(Lpar(2), Regs))
                        End If
                
                If cmd$ = "MPATH" And u = 1 Then Regs.SetVal Lpar(1), MapPath(Lpar(1), Regs)
                
                If cmd$ = "REP" And u = 3 Then Regs.SetVal Lpar(1), Replace(Regs.Item(Lpar(1)), Lpar(2), Lpar(3))
                If cmd$ = "REPZ" And u = 3 Then Regs.SetVal Lpar(1), Replace(Regs.Item(Lpar(1)), Lpar(2), Regs.Item(Lpar(3)))
                If cmd$ = "CMP" And u = 2 Then Rflag = Regs.Item(Lpar(1)) = Regs.Item(Lpar(2))
                If cmd$ = "CMPS" And u = 2 Then Rflag = Regs.Item(Lpar(1)) = Lpar(2)
                If cmd$ = "ENV" And u = 2 Then Regs.SetVal (Lpar(1)), Environ$(Lpar(2))
                If cmd$ = "INST" And u = 2 Then Rflag = InStr(Regs.Item(Lpar(1)), Lpar(2)) > 0
                If cmd$ = "INSR" And u = 2 Then Rflag = InStr(Regs.Item(Lpar(1)), Regs.Item(Lpar(2))) > 0
                If cmd$ = "LD" And u = 2 Then Rflag = Regs.Item(Lpar(1)) = PAR.Item(Lpar(2))
                If cmd$ = "LP" And u = 1 Then Looper.SetVal Lpar(1), "0"
                If cmd$ = "CLI" And u = 1 Then Regs.SetVal Lpar(1), ""
                If cmd$ = "SLASH" And u = 1 Then Regs.SetVal Lpar(1), Replace(Regs.Item(Lpar(1)), "\", "\\")
                If cmd$ = "USLASH" And u = 1 Then Regs.SetVal Lpar(1), Replace(Regs.Item(Lpar(1)), "\\", "\")
                If cmd$ = "PAR" And u = 2 Then PAR.SetVal Lpar(1), Lpar(2)
                If cmd$ = "REG" And u = 2 Then Regs.SetVal Lpar(1), PAR.Item(Lpar(2))
                If cmd$ = "EMP" And u = 1 Then Rflag = Len(Regs.Item(Lpar(1))) = 0
                If cmd$ = "COPY" And u = 2 Then FileCopy MapPath(Lpar(1)), MapPath(Lpar(2), Regs)
                If cmd$ = "RMDIR" And u = 1 Then VBDelThree MapPath(Lpar(1), Regs), False
                If cmd$ = "RRMDIR" And u = 1 Then VBDelThree MapPath(Regs.Item(Lpar(1)), Regs), False
                
                If cmd$ = "LODSB" And u = 2 Then
                    t0$ = Lpar(2)
                    n0 = Len(t0$)
                    t0$ = t0$ + "0"
                    t1$ = ""
                        For ax = 1 To n0 Step 2
                        n1 = Val("&H" + Mid(t0$, ax, 2))
                        t1$ = t1$ + Chr(n1 And 255)
                        Next ax
                    Regs.SetVal Lpar(1), t1$
                    t1$ = ""
                    End If
                
                If cmd$ = "SAVE" And u = 2 Then
                    t0$ = MapPath(Lpar(1), Regs)
                    Z = FreeFile
                    Debug.Print , "Save '"; t0$; "'"
                    Open t0$ For Output As Z
                    t0$ = Regs.Item(Lpar(2))
                    Print #Z, t0$;
                    Close #Z
                    t0$ = ""
                    End If
                
                If cmd$ = "WMSG" And u = 1 Then
                    Load API
                    API.Etiquette Lpar(1)
                    End If
                    
                If cmd$ = "CMSG" Then Unload API
                    
                If cmd$ = "RXCOPY" And u = 2 Then
                                Debug.Print "FileCopy '"; Regs.Item(Lpar(1)); "'", "'"; Regs.Item(Lpar(2)); "'"
                                'FileCopy Regs.Item(Lpar(1)), Regs.Item(Lpar(2))
                                XCopy Regs.Item(Lpar(1)), Regs.Item(Lpar(2)), ""
                                End If
                
                If cmd$ = "RXCOPYM" And u = 2 Then
                                Debug.Print "FileCopy '"; Regs.Item(Lpar(1)); "'", "'"; Regs.Item(Lpar(2)); "'"
                                'FileCopy Regs.Item(Lpar(1)), Regs.Item(Lpar(2))
                                XCopy MapPath(Regs.Item(Lpar(1))), MapPath(Regs.Item(Lpar(2))), ""
                                End If
                
                If cmd$ = "XCOPYM" And u = 2 Then
                                Debug.Print "FileCopy '"; Lpar(1); "'", "'"; Lpar(2); "'"
                                'FileCopy Regs.Item(Lpar(1)), Regs.Item(Lpar(2))
                                XCopy MapPath(Lpar(1)), MapPath(Lpar(2)), ""
                                End If
                
                If cmd$ = "EXIST" And u = 1 Then
                    Rflag = FileExists(Lpar(1))
                    Debug.Print "exists ", Rflag, "'" + Lpar(1) + "'"
                    End If
                    
                If cmd$ = "REXIST" And u = 1 Then
                    Rflag = FileExists(Regs.Item(Lpar(1)))
                    Debug.Print "exists ", Rflag, "'" + Regs.Item(Lpar(1)) + "'"
                    End If
                    
                If cmd$ = "NEG" Then Rflag = Rflag Xor True
                If cmd$ = "BIT" And u = 2 Then Bit(7 And Lpar(1)) = Val("0" + Lpar(2)) <> 0
                If cmd$ = "LBIT" And u = 1 Then Rflag = Bit(7 And Lpar(1))
                If cmd$ = "SBIT" And u = 1 Then Bit(7 And Lpar(1)) = Rflag
                
                If cmd$ = "AND" And u = 2 Then Bit(7 And Lpar(1)) = Bit(7 And Lpar(1)) And Bit(7 And Lpar(2))
                If cmd$ = "OR" And u = 2 Then Bit(7 And Lpar(1)) = Bit(7 And Lpar(1)) Or Bit(7 And Lpar(2))
                If cmd$ = "XOR" And u = 2 Then Bit(7 And Lpar(1)) = Bit(7 And Lpar(1)) Xor Bit(7 And Lpar(2))
                If cmd$ = "NAND" And u = 2 Then Bit(7 And Lpar(1)) = True Xor (Bit(7 And Lpar(1)) And Bit(7 And Lpar(2)))
                If cmd$ = "NOR" And u = 2 Then Bit(7 And Lpar(1)) = True Xor (Bit(7 And Lpar(1)) Or Bit(7 And Lpar(2)))
                
                If cmd$ = "MKDIR" And u = 1 Then
                        s4$ = Regs.Item(Lpar(1))
                        If Not FileExists(s4) Then Shell "cmd /C mkdir " + Chr(34) + Regs.Item(Lpar(1)) + Chr(34), vbHide
                        End If
                
                If cmd$ = "ERR" And u = 1 Then
                    MsgBox Lpar(1), vbCritical, "Error"
                    Error 1
                    End If
                    
                If cmd$ = "MSG" And u = 2 Then MsgBox Lpar(1), vbInformation, Lpar(2)
                If cmd$ = "MSGR" And u = 2 Then MsgBox Regs.Item(Lpar(1)), vbInformation, Lpar(2)
                If cmd$ = "MSGF" And u = 2 And Rflag Then MsgBox Lpar(1), vbInformation, Lpar(2)
                If cmd$ = "MSGNF" And u = 2 And Not Rflag Then MsgBox Lpar(1), vbInformation, Lpar(2)
                If cmd$ = "REQ" And u = 2 Then Rflag = MsgBox(Lpar(1), vbQuestion + vbYesNo, Lpar(2)) = vbYes
                If cmd$ = "INP" And u = 4 Then Regs.SetVal Lpar(1), InputBox(Lpar(2), Lpar(3), Lpar(4))
                If cmd$ = "EXIT" Then
                    Close
                    End
                    End If
                    
                If cmd$ = "RPAR" And u = 2 Then PAR.SetVal Lpar(1), Regs.Item(Lpar(2))
                If cmd$ = "EVAL" And u = 1 Then
                        t0$ = Regs.Item(Lpar(1))
                        PAR.Rewind
                            While PAR.Element(K$, V$)
                            If Asc(K$ + " ") <> 95 Then t0$ = Replace(t0$, "%" + K$ + "%", V$)
                            Wend
                        Regs.SetVal Lpar(1), t0$
                    End If
                    
                If cmd$ = "END" Then Exit For
                End If
            Next eip
        
        txt$ = Regs.Item("TEXT")
End Sub
    
Sub Main()
Pox = "Starting program"
On Error GoTo ErrorHandler
On Local Error GoTo ErrorHandler
On Error GoTo ErrorHandler

Set PAR = New Arrax
PAR.SetVal "_CONFIG", ""
PAR.SetVal "PATH", App.Path
PAR.SetVal "_VERSION", CStr(App.Major) + "." + CStr(App.Minor) + "." + CStr(App.Revision)
PAR.SetVal "TORIP", "127.0.0.1"
PAR.SetVal "TORPORT", "9154"
PAR.SetVal "TORTIME", "20"
PAR.SetVal "_XCOPYMODE", "DEF"
PAR.SetVal "TORPRETIME", "2"

If Command$ = "-SETUP" Then
    St$ = "@echo off" + vbCrLf + "set MYPATH=" + App.Path + vbCrLf + "cd /D " + App.Path + vbCrLf
    Open App.Path + "\autopath.bat" For Output As 1
    Print #1, St$
    Close #1
    End
    End If

Dim Tok(256) As String
cm$ = Command$
cm$ = Replace(cm$, "\""", Chr(8))

cx = Len(cm$)
bp = 0

Dim vf As Boolean
    For ax = 1 To cx
    ch$ = Mid(Command$, ax, 1)
    If ch$ = Chr(34) Then
        vf = vf Xor True
        Else
        If vf = False And ch$ = " " Then
            bp = bp + 1
            If bp > 255 Then Exit For
            Else
            If ch$ = Chr(8) Then ch = Chr(34)
            Tok(bp) = Tok(bp) + ch$
            End If
        End If
    Next ax
    
PAR.SetVal "_WIZARDFILE", "wizard.conf"
PAR.SetVal "_WIZARDACTION", ""
Verbose = True

    For ax = 0 To bp
    
    If Tok(ax) = "-ap" Then
        ChDrive Mid(App.Path, 1, 1) + ":"
        ChDir App.Path
        End If
    
    If Tok(ax) = "-apx" Then
        ChDrive Mid(App.Path, 1, 1) + ":"
        ChDir App.Path
        End
        End If
    
    If Tok(ax) = "-exit" Then End
    
    If Tok(ax) = "-box" Then
        MsgBox Tok(ax + 1), vbInformation, "OnionMail"
        End
        End If
        
    If Tok(ax) = "-err" Then
        MsgBox Tok(ax + 1), vbCritical + vbOKOnly, "OnionMail"
        End
        End If
       
    If Tok(ax) = "-s" Then
        ax = ax + 1
        PAR.SetVal "_WIZARDACTION", Tok(ax)
        End If
        
    If Tok(ax) = "-ti" Then
        ax = ax + 1
        PAR.SetVal "TORIP", Tok(ax)
        End If
    
    If Tok(ax) = "-tp" Then
        ax = ax + 1
        PAR.SetVal "TORPORT", Tok(ax)
        End If
                
    If Tok(ax) = "-tr" Then
        ax = ax + 1
        PAR.SetVal "TORPRETIME", Tok(ax)
        End If
                
    If Tok(ax) = "-tt" Then
        ax = ax + 1
        PAR.SetVal "TORTIME", Tok(ax)
        End If
                
    If Tok(ax) = "-ttt" Then
        Load API
        API.IPAddress = PAR.IfItem("TORIP", "127.0.0.1")
        API.Port = Val("0" + PAR.IfItem("TORPORT", "9154"))
        API.TTL = 2 * Val("0" + PAR.IfItem("TORTIME", "20"))
        API.PreTime = Val("0" + PAR.IfItem("TORPRETIME", "2"))
        API.Show
        API.DoTest
        Exit Sub
        End If
                
    If Tok(ax) = "-f" Then
        ax = ax + 1
        PAR.SetVal "_WIZARDFILE", Tok(ax)
        End If
        
    If Len(Tok(ax)) > 2 And InStr(Tok(ax), "-p") = 1 Then
        t0$ = Mid$(Tok(ax), 3)
        ax = ax + 1
        PAR.SetVal t0$, Tok(ax)
        End If
        
    If Tok(ax) = "-h" Then Verbose = False
    Next
    
InitProc
    
St$ = PAR.Item("_ERRORFILE")
If Len(St$) Then
    St$ = MapPath(St$)
    If FileExists(St$) Then Kill St$
    End If
    
Verbose = Val("0" + PAR.IfItem("_SHOW", "1")) <> 0
    
If Verbose Then
    Load Pres
    Set Pres.Icon = Wizard.Icon
    Pres.Show
    Else
    DoConfig PAR.Item("_WIZARDACTION"), PAR.Item("SERVERNAME"), False
    End
    End If

Exit Sub

ErrorHandler:

If Err.Number = 1 Then End
MsgBox "Run-Time error:" & vbCrLf & Err.Number & " " & Err.Description & vbCrLf & "When " & Pox & vbCrLf & "Retry with another configuration", vbCritical, "Fatal error"
Close
Resume resu1
resu1:

St$ = PAR.Item("_ERRORFILE")
If Len(St$) Then
    Close
    Z = FreeFile
    Open MapPath(St$) For Output As Z
    Print #Z, "Error, "; Err.Number; ", "; Err.Description
    Print #Z, "When,"; Pox
    Print #Z, "Date,";
    Print #Z, ToUnixTime(Now)
    Print #Z, "DATA:"
    PAR.Rewind
    While PAR.Element(K$, V$)
        Print #Z, "K: "; K$
        Print #Z, "V:", V$
        Wend
    Close #Z
    End If

St$ = PAR.Item("_STARTERRO")
    If Len(St$) Then
        St$ = MapPath(St$)
        StartDoc St$
        End If

End
End Sub

Function MapPath(St$, Optional escp As Arrax = Nothing) As String
    
    If Not escp Is Nothing Then
        cx = escp.MaxBound
            For ax = 0 To cx
            St$ = Replace(St$, "%" + escp.KeyId(ax) + "%", escp.ValId(ax))
            Next
        End If
        
    If Asc(St$) = &H21 Then
        MapPath = Mid(St$, 2)
        Exit Function
        End If
    
    If Asc(St$) = &H2A Then
        St$ = Mid(St$, 2)
        cx = PAR.MaxBound
        For ax = 0 To cx
            St$ = Replace(St$, "$" + PAR.KeyId(ax) + "$", PAR.ValId(ax))
            Next ax
        MapPath = St$
        Exit Function
        End If
    MapPath = PAR.Item("PATH") + "\" + St$
End Function
