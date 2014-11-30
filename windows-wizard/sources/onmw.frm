VERSION 5.00
Begin VB.Form Wizard 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "OnionMail Wizard"
   ClientHeight    =   2790
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7335
   Icon            =   "onmw.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2790
   ScaleWidth      =   7335
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Configuration:"
      Height          =   2775
      Left            =   0
      TabIndex        =   15
      Top             =   2820
      Width           =   7335
      Begin VB.CommandButton Command1 
         Caption         =   "&Ok"
         Height          =   375
         Left            =   3000
         TabIndex        =   17
         Top             =   2280
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.Label infoend 
         Alignment       =   2  'Center
         Height          =   1395
         Left            =   120
         TabIndex        =   18
         Top             =   720
         Visible         =   0   'False
         Width           =   7095
      End
      Begin VB.Label info 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   16
         Top             =   360
         Width           =   7095
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "User informations:"
      Height          =   2775
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7335
      Begin VB.Timer Timer1 
         Enabled         =   0   'False
         Interval        =   1000
         Left            =   6360
         Top             =   1380
      End
      Begin VB.CommandButton Paste 
         Caption         =   "&Paste"
         Height          =   375
         Left            =   6000
         TabIndex        =   19
         ToolTipText     =   "Use this button to paste user's data by clipboard from web to wizard."
         Top             =   1860
         Width           =   1215
      End
      Begin VB.TextBox pop32 
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   1680
         PasswordChar    =   "*"
         TabIndex        =   14
         Top             =   2100
         Width           =   4215
      End
      Begin VB.TextBox smtp2 
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   1680
         PasswordChar    =   "*"
         TabIndex        =   12
         Top             =   1860
         Width           =   4215
      End
      Begin VB.TextBox pop31 
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   1680
         PasswordChar    =   "*"
         TabIndex        =   10
         Top             =   1200
         Width           =   4215
      End
      Begin VB.TextBox smtp1 
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   1680
         PasswordChar    =   "*"
         TabIndex        =   8
         Top             =   960
         Width           =   4215
      End
      Begin VB.TextBox user 
         Height          =   285
         Left            =   1680
         TabIndex        =   6
         Top             =   720
         Width           =   4215
      End
      Begin VB.TextBox server 
         Height          =   285
         Left            =   1680
         TabIndex        =   4
         Top             =   480
         Width           =   4215
      End
      Begin VB.CommandButton Command6 
         Caption         =   "&Cancel"
         Height          =   375
         Left            =   6000
         TabIndex        =   2
         Top             =   960
         Width           =   1215
      End
      Begin VB.CommandButton Command5 
         Caption         =   "&Ok"
         Default         =   -1  'True
         Height          =   375
         Left            =   6000
         TabIndex        =   1
         Top             =   480
         Width           =   1215
      End
      Begin VB.Label InfSX 
         AutoSize        =   -1  'True
         Caption         =   "InfSX"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   22
         Top             =   2460
         Visible         =   0   'False
         Width           =   480
      End
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "helpex"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   195
         Left            =   6585
         TabIndex        =   21
         Top             =   2460
         Width           =   630
      End
      Begin VB.Label Label7 
         Caption         =   "Copy the passwords to verify:"
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   1560
         Width           =   4215
      End
      Begin VB.Label Label6 
         Caption         =   "POP3 Password:"
         Height          =   255
         Left            =   240
         TabIndex        =   13
         Top             =   2100
         Width           =   1455
      End
      Begin VB.Label Label5 
         Caption         =   "SMTP Password:"
         Height          =   255
         Left            =   240
         TabIndex        =   11
         Top             =   1860
         Width           =   1335
      End
      Begin VB.Label Label4 
         Caption         =   "POP3 Password:"
         Height          =   255
         Left            =   240
         TabIndex        =   9
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "SMTP Password:"
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   960
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "User name:"
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   720
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Server:"
         Height          =   255
         Left            =   240
         TabIndex        =   3
         Top             =   480
         Width           =   1095
      End
   End
End
Attribute VB_Name = "Wizard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
DefLng A-Z

Private Sub Command1_Click()
End
End Sub

Private Sub Command5_Click()

Pox = "Parsing input"
server.Text = LCase(server.Text)
user.Text = LCase(user.Text)
smtp1.Text = LTrim(RTrim(smtp1.Text))
smtp2.Text = LTrim(RTrim(smtp2.Text))
pop31.Text = LTrim(RTrim(pop31.Text))
pop32.Text = LTrim(RTrim(pop32.Text))

If Len(server.Text) < 22 And InStr(server.Text, ".onion") <> 17 Then
    MsgBox "Wrong OnionMail Server address" + vbCrLf + "The Hidden server address is required", vbExclamation, "Error"
    Exit Sub
    End If

If Len(user.Text) < 4 Then
    MsgBox "Wrong Username." + vbCrLf + "The username is required", vbExclamation, "Error"
    Exit Sub
    End If

If InStr(user.Text, "@") > 0 Then
    MsgBox "Wrong Username.", vbExclamation, "Error"
    Exit Sub
    End If

If Len(smtp1.Text) < 6 Or smtp1.Text <> smtp2.Text Then
    MsgBox "Wrong SMTP password." + vbCrLf + "The SMTP password is required", vbExclamation, "Error"
    Exit Sub
    End If
    
If Len(pop31.Text) < 6 Or pop31.Text <> pop32.Text Then
    MsgBox "Wrong POP3 password." + vbCrLf + "The POP3 password is required", vbExclamation, "Error"
    Exit Sub
    End If

If pop31.Text = smtp1.Text Then
    MsgBox "Wrong passwords." + vbCrLf + "The POP3 password can't be the same of SMTP password." + vbCrLf + "If you have this configuration is very insecure!!!", vbCritical, "Error"
    Exit Sub
    End If

PAR.SetVal "SMTPP", smtp1.Text
PAR.SetVal "POP3P", pop31.Text
PAR.SetVal "USER", user.Text
PAR.SetVal "ONION", server.Text

If InStr(user.Text, "..") > 0 Or InStr(user.Text, "/") > 0 Or InStr(user.Text, "\") > 0 Or InStr(user.Text, Chr(34)) > 0 Then
    MsgBox "Wrong parameters", vbCritical, "Error"
    Exit Sub
    End If
    
If InStr(server.Text, "..") > 0 Or InStr(server.Text, "/") > 0 Or InStr(server.Text, "\") > 0 Or InStr(user.Text, Chr(34)) > 0 Then
    MsgBox "Wrong parameters", vbCritical, "Error"
    Exit Sub
    End If


If ArleadyConfig(server.Text, user.Text) Then
    If MsgBox("Warning:" + vbCrLf + "The wizard has detected that this user has already been configured in the past." + _
            "If the above configuration is successful, it is recommended not to continue. Verify the account before proceeding with further attempts on the same account." + _
            "Do you want to continue with the configuration?", vbQuestion + vbYesNo + vbDefaultButton2, "OnionMail Wizard") = vbNo Then Exit Sub
    End If

St$ = PAR.IfItem("_INFOEND", "Click Ok to close.")
St$ = Replace(St$, "\n", vbCrLf)

PAR.Rewind
    While PAR.Element(K$, V$)
    St$ = Replace(St$, "%" + K$ + "%", V$)
    Wend

infoend = St$

Frame3.visible = False
Frame1.Move 0, 0
Frame1.visible = True
info = "Configuration in progress..."
DoEvents

DoConfig Config.ACTION_WIZARD, server.Text, True

Command1.visible = True
info = PAR.IfItem("_COMPLETE", "Configuration complete")
infoend.visible = True
If PAR.Item("_LOCKFILE") <> "" Then
    z = FreeFile
    Open MapPath(PAR.Item("_LOCKFILE")) For Output As z
    Print #z, 1
    Close #z
    End If
End Sub


Private Sub Command6_Click()
End
End Sub

Private Sub Form_Load()
        
Label8.Caption = PAR.IfItem("_HELPCAPT", "Online Help / How to get accont.")

St$ = PAR.Item("_INFSX")
If Len(St$) Then
    InfSX.Caption = St$
    InfSX.visible = True
    End If
    

End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub


Private Sub InfSX_Click()
Label8_Click

End Sub

Private Sub Label8_Click()
StartDoc MapPath(PAR.IfItem("_HELPDOC", "http://onionmail.info"))
End Sub

Private Sub Paste_Click()
    If Clipboard.GetFormat(vbCFText) Then
        txt$ = Clipboard.GetText(vbCFText)
        Dim Lin() As String
        txt$ = Replace(txt$, vbCrLf, vbLf)
        txt$ = txt$ + vbLf + vbLf + vbLf + vbLf
        Lin = Split(txt$, vbLf)
        okka = 0
        server.Text = ""
        user.Text = ""
        smtp1.Text = ""
        smtp2.Text = ""
        pop31.Text = ""
        pop32.Text = ""
        
        mli = UBound(Lin) - 4
        
            For li = 0 To mli
            Dim Tok() As String
            Dim Word() As String
            Dim Lower() As String
            Tok = Split(Lin(li), Chr(9), 2)
            Word = Split(Lin(li), " ")
            mw = UBound(Word)
                For ax = 0 To mw
                Word(ax) = LCase(Word(ax))
                Next
                
            If mw > 2 Then
                If Word(0) = "pop3" And Word(1) = "server" And Word(3) = "port" Then server.Text = Word(2): okka = okka Or 1
                If Word(0) = "smtp" And Word(1) = "server" And Word(3) = "port" Then server.Text = Word(2): okka = okka Or 1
                If Word(0) = "the" And (Word(1) = "pop3" Or Word(1) = "smtp") And (Word(2) = "username" Or Word(2) = "usename") And Word(3) = "is:" Then
                    t0$ = LTrim(RTrim(Lin(li + 1)))
                    If t0$ <> "" Then user.Text = t0$: okka = okka Or 2
                    If True Or InStr(Lin(li + 2), "password is:") > 0 Then
                        t0$ = LTrim(RTrim(Lin(li + 3)))

                        If t0$ <> "" Then
                            If Word(1) = "pop3" Then
                                pop31.Text = t0$
                                pop32.Text = t0$
                                okka = okka Or 8
                                Else
                                smtp1.Text = t0$
                                smtp2.Text = t0$
                                okka = okka Or 4
                                End If
                            End If
                        End If
                    
                    End If
                End If
            
            If UBound(Tok) > 0 Then
                cm$ = Replace(LCase(Tok(0)), " ", "")
                pa$ = LTrim(RTrim(Tok(1)))
                pa$ = Replace(pa$, Chr(9), "")
                pa$ = Replace(pa$, vbCr, "")
                If InStr(cm$, "pop3server") > 0 And InStr(pa$, ".onion") > 0 Then server.Text = pa$: okka = okka Or 1
                If InStr(cm$, "smtpserver") > 0 And InStr(pa$, ".onion") > 0 Then server.Text = pa$: okka = okka Or 1
                If InStr(cm$, "smtpusername") > 0 And InStr(pa$, "@") = 0 Then user.Text = pa$: okka = okka Or 2
                If InStr(cm$, "pop3username") > 0 And InStr(pa$, "@") = 0 Then user.Text = pa$: okka = okka Or 2
                If InStr(cm$, "smtppassword") > 0 Then smtp1.Text = pa$: smtp2.Text = pa$: okka = okka Or 4
                If InStr(cm$, "pop3password") > 0 Then pop31.Text = pa$: pop32.Text = pa$: okka = okka Or 8
                
                End If
            Next
            If okka <> 15 Then MsgBox "I can't understand all parameters." + vbCrLf + "Insert all parameters manually.", vbExclamation, "Sorry"
        Else
        MsgBox "Unsupported clipboard format.", vbExclamation, "Error"
    End If
End Sub

Private Sub Timer1_Timer()
    server.BackColor = QBColor(15)
 '   pop31.BackColor = QBColor(15)
 '   pop32.BackColor = QBColor(15)
 '   smtp1.BackColor = QBColor(15)
 '   smtp2.BackColor = QBColor(15)
    user.BackColor = QBColor(15)
    Timer1.Enabled = False
End Sub

Private Function Object_KeyPress(KeyAscii As Integer, alfa$, force As Boolean) As Boolean
If KeyAscii < 32 Then
    Object_KeyPress = False
    Exit Function
    End If
    
ch$ = LCase(Chr(KeyAscii))
If force Or InStr(alfa$, ch$) < 1 Then
    Beep
    Timer1.Enabled = True
    Object_KeyPress = True
    Else
    Object_KeyPress = False
    End If
End Function

Private Sub user_KeyPress(KeyAscii As Integer)

    x$ = user.Text + Chr(13)
    Dim force As Boolean
    force = InStr(x$, ".list" + Chr(13)) > 0 Or InStr(x$, ".onion" + Chr(13)) > 0 Or InStr(x$, ".app" + Chr(13)) > 0 Or user.Text = "server"
    If Object_KeyPress(KeyAscii, VALID1, force) Then user.BackColor = QBColor(12)
    
End Sub

Private Sub server_KeyPress(KeyAscii As Integer)
    If Object_KeyPress(KeyAscii, VALIDO, False) Then server.BackColor = QBColor(12)
End Sub

