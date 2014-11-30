VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form API 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   645
   ClientLeft      =   45
   ClientTop       =   45
   ClientWidth     =   5910
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   43
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   394
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   4680
      Top             =   0
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   5220
      Top             =   0
   End
   Begin MSWinsockLib.Winsock Sok 
      Left            =   120
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemoteHost      =   "127.0.0.1"
      RemotePort      =   9154
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Wait for TOR ..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C000C0&
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Top             =   180
      Width           =   5715
   End
End
Attribute VB_Name = "API"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
DefLng A-Z

Public IPAddress As String
Public Port As Integer
Public TTL As Integer
Public PreTime As Integer
Public Status As Integer
Private mode As Boolean

Public Sub DoTest()
If PreTime = 0 Then
    DoTestEx
    Else
    Timer2.Interval = 1000 * PreTime
    Timer2.Enabled = True
    End If
  
End Sub

Public Sub DoTestEx()
Status = 1
Sok.Connect IPAddress, Port
Label1.ForeColor = QBColor(9)
End Sub

Public Sub Etiquette(Msg$)
Timer1.Enabled = False
Label1.Caption = Msg$
Label1.ForeColor = QBColor(1)
mode = True
Me.visible = True
End Sub

Private Sub Sok_Connect()
Status = 2
Sok.Close
If Not mode Then End
End Sub

Private Sub Sok_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
Sok.Close
Status = 0
End Sub

Private Sub Timer1_Timer()
TTL = TTL - 1

If Status = 0 Then
    If TTL < 0 Then
        Timer1.Enabled = False
        MsgBox "Cant connect to TOR at " + IPAddress + ":" + CStr(Port), vbCritical, "Error"
        End
        End If
    Sok.Close
    DoTest
    Timer1.Enabled = True
    End If
If Status = 2 Then End
End Sub

Private Sub Timer2_Timer()
    DoTestEx
    Timer2.Enabled = False
End Sub
