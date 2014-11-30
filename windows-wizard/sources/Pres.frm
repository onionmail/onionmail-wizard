VERSION 5.00
Begin VB.Form Pres 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "OnionMail Wizard"
   ClientHeight    =   7215
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10455
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   481
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   697
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command2 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   660
      TabIndex        =   2
      Top             =   6720
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Ok"
      Default         =   -1  'True
      Height          =   375
      Left            =   8220
      TabIndex        =   1
      Top             =   6720
      Width           =   1575
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6615
      Left            =   0
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Text            =   "Pres.frx":0000
      Top             =   0
      Width           =   10455
   End
End
Attribute VB_Name = "Pres"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Wizard.Show
Unload Me
End Sub

Private Sub Command2_Click()
End
End Sub

Private Sub Form_Load()
t0$ = App.Path + "\" + PAR.IfItem("_TEXTFILE", "wizard.txt")

If Not FileExists(t0$) Then
    Wizard.Show
    Me.Hide
    Exit Sub
    End If
Text1 = Read(t0$)
End Sub
Private Function Read(fi$) As String
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

