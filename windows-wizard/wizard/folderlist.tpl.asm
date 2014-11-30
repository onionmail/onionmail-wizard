INST TEXT,<folderlist>
JNZ Error
INST TEXT,</folderlist>
JNZ Error

load XML,wizard\folderlist.tpl.ext
repz TEXT,</folderlist>,XML
INST TEXT,</folderlist>
JZ Error

addi TEXT,</folderlist>
cli XML
EVAL TEXT

XCOPYM SkelFile\Mail,*$APPDATA$\OnionMail$ACCOUNT$\
END

Error:
err XML Error in folderlist.xml 
