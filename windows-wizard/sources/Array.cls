VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Arrax"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
DefLng A-Z
Dim Keys() As String
Dim Vals() As String
Const Magic = &H900E1A04
Private Cursor As Integer

Public Sub Clear()
    ReDim Keys(0) As String
    ReDim Vals(0) As String
    Cursor = 0
End Sub

Public Sub Rewind()
    Cursor = 0
End Sub

Public Function Position() As Integer
    Position = Cursor - 1
End Function

Public Function Element(K$, V$) As Boolean
    Element = (Cursor <= UBound(Keys))
    If Element Then
        K$ = Keys(Cursor)
        V$ = Vals(Cursor)
        Cursor = Cursor + 1
        Else
        K$ = ""
        V$ = ""
        End If
End Function

Private Function GetId(K$) As Integer
    cx = UBound(Keys)
    For ax = 0 To cx
    If Keys(ax) = K$ Then
        GetId = ax
        Exit Function
        End If
    Next
    GetId = -1
End Function

Public Function HasKey(K$) As Boolean
    HasKey = GetId(K$) <> -1
End Function

Public Function KeySet() As String()
   KeySet = Keys
End Function

Public Function ValId(id) As String
    ValId = Vals(id)
End Function

Public Sub setValId(id, vl$)
    Vals(id) = vl$
End Sub

Public Function KeyId(id) As String
    KeyId = Keys(id)
End Function

Public Function MaxBound() As Integer
    MaxBound = UBound(Keys)
End Function

Public Sub SetVal(K$, V$)
    id = GetId(K$)
    If id = -1 Then
        u = UBound(Keys) + 1
        ReDim Preserve Keys(u)
        ReDim Preserve Vals(u)
        Keys(u) = K$
        Vals(u) = V$
        Else
        Vals(id) = V$
        End If
End Sub

Public Function Item(K$) As String
    id = GetId(K$)
    If id <> -1 Then Item = Vals(id)
  
End Function

Public Function GetVal(K$) As String
    id = GetId(K$)
    If id <> -1 Then GetVal = Vals(id)
  
End Function

Public Function IfItem(K$, E$) As String
    id = GetId(K$)
    If id <> -1 Then IfItem = Vals(id) Else IfItem = E$
  
End Function

Public Sub Save(H)
    dd& = Magic
    Put #H, , dd&
    u% = UBound(Keys)
    Put #H, , u%
    For ax = 0 To u%
        lk% = Len(Keys(ax))
        lv% = Len(Vals(ax))
        Put #H, , lk%
        Put #H, , Keys(ax)
        Put #H, , lv%
        Put #H, , Vals(ax)
        c% = &H7FFF And (ax + lk + lv)
        Put #H, , c%
    Next
End Sub

Public Sub Load(H)
    Get #H, , dd&
    If dd& <> Magic Then Error 5
    Get #H, , u%
    ReDim Keys(u%)
    ReDim Vals(u%)
    Cursor = 0
    For ax = 0 To u%
        Get #H, , lk%
        Keys(ax) = Space(lk%)
        Get #H, , Keys(ax)
        Get #H, , lv%
        Vals(ax) = Space(lv%)
        Get #H, , Vals(ax)
        c% = &H7FFF And (ax + lk + lv)
        Get #H, , Vr%
        If Vr% <> c% Then Error 5
        Next
End Sub

Private Sub Class_Initialize()
Clear
End Sub

Public Sub ToDebug()
u = UBound(Keys)
Debug.Print "ArraX:"
    For a = 0 To u
    Debug.Print a, "'" + Keys(a) + "'", ">", "'" + Vals(a) + "'"
    Next
    
End Sub

