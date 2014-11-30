
	SET OBJ,claws-mail
	CALL IfSetup
	MOVP CLAWSMAIL,DS
	
	SET OBJ,gnupg
	CALL IfSetup
	
	SET OBJ,OnionMail
	CALL IfSetup
	MOVP ONIONMAIL,DS
	
	SET OBJ,TorONM
	CALL IfSetup
	MOVP TORPATH,DS
	
	EVAL TEXT
	END
	
	:IfSetup 10
	REG DS,APPDATA
	ADDI DS,\
	ADD DS,OBJ
	
	REG SR,PATH
	ADDI SR,\SkelFile\
	ADD SR,OBJ
	
	REXIST DS
	JZ NoSetup

	MKDIR DS
	RXCOPY SR,DS
	RET
	:NoSetup 10
	RET
	
