[Account: %ACCOUNT%]
account_name=%USER%@%ONION%
is_default=0
name=%USER%
address=%USER%@%ONION%
organization=
protocol=0
receive_server=%IP%
smtp_server=%IP%
nntp_server=
local_mbox=/var/mail
use_mail_command=0
mail_command=/usr/sbin/sendmail -t -i
use_nntp_auth=0
use_nntp_auth_onconnect=0
user_id=%USER%
password=%POP3P%
use_apop_auth=0
remove_mail=1
message_leave_time=7
message_leave_hour=0
enable_size_limit=0
size_limit=1024
filter_on_receive=1
filterhook_on_receive=1
imap_auth_method=0
receive_at_get_all=1
max_news_articles=300
inbox=#mh/OnionMail%ACCOUNT%/inbox
local_inbox=#mh/OnionMail%ACCOUNT%/inbox
imap_directory=
imap_subsonly=1
low_bandwidth=0
generate_msgid=1
generate_xmailer=1
add_custom_header=0
msgid_with_addr=0
use_smtp_auth=1
smtp_auth_method=16
smtp_user_id=%USER%
smtp_password=%SMTPP%
pop_before_smtp=0
pop_before_smtp_timeout=5
signature_type=0
signature_path=
auto_signature=0
signature_separator=-- 
set_autocc=0
auto_cc=
set_autobcc=0
auto_bcc=
set_autoreplyto=0
auto_replyto=
enable_default_dictionary=0
default_dictionary=de
enable_default_alt_dictionary=0
default_alt_dictionary=de
compose_with_format=0
compose_subject_format=
compose_body_format=
reply_with_format=0
reply_quotemark=
reply_body_format=
forward_with_format=0
forward_quotemark=
forward_body_format=
default_privacy_system=
default_encrypt=0
default_encrypt_reply=1
default_sign=0
default_sign_reply=0
save_clear_text=0
encrypt_to_self=0
privacy_prefs=gpg=REVGQVVMVA==
ssl_pop=2
ssl_imap=0
ssl_nntp=0
ssl_smtp=2
use_nonblocking_ssl=1
in_ssl_client_cert_file=
in_ssl_client_cert_pass=!
out_ssl_client_cert_file=
out_ssl_client_cert_pass=!
set_smtpport=1
smtp_port=25
set_popport=1
pop_port=110
set_imapport=0
imap_port=143
set_nntpport=0
nntp_port=119
set_domain=0
domain=
gnutls_set_priority=0
gnutls_priority=
mark_crosspost_read=0
crosspost_color=0
set_sent_folder=0
sent_folder=
set_queue_folder=0
queue_folder=
set_draft_folder=0
draft_folder=
set_trash_folder=0
trash_folder=
imap_use_trash=1