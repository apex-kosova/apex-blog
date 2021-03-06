--------------------------------------------------------
--  DDL for Sequence BLOG_SEQ
--------------------------------------------------------
CREATE SEQUENCE "BLOG_SEQ"
minvalue 1
maxvalue 9999999999999999999999999999
increment by 1
start with 100001
/
--------------------------------------------------------
--  DDL for Table BLOG_BLOGGERS
--------------------------------------------------------
create table  blog_bloggers(
  id number( 38, 0 ) not null,
	row_version number( 38, 0 ) not null,
	created_on timestamp( 6 ) with local time zone not null,
	created_by varchar2( 256 char ) not null,
	changed_on timestamp( 6 ) with local time zone not null,
	changed_by varchar2( 256 char ) not null,
	is_active number( 1, 0 ) not null,
	display_seq number( 10, 0 ) not null,
	blogger_name varchar2( 256 char ) not null,
	apex_username varchar2(  256 char ) not null,
	email varchar2( 256 char ),
	blogger_desc varchar2( 4000 char ),
  constraint blog_bloggers_pk primary key( id ),
  constraint blog_bloggers_uk1 unique( apex_username ),
  constraint blog_bloggers_ck1 check( row_version > 0 ),
  constraint blog_bloggers_ck3 check( display_seq > 0 ),
  constraint blog_bloggers_ck2 check( is_active in( 0 , 1 ) )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_CATEGORIES
--------------------------------------------------------
create table  blog_categories(
  id number( 38, 0 ) not null,
	row_version number( 38 ,0 ) not null,
	created_on timestamp( 6 ) with local time zone not null,
	created_by varchar2( 256 char ) not null,
	changed_on timestamp( 6 ) with local time zone not null,
	changed_by varchar2( 256 char ) not null,
	is_active number( 1, 0 ) not null,
	display_seq number( 10, 0 ) not null,
	title varchar2( 256 char ) not null,
	title_unique varchar2( 256 char ) as( upper( trim( title ) ) ) virtual ,
	notes varchar2( 4000 char ),
  constraint blog_categories_pk primary key( id ),
	constraint blog_categories_uk1 unique( title ),
	constraint blog_categories_uk2 unique( title_unique ),
  constraint blog_categories_ck1 check( row_version > 0 ),
	constraint blog_categories_ck2 check( is_active in( 0, 1 ) ),
  constraint blog_categories_ck3 check( display_seq > 0 )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_COMMENTS
--------------------------------------------------------
create table blog_comments(
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_active number( 1, 0 ) not null,
  post_id number( 38, 0 ) not null,
  parent_id number( 38, 0 ),
  body_html varchar2( 4000 char ) not null,
  comment_by varchar2( 256 char ) not null,
  constraint blog_comments_pk primary key( id ),
  constraint blog_comment_ck2 check( is_active in( 0 , 1 ) ),
  constraint blog_comment_ck1 check( row_version > 0 )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_COMMENT_FLAGS
--------------------------------------------------------
create table blog_comment_flags (
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  comment_id number( 38, 0 ) not null,
  flag varchar2( 256 char ) not null,
  constraint blog_comment_flags_pk primary key( id ),
  constraint blog_comment_flags_ck1 check( row_version > 0 )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_COMMENT_SUBS
--------------------------------------------------------
create table blog_comment_subs(
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  post_id number( 38, 0 ) not null,
  email_id number( 38, 0 ) not null,
  constraint blog_comment_subs_pk primary key( id ),
  constraint blog_comment_subs_uk1 unique( post_id, email_id ),
  constraint blog_comment_subs_ck1 check( row_version > 0 )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_COMMENT_SUBS_EMAIL
--------------------------------------------------------
create table blog_comment_subs_email(
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_active number( 1, 0 ) not null,
  email varchar2( 256 char ) not null,
  email_unique varchar2( 256 char ) as ( lower( trim( email ) ) ) virtual not null,
  constraint blog_comment_subs_email_pk primary key( id ),
  constraint blog_comment_subs_email_uk1 unique( email_unique ),
  constraint blog_comment_subs_email_ck1 check( row_version > 0 ),
  constraint blog_comment_subs_email_ck2 check( is_active in( 0, 1 ) )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_FEATURES
--------------------------------------------------------
create table blog_features(
  build_option_name varchar2( 255 char ) not null,
  build_option_group varchar2( 255 char ) not null,
  is_active number( 1, 0 ) not null,
  display_seq number( 10, 0 ) not null,
  notes varchar2( 4000 char ),
  constraint blog_features_pk primary key( build_option_name ),
  constraint blog_features_ck1 check( display_seq > 0 ),
  constraint blog_features_ck2 check( is_active in( 0, 1 ) )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_FILES
--------------------------------------------------------
create table blog_files (
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_active number( 1, 0 ) not null,
  is_download number( 1, 0 ) not null,
  file_name varchar2( 256 char ) not null,
  mime_type varchar2( 256 char ) not null,
  blob_content blob not null,
  file_charset varchar2( 256 char ),
  file_desc varchar2( 4000 char ),
  notes varchar2( 4000 char ),
  file_size number( 38, 0 ) as ( sys.dbms_lob.getlength( blob_content ) ) virtual,
  constraint blog_files_pk primary key( id ),
  constraint blog_files_uk1 unique( file_name  ),
  constraint blog_files_ck1 check( row_version > 0 ),
  constraint blog_files_ck2 check( is_active in( 0, 1 ) ),
  constraint blog_files_ck3 check( is_download in( 0, 1 ) )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_INIT_ITEMS
--------------------------------------------------------
create table blog_init_items(
  application_id number(38,0) not null,
  item_name varchar2(256 char) not null,
  constraint blog_init__items_pk primary key( application_id, item_name )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_LINKS
--------------------------------------------------------
create table blog_links(
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_active number( 1, 0 ) not null,
  display_seq number( 10, 0 ) not null,
  link_group_id number not null,
  title varchar2( 256 char ) not null,
  link_desc varchar2( 4000 char ) not null,
  link_url varchar2( 256 char ) not null,
  notes varchar2( 4000 char ),
  constraint blog_links_pk primary key( id ),
  constraint blog_links_uk1 unique( link_group_id, id ),
  constraint blog_links_ck1 check( row_version > 0 ),
  constraint blog_links_ck2 check( is_active in( 0, 1 ) ),
  constraint blog_links_ck3 check( display_seq > 0 )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_LINK_ROUPS
--------------------------------------------------------
create table blog_link_groups(
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_active number( 1, 0 ) not null,
  display_seq number( 10, 0 ) not null,
  title varchar2( 256 char ) not null,
  title_unique varchar2( 256 char ) as ( upper( title ) ) virtual ,
  notes varchar2( 4000 char ),
  constraint blog_link_groups_pk primary key( id ),
  constraint blog_link_groups_uk1 unique( title_unique ),
  constraint blog_link_groups_ck1 check( row_version > 0 ),
  constraint blog_link_groups_ck2 check( is_active in( 0 , 1 ) ),
  constraint blog_link_groups_ck3 check( display_seq > 0 )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_POSTS
--------------------------------------------------------
create table  blog_posts(
  id number( 38, 0 ) not null,
	row_version number( 38, 0 ) not null,
	created_on timestamp( 6 ) with local time zone not null,
	created_by varchar2( 256 char ) not null,
	changed_on timestamp( 6 ) with local time zone not null,
	changed_by varchar2( 256 char ) not null,
	is_active number( 1, 0 ) not null,
	blogger_id number( 38, 0 ) not null,
	category_id number( 38, 0 ) not null,
	title varchar2( 256 char ) not null,
	post_desc varchar2( 1024 char ) not null,
	body_html clob not null,
	first_paragraph varchar2( 4000 char ) not null,
	published_on timestamp( 6 ) with local time zone not null,
	notes varchar2( 4000 char ),
  body_length number( 38, 0 ) as ( sys.dbms_lob.getlength( body_html ) ) virtual,
	archive_year_month number( 6, 0 ) as ( to_number( to_char( published_on, 'YYYYMM' ) ) ) virtual ,
	archive_year number( 4, 0 ) as ( to_number( to_char( published_on, 'YYYY' ) ) ) virtual ,
	constraint blog_posts_pk primary key( id ),
  constraint blog_posts_ck1 check( row_version > 0 ),
  constraint blog_posts_ck2 check( is_active in( 0 , 1 ) )
)
/

create index blog_posts_ctx on blog_posts (body_html)
  indextype is ctxsys.context  parameters (
    'filter ctxsys.null_filter section group ctxsys.html_section_group sync (on commit)'
  )
/
--------------------------------------------------------
--  DDL for Table BLOG_POST_PREVIEW
--------------------------------------------------------
create table blog_post_preview(
  id number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone default localtimestamp not null,
  post_title varchar2( 128 char ),
  category_title varchar2( 128 char ),
  body_html clob,
  tags varchar2( 4000 char ),
  constraint blog_post_preview_pk primary key( id )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_POST_TAGS
--------------------------------------------------------
create table blog_post_tags(
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_active number( 1, 0 ) not null,
  display_seq number( 10, 0 ) not null,
  post_id number( 38, 0 ) not null,
  tag_id number( 38, 0 ) not null,
  constraint blog_post_tags_pk primary key( id ),
  constraint blog_post_tags_uk1 unique( post_id, tag_id ),
  constraint blog_post_tags_ck1 check( row_version > 0 ),
  constraint blog_post_tags_ck2 check( is_active in( 0, 1 ) ),
  constraint blog_post_tags_ck3 check( display_seq > 0 )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_POST_SETTINGS
--------------------------------------------------------
create table blog_settings(
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_nullable number( 1, 0 ) not null,
  display_seq number( 10, 0 ) not null,
  attribute_name varchar2( 64 char ) not null,
  data_type varchar2( 64 char ) not null,
  group_name varchar2( 64 char ) not null,
  attribute_value varchar2( 4000 char ),
  post_expression varchar2( 4000 char ),
  constraint blog_settings_pk primary key( id ),
  constraint blog_settings_uk1 unique( attribute_name ),
  constraint blog_settings_ck1 check( row_version > 0 ),
  constraint blog_settings_ck2 check( is_nullable in( 0, 1 ) ),
  constraint blog_settings_ck3 check( display_seq > 0 ),
  constraint blog_settings_ck11 check(
    is_nullable = 1 or
    is_nullable = 0 and
    attribute_value is not null
  ),
  constraint blog_settings_ck12 check(
    group_name in(
      'BLOG_PAR_GROUP_GENERAL'
      ,'BLOG_PAR_GROUP_REPORTS'
      ,'BLOG_PAR_GROUP_SEO'
      ,'BLOG_PAR_GROUP_UI'
      ,'INTERNAL'
    )
  ),
  constraint blog_settings_ck13 check(
    data_type in(
      'INTEGER'
      ,'STRING'
      ,'DATE_FORMAT'
      ,'URL'
      ,'EMAIL'
    )
  ),
  constraint blog_settings_ck14 check(
    data_type != 'INTEGER' or
    data_type = 'INTEGER' and
    round( to_number( attribute_value ) ) between 1 and 100
  ),
  constraint blog_settings_ck15 check(
    data_type != 'URL' or
    data_type = 'URL' and
    regexp_like( attribute_value, '^https?\:\/\/.*$' )
  ),
  constraint blog_settings_ck16 check(
    data_type != 'EMAIL' or
    data_type = 'EMAIL' and
    regexp_like( attribute_value, '^.*\@.*\..*$' )
  )
)
/
--------------------------------------------------------
--  DDL for Table BLOG_TAGS
--------------------------------------------------------
create table blog_tags (
  id number( 38, 0 ) not null,
  row_version number( 38, 0 ) not null,
  created_on timestamp( 6 ) with local time zone not null,
  created_by varchar2( 256 char ) not null,
  changed_on timestamp( 6 ) with local time zone not null,
  changed_by varchar2( 256 char ) not null,
  is_active number( 1, 0 ) not null,
  tag varchar2( 64 char ) not null,
  tag_unique varchar2( 64 char ) as ( upper( trim( tag ) ) ) virtual ,
  notes varchar2( 4000 char ),
  constraint blog_tags_pk primary key( id ),
  constraint blog_tags_uk1 unique( tag ),
  constraint blog_tags_uk2 unique( tag_unique ),
  constraint blog_tags_ck1 check( row_version > 0 ),
  constraint blog_tags_ck2 check( is_active in( 0 , 1 ) )
)
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_CATEGORIES
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_CATEGORIES" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "IS_ACTIVE", "DISPLAY_SEQ", "TITLE", "TITLE_UNIQUE", "NOTES", "POSTS_COUNT", "ALLOWED_ROW_OPERATION") AS
  select
   t1.id                as id
  ,t1.row_version       as row_version
  ,t1.created_on        as created_on
  ,lower(t1.created_by) as created_by
  ,t1.changed_on        as changed_on
  ,lower(t1.changed_by) as changed_by
  ,t1.is_active         as is_active
  ,t1.display_seq       as display_seq
  ,t1.title             as title
  ,t1.title_unique      as title_unique
  ,t1.notes             as notes
  ,(
    select count(l1.id)
    from blog_posts l1
    where 1 = 1
    and l1.category_id = t1.id
   )                    as posts_count
  ,case
    when exists(
      select 1
      from blog_posts l2
      where 1 = 1
      and l2.category_id = t1.id
    )
    then 'U'
    else 'UD'
  end                   as allowed_row_operation
from blog_categories t1
/
--------------------------------------------------------
--  DDL for View BLOG_V_COMMENTS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_COMMENTS" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "IS_ACTIVE", "POST_ID", "PARENT_ID", "POST_TITLE", "BODY_HTML", "COMMENT_BY", "USER_ICON", "ICON_MODIFIER")  AS
  select
   t1.id            as id
  ,t1.row_version   as row_version
  ,t1.created_on    as created_on
  ,t1.created_by    as created_by
  ,t1.changed_on    as changed_on
  ,t1.changed_by    as changed_by
  ,t1.is_active     as is_active
  ,t1.post_id       as post_id
  ,t1.parent_id     as parent_id
  ,(
    select title
    from blog_posts l1
    where 1 = 1
    and l1.id = t1.post_id
   )                as post_title
  ,t1.body_html     as body_html
  ,t1.comment_by    as comment_by
  ,apex_string.get_initials( t1.comment_by ) as user_icon
  ,'u-color-' || ora_hash( lower( t1.comment_by ), 45) as icon_modifier
from blog_comments t1
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_FEATURES
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_FEATURES" ("APPLICATION_ID", "BUILD_OPTION_ID", "ALLOWED_ROW_OPERATION", "DISPLAY_SEQ", "FEATURE_NAME", "FEATURE_GROUP", "BUILD_OPTION_STATUS", "LAST_UPDATED_ON", "LAST_UPDATED_BY", "IS_ACTIVE") AS
  select t1.application_id      as application_id
  ,t1.build_option_id           as build_option_id
  ,'U'                          as allowed_row_operation
  ,t2.display_seq               as display_seq
  ,apex_lang.message(
    p_name => t2.build_option_name
  )                             as feature_name
  ,apex_lang.message(
    p_name => t2.build_option_group
  )                             as feature_group
  ,t1.build_option_status       as build_option_status
  ,t1.last_updated_on           as last_updated_on
  ,lower( t1.last_updated_by )  as last_updated_by
  ,t2.is_active                 as is_active
from apex_application_build_options t1
join blog_features t2
  on t1.build_option_name = t2.build_option_name
where 1 = 1
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_FILES
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_FILES" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "IS_ACTIVE", "IS_DOWNLOAD", "FILE_NAME", "MIME_TYPE", "BLOB_CONTENT", "FILE_SIZE", "FILE_CHARSET", "FILE_DESC", "NOTES") AS
  select t1.id          as id
  ,t1.row_version       as row_version
  ,t1.created_on        as created_on
  ,lower(t1.created_by) as created_by
  ,t1.changed_on        as changed_on
  ,lower(t1.changed_by) as changed_by
  ,t1.is_active         as is_active
  ,t1.is_download       as is_download
  ,t1.file_name         as file_name
  ,t1.mime_type         as mime_type
  ,t1.blob_content      as blob_content
  ,t1.file_size         as file_size
  ,t1.file_charset      as file_charset
  ,t1.file_desc         as file_desc
  ,t1.notes             as notes
from blog_files t1
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_LINKS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_LINKS" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "LINK_GROUP_ID", "IS_ACTIVE", "LINK_GROUP_IS_ACTIVE", "DISPLAY_SEQ", "LINK_GROUP_DISPLAY_SEQ", "TITLE", "LINK_GROUP_TITLE", "LINK_DESC", "NOTES", "LINK_URL", "LINK_STATUS") AS
  select
   t1.id                        as id
  ,t1.row_version               as row_version
  ,t1.created_on                as created_on
  ,lower(t1.created_by)         as created_by
  ,t1.changed_on                as changed_on
  ,lower(t1.changed_by)         as changed_by
  ,t2.id                        as link_group_id
  ,t1.is_active                 as is_active
  ,t2.is_active                 as link_group_is_active
  ,t1.display_seq               as display_seq
  ,t2.display_seq               as link_group_display_seq
  ,t1.title                     as title
  ,t2.title                     as link_group_title
  ,t1.link_desc                 as link_desc
  ,t1.notes                     as notes
  ,t1.link_url                  as link_url
  ,case t2.is_active
   when 1
   then case t1.is_active
     when 1
     then 'ENABLED'
     else 'DISABLED'
     end
   else 'GROUP_DISABLED'
   end                          as link_status
from blog_links t1
join blog_link_groups t2
  on t1.link_group_id = t2.id
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_LINK_GROUPS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_LINK_GROUPS" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "IS_ACTIVE", "DISPLAY_SEQ", "TITLE", "TITLE_UNIQUE", "NOTES", "LINK_COUNT") AS
  select t1.id          as id
  ,t1.row_version       as row_version
  ,t1.created_on        as created_on
  ,lower(t1.created_by) as created_by
  ,t1.changed_on        as changed_on
  ,lower(t1.changed_by) as changed_by
  ,t1.is_active         as is_active
  ,t1.display_seq       as display_seq
  ,t1.title             as title
  ,t1.title_unique      as title_unique
  ,t1.notes             as notes
  ,(
    select count(l1.id)
    from blog_links l1
    where 1 = 1
    and l1.link_group_id = t1.id
   )                    as link_count
from blog_link_groups t1
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_POSTS_TAGS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_POST_TAGS" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "IS_ACTIVE", "POST_ID", "TAG_ID", "DISPLAY_SEQ", "TAG") DEFAULT COLLATION "USING_NLS_COMP" AS
  select
   t2.id                        as id
  ,t2.row_version               as row_version
  ,t2.created_on                as created_on
  ,lower(t2.created_by)         as created_by
  ,t2.changed_on                as changed_on
  ,lower(t2.changed_by)         as changed_by
  ,t1.is_active * t2.is_active  as is_active
  ,t2.post_id                   as post_id
  ,t2.tag_id                    as tag_id
  ,t2.display_seq               as display_seq
  ,t1.tag                       as tag
from blog_tags t1
join blog_post_tags t2 on t1.id = t2.tag_id
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_SETTINGS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_SETTINGS" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "IS_NULLABLE", "DISPLAY_SEQ", "ATTRIBUTE_NAME", "DATA_TYPE", "GROUP_NAME", "ATTRIBUTE_DESC", "ATTRIBUTE_VALUE", "ATTRIBUTE_GROUP", "POST_EXPRESSION") AS
  select t1.id                as id
  ,t1.row_version           as row_version
  ,t1.created_on            as created_on
  ,lower(t1.created_by)     as created_by
  ,t1.changed_on            as changed_on
  ,lower(t1.changed_by)     as changed_by
  ,t1.is_nullable           as is_nullable
  ,t1.display_seq           as display_seq
  ,t1.attribute_name        as attribute_name
  ,t1.data_type             as data_type
  ,t1.group_name            as group_name
  ,apex_lang.message(
    'BLOG_PAR_'
    || t1.attribute_name
  )                         as attribute_desc
  ,t1.attribute_value       as attribute_value
  ,apex_lang.message(
    t1.group_name
  )                         as attribute_group
  ,t1.post_expression       as post_expression
from blog_settings t1
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_TAGS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_TAGS" ("ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "IS_ACTIVE", "TAG", "TAG_UNIQUE", "NOTES", "POSTS_COUNT", "ALLOWED_ROW_OPERATION") AS
  select t1.id          as id
  ,t1.row_version       as row_version
  ,t1.created_on        as created_on
  ,lower(t1.created_by) as created_by
  ,t1.changed_on        as changed_on
  ,lower(t1.changed_by) as changed_by
  ,t1.is_active         as is_active
  ,t1.tag               as tag
  ,t1.tag_unique        as tag_unique
  ,t1.notes             as notes
  ,(
    select count(l1.id)
    from blog_post_tags l1
    where 1 = 1
    and l1.tag_id = t1.id
   )                    as posts_count
  ,case
    when exists(
      select 1
      from blog_post_tags l2
      where 1 = 1
      and l2.tag_id = t1.id
    )
    then 'U'
    else 'UD'
  end                   as allowed_row_operation
from blog_tags t1
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_COMMENTS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_COMMENTS" ("COMMENT_ID", "IS_ACTIVE", "POST_ID", "PARENT_ID", "CREATED_ON", "COMMENT_BY", "COMMENT_BODY", "USER_ICON", "ICON_MODIFIER") AS
  select
   t1.id as comment_id
  ,t1.is_active
  ,t1.post_id as post_id
  ,t1.parent_id as parent_id
  ,t1.created_on as created_on
  ,t1.comment_by as comment_by
  ,t1.body_html as comment_body
  ,apex_string.get_initials( t1.comment_by ) as user_icon
  ,'u-color-' || ora_hash( lower( t1.comment_by ), 45) as icon_modifier
from blog_comments t1
where 1 = 1
and t1.is_active = 1
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_FILES
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_FILES" ("FILE_ID", "CREATED_ON", "CHANGED_ON", "IS_DOWNLOAD", "FILE_NAME", "MIME_TYPE", "BLOB_CONTENT", "FILE_SIZE", "FILE_CHARSET", "FILE_DESC") AS
  select t1.id as file_id
  ,t1.created_on
  ,t1.changed_on
  ,t1.is_download
  ,t1.file_name
  ,t1.mime_type
  ,t1.blob_content
  ,t1.file_size
  ,t1.file_charset
  ,t1.file_desc
from blog_files t1
where 1 = 1
and t1.is_active = 1
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_INIT_ITEMS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_INIT_ITEMS" ("APPLICATION_ID", "ITEM_NAME", "ITEM_VALUE") AS
  select i.application_id as application_id
  ,i.item_name          as item_name
  ,s.attribute_value    as item_value
from blog_init_items i
join blog_settings s
  on i.item_name = s.attribute_name
;
--------------------------------------------------------
--  DDL for View BLOG_V_LINKS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_LINKS" ("LINK_ID", "GROUP_ID", "GROUP_TITLE", "GROUP_DISPLAY_SEQ", "DISPLAY_SEQ", "LINK_TITLE", "LINK_DESC", "LINK_URL") AS
  select t1.id        as link_id
  ,t2.id              as group_id
  ,t2.title           as group_title
  ,t2.display_seq     as group_display_seq
  ,t1.display_seq     as display_seq
  ,t1.title           as link_title
  ,t1.link_desc       as link_desc
  ,t1.link_url        as link_url
from blog_links t1
join blog_link_groups t2
  on t1.link_group_id = t2.id
where 1 = 1
and t1.is_active * t2.is_active > 0
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_LINK_GROUPS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_LINK_GROUPS" ( "GROUP_ID", "GROUP_TITLE", "GROUP_DISPLAY_SEQ") AS
  select t1.id        as group_id
  ,t1.title           as group_title
  ,t1.display_seq     as group_display_seq
from blog_link_groups t1
where 1 = 1
and t1.is_active = 1
and exists(
  select 1
  from blog_links x1
  where 1 = 1
  and x1.is_active = 1
  and x1.link_group_id = t1.id
)
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_POSTS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_POSTS" ("POST_ID", "CATEGORY_ID", "BLOGGER_ID", "BLOGGER_NAME", "POST_TITLE", "CATEGORY_TITLE", "POST_DESC", "FIRST_PARAGRAPH", "BODY_HTML", "PUBLISHED_ON", "ARCHIVE_YEAR_MONTH", "ARCHIVE_YEAR", "CATEGORY_SEQ", "CHANGED_ON", "COMMENTS_COUNT") AS
  select
   t1.id                  as post_id
  ,t3.id                  as category_id
  ,t2.id                  as blogger_id
  ,t2.blogger_name        as blogger_name
  ,t1.title               as post_title
  ,t3.title               as category_title
  ,t1.post_desc           as post_desc
  ,t1.first_paragraph     as first_paragraph
  ,t1.body_html           as body_html
  ,t1.published_on        as published_on
  ,t1.archive_year_month  as archive_year_month
  ,t1.archive_year        as archive_year
  ,t3.display_seq         as category_seq
  ,t1.changed_on          as changed_on
  ,(
    select count( l1.id )
    from blog_comments l1
    where 1 = 1
    and l1.is_active = 1
    and l1.post_id  = t1.id
  )                       as comments_count
from blog_posts       t1
join blog_bloggers    t2 on t1.blogger_id  = t2.id
join blog_categories  t3 on t1.category_id = t3.id
where 1 = 1
and t1.is_active = 1
and t2.is_active = 1
and t3.is_active = 1
and t1.published_on <= localtimestamp
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_POSTS_TAGS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_POST_TAGS" ("POST_ID", "TAG_ID", "DISPLAY_SEQ", "TAG") AS
  select t2.post_id  as post_id
  ,t2.tag_id       as tag_id
  ,t2.display_seq  as display_seq
  ,t1.tag          as tag
from blog_tags t1
join blog_post_tags t2 on t1.id = t2.tag_id
where 1 = 1
and t1.is_active * t2.is_active > 0
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_TAGS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_TAGS" ("TAG_ID", "TAG") AS
  select t1.id  as tag_id
  ,t1.tag     as tag
from blog_tags t1
where 1 = 1
and t1.is_active = 1
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_TEMP_FILES
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_TEMP_FILES" ("SEQ_ID", "ID", "ROW_VERSION", "IS_ACTIVE", "IS_DOWNLOAD", "FILE_NAME", "FILE_DESC", "MIME_TYPE", "BLOB_CONTENT") AS
  select t1.seq_id
  ,t1.n002    as id
  ,t1.n003    as row_version
  ,t1.n004    as is_active
  ,t1.n005    as is_download
  ,t1.c001    as file_name
  ,t1.c002    as file_desc
  ,t1.c003    as mime_type
  ,t1.blob001 as blob_content
from apex_collections t1
where 1 = 1
and collection_name = 'BLOG_FILES'
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_ALL_POSTS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ALL_POSTS" ("ID", "CATEGORY_ID", "BLOGGER_ID", "ROW_VERSION", "CREATED_ON", "CREATED_BY", "CHANGED_ON", "CHANGED_BY", "BLOGGER_NAME", "BLOGGER_EMAIL", "CATEGORY_TITLE", "TITLE", "POST_DESC", "BODY_HTML", "BODY_LENGTH", "PUBLISHED_ON", "NOTES", "PUBLISHED_DISPLAY", "POST_TAGS", "VISIBLE_TAGS", "HIDDEN_TAGS", "COMMENTS_COUNT", "POST_STATUS") AS
  select
   t1.id                as id
  ,t1.category_id       as category_id
  ,t1.blogger_id        as blogger_id
  ,t1.row_version       as row_version
  ,t1.created_on        as created_on
  ,lower(t1.created_by) as created_by
  ,t1.changed_on        as changed_on
  ,lower(t1.changed_by) as changed_by
  ,t3.blogger_name      as blogger_name
  ,t3.email             as blogger_email
  ,t2.title             as category_title
  ,t1.title             as title
  ,t1.post_desc         as post_desc
  ,t1.body_html         as body_html
  ,t1.body_length       as body_length
  ,t1.published_on      as published_on
  ,t1.notes             as notes
  ,case t1.is_active * t2.is_active * t3.is_active
    when 1
    then t1.published_on
   end                  as published_display
  ,(
    select listagg( tags.tag, ', ' )  within group(order by tags.display_seq) as tags
    from blog_v_all_post_tags tags
    where 1 = 1
    and tags.post_id = t1.id
  )                     as post_tags
  ,(
    select listagg( tags.tag, ', ' )  within group(order by tags.display_seq) as tags
    from blog_v_all_post_tags tags
    where 1 = 1
    and tags.post_id = t1.id
    and tags.is_active = 1
  )                     as visible_tags
  ,(
    select listagg( tags.tag, ', ' )  within group(order by tags.display_seq) as tags
    from blog_v_all_post_tags tags
    where 1 = 1
    and tags.post_id = t1.id
    and tags.is_active = 0
  )                     as hidden_tags
  ,(
    select count( co.id )
    from blog_comments co
    where 1 = 1
    and co.post_id  = t1.id
  )                     as comments_count
  ,case
    when t3.is_active = 0
    then 'BLOGGER_DISABLED'
    when t2.is_active = 0
    then 'CATEGORY_DISABLED'
    when t1.is_active = 0
    then 'DRAFT'
    when t1.published_on > localtimestamp
    then 'SCHEDULED'
    else 'PUBLISHED'
   end                  as post_status
from blog_posts t1
join blog_categories t2 on t1.category_id = t2.id
join blog_bloggers t3 on t1.blogger_id = t3.id
where 1 = 1
/
--------------------------------------------------------
--  DDL for View BLOG_V_ARCHIVE_YEAR
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_ARCHIVE_YEAR" ("ARCHIVE_YEAR", "POST_COUNT") AS
select t1.archive_year  as archive_year
  ,count( t1.post_id )  as post_count
from blog_v_posts t1
where 1 = 1
group by t1.archive_year
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_CATEGORIES
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_CATEGORIES" ("CATEGORY_ID", "CREATED_ON", "CATEGORY_TITLE", "DISPLAY_SEQ", "POSTS_COUNT") AS
  select
   t1.id            as category_id
  ,t1.created_on    as created_on
  ,t1.title         as category_title
  ,t1.display_seq   as display_seq
  ,(
    select count(1)
    from blog_v_posts l1
    where 1 = 1
    and l1.category_id = t1.id
   )                as posts_count
from blog_categories t1
where 1 = 1
and t1.is_active = 1
and exists (
  select 1
  from blog_v_posts x1
  where 1 = 1
  and x1.category_id  = t1.id
)
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_POSTS_LAST20
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_POSTS_LAST20" ("DISPLAY_SEQ", "POST_ID", "PUBLISHED_ON", "BLOGGER_NAME", "POST_TITLE", "POST_DESC", "CATEGORY_TITLE") AS
  with qry as (
  select
     row_number() over ( order by t1.published_on desc ) as rn
    ,t1.post_id
    ,t1.post_title
    ,t1.post_desc
    ,t1.blogger_name
    ,t1.category_title
    ,t1.published_on
  from blog_v_posts t1
)
select qry.rn         as display_seq
  ,qry.post_id        as post_id
  ,qry.published_on   as published_on
  ,qry.blogger_name   as blogger_name
  ,qry.post_title     as post_title
  ,qry.post_desc      as post_desc
  ,qry.category_title as category_title
from qry
where 1 = 1
and qry.rn <= 20
with read only
/
--------------------------------------------------------
--  DDL for View BLOG_V_REP_POST_BY_STATUS
--------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "BLOG_V_REP_POST_BY_STATUS" ("APPLICATION_ID", "NUM_POSTS", "POST_STATUS") DEFAULT COLLATION "USING_NLS_COMP"  AS
  with apex_lov as(
  select v1.application_id
    ,v1.return_value
    ,v1.display_value
  from apex_application_lov_entries v1
  where 1 = 1
  and v1.list_of_values_name = 'POST_STATUS'
), blog_data as(
  select v1.post_status
    ,count(1) as num_posts
  from blog_v_all_posts v1
  where 1 = 1
  group by v1.post_status
)
select q2.application_id
  ,q1.num_posts
  ,case
    when q2.return_value is null
    then q1.post_status
    else q2.display_value
   end as post_status
from blog_data q1
join apex_lov q2 on q1.post_status = q2.return_value
with read only
/
CREATE OR REPLACE package  "BLOG_UTIL"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Procedure and functions for public application
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 22.04.2019 - Created
--    Jari Laine 28.03.2020 - Signature 2 of get_year_month function
--    Jari Laine 15.04.2020 - function validate_comment
--    Jari Laine 26.04.2020 - Changed validate_comment us apex_util.savekey_vc2
--                            and removed custom functions that was doing same thing
--    Jari Laine 08.05.2020 - Functions get_year_month are obsolete
--                            application changed to group archives by year
--    Jari Laine 10.05.2020 - Procedure new_comment_notify to notify blogger about new comments
--                            Procedure subscribe to subscribe comment reply
--                            Procedure unsubscribe for unsubscribe comment reply
--    Jari Laine 11.05.2020 - Procedures and functions relating comments moved to package blog_comm
--    Jari Laine 17.05.2020 - Added out parameters p_older_title and p_newer_title to procedure get_post_pagination
--                            Materialized view blog_items_init changed to view
--                            Removed function get_item_init_value
--    Jari Laine 18.05.2020 - Moved ORDS specific global constants
--    Jari Laine 19.05.2020 - Changed apex_debug to warn in no_data_found exception handlers
--                            Changed apex_error_handler honor error display position when
--                            ORA error is between -20999 and 20901
--                            Changed procedure get_post_pagination to raises ORA -20901 when no data found
--    Jari Laine 19.05.2020   Removed global constants
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global constants
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

  g_number_format constant varchar2(40)   := 'fm99999999999999999999999999999999999999';

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function apex_error_handler (
    p_error           in apex_error.t_error
  ) return apex_error.t_error_result;
--------------------------------------------------------------------------------
  function get_attribute_value(
    p_attribute_name  in varchar2
  ) return varchar2 result_cache;
--------------------------------------------------------------------------------
  procedure initialize_items(
    p_app_id          in varchar2
  );
--------------------------------------------------------------------------------
  function get_post_title(
    p_post_id         in varchar2,
    p_escape          in boolean
  ) return varchar2;
--------------------------------------------------------------------------------
  procedure get_post_pagination(
    p_post_id         in varchar2,
    p_post_title      out nocopy varchar2,
    p_newer_id        out nocopy varchar2,
    p_newer_title     out nocopy varchar2,
    p_older_id        out nocopy varchar2,
    p_older_title     out nocopy varchar2
  );
--------------------------------------------------------------------------------
  function get_category_title(
    p_category_id     in varchar2,
    p_escape          in boolean
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_tag(
    p_tag_id          in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
end "BLOG_UTIL";
/


CREATE OR REPLACE package body "BLOG_UTIL"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global functions and procedures
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function apex_error_handler(
    p_error in apex_error.t_error
  ) return apex_error.t_error_result
  as
    l_genereric_error constant varchar2(255) := 'BLOG_GENERIC_ERROR';

    l_result          apex_error.t_error_result;
    l_reference_id    pls_integer;
    l_constraint_name varchar2(255);
    l_err_msg         varchar2(32700);

  begin

    -- This function must be used to ensure initialization is compatible
    -- with future changes to t_error_result.
    l_result :=
      apex_error.init_error_result(
        p_error => p_error
      );

    -- If it's an internal error raised by APEX, like an invalid statement or
    -- code which can't be executed, the error text might contain security sensitive
    -- information. To avoid this security problem we can rewrite the error to
    -- a generic error message and log the original error message for further
    -- investigation by the help desk.
    if p_error.is_internal_error then

      if not p_error.is_common_runtime_error then
        -- Change the message to the generic error message which doesn't expose
        -- any sensitive information.
        l_result.message := apex_lang.message(l_genereric_error);
        l_result.additional_info := null;
      end if;

    else

      -- Don't change display position for specific ORA eror codes
      if not p_error.ora_sqlcode between -20999 and -20901
      then
        -- Always show the error as inline error
        l_result.display_location := case
          when l_result.display_location = apex_error.c_on_error_page
          then apex_error.c_inline_in_notification
          else l_result.display_location
          end
       ;
      end if;

      -- If it's a constraint violation like
      --
      --   -) ORA-02292 ORA-02291 ORA-02290 ORA-02091 ORA-00001: unique constraint violated
      --   -) : transaction rolled back (-> can hide a deferred constraint)
      --   -) : check constraint violated
      --   -) : integrity constraint violated - parent key not found
      --   -) : integrity constraint violated - child record found
      --
      -- we try to get a friendly error message from our constraint lookup configuration.
      -- If we don't find the constraint in our lookup table we fallback to
      -- the original ORA error message.

      if p_error.ora_sqlcode in (-1, -2091, -2290, -2291, -2292) then

        l_constraint_name :=
          apex_error.extract_constraint_name(
            p_error => p_error
          );

        l_err_msg := apex_lang.message(l_constraint_name);

        -- not every constraint has to be in our lookup table
        if not l_err_msg = l_constraint_name then
          l_result.message := l_err_msg;
          l_result.additional_info := null;
        end if;

      end if;

      -- If an ORA error has been raised, for example a raise_application_error(-20xxx, '...')
      -- in a table trigger or in a PL/SQL package called by a process and we
      -- haven't found the error in our lookup table, then we just want to see
      -- the actual error text and not the full error stack with all the ORA error numbers.
      if p_error.ora_sqlcode is not null
      and l_result.message = p_error.message
      then
        l_result.message :=
          apex_error.get_first_ora_error_text (
            p_error => p_error
          );
        l_result.additional_info := null;
      end if;

      -- If no associated page item/tabular form column has been set, we can use
      -- apex_error.auto_set_associated_item to automatically guess the affected
      -- error field by examine the ORA error for constraint names or column names.
      if l_result.page_item_name is null
      and l_result.column_alias is null then

        apex_error.auto_set_associated_item (
           p_error => p_error
          ,p_error_result => l_result
        );

      end if;

    end if;

    return l_result;

  end apex_error_handler;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_attribute_value(
    p_attribute_name in varchar2
  ) return varchar2 result_cache
  as
    l_value varchar2(4000);
  begin

    apex_debug.enter(
      'blog_util.get_attribute_value'
      ,'p_attribute_name'
      ,p_attribute_name
    );

    if p_attribute_name is null then
      raise no_data_found;
    end if;

    -- fetch and return value from settings table
    select attribute_value
    into l_value
    from blog_settings
    where attribute_name = p_attribute_name
    ;

    apex_debug.info( 'Fetch attribute %s return: %s', p_attribute_name, l_value );
    return l_value;

    exception when no_data_found
    then

      apex_debug.warn(
         p_message => 'No data found. %s( %s => %s )'
        ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
        ,p1 => 'p_attribute_name'
        ,p2 => coalesce( p_attribute_name, '(null)' )
      );
      raise;

    when others
    then

      apex_debug.error(
         p_message => 'Unhandled error. %s( %s => %s )'
        ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
        ,p1 => 'p_attribute_name'
        ,p2 => coalesce( p_attribute_name, '(null)' )
      );
      raise;

  end get_attribute_value;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure initialize_items(
    p_app_id in varchar2
  )
  as
    l_app_id number;
  begin

    apex_debug.enter(
      'blog_util.initialize_items'
      ,'p_app_id'
      ,p_app_id
    );

    if p_app_id is null then
      raise no_data_found;
    end if;

    l_app_id := to_number( p_app_id );
    -- loop materialized view and set items values
    for c1 in (
      select
        i.item_name,
        i.item_value
      from blog_v_init_items i
      where i.application_id = l_app_id
    ) loop

      apex_debug.info( 'Initialize application id: %s item: %s value: %s', p_app_id, c1.item_name, c1.item_value );
      apex_util.set_session_state( c1.item_name, c1.item_value, false );

    end loop;

  exception when no_data_found then

    apex_debug.warn(
       p_message => 'No data found. %s( %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_app_id'
      ,p2 => coalesce( p_app_id, '(null)' )
    );
    raise;

  when others then

    apex_debug.error(
       p_message => 'Unhandled error. %s( %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_app_id'
      ,p2 => coalesce( p_app_id, '(null)' )
    );
    raise;

  end initialize_items;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post_title(
    p_post_id     in varchar2,
    p_escape      in boolean
  ) return varchar2
  as
    l_value   varchar2(4000);
    l_post_id number;
  begin

    apex_debug.enter(
      'blog_util.get_post_title'
      ,'p_post_id'
      ,p_post_id
      ,'p_escape'
      ,apex_debug.tochar(p_escape)
    );

    if p_post_id is null then
      raise no_data_found;
    end if;

    l_post_id := to_number( p_post_id );

    -- fetch and return post title
    select v1.post_title
    into l_value
    from blog_v_posts v1
    where v1.post_id = l_post_id
    ;
    apex_debug.info( 'Fetch post: %s return: %s', p_post_id, l_value );
    -- espace html and return string
    return case when p_escape
      then apex_escape.html(l_value)
      else l_value
      end
    ;

  exception when no_data_found
  then

    apex_debug.warn(
       p_message => 'No data found. %s( %s => %s, %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_post_id'
      ,p2 => coalesce( p_post_id, '(null)' )
      ,p3 => 'p_escape'
      ,p4 => apex_debug.tochar( p_escape )
    );
    raise;

  when others
  then

    apex_debug.error(
       p_message => 'Unhandled error. %s( %s => %s, %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_post_id'
      ,p2 => coalesce( p_post_id, '(null)' )
      ,p3 => 'p_escape'
      ,p4 => apex_debug.tochar( p_escape )
    );
    raise;

  end get_post_title;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure get_post_pagination(
    p_post_id         in varchar2,
    p_post_title      out nocopy varchar2,
    p_newer_id        out nocopy varchar2,
    p_newer_title     out nocopy varchar2,
    p_older_id        out nocopy varchar2,
    p_older_title     out nocopy varchar2
  )
  as
    l_post_id     number;
    l_post_title  varchar2(512);
    l_newer_id    number;
    l_newer_title varchar2(512);
    l_older_id    number;
    l_older_title varchar2(512);
  begin

    apex_debug.enter(
      'blog_util.pagination'
      ,'p_post_id'
      ,p_post_id
    );

    if p_post_id is null then
      raise no_data_found;
    end if;

    l_post_id := to_number( p_post_id );

    select q1.post_title
      ,q1.newer_id
      ,q1.newer_title
      ,q1.older_id
      ,q1.older_title
    into l_post_title, l_newer_id, l_newer_title, l_older_id, l_older_title
    from (
      select
         v1.post_id
        ,v1.post_title
        ,lag( v1.post_id ) over(order by v1.published_on desc) as newer_id
        ,lag( v1.post_title ) over(order by v1.published_on desc) as newer_title
        ,lead( v1.post_id ) over(order by v1.published_on desc) as older_id
        ,lead( v1.post_title ) over(order by v1.published_on desc) as older_title
      from blog_v_posts v1
      where 1 = 1
    ) q1
    where 1 = 1
    and q1.post_id = l_post_id
    ;

    p_post_title  := l_post_title;
    p_newer_id    := to_char( l_newer_id, g_number_format );
    p_newer_title := l_newer_title;
    p_older_id    := to_char( l_older_id, g_number_format );
    p_older_title := l_older_title;

    apex_debug.info( 'Fetch post: %s next_id: %s prev_id: %s', p_post_id, p_newer_id, p_older_id );

  exception when no_data_found
  then

    apex_debug.warn(
       p_message => 'No data found. %s( %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_post_id'
      ,p2 => coalesce( p_post_id, '(null)' )
    );

    --raise;
    -- We wan't show errors between -20999 and -20901 in error page
    raise_application_error(-20901, 'Post not found.');

  when others
  then

    apex_debug.error(
       p_message => 'Unhandled error. %s( %s => %s, %s => %s, %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_post_id'
      ,p2 => coalesce( p_post_id, '(null)' )
      ,p3 => 'p_newer_id'
      ,p4 => p_newer_id
      ,p5 => 'p_older_id'
      ,p6 => p_older_id
    );
    raise;

  end get_post_pagination;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_category_title(
    p_category_id in varchar2,
    p_escape      in boolean
  ) return varchar2
  as
    l_category_id number;
    l_title       varchar2(4000);
  begin

    apex_debug.enter(
      'blog_util.get_category_title'
      ,'p_category_id'
      ,p_category_id
      ,'p_escape'
      ,apex_debug.tochar(p_escape)
    );

    if p_category_id is null then
      raise no_data_found;
    end if;

    l_category_id := to_number( p_category_id );

    -- fetch and return category name
    select v1.category_title
    into l_title
    from blog_v_categories v1
    where v1.category_id = l_category_id
    ;
    apex_debug.info( 'Fetch category: %s return: %s', p_category_id, l_title );
    -- espace html and return string
    return case when p_escape
      then apex_escape.html(l_title)
      else l_title
      end
    ;

  exception when no_data_found then

    apex_debug.warn(
       p_message => 'No data found. %s( %s => %s, %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_category_id'
      ,p2 => coalesce( p_category_id, '(null)' )
      ,p3 => 'p_escape'
      ,p4 => apex_debug.tochar( p_escape )
    );
    raise;

  when others then
    apex_debug.error(
       p_message => 'Unhandled error. %s( %s => %s, %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_category_id'
      ,p2 => coalesce( p_category_id, '(null)' )
      ,p3 => 'p_escape'
      ,p4 => apex_debug.tochar( p_escape )
    );
    raise;
  end get_category_title;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tag(
    p_tag_id in varchar2
  ) return varchar2
  as
    l_tag_id  number;
    l_value   varchar2(4000);
  begin

    apex_debug.enter(
      'blog_util.get_tag'
      ,'p_tag_id'
      ,p_tag_id
    );

    if p_tag_id is null then
      raise no_data_found;
    end if;

    l_tag_id := to_number( p_tag_id );

    -- fetch and return tag name
    select t1.tag
    into l_value
    from blog_v_tags t1
    where 1 = 1
    and t1.tag_id = l_tag_id
    ;
    apex_debug.info( 'Fetch tag: %s return: %s', p_tag_id, l_value );
    -- espace html and return string
    return apex_escape.html( l_value );
  exception when no_data_found
  then

    apex_debug.warn(
       p_message => 'No data found. %s( %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_tag_id'
      ,p2 => coalesce( p_tag_id, '(null)' )
    );
    raise;

  when others
  then

    apex_debug.error(
       p_message => 'Unhandled error. %s( %s => %s )'
      ,p0 => utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(1))
      ,p1 => 'p_tag_id'
      ,p2 => coalesce( p_tag_id, '(null)' )
    );
    raise;

  end get_tag;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end "BLOG_UTIL";
/
CREATE OR REPLACE package "BLOG_ORDS"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Procedure and functions for ORDS
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 09.01.2020 - Created
--    Jari Laine 28.03.2020 - Added procedure create_public_xml_module
--                            Local constants renamed
--    Jari Laine 09.04.2020 - Package reorganized and removed e.g.
--                            procedures create_public_xml_module and create_public_files_module
--    Jari Laine 17.05.2020 - Add get_ords_service function.
--                            Originaly function was in blog_xml package
--    Jari Laine 18.05.2020 - Add private constant c_module_name
--                            Removed function get_file_path_prefix
--                            Removed ORDS specific constants from package blog_util
--                            Removed function get_ords_service
--                            Added function get_module_path
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure create_module(
    p_base_path in varchar2 default null
  );
--------------------------------------------------------------------------------
  procedure add_files_template;
--------------------------------------------------------------------------------
  procedure create_rss_template;
--------------------------------------------------------------------------------
  procedure create_sitemap_templates;
--------------------------------------------------------------------------------
  function get_module_path(
    p_canonical     in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
end "BLOG_ORDS";
/


CREATE OR REPLACE package body "BLOG_ORDS"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  c_module_name constant varchar2(256)  := 'BLOG_PUBLIC_FILES';
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure create_module(
    p_base_path in varchar2 default null
  )
  as
    l_base_path varchar2(256);
  begin

    l_base_path :=
      case when p_base_path is null
      then sys.dbms_random.string('l', 12)
      else p_base_path
      end
    ;
    -- Static files module
    ords.define_module(
      p_module_name     => c_module_name
      ,p_base_path      => l_base_path
      ,p_items_per_page => 25
      ,p_status         => 'PUBLISHED'
      ,p_comments       => 'Blog static content from blog_files table and dynamic XML'
    );
  end create_module;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure add_files_template
  as
  begin

    ords.define_template(
      p_module_name     => c_module_name
      ,p_pattern        => 'files/:p_file_name'
      ,p_priority       => 0
      ,p_etag_type      => 'HASH'
      ,p_etag_query     => null
      ,p_comments       => 'Blog static files'
    );

    ords.define_handler(
      p_module_name     => c_module_name
      ,p_pattern        => 'files/:p_file_name'
      ,p_method         => 'GET'
      ,p_source_type    => 'resource/lob'
      ,p_items_per_page => 0
      ,p_mimes_allowed  => ''
      ,p_comments       => 'Blog static files'
      ,p_source         =>
        'select v1.mime_type'
        || chr(10) || '  ,v1.blob_content'
        || chr(10) || 'from blog_v_files v1'
        || chr(10) || 'where 1 = 1'
        || chr(10) || 'and v1.is_download = 0'
        || chr(10) || 'and v1.file_name = :p_file_name'
    );

  end add_files_template;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure create_rss_template
  as
  begin

    ords.define_template(
      p_module_name     => c_module_name
      ,p_pattern        => 'feed/rss'
      ,p_priority       => 0
      ,p_etag_type      => 'HASH'
      ,p_etag_query     => null
      ,p_comments       => 'Blog rss feed'
    );

    ords.define_handler(
      p_module_name     => c_module_name
      ,p_pattern        => 'feed/rss'
      ,p_method         => 'GET'
      ,p_source_type    => 'plsql/block'
      ,p_items_per_page => 0
      ,p_mimes_allowed  => ''
      ,p_comments       => 'Blog rss feed'
      ,p_source         =>
        'begin' || chr(10)
        || '  blog_xml.rss(:p_lang);' || chr(10)
        || 'end;'
    );

  end create_rss_template;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure create_sitemap_templates
  as
  begin

    ords.define_template(
      p_module_name     => c_module_name
      ,p_pattern        => 'sitemap/index'
      ,p_priority       => 0
      ,p_etag_type      => 'HASH'
      ,p_etag_query     => null
      ,p_comments       => 'Blog sitemap index'
    );

    ords.define_handler(
      p_module_name     => c_module_name
      ,p_pattern        => 'sitemap/index'
      ,p_method         => 'GET'
      ,p_source_type    => 'plsql/block'
      ,p_mimes_allowed  => ''
      ,p_comments       => null
      ,p_source         =>
        'begin' || chr(10)
        || '  blog_xml.sitemap_index;' || chr(10)
        || 'end;'
    );

    ords.define_template(
      p_module_name     => c_module_name
      ,p_pattern        => 'sitemap/main'
      ,p_priority       => 0
      ,p_etag_type      => 'HASH'
      ,p_etag_query     => null
      ,p_comments       => 'Blog sitemap index'
    );

    ords.define_handler(
      p_module_name     => c_module_name
      ,p_pattern        => 'sitemap/main'
      ,p_method         => 'GET'
      ,p_source_type    => 'plsql/block'
      ,p_mimes_allowed  => ''
      ,p_comments       => null
      ,p_source         =>
        'begin' || chr(10)
        || '  blog_xml.sitemap_main;' || chr(10)
        || 'end;'
    );

    ords.define_template(
      p_module_name     => c_module_name
      ,p_pattern        => 'sitemap/posts'
      ,p_priority       => 0
      ,p_etag_type      => 'HASH'
      ,p_etag_query     => null
      ,p_comments       => 'Blog posts sitemap'
    );

    ords.define_handler(
      p_module_name     => c_module_name
      ,p_pattern        => 'sitemap/posts'
      ,p_method         => 'GET'
      ,p_source_type    => 'plsql/block'
      ,p_mimes_allowed  => ''
      ,p_comments       => 'Blog posts sitemap'
      ,p_source         =>
        'begin' || chr(10)
        || '  blog_xml.sitemap_posts;' || chr(10)
        || 'end;'
      );

  end create_sitemap_templates;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_module_path(
    p_canonical     in varchar2 default 'NO'
  ) return varchar2
  as
    l_url   varchar2(4000);
    c_owner constant varchar2(4000) := sys_context( 'USERENV', 'CURRENT_SCHEMA' );
  begin

    begin
      -- query ORDS metadata to get resource url
      select t1.pattern || t2.uri_prefix as url
      into l_url
      from user_ords_schemas t1
      join user_ords_modules t2
        on t1.id = t2.schema_id
      where 1 = 1
        and t1.parsing_schema = c_owner
        and t2.name = c_module_name
      ;
    exception when no_data_found then
      raise_application_error( -20001,  'Configuration not exists.' );
      l_url := null;
    end;

    if p_canonical = 'YES'
    then
      l_url := blog_util.get_attribute_value( 'CANONICAL_URL' )
        || l_url
      ;
    end if;

    return l_url;

  end get_module_path;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end "BLOG_ORDS";
/
CREATE OR REPLACE package  "BLOG_PLUGIN"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Procedures and functions for APEX plugins
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 22.04.2019 - Created
--    Jari Laine 03.01.2020 - Comments to package specs
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure render_math_question_field(
    p_item    in apex_plugin.t_item,
    p_plugin  in apex_plugin.t_plugin,
    p_param   in apex_plugin.t_item_render_param,
    p_result  in out nocopy apex_plugin.t_item_render_result
  );
--------------------------------------------------------------------------------
  procedure ajax_math_question_field(
    p_item    in            apex_plugin.t_item,
    p_plugin  in            apex_plugin.t_plugin,
    p_param   in            apex_plugin.t_item_ajax_param,
    p_result  in out nocopy apex_plugin.t_item_ajax_result
  );
--------------------------------------------------------------------------------
  procedure validate_math_question_field(
    p_item    in            apex_plugin.t_item,
    p_plugin  in            apex_plugin.t_plugin,
    p_param   in            apex_plugin.t_item_validation_param,
    p_result  in out nocopy apex_plugin.t_item_validation_result
  );
--------------------------------------------------------------------------------
end "BLOG_PLUGIN";
/


CREATE OR REPLACE package body "BLOG_PLUGIN"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function to_html_entities(
    p_number in number,
    p_format in varchar2
  ) return varchar2
  as
    l_string varchar2(4000);
    l_result varchar2(4000);
  begin

    l_string := to_char( p_number, p_format );
    for i in 1 .. length( l_string )
    loop
      l_result := l_result || '&#' || ascii( substr( l_string, i, 1 ) );
    end loop;
    return l_result;

  end to_html_entities;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure render_math_question_field(
    p_item in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result
  )
  as
    l_name varchar2(30);
  begin

    l_name := apex_plugin.get_input_name_for_page_item(false);

    if p_param.is_readonly or p_param.is_printer_friendly then

      -- emit hidden text field if necessary
      apex_plugin_util.print_hidden_if_readonly (
        p_item_name => p_item.name,
        p_value => p_param.value,
        p_is_readonly => p_param.is_readonly,
        p_is_printer_friendly => p_param.is_printer_friendly
      );
      -- emit display span with the value
      apex_plugin_util.print_display_only (
        p_item_name => p_item.name,
        p_display_value => p_param.value,
        p_show_line_breaks => false,
        p_escape => true,
        p_attributes => p_item.element_attributes
      );
    else

      sys.htp.p('<input type="text" '
        || case when p_item.element_width is not null
            then'size="' || p_item.element_width ||'" '
           end
        || case when p_item.element_max_length  is not null
            then 'maxlength="' || p_item.element_max_length || '" '
           end
        || apex_plugin_util.get_element_attributes(p_item, l_name, 'text_field apex-item-text')
        || 'value="" />'
      );
      sys.htp.p('<span class="apex-item-icon '
        || p_item.icon_css_classes
        || '" aria-hidden="true"></span>'
      );

      apex_javascript.add_onload_code (
        p_code => 'apex.server.plugin("' || apex_plugin.get_ajax_identifier || '",{},{'
        || 'dataType:"text",'
        || 'success:function(data){'
--        || '$(".z-question").html(data);'
        || '$(data).insertBefore($("#' || p_item.name || '_LABEL").children());'
        || '}});'
      );
      -- Tell APEX that this textarea is navigable
      p_result.is_navigable := true;

    end if;

  end render_math_question_field;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure ajax_math_question_field(
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_ajax_param,
    p_result in out nocopy apex_plugin.t_item_ajax_result
  )
  as
    l_err   varchar2(4000);
    l_data  varchar2(4000);
    l_min   number;
    l_max   number;
    l_num_1 number;
    l_num_2 number;
    l_tab   apex_t_varchar2;
  begin

    l_min   := to_number( p_item.attribute_01 );
    l_max   := to_number( p_item.attribute_02 );
    l_num_1 := round( sys.dbms_random.value( l_min, l_max ) );

    l_min   := to_number( p_item.attribute_03 );
    l_max   := to_number( p_item.attribute_04 );
    l_num_2 := round( sys.dbms_random.value( l_min, l_max ) );

    l_data  := '<span class="z-question">';
    l_data  := l_data || to_html_entities( l_num_1, blog_util.g_number_format );
    l_data  := l_data || '&nbsp;&#' || ascii('+') || '&nbsp;';
    l_data  := l_data || to_html_entities( l_num_2, blog_util.g_number_format );
    l_data  := l_data || '&#' || ascii('?');
    l_data  := l_data || '</span>';

    apex_util.set_session_state(
       p_name   => p_item.attribute_05
      ,p_value  => to_char( l_num_1 + l_num_2 , blog_util.g_number_format )
      ,p_commit => false
    );

    -- Write header for the output
    sys.owa_util.mime_header('text/plain', false);
    sys.htp.p('Cache-Control: no-cache');
    sys.htp.p('Pragma: no-cache');
    sys.owa_util.http_header_close;
    -- Write output
    sys.htp.prn( l_data );
    -- set correct answer to item session state

  exception when others
  then

    l_err := apex_lang.message(
      p_name => p_plugin.attribute_02
      ,p0 => p_item.plain_label
    );

    sys.htp.prn( l_err );

  end ajax_math_question_field;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure validate_math_question_field(
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_validation_param,
    p_result in out nocopy apex_plugin.t_item_validation_result
  )
  as
    l_answer  varchar2(4000);
    l_value   varchar2(4000);
    l_result  boolean;
  begin

    if p_param.value is not null then

      l_value   := v(p_item.attribute_05);
      l_answer  := p_param.value;

      -- Check is answer correct
      l_result  := case when l_value = l_answer then true else false end;

    else
      l_result := false;
    end if;

    if not l_result then

      p_result.message := apex_lang.message(
        p_name => p_plugin.attribute_01
        ,p0 => p_item.plain_label
      );

      if p_result.message = apex_escape.html(p_plugin.attribute_01) then
        p_result.message := p_plugin.attribute_01;
      end if;

    end if;

  end validate_math_question_field;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end "BLOG_PLUGIN";
/
CREATE OR REPLACE package  "BLOG_URL"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Generate URL or redirect
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 22.04.2019 - Created
--    Jari Laine 09.05.2020 - Functions that are called only from APEX
--                            number return value and number input parameters changed to varchar2.
--                            Functions that are also used in query
--                            another signature with varchar2 input and return values created for APEX
--                            Added parameter p_canonical to functions returning URL
--    Jari Laine 10.05.2020 - New function get_unsubscribe
--    Jari Laine 19.05.2020 - Changed page and items name to "hard coded" values
--                            and removed global constants from blog_util package
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tab(
    p_app_id          in varchar2 default null,
    p_app_page_id     in varchar2 default 'HOME',
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_post(
    p_post_id         in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_post(
    p_post_id         in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_category(
    p_category_id     in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_category(
    p_category_id     in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_archive(
    p_archive_id      in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_archive(
    p_archive_id      in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_tag(
    p_tag_id          in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_unsubscribe(
    p_app_id          in varchar2,
    p_post_id         in varchar2,
    p_subscription_id in number
  ) return varchar2;
--------------------------------------------------------------------------------
  procedure redirect_search(
    p_value           in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null
  );
--------------------------------------------------------------------------------
end "BLOG_URL";
/


CREATE OR REPLACE package body "BLOG_URL"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tab(
    p_app_id        in varchar2 default null,
    p_app_page_id   in varchar2 default 'HOME',
    p_session       in varchar2 default null,
    p_canonical     in varchar2 default 'NO'
  ) return varchar2
  as
  begin

    return
      case p_canonical
      when 'YES'
      then blog_util.get_attribute_value( 'CANONICAL_URL' )
      end
      ||
      apex_page.get_url(
        p_application => p_app_id
       ,p_page        => p_app_page_id
       ,p_session     => p_session
       ,p_clear_cache => 'RP'
       --,p_plain_url   => true
      );

  end get_tab;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post(
    p_post_id       in number,
    p_app_id        in varchar2 default null,
    p_session       in varchar2 default null,
    p_canonical     in varchar2 default 'NO'
  ) return varchar2
  as
    l_post_id varchar2(256);
  begin

    l_post_id := to_char( p_post_id, blog_util.g_number_format );
    return
      get_post(
         p_post_id      => l_post_id
        ,p_app_id       => p_app_id
        ,p_session      => p_session
        ,p_canonical    => p_canonical
      );

  end get_post;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post(
    p_post_id       in varchar2,
    p_app_id        in varchar2 default null,
    p_session       in varchar2 default null,
    p_canonical     in varchar2 default 'NO'
  ) return varchar2
  as
    l_url varchar2(4000);
  begin

    -- workaround because APEX 19.2
    -- apex_page.get_url don't have parameter p_plain_url
    if p_canonical = 'YES'
    then
      l_url := 'f?p='
        || coalesce( p_app_id, v( 'APP_ID' ) )
        || ':POST:::NO:RP:'
        || 'P2_POST_ID'
        || ':'
        || p_post_id
      ;

      l_url :=
        apex_util.prepare_url(
           p_url => l_url
          ,p_plain_url => true
        );

      l_url := blog_util.get_attribute_value( 'CANONICAL_URL' ) || l_url;

    else
      l_url :=
        apex_page.get_url(
          p_application => p_app_id
         ,p_page        => 'POST'
         ,p_session     => p_session
         ,p_clear_cache => 'RP'
         ,p_items       => 'P2_POST_ID'
         ,p_values      => p_post_id
         --,p_plain_url   => true
        )
      ;
    end if;

    return l_url;

  end get_post;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_category(
    p_category_id in number,
    p_app_id      in varchar2 default null,
    p_session     in varchar2 default null,
    p_canonical   in varchar2 default 'NO'
  ) return varchar2
  as
    l_category_id varchar2(256);
  begin

    l_category_id := to_char( p_category_id, blog_util.g_number_format );
    return
      get_category(
         p_category_id  => l_category_id
        ,p_app_id       => p_app_id
        ,p_session      => p_session
        ,p_canonical    => p_canonical
      );

  end get_category;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_category(
    p_category_id in varchar2,
    p_app_id      in varchar2 default null,
    p_session     in varchar2 default null,
    p_canonical   in varchar2 default 'NO'
  ) return varchar2
  as
  begin

    return
      case p_canonical
      when 'YES'
      then blog_util.get_attribute_value( 'CANONICAL_URL' )
      end
      ||
      apex_page.get_url(
        p_application => p_app_id
       ,p_page        => 'CATEGORY'
       ,p_session     => p_session
       ,p_clear_cache => 'RP'
       ,p_items       => 'P14_CATEGORY_ID'
       ,p_values      => p_category_id
       --,p_plain_url   => true
      );

  end get_category;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_archive(
    p_archive_id      in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2
  as
    l_archive_id varchar2(256);
  begin

    l_archive_id := to_char( p_archive_id, blog_util.g_number_format );
    return
      get_archive(
         p_archive_id   => l_archive_id
        ,p_app_id       => p_app_id
        ,p_session      => p_session
        ,p_canonical    => p_canonical
      );

  end get_archive;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_archive(
    p_archive_id      in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2
  as
  begin

    return
      case p_canonical
      when 'YES'
      then blog_util.get_attribute_value( 'CANONICAL_URL' )
      end
      ||
      apex_page.get_url(
         p_application => p_app_id
        ,p_page        => 'ARCHIVES'
        ,p_session     => p_session
        ,p_clear_cache => 'RP'
        ,p_items       => 'P15_ARCHIVE_ID'
        ,p_values      => p_archive_id
        --,p_plain_url   => true
      )
    ;

  end get_archive;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tag(
    p_tag_id      in number,
    p_app_id      in varchar2 default null,
    p_session     in varchar2 default null,
    p_canonical   in varchar2 default 'NO'
  ) return varchar2
  as
  begin

    return
      case p_canonical
      when 'YES'
      then blog_util.get_attribute_value( 'CANONICAL_URL' )
      end
      ||
      apex_page.get_url(
         p_application => p_app_id
        ,p_page        => 'TAG'
        ,p_session     => p_session
        ,p_clear_cache => 'RP'
        ,p_items       => 'P6_TAG_ID'
        ,p_values      => p_tag_id
        --,p_plain_url   => true
      )
    ;

  end get_tag;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_unsubscribe(
    p_app_id          in varchar2,
    p_post_id         in varchar2,
    p_subscription_id in number
  ) return varchar2
  as
    l_url     varchar2(4000);
    l_subs_id varchar2(256);
  begin

    l_subs_id := to_char( p_subscription_id, blog_util.g_number_format );
    -- workaround because APEX 19.2
    -- apex_page.get_url don't have parameter p_plain_url
    l_url := 'f?p='
      || p_app_id
      || ':POST:::NO:RP:'
      || 'P2_POST_ID'
      || ','
      || 'P2_SUBSCRIPTION_ID'
      || ':'
      || p_post_id
      || ','
      || p_subscription_id
    ;

    l_url :=
      apex_util.prepare_url(
         p_url => l_url
        ,p_checksum_type => 'PUBLIC_BOOKMARK'
        ,p_plain_url => true
      );

    return blog_util.get_attribute_value( 'CANONICAL_URL' ) || l_url;

  end get_unsubscribe;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure redirect_search(
    p_value         in varchar2,
    p_app_id        in varchar2 default null,
    p_session       in varchar2 default null
  )
  as
  begin
    -- Get search page URL and redirect if there there is string for search
    if p_value is not null then
      apex_util.redirect_url (
        apex_page.get_url(
           p_application => p_app_id
          ,p_page        => 'SEARCH'
          ,p_session     => p_session
          ,p_clear_cache => 'RP'
          ,p_items       => 'P0_SEARCH'
          ,p_values      => p_value
          --,p_plain_url   => true
        )
      );
    end if;
  end redirect_search;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end "BLOG_URL";
/
CREATE OR REPLACE package "BLOG_CM"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Content management API
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 26.04.2019 - Created
--    Jari Laine 10.01.2020 - Added procedure merge_files and file_upload
--    Jari Laine 12.01.2020 - Added function prepare_file_path
--    Jari Laine 09.04.2020 - Handling tags case insensitive
--    Jari Laine 09.05.2020 - Procedures and functions number input parameters changed to varchar2
--                            New functions get_comment_post_id and is_email
--    Jari Laine 10.05.2020 - Procedure send_reply_notify to send notify on reply to comment
--    Jari Laine 12.05.2020 - Removed function prepare_file_path
--    Jari Laine 17.05.2020 - Removed parameter p_err_mesg from function get_first_paragraph,
--                            function is called now from APEX application conputation
--    Jari Laine 19.05.2020 - Removed obsolete function get_post_title
--
--  TO DO:
--    #1  check constraint name that raised dup_val_on_index error
--    #2  group name is hard coded to procedure add_blogger
--        some reason didn't manage use apex_authorization.is_authorized
--        seems user session isn't entablished before process point After Authentication runs
--    #3  email validation could improved
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure get_blogger_details(
    p_app_id          in varchar2,
    p_username        in varchar2,
    p_id              out nocopy number,
    p_name            out nocopy varchar2
  );
--------------------------------------------------------------------------------
  -- Called from: admin app pages 14
  function get_category_seq return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 20
  function get_link_grp_seq return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 18
  function get_link_seq(
    p_link_group_id   in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 12
  function get_post_tags(
    p_post_id         in varchar2,
    p_sep             in varchar2 default ','
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 12
  function get_category_title(
    p_category_id      in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 12
  function get_first_paragraph(
    p_body_html       in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 12
  function request_to_post_status(
    p_request         in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app page 22 Close Dialog condition
  function file_upload(
    p_file_name       in varchar2
  ) return boolean;
--------------------------------------------------------------------------------
  function remove_whitespace(
    p_string          in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app page 23 and procedure blog_cm.file_upload
  procedure merge_files;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 12
  procedure add_category(
    p_title           in varchar2,
    p_err_mesg        in varchar2,
    p_category_id     out nocopy number
  );
--------------------------------------------------------------------------------
  -- Called from: admin app pages 12
  procedure add_post_tags(
    p_post_id         in varchar2,
    p_tags            in varchar2,
    p_sep             in varchar2 default ','
  );
--------------------------------------------------------------------------------
  -- This procedure is not used currently
  procedure remove_unused_tags;
--------------------------------------------------------------------------------
  -- this procedure is not used / not ready
  procedure save_post_preview(
    p_id              in varchar2,
    p_tags            in varchar2,
    p_post_title      in varchar2,
    p_category_title  in varchar2,
    p_body_html       in clob
  );
--------------------------------------------------------------------------------
  -- Called from: procedure blog_conf.purge_post_preview_job
  -- this procedure is not used / not ready
  procedure purge_post_preview;
---------------------------- ----------------------------------------------------
  -- this procedure is not used / not ready
  procedure purge_post_preview_job(
    p_drop_job    in boolean default false
  );
--------------------------------------------------------------------------------
  -- Called from: admin app pages 20012
  function is_integer(
    p_value           in varchar2,
    p_err_mesg        in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 20012
  function is_url(
    p_value           in varchar2,
    p_err_mesg        in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 20012
  function is_date_format(
    p_value           in varchar2,
    p_err_mesg        in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 20012
  function is_email(
    p_value           in varchar2,
    p_err_mesg        in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 32
  function get_comment_post_id(
    p_comment_id      in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- Called from: admin app pages 33
  procedure send_reply_notify(
    p_app_id          in varchar2,
    p_app_name        in varchar2,
    p_post_id         in varchar2,
    p_email_template  in varchar2
  );
--------------------------------------------------------------------------------
end "BLOG_CM";
/


CREATE OR REPLACE package body "BLOG_CM"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure add_tag(
    p_tag     in varchar2,
    p_tag_id  out nocopy number
  )
  as
    l_value varchar2(256);
  begin

    p_tag_id  := null;
    l_value := trim( p_tag );

    -- if tag is not null then insert to table and return id
    if l_value is not null then

      begin

        insert into blog_tags( is_active, tag )
        values ( 1, l_value )
        returning id into p_tag_id
        ;

      -- if unique constraint violation, tag exists.
      -- find id for tag in exception handler
      -- TO DO see item 1 from package specs
      exception when dup_val_on_index then

        l_value := upper(l_value);

        select id
        into p_tag_id
        from blog_v_all_tags
        where 1 = 1
        and tag_unique = l_value
        ;

      end;

    end if;

  end add_tag;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure add_tag_to_post(
    p_post_id     in number,
    p_tag_id      in number,
    p_display_seq in number
  )
  as
  begin

    -- insert post id, tag id and display sequency to table.
    -- use unique constraint violation to skip existing records.
    insert into blog_post_tags( is_active, post_id, tag_id, display_seq )
    values ( 1, p_post_id, p_tag_id, p_display_seq )
    ;

  -- TO DO see item 1 from package specs
  exception when dup_val_on_index then

    -- update display sequence if it changed
    update blog_post_tags
    set display_seq = p_display_seq
    where 1 = 1
    and post_id = p_post_id
    and tag_id = p_tag_id
    and display_seq != p_display_seq
    ;

  end add_tag_to_post;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure cleanup_post_tags(
    p_post_id in number,
    p_tag_tab in apex_t_number
  )
  as
  begin
    -- cleanup relationship from tags that aren't belong to post anymore
    delete
    from blog_post_tags t1
    where 1 = 1
    and post_id = p_post_id
    and not exists(
      select 1
      from table( p_tag_tab ) x1
      where 1 = 1
      and x1.column_value = t1.tag_id
    );
  end cleanup_post_tags;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure add_blogger(
    p_app_id    in varchar2,
    p_username  in varchar2,
    p_id        out nocopy number,
    p_name      out nocopy varchar2
  )
  as
    l_max   number;
    l_autz  varchar2(256);
    l_name  varchar2(256);
    l_email varchar2(256);
  begin

    -- check if user is in specific group
    -- if authorized add user to blog_bloggers table
    -- TO DO see item 2 from package specs
    if apex_util.current_user_in_group( 'Bloggers' )
    then

      -- Fetch net display_seq
      select ceil(coalesce(max(display_seq) + 1, 1) / 10) * 10
      into l_max
      from blog_bloggers
      ;

      -- Fetch user information from APEX users
      select email
        ,v1.first_name || ' ' || v1.last_name as full_name
      into l_email, l_name
      from apex_workspace_apex_users v1
      where 1  =1
      and v1.user_name = p_username
      ;

      -- Add new blogger
      insert into blog_bloggers
      ( apex_username, is_active, display_seq, blogger_name, email )
      values
      ( p_username, 1, l_max, l_name, l_email )
      returning id, blogger_name into p_id, p_name
      ;

    end if;

  end add_blogger;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global functions and procedures
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure get_blogger_details(
    p_app_id    in varchar2,
    p_username  in varchar2,
    p_id        out nocopy number,
    p_name      out nocopy varchar2
  )
  as
  begin
    -- fetch blogger id and name
    select id
      ,blogger_name
    into p_id, p_name
    from blog_bloggers
    where apex_username = p_username
    ;
  exception when no_data_found
  then
    -- if blogger details not found
    -- check if user is authorized use blog
    -- if authorized add user to blog_bloggers table
    add_blogger(
       p_app_id => p_app_id
      ,p_username => p_username
      ,p_id => p_id
      ,p_name => p_name
    );
  end get_blogger_details;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_category_seq
  return varchar2
  as
    l_max     number;
    l_result  varchar2(256);
  begin
    -- fetch max category display sequence
    select max( v1.display_seq ) as display_seq
    into l_max
    from blog_v_all_categories v1
    ;
    -- return next category display sequence
    l_result := to_char(
      ceil( coalesce( l_max + 1, 1 ) / 10 ) * 10
      ,blog_util.g_number_format
    );

    return l_result;

  end get_category_seq;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_link_grp_seq
  return varchar2
  as
    l_max     number;
    l_result  varchar2(256);
  begin

    -- fetch max link group display sequence
    select max( v1.display_seq ) as display_seq
    into l_max
    from blog_v_all_link_groups v1
    ;
    -- return next link group display sequence
    l_result := to_char(
      ceil( coalesce( l_max + 1, 1 ) / 10 ) * 10
      ,blog_util.g_number_format
    );

    return l_result;

  end get_link_grp_seq;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_link_seq(
    p_link_group_id in varchar2
  ) return varchar2
  as
    l_result        varchar2(256);
    l_link_group_id number;
    l_max           number;
  begin

    l_link_group_id := to_number( p_link_group_id );

    -- fetch max link display sequence
    select max( v1.display_seq ) as display_seq
    into l_max
    from blog_v_all_links v1
    where 1 = 1
    and link_group_id = l_link_group_id
    ;
    -- return next link display sequence
    l_result := to_char(
      ceil( coalesce( l_max + 1, 1 ) / 10 ) * 10
      ,blog_util.g_number_format
    );

    return l_result;

  end get_link_seq;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function request_to_post_status(
    p_request     in varchar2
  ) return varchar2
  as
  begin
    -- one reason for this function is that APEX 19.2 as bug in switch.
    -- switch not allow return value zero (0)

    -- conver APEX request to post status (blog_posts.is_active)
    return case p_request
      when 'CREATE_DRAFT'
      then '0'
      when 'CREATE'
      then '1'
      when 'SAVE_DRAFT'
      then '0'
      when 'SAVE_AND_PUBLISH'
      then '1'
      when 'REVERT_DRAFT'
      then '0'
      when 'SAVE'
      then '1'
      else '0'
    end;

  end request_to_post_status;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post_tags(
    p_post_id in varchar2,
    p_sep     in varchar2 default ','
  ) return varchar2
  as
    l_post_id number;
    l_tags    varchar2(32700);
  begin

    l_post_id := to_number( p_post_id );

    -- fetch and return comma separated is of post tags
    select listagg( v1.tag, p_sep) within group( order by v1.display_seq ) as tags
    into l_tags
    from blog_v_all_post_tags v1
    where 1 = 1
    and v1.post_id = l_post_id
    ;
    return l_tags;

  exception when no_data_found then
    return null;
  when others then
    raise;
  end get_post_tags;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_category_title(
    p_category_id in varchar2
  ) return varchar2
  as
    l_category_id number;
    l_title       varchar2(4000);
  begin

    l_category_id := to_number( p_category_id );

    -- fetch and return category name
    select t1.title
    into l_title
    from blog_v_all_categories t1
    where t1.id = l_category_id
    ;
    return l_title;

  exception when no_data_found then
    return null;
  when others then
    raise;
  end get_category_title;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_first_paragraph(
    p_body_html in varchar2
  ) return varchar2
  as
    l_first_p       varchar2(32700);
    l_first_p_start number;
    l_first_p_end   number;
  begin

    -- get first paragraph start and end positions
    l_first_p_start := instr( p_body_html, '<p>' );
    l_first_p_end   := instr( p_body_html, '</p>' );

    --post must have at least one paragraph
    if l_first_p_start > 0 and l_first_p_end > 0 then

      l_first_p_start := l_first_p_start - 1;
      l_first_p_end   := l_first_p_end + 3;

      -- get first paragraph
      l_first_p := substr( p_body_html, l_first_p_start, l_first_p_end );

      -- remove whitespace
      l_first_p := replace( regexp_replace( l_first_p, '\s+', ' ' ), '  ', ' ' );

    end if;

    return l_first_p;

  end get_first_paragraph;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function file_upload(
    p_file_name   in varchar2
  ) return boolean
  as
    l_file_exists boolean;
    l_file_names  apex_t_varchar2;
    l_file_name   varchar2(256);
  begin

    l_file_exists := false;

    -- Get file names
    l_file_names := apex_string.split (
      p_str => p_file_name
      ,p_sep => ':'
    );

    apex_collection.create_or_truncate_collection(
      p_collection_name => 'BLOG_FILES'
    );

    -- store uploaded files to apex_collection
    -- if files exists, we prompt user to confirm file overwrite
    for i in 1 .. l_file_names.count
    loop

      l_file_name := substr(l_file_names(i), instr(l_file_names(i), '/') + 1);

      for c1 in(
        select t1.id        as id
          ,t2.id            as file_id
          ,t2.row_version   as row_version
          ,t2.is_active     as is_active
          ,t2.is_download   as is_download
          ,t2.file_desc     as file_desc
          ,t1.mime_type     as mime_type
          ,t1.blob_content  as blob_content
        from apex_application_temp_files t1
        left join blog_v_all_files t2 on t2.file_name = l_file_name
        where 1 = 1
        and t1.name = l_file_names(i)
      ) loop

        l_file_exists := case
          when c1.file_id is not null
          then true
          else l_file_exists
          end
        ;

        apex_collection.add_member(
           p_collection_name => 'BLOG_FILES'
          ,p_n001     => c1.id
          ,p_n002     => c1.file_id
          ,p_n003     => c1.row_version
          ,p_n004     => coalesce(c1.is_active, 1)
          ,p_n005     => coalesce(c1.is_download, 0)
          ,p_c001     => l_file_name
          ,p_c002     => c1.file_desc
          ,p_c003     => c1.mime_type
          ,p_blob001  => c1.blob_content
        );

      end loop;
    end loop;

    -- if non of files exists, insert files to blog_files
    if not l_file_exists then
      merge_files;
    end if;

    return not l_file_exists;

  end file_upload;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function remove_whitespace(
    p_string      in varchar2
  ) return varchar2
  as
  begin
    -- remove whitespace characters from string
    return regexp_replace( p_string, '\s+', ' ' );
  end remove_whitespace;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure merge_files
  as
  begin

    -- insert new files and overwrite existing
    merge into blog_files t1 using blog_v_temp_files v1
    on (t1.id = v1.id)
    when matched then
      update
        set t1.blob_content = v1.blob_content
    when not matched then
      insert (
         is_active
        ,is_download
        ,file_name
        ,mime_type
        ,blob_content
        ,file_desc
      )
      values (
         v1.is_active
        ,v1.is_download
        ,v1.file_name
        ,v1.mime_type
        ,v1.blob_content
        ,v1.file_desc
      );

  end merge_files;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure add_category(
    p_title       in varchar2,
    p_err_mesg    in varchar2,
    p_category_id out nocopy number
  )
  as
    l_seq       number;
    l_value     varchar2(512);
    l_err_mesg  varchar2(32700);
  begin

    p_category_id := null;
    l_value := trim( p_title );

    -- category title must have some value
    if l_value is null then
      -- prepare error message
      l_err_mesg := apex_lang.message( p_err_mesg );

      if l_err_mesg = apex_escape.html( p_err_mesg )
      then
        l_err_mesg := p_err_mesg;
      end if;

      raise_application_error( -20002,  l_err_mesg );

    end if;

    -- get next sequence value
    l_seq   := get_category_seq;

    -- try insert category and return id for out parameter.
    -- if unique constraint violation raised, category exists.
    -- then find category id for out parameter in exception handler
    insert into blog_categories ( is_active, display_seq, title )
    values( 1, l_seq, l_value )
    returning id into p_category_id
    ;

  -- TO DO see item 1 from package specs
  exception when dup_val_on_index then
    -- if category already exists, just fetch id
    l_value := upper( l_value );
    select v1.id
    into p_category_id
    from blog_v_all_categories v1
    where 1 = 1
    and v1.title_unique = l_value
    ;

  end add_category;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure add_post_tags(
    p_post_id in varchar2,
    p_tags    in varchar2,
    p_sep     in varchar2 default ','
  )
  as
    l_post_id     number;
    l_tag_id      number;
    l_display_seq number;
    l_tag_tab     apex_t_varchar2;
    l_tag_id_tab  apex_t_number;
  begin

    l_post_id := to_number( p_post_id );

    -- split tags string to table and loop all values
    l_tag_tab := apex_string.split(
       p_str => p_tags
      ,p_sep => p_sep
    );

    for i in 1 .. l_tag_tab.count
    loop

      -- add tag to repository
      l_tag_id := null;

      add_tag(
         p_tag    => l_tag_tab(i)
        ,p_tag_id => l_tag_id
      );

      if l_tag_id is not null then

        -- collect tag id to table.
        -- table is used at end of procedure for checking relationships between tags and post
        apex_string.push( l_tag_id_tab, l_tag_id );

        -- get table record count for tag display sequence
        l_display_seq:= l_tag_id_tab.count * 10;

        -- tag post
        add_tag_to_post(
           p_post_id     => l_post_id
          ,p_tag_id      => l_tag_id
          ,p_display_seq => l_display_seq
        );

      end if;

    end loop;

    cleanup_post_tags(
       p_post_id => l_post_id
      ,p_tag_tab => l_tag_id_tab
    );
/*
    -- if any relationship was removed, remove unused tags
    if sql%rowcount > 0 then
      remove_unused_tags;
    end if;
*/

  end add_post_tags;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  -- This procedure is not used currently
  procedure remove_unused_tags
  as
  begin
    -- cleanup tags that aren't linked to any post
    delete from blog_tags t1
    where 1 = 1
    and not exists(
      select 1
      from blog_v_all_post_tags x1
      where 1 = 1
      and x1.tag_id = t1.id
    );
  end remove_unused_tags;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  -- this procedure is not used / not ready
  procedure save_post_preview(
    p_id              in varchar2,
    p_tags            in varchar2,
    p_post_title      in varchar2,
    p_category_title  in varchar2,
    p_body_html       in clob
  )
  as
  begin

    delete from blog_post_preview
    where id = p_id
    ;

    insert into blog_post_preview(
       id
      ,tags
      ,post_title
      ,category_title
      ,body_html
    )
    values(
       p_id
      ,p_tags
      ,p_post_title
      ,p_category_title
      ,p_body_html
    )
    ;
  end save_post_preview;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  -- this procedure is not used / not ready
  procedure purge_post_preview
  as
  begin

    -- Delete from blog_post_preview rows where session is expired
    delete from blog_post_preview p
    where not exists (
      select 1
      from apex_workspace_sessions s
      where 1 = 1
      and s.apex_session_id = p.id
    );
  end purge_post_preview;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  -- this procedure is not used / not ready
  procedure purge_post_preview_job(
    p_drop_job in boolean default false
  )
  as
    l_job_name      varchar2(255);
    job_not_exists  exception;
    pragma          exception_init(job_not_exists, -27475);
  begin

    l_job_name := 'BLOG_JOB_PURGE_POST_PREVIEW';

    begin
      sys.dbms_scheduler.drop_job(
        job_name => l_job_name
      );
    exception when job_not_exists then
      null;
    end;

    if not p_drop_job then
      sys.dbms_scheduler.create_job(
         job_name        => l_job_name
        ,job_type        => 'STORED_PROCEDURE'
        ,job_action      => 'blog_conf.purge_post_preview'
        ,start_date      => trunc(localtimestamp, 'HH')
        ,repeat_interval => 'FREQ=DAILY'
        ,enabled         => true
        ,comments        => 'Purge expired sessions posts previews'
      );
    end if;

  end purge_post_preview_job;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function is_integer(
    p_value     in varchar2,
    p_err_mesg  in varchar2
  ) return varchar2
  as
    l_err_mesg varchar2(32700);
  begin

    -- prepare validation error message
    l_err_mesg := apex_lang.message( p_err_mesg );

    if l_err_mesg = apex_escape.html( p_err_mesg )
    then
      l_err_mesg := p_err_mesg;
    end if;

    if round( to_number( p_value ) ) between 1 and 100
    then
      l_err_mesg := null;
    end if;

    return l_err_mesg;

  exception when invalid_number
  or value_error
  then
    return l_err_mesg;
  end is_integer;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function is_url(
    p_value     in varchar2,
    p_err_mesg  in varchar2
  ) return varchar2
  as
    l_err_mesg varchar2(32700);
  begin

    if not regexp_like(p_value, '^https?\:\/\/.*$')
    then
      -- prepare validation error message
      l_err_mesg := apex_lang.message( p_err_mesg );

      if l_err_mesg = apex_escape.html( p_err_mesg )
      then
        l_err_mesg := p_err_mesg;
      end if;
    else
      l_err_mesg := null;
    end if;

    return l_err_mesg;

  end is_url;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function is_date_format(
    p_value     in varchar2,
    p_err_mesg  in varchar2
  ) return varchar2
  as
    l_err_mesg          varchar2(32700);
    invalid_date_format exception;
    pragma              exception_init(invalid_date_format, -1821);
  begin

    -- prepare validation error message
    l_err_mesg := apex_lang.message( p_err_mesg );

    if l_err_mesg = apex_escape.html( p_err_mesg )
    then
      l_err_mesg := p_err_mesg;
    end if;

    if to_char( systimestamp, p_value ) = to_char( systimestamp, p_value )
    then
      l_err_mesg := null;
    end if;

    return l_err_mesg;

  exception when invalid_date_format
  then
    return l_err_mesg;
  end is_date_format;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function is_email(
    p_value     in varchar2,
    p_err_mesg  in varchar2
  ) return varchar2
  as
    l_err_mesg varchar2(32700);
  begin
    -- TO DO see item 3 from package specs
    -- do some basic check for email address
    if not regexp_like(p_value, '^.*\@.*\..*$')
    then
      -- Prepare validation error message
      l_err_mesg := apex_lang.message( p_err_mesg );

      if l_err_mesg = apex_escape.html( p_err_mesg )
      then
        l_err_mesg := p_err_mesg;
      end if;
    else
      l_err_mesg := null;
    end if;

    return l_err_mesg;

  end is_email;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_comment_post_id(
    p_comment_id in varchar2
  ) return varchar2
  as
    l_comment_id  number;
    l_post_id     number;
  begin

    l_comment_id := to_number( p_comment_id );

    -- fetch and return post id for comment
    select v1.post_id
    into l_post_id
    from blog_v_all_comments v1
    where 1 = 1
    and v1.id = l_comment_id
    ;

    return to_char(l_post_id, blog_util.g_number_format );

  end get_comment_post_id;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure send_reply_notify(
    p_app_id          in varchar2,
    p_app_name        in varchar2,
    p_post_id         in varchar2,
    p_email_template  in varchar2
  )
  as
    l_post_id   number;
    l_app_email varchar2(4000);
  begin

    l_post_id := to_number( p_post_id );

    -- fetch application email address
    l_app_email := blog_util.get_attribute_value('APP_EMAIL');

    -- send notify users that have subscribed to replies to comment
    for c1 in(
      select t2.email
      ,json_object (
         'APP_NAME'         value p_app_name
        ,'POST_TITLE'       value v1.title
        ,'POST_LINK'        value
            blog_url.get_post(
               p_app_id     => p_app_id
              ,p_post_id    => v1.id
              ,p_canonical  => 'YES'
            )
        ,'UNSUBSCRIBE_LINK' value
            blog_url.get_unsubscribe(
               p_app_id          => p_app_id
              ,p_post_id         => p_post_id
              ,p_subscription_id => t1.id
            )
       ) as placeholders
      from blog_comment_subs t1
      join blog_comment_subs_email t2
        on t1.email_id = t2.id
      join blog_v_all_posts v1
        on t1.post_id = v1.id
      where 1 = 1
        -- send notification if subscription is created less than month ago
        and t1.created_on >= add_months( localtimestamp, -1 )
        and v1.id = l_post_id
    ) loop

      apex_mail.send (
         p_from => l_app_email
        ,p_to   => c1.email
        ,p_template_static_id => p_email_template
        ,p_placeholders => c1.placeholders
      );

    end loop;

  end send_reply_notify;
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------
end "BLOG_CM";
/
CREATE OR REPLACE package  "BLOG_COMM"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Procedure and functions for public application
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 11.05.2020 - Created
--
--  TO DO:
--    #1  comment HTML validation could improved
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function format_comment(
    p_comment         in varchar2,
    p_remove_anchors  in boolean default false
  ) return varchar2;
--------------------------------------------------------------------------------
  function validate_comment(
    p_comment         in varchar2,
    p_length_err_mesg in varchar2,
    p_parse_err_mesg  in varchar2,
    p_max_length      in number default 4000
  ) return varchar2;
--------------------------------------------------------------------------------
  procedure new_comment_notify(
    p_post_id         in varchar2,
    p_app_name        in varchar2,
    p_email_template  in varchar2
  );
--------------------------------------------------------------------------------
  procedure subscribe(
    p_post_id         in varchar2,
    p_email           in varchar2
  );
--------------------------------------------------------------------------------
  procedure unsubscribe(
    p_subscription_id in varchar2
  );
--------------------------------------------------------------------------------
end "BLOG_COMM";
/


CREATE OR REPLACE package body "BLOG_COMM"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  c_whitelist_tags      constant varchar2(256)  := '<b>,</b>,<i>,</i>,<u>,</u>,<code>,</code>';
  c_code_css_class      constant varchar2(256)  := 'z-program-code';
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure remove_ascii(
    p_string in out nocopy varchar2
  )
  as
  begin
    -- remove unwanted ascii codes
    for i in 0 .. 31
    loop
      if i != 10 then
        p_string := trim( replace( p_string, chr(i) ) );
      end if;
    end loop;
  end remove_ascii;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure remove_anchor(
    p_string in out nocopy varchar2
  )
  as
  begin
    -- remove anchor tags
    p_string := regexp_replace( p_string, '<a[^>]*>(.*?)<\/a>', '', 1, 0, 'i' );
  end remove_anchor;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure escape_html(
    p_string in out nocopy varchar2
  )
  as
  begin

    -- change all hash marks so we can escape those
    -- after calling apex_escape.html_whitelist
    -- escape of hash marks needed to prevent APEX substitutions
    p_string := replace( p_string, '#', '#HashMark#' );

    -- escape comment html
    p_string := apex_escape.html_whitelist(
       p_html            => p_string
      ,p_whitelist_tags  => c_whitelist_tags
    );

    -- escape hash marks
    p_string := replace( p_string, '#HashMark#', '&#x23;' );

  end escape_html;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure build_code_tab(
    p_comment   in out nocopy varchar2,
    p_code_tab  in out nocopy apex_t_varchar2
  )
  as

    l_code_cnt  pls_integer := 0;
    l_start_pos pls_integer := 0;
    l_end_pos   pls_integer := 0;

  begin

    -- check code open tag count
    l_code_cnt := regexp_count( p_comment, '\<code\>', 1, 'i' );

    -- process code tags if open and close count match ( pre check is for valid HTML )
    if l_code_cnt = regexp_count( p_comment, '\<\/code\>', 1, 'i' )
    then

      -- collect content inside code tags to collection
      for i in 1 .. l_code_cnt
      loop

        -- get code start and end position
        l_start_pos := instr( lower( p_comment ), '<code>' );
        l_end_pos := instr( lower( p_comment ), '</code>' );

        -- store code tag content to collection and wrap it to pre tag having class
        apex_string.push(
           p_table => p_code_tab
          ,p_value => '<pre class="' || c_code_css_class || '">'
            || substr(p_comment, l_start_pos  + 6, l_end_pos - l_start_pos - 6)
            || '</pre>'
        );

        -- substitude handled code tag
        p_comment := rtrim( substr( p_comment, 1, l_start_pos - 1 ), chr(10) )
          || chr(10)
          || 'CODE#' || i
          || chr(10)
          || ltrim( substr( p_comment, l_end_pos + 7 ), chr(10) )
        ;

      end loop;

    end if;

  end build_code_tab;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure build_comment_html(
    p_comment in out nocopy varchar2
  )
  as
    l_temp        varchar2(32700);
    l_code_row    number;
    l_code_tab    apex_t_varchar2;
    l_comment_tab apex_t_varchar2;
  begin

    -- process code tags
    build_code_tab(
       p_comment => p_comment
      ,p_code_tab => l_code_tab
    );

    -- split comment to collection by new line character
    l_comment_tab := apex_string.split( p_comment, chr(10) );

    -- comment is stored to collection
    -- start building comment with prober html tags
    p_comment := null;

    -- Format comment
    for i in 1 .. l_comment_tab.count
    loop

      l_temp := trim( l_comment_tab(i) );

      -- check if row is code block
      if regexp_like( l_temp, '^CODE\#[0-9]+$' )
      then
        -- get code block row number
        l_code_row := regexp_substr( l_temp, '[0-9]+' );
        -- close p tag, insert code block
        -- and open p tag again for text
        p_comment := p_comment
          || '</p>'
          || chr(10)
          || l_code_tab(l_code_row)
          || chr(10)
          || '<p>'
        ;

      else
        -- append text if row is not empty
        if l_temp is not null
        then
          -- if we are in first row
          if p_comment is null
          then
            p_comment := l_temp;
          else
            -- check if p tag is opened, then insert br for new line
            p_comment := p_comment
              ||
                case
                when not substr( p_comment, length( p_comment ) - 2 ) = '<p>'
                then '<br />' || chr(10)
                end
              || l_temp
            ;
          end if;
        end if;

      end if;

    end loop;

    -- wrap comment to p tag.
    p_comment := '<p>' || p_comment || '</p>';
    -- there might be empty p, if comment ends code tag, remove that
    p_comment := replace( p_comment, '<p></p>' );

  end build_comment_html;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global functions and procedures
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function format_comment(
    p_comment         in varchar2,
    p_remove_anchors  in boolean default false
  ) return varchar2
  as
    l_comment varchar2(32700);
  begin

    l_comment := p_comment;

    -- remove unwanted ascii codes
    remove_ascii(
       p_string => l_comment
    );
    -- remove all anchors
    if p_remove_anchors
    then
      remove_anchor(
        p_string => l_comment
      );
    end if;
    -- escape HTML
    escape_html(
       p_string => l_comment
    );
    -- build comment HTML
    build_comment_html(
       p_comment => l_comment
    );
    -- return comment
    return l_comment;

  end format_comment;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function validate_comment(
    p_comment         in varchar2,
    p_length_err_mesg in varchar2,
    p_parse_err_mesg  in varchar2,
    p_max_length      in number default 4000
  ) return varchar2
  as
    l_xml       xmltype;
    l_result    varchar2(32700);
    l_err_mesg  varchar2(32700);

    xml_parsing_failed exception;
    pragma exception_init( xml_parsing_failed, -31011 );
  begin

    -- check formatted comment length
    if length( p_comment ) > p_max_length
    then
      -- set error message
      l_err_mesg := p_length_err_mesg;
    else
      -- check HTML is valid
      -- TO DO see item 1 from package specs
      begin
        l_xml := xmltype.createxml(
            '<root><row>'
          || p_comment
          || '</row></root>'
        );
      exception when xml_parsing_failed then
        -- set error message
        l_err_mesg := p_parse_err_mesg;
      end;

    end if;

    if l_err_mesg is not null
    then
      -- prepare return validation error message
      l_result := apex_lang.message( l_err_mesg );

      if l_result = apex_escape.html( l_err_mesg )
      then
        l_result := l_err_mesg;
      end if;

    end if;
    -- return validation result
    -- if validation fails we return error message stored to variable
    return l_result;

  end validate_comment;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure new_comment_notify(
    p_post_id         in varchar2,
    p_app_name        in varchar2,
    p_email_template  in varchar2
  )
  as
    l_post_id   number;
    l_app_email varchar2(4000);
  begin

    -- fetch application email address
    l_app_email := blog_util.get_attribute_value('APP_EMAIL');

    l_post_id   := to_number( p_post_id );

    -- get values for APEX email template
    -- send notify email if blog email address is set
    -- and blogger has set email
    for c1 in(
      select v1.blogger_email
        ,json_object (
           'APP_NAME'     value p_app_name
          ,'BLOGGER_NAME' value v1.blogger_name
          ,'POST_TITLE'   value v1.title
          ,'POST_LINK'    value
              blog_url.get_post(
                 p_post_id => v1.id
                ,p_canonical => 'YES'
              )
        ) as placeholders
      from blog_v_all_posts v1
      where 1 = 1
      and v1.id = l_post_id
      and v1.blogger_email is not null
      and l_app_email is not null
    ) loop
      -- send notify email
      apex_mail.send (
         p_to                 => c1.blogger_email
        ,p_from               => l_app_email
        ,p_template_static_id => p_email_template
        ,p_placeholders       => c1.placeholders
      );
    end loop;

  end new_comment_notify;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure subscribe(
    p_post_id in varchar2,
    p_email   in varchar2
  )
  as
    l_email     varchar2(256);
    l_post_id   number;
    l_email_id  number;
  begin

    l_email   := trim( lower( p_email ) );
    l_post_id := to_number( p_post_id );

    -- subscribe user to get notify on reply to comment
    if p_email is not null
    and p_post_id is not null
    then
      -- store email address and return id
      begin
        insert into
          blog_comment_subs_email( email, is_active )
        values ( l_email, 1 )
        returning id into l_email_id
        ;
      -- if email address already exists, fetch id
      exception when dup_val_on_index
      then
        select id
        into l_email_id
        from blog_comment_subs_email
        where 1 = 1
        and email_unique = l_email
        ;
      end;
      -- store post to email link
      insert into
        blog_comment_subs( post_id, email_id )
      values
        ( p_post_id, l_email_id )
      ;
    end if;
  -- if subscription already exists, do nothing
  exception when dup_val_on_index
  then
    null;
  end subscribe;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure unsubscribe(
    p_subscription_id in varchar2
  )
  as
  begin
    -- remove user subscribtion to get notify from replies
    delete
      from blog_comment_subs
    where 1 = 1
    and id = p_subscription_id
    ;
  end unsubscribe;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end "BLOG_COMM";
/
CREATE OR REPLACE package "BLOG_HTML"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Functions to generate and return HTML code
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 22.04.2019 - Created
--    Jari Laine 29.04.2020 - New function get_robots_noindex_meta
--                            Functions to generate canonical link outputs robot noindex meta tag
--                            if proper link can't be generated
--                            Added apex_debug to functions generating meta and canonical link
--    Jari Laine 10.05.2020 - Utilize blog_url functions p_canonical
--    Jari Laine 19.05.2020 - Removed obsolete function get_search_button
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_META_ROBOTS_NOINDEX
  function get_robots_noindex_meta return varchar2;
--------------------------------------------------------------------------------
  function get_tag_anchor(
    p_tag_id              in number,
    p_app_id              in varchar2,
    p_tag                 in varchar2,
    p_button              in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_META_HOME_DESCRIPTION
  function get_description_meta(
    p_desc                in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_META_POST_DESCRIPTION
  function get_post_description_meta(
    p_post_id             in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_CANONICAL_LINK_TAB
  function get_tab_canonical_link(
    p_app_page_id         in varchar2,
    p_app_id              in varchar2 default null
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_CANONICAL_LINK_POST
  function get_post_canonical_link(
    p_post_id             in varchar2,
    p_app_id              in varchar2 default null
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_CANONICAL_LINK_CATEGORY
  function get_category_canonical_link(
    p_category_id         in varchar2,
    p_app_id              in varchar2 default null
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_CANONICAL_LINK_ARCHIVE
  function get_archive_canonical_link(
    p_archive_id          in varchar2,
    p_app_id              in varchar2 default null
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_CANONICAL_LINK_TAG
  function get_tag_canonical_link(
    p_tag_id              in varchar2,
    p_app_id              in varchar2 default null
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_RSS_ANCHOR
  function get_rss_anchor(
    p_app_name            in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app shortcut BLOG_RSS_LINK
  function get_rss_link(
    p_app_name            in varchar2,
    p_build_option_status in varchar2 default 'INCLUDE'
  ) return varchar2;
--------------------------------------------------------------------------------
  -- called from pub app classic report on pages 2, 3, 6, 14, 15
  function get_post_tags(
    p_post_id             in number,
    p_app_id              in varchar2 default null,
    p_button              in varchar2 default 'YES'
  ) return varchar2;
--------------------------------------------------------------------------------
  -- not ready / not unused
  function get_preview_tags(
    p_tags                in varchar2
  ) return varchar2;
--------------------------------------------------------------------------------
end "BLOG_HTML";
/


CREATE OR REPLACE package body "BLOG_HTML"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure get_tag_anchor(
    p_tag_id  in number,
    p_app_id  in varchar2,
    p_tag     in varchar2,
    p_button  in varchar2,
    p_tags    in out nocopy varchar2
  )
  as
  begin
    -- generate HTML for tag
    if p_tag is null then
      p_tags := p_tags;
    else
      -- generate button
      if p_button = 'YES' then
        p_tags := p_tags
          ||  get_tag_anchor(
                p_tag_id  => p_tag_id
                ,p_app_id => p_app_id
                ,p_tag    => p_tag
                ,p_button => p_button
              );
      else
      -- generate anchor tag
        p_tags := p_tags
          ||  case when p_tags is not null then ',' end
          ||  get_tag_anchor(
                p_tag_id  => p_tag_id
                ,p_app_id => p_app_id
                ,p_tag    => p_tag
                ,p_button => p_button
              );
      end if;
    end if;
  end get_tag_anchor;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global functions and procedures
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_robots_noindex_meta return varchar2
  as
  begin
    return '<meta name="robots" value="noindex" />';
  end get_robots_noindex_meta;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tag_anchor(
    p_tag_id  in number,
    p_app_id  in varchar2,
    p_tag     in varchar2,
    p_button  in varchar2
  ) return varchar2
  as
    l_tag varchar2(4000);
    l_url varchar2(4000);
  begin

    -- generate HTML for tag
    if p_tag is not null then

      l_tag := apex_escape.html( p_tag );

      -- get URL for tag
      l_url :=  blog_url.get_tag(
        p_tag_id => p_tag_id
        ,p_app_id => p_app_id
      );


      if p_button = 'YES' then
        -- generate button
        l_tag := '<a href="'
          || l_url
          || '"'
          || ' class="t-Button'
          || ' t-Button--icon'
          || ' t-Button--noUI'
--          || ' t-Button--small'
--          || ' t-Button--hot'
--          || ' t-Button--link'
--          || ' t-Button--simple'
          || ' t-Button--iconLeft'
          || ' margin-top-sm'
          || '">'
          || '<span class="t-Icon fa fa-tag" aria-hidden="true"></span>'
          || l_tag
          || '</a>'
        ;

      else
        -- generate anchor tag
        l_tag := '<a href="'
          || l_url
          || '"'
          || ' class="margin-bottom-md margin-left-sm">'
          || l_tag
          || '</a>'
        ;

      end if;

    end if;

    return l_tag;

  end get_tag_anchor;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_description_meta(
    p_desc in varchar2
  ) return varchar2
  as
    l_html varchar2(32700);
  begin
    -- generate description meta tag
    if p_desc is not null then
      l_html :=
        '<meta name="description" content="'
        || apex_escape.html_attribute( p_desc )
        || '"/>'
      ;
    else
      apex_debug.warn('Description meta tag not generated.');
    end if;

    return l_html;

  end get_description_meta;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post_description_meta(
    p_post_id in varchar2
  ) return varchar2
  as
    l_post_desc varchar2(32700);
  begin
    -- generate description meta tag for post
    select v1.post_desc
    into l_post_desc
    from blog_v_posts v1
    where 1= 1
    and v1.post_id = p_post_id
    ;
    return get_description_meta(
      p_desc => l_post_desc
    );
  exception when no_data_found then
    apex_debug.warn( 'No data found to generate description meta tag for post id %s', p_post_id );
    return null;
  end get_post_description_meta;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tab_canonical_link(
    p_app_page_id     in varchar2,
    p_app_id          in varchar2 default null
  ) return varchar2
  as
    l_html varchar2(32700);
  begin
    -- generate canonical link for tab
    if p_app_page_id is not null then
      l_html :=
        '<link rel="canonical" href="'
        || blog_url.get_tab(
           p_app_id       => p_app_id
          ,p_app_page_id  => p_app_page_id
          ,p_canonical    => 'YES'
        )
        || '" />'
      ;
    else
      -- if p_app_page_id is not defined then generate
      -- robots no index meta tag
      apex_debug.warn( 'Canonical link tag not generated for tab.');
      l_html := get_robots_noindex_meta;
    end if;

    return l_html;

  end get_tab_canonical_link;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post_canonical_link(
    p_post_id       in varchar2,
    p_app_id        in varchar2 default null
  ) return varchar2
  as
    l_html varchar2(32700);
  begin
    -- generate canonical link for post
    if p_post_id is not null then
      l_html :=
        '<link rel="canonical" href="'
        || blog_url.get_post(
           p_post_id      => p_post_id
          ,p_app_id       => p_app_id
          ,p_session      => ''
          ,p_canonical => 'YES'
        )
        || '" />'
      ;
    else
      apex_debug.warn('Canonical link tag not generated for post.');
      l_html := get_robots_noindex_meta;
    end if;

    return l_html;

  end get_post_canonical_link;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_category_canonical_link(
    p_category_id   in varchar2,
    p_app_id        in varchar2 default null
  ) return varchar2
  as
    l_html varchar2(32700);
  begin
    -- generate canonical link for category
    if p_category_id is not null
    then
      l_html :=
        '<link rel="canonical" href="'
        || blog_url.get_category(
           p_category_id  => p_category_id
          ,p_app_id       => p_app_id
          ,p_session      => ''
          ,p_canonical => 'YES'
        )
        || '" />'
      ;
    else
      apex_debug.warn( 'Canonical link tag not generated for category.');
      l_html := get_robots_noindex_meta;
    end if;

    return l_html;

  end get_category_canonical_link;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_archive_canonical_link(
    p_archive_id    in varchar2,
    p_app_id        in varchar2 default null
  ) return varchar2
  as
    l_html varchar2(32700);
  begin
      -- generate canonical link for archives
    if p_archive_id is not null
    then
      l_html :=
        '<link rel="canonical" href="'
        || blog_url.get_archive(
           p_archive_id   => p_archive_id
          ,p_app_id       => p_app_id
          ,p_session      => ''
          ,p_canonical => 'YES'
        )
        || '" />'
      ;
    else
      apex_debug.warn( 'Canonical link tag not generated for archive.');
      l_html := get_robots_noindex_meta;
    end if;

    return l_html;

  end get_archive_canonical_link;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tag_canonical_link(
    p_tag_id        in varchar2,
    p_app_id        in varchar2 default null
  ) return varchar2
  as
  begin
    -- generate canonical link for tags
    if p_tag_id is not null then
      return
        '<link rel="canonical" href="'
        || blog_url.get_tag(
           p_tag_id       => p_tag_id
          ,p_app_id       => p_app_id
          ,p_session      => ''
          ,p_canonical    => 'YES'
        )
        || '" />'
      ;
    else
      apex_debug.warn('Canonical link tag not generated for tag.');
      return get_robots_noindex_meta;
    end if;
  end get_tag_canonical_link;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_rss_anchor(
    p_app_name in varchar2
  ) return varchar2
  as
    l_rss_url varchar2(4000);
    l_rss_title varchar2(4000);
  begin

    -- generate RSS anchor
    l_rss_title := apex_lang.message( 'BLOG_RSS_TITLE', p_app_name );

    l_rss_url := blog_util.get_attribute_value( 'RSS_URL' );

    if l_rss_url is not null
    then
      l_rss_url :=
        '<a href="'
        || l_rss_url
        || '" rel="alternate" type="application/rss+xml" aria-label="'
        || l_rss_title
        || '" class="t-Button t-Button--noLabel t-Button--icon t-Button--link">'
        || '<span aria-hidden="true" class="fa fa-rss-square fa-3x fa-lg u-color-8-text"></span>'
        || '</a>'
      ;
    else
      apex_debug.warn('RSS URL is empty. RSS anchor not generated.');
      l_rss_url := '<small>RSS url is not set</small>';
    end if;

    return l_rss_url;

  end get_rss_anchor;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_rss_link(
    p_app_name            in varchar2,
    p_build_option_status in varchar2 default 'INCLUDE'
  ) return varchar2
  as
    l_rss_url varchar2(4000);
    l_rss_title varchar2(4000);
  begin
    -- generate link for rss

    l_rss_url := blog_util.get_attribute_value( 'RSS_URL' );

    if p_build_option_status = 'INCLUDE'
    and l_rss_url is not null
    then
      l_rss_title := apex_lang.message( 'BLOG_RSS_TITLE', p_app_name );
      --l_rss_title := apex_escape.html_attribute( l_rss_title );
      l_rss_url :=
        '<link rel="alternate" type="application/rss+xml" href="'
        || l_rss_url
        || '" title="'
        || l_rss_title
        || '"/>'
      ;
    else
      if l_rss_url is null
      then
        apex_debug.warn('RSS  URL is empty. RSS link for header not generated.');
      end if;
      l_rss_url := '<!-- no feed link -->';
    end if;

    return l_rss_url;

  end get_rss_link;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post_tags(
    p_post_id in number,
    p_app_id  in varchar2 default null,
    p_button  in varchar2 default 'YES'
  ) return varchar2
  as
    l_tags varchar2(32700);
  begin
    -- generate html for post tags
    select listagg(
      get_tag_anchor(
         p_tag_id => v1.tag_id
        ,p_app_id => p_app_id
        ,p_tag    => v1.tag
        ,p_button => p_button
      ), case when p_button != 'YES' then ', ' end)
    within group(order by v1.display_seq) as tags
    into l_tags
    from blog_v_post_tags v1
    where 1 = 1
    and v1.post_id = p_post_id
    ;
    return l_tags;

  end get_post_tags;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_preview_tags(
    p_tags in varchar2
  ) return varchar2
  as
    l_tags      varchar2(32700);
    l_tags_tab  apex_t_varchar2;
  begin

    l_tags_tab := apex_string.split( p_tags, ',' );
    -- Loop tags to generate tags links
    for i in 1 .. l_tags_tab.count
    loop
      get_tag_anchor(
         p_tag_id => null
        ,p_app_id => null
        ,p_tag    => trim(l_tags_tab(i))
        ,p_button => 'YES'
        ,p_tags   => l_tags
      );
    end loop;

    return l_tags;

  end get_preview_tags;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end "BLOG_HTML";
/
CREATE OR REPLACE package "BLOG_XML"
authid definer
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  DESCRIPTION
--    Procedure and functions to generate e.g. RSS feed and sitemap
--
--  MODIFIED (DD.MM.YYYY)
--    Jari Laine 07.05.2019 - Created
--    Jari Laine 08.01.2020 - Removed categories sitemap
--    Jari Laine 08.01.2020 - Modified use ORDS and blog version 4
--    Jari Laine 09.04.2020 - Utilize blog_url functions parameter p_canonical
--    Jari Laine 17.05.2020 - Removed private function get_app_alias
--                            and constant c_pub_app_id
--                            Moved private function get_ords_service to blog_ords package
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure rss(
    p_lang in varchar2 default 'en'
  );
--------------------------------------------------------------------------------
  procedure sitemap_index;
--------------------------------------------------------------------------------
  procedure sitemap_main;
--------------------------------------------------------------------------------
  procedure sitemap_posts;
--------------------------------------------------------------------------------
end "BLOG_XML";
/


CREATE OR REPLACE package body "BLOG_XML"
as
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private constants and variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Private procedures and functions
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- none
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global functions and procedures
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure rss(
    p_lang in varchar2 default 'en'
  )
  as
    l_rss           blob;
    l_rss_url       varchar2(4000);
    l_rss_desc      varchar2(4000);
    l_home_url      varchar2(4000);
    l_app_id        varchar2(4000);
    l_blog_name     varchar2(4000);
    l_rss_version   constant varchar2(5) := '2.0';
  begin

    -- RSS feed URL
    l_rss_url   := blog_util.get_attribute_value( 'RSS_URL' );
    -- blog name
    l_blog_name := blog_util.get_attribute_value( 'G_APP_NAME' );
    -- rss feed description
    l_rss_desc  := blog_util.get_attribute_value( 'G_APP_DESC' );
    -- blog application id
    l_app_id    := blog_util.get_attribute_value( 'G_PUB_APP_ID' );
    -- blog home page absulute URL
    l_home_url  := blog_url.get_tab(
       p_app_id => l_app_id
      ,p_canonical => 'YES'
    );

    -- generate RSS
    select xmlserialize( document
      xmlelement(
        "rss", xmlattributes(
           l_rss_version as "version"
          ,'http://purl.org/dc/elements/1.1/' as "xmlns:dc"
          ,'http://www.w3.org/2005/Atom'      as "xmlns:atom"
        )
        ,xmlelement(
          "channel"
          ,xmlelement(
             "atom:link"
            ,xmlattributes(
               'self'                         as "rel"
              ,l_rss_url                      as "href"
              ,'application/rss+xml'          as "type"
            )
          )
          ,xmlforest(
             l_blog_name                      as "title"
            ,l_home_url                       as "link"
            ,l_rss_desc                       as "description"
            ,p_lang                           as "language"
          )
          ,xmlagg(
            xmlelement(
               "item"
              ,xmlelement( "title",       posts.post_title )
              ,xmlelement( "dc:creator",  posts.blogger_name )
              ,xmlelement( "category",    posts.category_title )
              ,xmlelement( "link",        blog_url.get_post(
                                             p_app_id     => l_app_id
                                            ,p_post_id    => posts.post_id
                                            ,p_canonical  => 'YES'
                                          )
              )
              ,xmlelement( "description", posts.post_desc )
              ,xmlelement( "pubDate", to_char( sys_extract_utc( posts.published_on ), 'Dy, DD Mon YYYY HH24:MI:SS "GMT"' ) )
              ,xmlelement( "guid", xmlattributes( 'false' as "isPermaLink" ), posts.post_id )
            ) order by posts.published_on desc
          )
        )
      --).getclobval()
      --).getblobval(nls_charset_id('AL32UTF8'))
      )
    as blob encoding 'UTF-8' indent size=2)
    into l_rss
    from blog_v_posts_last20 posts
    ;

    owa_util.mime_header( 'application/rss+xml', false, 'UTF-8' );
--    owa_util.mime_header('application/xml', false, 'UTF-8' );
    sys.htp.p( 'Cache-Control: max-age=3600, public' );
    sys.owa_util.http_header_close;

    wpg_docload.download_file(l_rss);

  end rss;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure sitemap_index
  as
    l_xml   blob;
    l_url   varchar2(4000);
    l_main  varchar2(255);
    l_posts varchar2(255);
  begin

    l_url :=  blog_util.get_attribute_value( 'CANONICAL_URL' );

    l_main := l_url
      || blog_ords.get_module_path
      || 'sitemap/main'
    ;

    l_posts := l_url
      || blog_ords.get_module_path
      || 'sitemap/posts'
    ;

    with si as (
      select 1 as grp
        ,l_main as loc
      from dual
      union all
        select 2 as grp
        ,l_posts as loc
      from dual
    )
    select xmlserialize( document
      xmlelement(
        "sitemapindex",
        xmlattributes('http://www.sitemaps.org/schemas/sitemap/0.9' as "xmlns"),
        (
          xmlagg(
              xmlelement("sitemap"
              ,xmlelement("loc", loc )
            ) order by grp
          )
        )
      )
    as blob encoding 'UTF-8' indent size=2)
    into l_xml
    from si
    ;

    owa_util.mime_header('application/xml', false, 'UTF-8');
    sys.htp.p('Cache-Control: max-age=3600, public' );
    sys.owa_util.http_header_close;

    wpg_docload.download_file(l_xml);

  end sitemap_index;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure sitemap_main
  as
    l_xml     blob;
    l_app_id  varchar2(256);
    l_pub_id  number;
  begin

    l_app_id := blog_util.get_attribute_value( 'G_PUB_APP_ID' );
    l_pub_id := to_number( l_app_id );

    select xmlserialize( document
      xmlelement(
        "urlset",
        xmlattributes('http://www.sitemaps.org/schemas/sitemap/0.9' as "xmlns"),
        (
          xmlagg(
              xmlelement("url"
              ,xmlelement("loc",  blog_url.get_tab(
                                     p_app_id  => l_app_id
                                    ,p_app_page_id => li.entry_attribute_10
                                    ,p_canonical => 'YES'
                                  )
              )
--            ,XMLElement( "lastmod", to_char( sysdate, 'YYYY-MM-DD' ) )
--            ,XMLElement( "changefreq", 'monthly' )
--            ,XMLElement( "priority", '0.5' )
            )
          )
        )
      )
    as blob encoding 'UTF-8' indent size=2)
    into l_xml
    from apex_application_list_entries li
    where 1 = 1
      and li.list_name = 'Desktop Navigation Menu'
      and li.application_id = l_pub_id
    and not exists(
      select 1
      from apex_application_build_options bo
      where 1 = 1
        and bo.application_id = l_pub_id
        and bo.build_option_name = li.build_option
        and bo.build_option_status = 'Exclude'
    );

    owa_util.mime_header('application/xml', false, 'UTF-8');
    sys.htp.p('Cache-Control: max-age=3600, public' );
    sys.owa_util.http_header_close;

    wpg_docload.download_file(l_xml);

  end sitemap_main;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  procedure sitemap_posts
  as
    l_xml     blob;
    l_app_id  varchar2(256);
  begin

    l_app_id := blog_util.get_attribute_value( 'G_PUB_APP_ID' );

    select xmlserialize( document
      xmlelement(
        "urlset",
        xmlattributes('http://www.sitemaps.org/schemas/sitemap/0.9' as "xmlns"),
        (
          xmlagg(
              xmlelement( "url"
                ,xmlelement( "loc", blog_url.get_post(
                                       p_app_id     => l_app_id
                                      ,p_post_id    => posts.post_id
                                      ,p_canonical  => 'YES'
                                    )
                )
                ,XMLElement( "lastmod", to_char( sys_extract_utc( posts.changed_on ), 'YYYY-MM-DD"T"HH24:MI:SS"+00:00""' ) )
--              ,XMLElement("changefreq", 'monthly')
--              ,XMLElement("priority", '0.5')
              ) order by posts.published_on desc
          )
        )
      )
    as blob encoding 'UTF-8' indent size=2)
    into l_xml
    from blog_v_posts posts
    ;

    owa_util.mime_header('application/xml', false, 'UTF-8');
    sys.htp.p('Cache-Control: max-age=3600, public' );
    sys.owa_util.http_header_close;

    wpg_docload.download_file(l_xml);

  end sitemap_posts;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end "BLOG_XML";
/
--------------------------------------------------------
--  DDL for Trigger BLOG_BLOGGERS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_BLOGGERS_TRG"
before
insert or
update on blog_bloggers
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );

  elsif updating then
    :new.row_version := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context('USERENV','PROXY_USER')
    ,sys_context('USERENV','SESSION_USER')
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_CATEGORIES_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_CATEGORIES_TRG"
before
insert or
update on blog_categories
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );
  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on   := localtimestamp;
  :new.changed_by   := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context('USERENV','PROXY_USER')
    ,sys_context('USERENV','SESSION_USER')
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_COMMENTS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_COMMENTS_TRG"
before
insert or
update on blog_comments
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context( 'USERENV','PROXY_USER' )
      ,sys_context( 'USERENV','SESSION_USER' )
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context( 'USERENV','PROXY_USER' )
    ,sys_context( 'USERENV','SESSION_USER' )
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_COMMENT_FLAGS_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "BLOG_COMMENT_FLAGS_TRG" 
before
insert or
update on blog_comment_flags
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context( 'USERENV','PROXY_USER' )
      ,sys_context( 'USERENV','SESSION_USER' )
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context( 'USERENV','PROXY_USER' )
    ,sys_context( 'USERENV','SESSION_USER' )
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_COMMENT_SUBS_EMAIL_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_COMMENT_SUBS_EMAIL_TRG"
before
insert or
update on blog_comment_subs_email
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context( 'USERENV','PROXY_USER' )
      ,sys_context( 'USERENV','SESSION_USER' )
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context( 'USERENV','PROXY_USER' )
    ,sys_context( 'USERENV','SESSION_USER' )
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_COMMENT_SUBS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_COMMENT_SUBS_TRG"
before
insert or
update on blog_comment_subs
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context( 'USERENV','PROXY_USER' )
      ,sys_context( 'USERENV','SESSION_USER' )
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context( 'USERENV','PROXY_USER' )
    ,sys_context( 'USERENV','SESSION_USER' )
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_FILES_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_FILES_TRG"
before
insert or
update on blog_files
for each row
begin

  if inserting then

    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       :new.created_by
      ,sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context('USERENV','PROXY_USER')
    ,sys_context('USERENV','SESSION_USER')
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_LINKS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_LINKS_TRG"
before
insert or
update on blog_links
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );
  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context('USERENV','PROXY_USER')
    ,sys_context('USERENV','SESSION_USER')
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_LINK_GROUPS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_LINK_GROUPS_TRG"
before
insert or
update on blog_link_groups
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       :new.created_by
      ,sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );
  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_POSTS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_POSTS_TRG"
before
insert or
update on blog_posts
for each row
begin

  if inserting then
    :new.id := coalesce( :new.id,
      to_number( to_char( sys_extract_utc( systimestamp ), 'YYYYMMDDHH24MISSFF6' ) )
    );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context( 'USERENV','PROXY_USER' )
      ,sys_context( 'USERENV','SESSION_USER' )
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.published_on := coalesce( :new.published_on, localtimestamp );

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context( 'USERENV','PROXY_USER' )
      ,sys_context( 'USERENV','SESSION_USER' )
    );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_POST_TAGS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_POST_TAGS_TRG"
before
insert or
update on blog_post_tags
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );
  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on   := localtimestamp;
  :new.changed_by   := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context('USERENV','PROXY_USER')
    ,sys_context('USERENV','SESSION_USER')
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_SETTINGS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_SETTINGS_TRG"
before
insert or
update on blog_settings
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context('USERENV','PROXY_USER')
    ,sys_context('USERENV','SESSION_USER')
  );

end;
/
--------------------------------------------------------
--  DDL for Trigger BLOG_TAGS_TRG
--------------------------------------------------------
CREATE OR REPLACE EDITIONABLE TRIGGER "BLOG_TAGS_TRG"
before
insert or
update on blog_tags
for each row
begin

  if inserting then
    :new.id           := coalesce( :new.id, blog_seq.nextval );
    :new.row_version  := coalesce( :new.row_version, 1 );
    :new.created_on   := localtimestamp;
    :new.created_by   := coalesce(
       sys_context( 'APEX$SESSION', 'APP_USER' )
      ,sys_context('USERENV','PROXY_USER')
      ,sys_context('USERENV','SESSION_USER')
    );

  elsif updating then
    :new.row_version  := :old.row_version + 1;
  end if;

  :new.changed_on := localtimestamp;
  :new.changed_by := coalesce(
     sys_context( 'APEX$SESSION', 'APP_USER' )
    ,sys_context('USERENV','PROXY_USER')
    ,sys_context('USERENV','SESSION_USER')
  );

end;
/
--------------------------------------------------------
--  DDL for Foreign Keys
--------------------------------------------------------
ALTER TABLE BLOG_COMMENTS ADD CONSTRAINT BLOG_COMMENTS_FK1 FOREIGN KEY (POST_ID)
  REFERENCES BLOG_POSTS (ID) ON DELETE CASCADE ENABLE;

ALTER TABLE BLOG_COMMENTS ADD CONSTRAINT BLOG_COMMENTS_FK2 FOREIGN KEY (PARENT_ID)
  REFERENCES BLOG_COMMENTS (ID) ON DELETE SET NULL ENABLE;

ALTER TABLE BLOG_COMMENT_FLAGS ADD CONSTRAINT BLOG_COMMENT_FLAGS_FK1 FOREIGN KEY (COMMENT_ID)
  REFERENCES BLOG_COMMENTS (ID) ON DELETE CASCADE ENABLE;

ALTER TABLE BLOG_COMMENT_SUBS ADD CONSTRAINT BLOG_COMMENT_SUBS_FK1 FOREIGN KEY (POST_ID)
  REFERENCES BLOG_POSTS (ID) ON DELETE CASCADE ENABLE;

ALTER TABLE BLOG_COMMENT_SUBS ADD CONSTRAINT BLOG_COMMENT_SUBS_FK2 FOREIGN KEY (EMAIL_ID)
  REFERENCES BLOG_COMMENT_SUBS_EMAIL (ID) ON DELETE CASCADE ENABLE;

ALTER TABLE BLOG_INIT_ITEMS ADD CONSTRAINT BLOG_INIT_ITEMS_FK1 FOREIGN KEY (ITEM_NAME)
  REFERENCES BLOG_SETTINGS (ATTRIBUTE_NAME) ENABLE;

ALTER TABLE BLOG_LINKS ADD CONSTRAINT BLOG_LINKS_FK1 FOREIGN KEY (LINK_GROUP_ID)
  REFERENCES BLOG_LINK_GROUPS (ID) ON DELETE CASCADE ENABLE;

ALTER TABLE BLOG_POSTS ADD CONSTRAINT BLOG_POSTS_FK1 FOREIGN KEY (BLOGGER_ID)
  REFERENCES BLOG_BLOGGERS (ID) ENABLE;

ALTER TABLE BLOG_POSTS ADD CONSTRAINT BLOG_POSTS_FK2 FOREIGN KEY (CATEGORY_ID)
  REFERENCES BLOG_CATEGORIES (ID) ENABLE;

ALTER TABLE BLOG_POST_TAGS ADD CONSTRAINT BLOG_POST_TAGS_FK1 FOREIGN KEY (POST_ID)
  REFERENCES BLOG_POSTS (ID) ON DELETE CASCADE ENABLE;

ALTER TABLE BLOG_POST_TAGS ADD CONSTRAINT BLOG_POST_TAGS_FK2 FOREIGN KEY (TAG_ID)
  REFERENCES BLOG_TAGS (ID) ENABLE;
