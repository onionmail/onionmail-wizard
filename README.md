onionmail-wizard
================

 Copyright (C) 2014 by Tramaci.Org & OnionMail.info & mes3hacklab
 This file is a wizard to subscribe and configure onionmail in TAILS
 (PGP keys, Claws-Mail, VMAT address and etc...)

 onionmail-wizard is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 3 of the License, or
 (at your option) any later version.

 This source code is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this source code; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


These are the source codes of OnionMail end user wizard.

This wizard is only a facilitation to configure Claws-Mail and GnuPG.
The purpose of this wizard is to allow users easy configuration of
the encrypted email.

There are some versions of this wizard:

Directory list:
	onionmail-py		Wizard script sources.
	onionmail-wizard-x.x.x	deb package sources.
	maildir			Empty user's maildir skel file.
	profile			Empty user's profile skel file.

	windows-wizard		Windows's version if this wizard.

---------------- WINDOWS WIZARD WARNING ---------------------------------
	
Windows systems are insecure by default. Use OnionMail on windows 
decrease the security and privacy. Microsoft can share your data with the 
PRISM NSA's project. Please use TAILS instead.

Some softare is not open source and we don't know really what it do.

If you want to use in Windows OnionMail at your own risk This is the 
wizard for windows platforms.
We do this in the spirit of open source and cross-platform.

We want to leave to you a good luck amulet. This is a regedit (register) 
file that reset all system logs that log all your activities.

ClearMainMRU.reg

Good luck ;)

-------------------------------------------------------------------------

Windows Wizard:
	Directory list
	windows-wizard/User
		Default empty user profile (legacy Win XP ver.).

	windows-wizard/SkelFile
		Skel files for all wizard's programs.

        windows-wizard/SkelFile/Claws-mail
		Empty user's profile.

        windows-wizard/SkelFile/gnupg
		Empty GnuPG profile.

        windows-wizard/SkelFile/Mail
		Empty user's mailbox.

        windows-wizard/SkelFile/OnionMail
		Wizard's skel file.

        windows-wizard/SkelFile/TorONM
		Place here the default
		TOR's data directory.

	windows-wizard/sources
		Soucre codes of wizard
		Visual Basic 6.0

	You must include:
		* GnuPG
		* Claws-Mail
		* TOR
		* NTU
		* VB6 Runtime
		* WinSock control

	All reults file list:
		filelist
