--------------------------------------------------------
--  File created - Saturday-January-04-2020
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger BLOG_FILES_TRG
--------------------------------------------------------

CREATE OR REPLACE TRIGGER "BLOG_FILES_TRG"
before
insert or
update on blog_files
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := coalesce( :new.created_on, localtimestamp );
    :new.created_by   := coalesce( :new.created_by, sys_context( 'APEX$SESSION', 'APP_USER' ), sys_context('USERENV', 'SESSION_USER') );
  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on   := localtimestamp;
  :new.changed_by   := coalesce( sys_context( 'APEX$SESSION', 'APP_USER' ), sys_context('USERENV', 'SESSION_USER') );

  :new.file_size := coalesce( dbms_lob.getlength( :new.blob_content ), 0 );

	:new.etag :=
       to_char( :new.id )
    || to_char( :new.row_version )
    || to_char( sys_extract_utc( :new.changed_on ), 'YYYYMMDDHH24MISSFF6' )
  ;

end;
/