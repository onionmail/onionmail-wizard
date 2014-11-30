INST TEXT,<folderlist>
JNZ Error
INST TEXT,</folderlist>
JNZ Error

load XML,folderlist.tpl.ext
repz TEXT,</folderlist>,XML
INST TEXT,</folderlist>
JZ Error

addi TEXT,</folderlist>
cli XML
EVAL TEXT
end

Error:
err XML Error in folderlist.xml 
