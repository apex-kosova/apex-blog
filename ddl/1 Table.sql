CREATE TABLE  BLOG_ACTIVITY_LOG1
(    ACTIVITY_DATE DATE DEFAULT SYSDATE,
ACTIVITY_TYPE VARCHAR2(40 CHAR),
APEX_SESSION_ID NUMBER(38,0),
RELATED_ID NUMBER(38,0),
IP_ADDRESS VARCHAR2(500 CHAR),
USER_ID NUMBER(38,0),
LATITUDE NUMBER(9,6),
LONGITUDE NUMBER(9,6),
COUNTRY_CODE VARCHAR2(2 CHAR),
COUNTRY_REGION VARCHAR2(255 CHAR),
COUNTRY_CITY VARCHAR2(255 CHAR),
HTTP_USER_AGENT VARCHAR2(2000 CHAR),
HTTP_REFERER VARCHAR2(2000 CHAR),
SEARCH_TYPE VARCHAR2(80 CHAR),
SEARCH_CRITERIA VARCHAR2(4000 CHAR),
ADDITIONAL_INFO VARCHAR2(4000 CHAR)
) NOLOGGING
/
CREATE TABLE  BLOG_ACTIVITY_LOG2
(    ACTIVITY_DATE DATE DEFAULT SYSDATE,
ACTIVITY_TYPE VARCHAR2(40 CHAR),
APEX_SESSION_ID NUMBER(38,0),
RELATED_ID NUMBER(38,0),
IP_ADDRESS VARCHAR2(500 CHAR),
USER_ID NUMBER(38,0),
LATITUDE NUMBER(9,6),
LONGITUDE NUMBER(9,6),
COUNTRY_CODE VARCHAR2(2 CHAR),
COUNTRY_REGION VARCHAR2(255 CHAR),
COUNTRY_CITY VARCHAR2(255 CHAR),
HTTP_USER_AGENT VARCHAR2(2000 CHAR),
HTTP_REFERER VARCHAR2(2000 CHAR),
SEARCH_TYPE VARCHAR2(80 CHAR),
SEARCH_CRITERIA VARCHAR2(4000 CHAR),
ADDITIONAL_INFO VARCHAR2(4000 CHAR)
) NOLOGGING
/
CREATE TABLE  BLOG_COMMENT_USER
(    USER_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
EMAIL VARCHAR2(256 CHAR) NOT NULL ENABLE,
NICK_NAME VARCHAR2(80 CHAR) NOT NULL ENABLE,
BLOCKED VARCHAR2(1 CHAR) DEFAULT 'N' NOT NULL ENABLE,
BLOCKED_ON DATE,
WEBSITE VARCHAR2(256 CHAR),
USER_TYPE VARCHAR2(1) DEFAULT 'R' NOT NULL ENABLE,
CONSTRAINT BLOG_COMMENT_USER_CK1 CHECK (USER_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_USER_CK2 CHECK (BLOCKED IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_COMMENT_USER_PK PRIMARY KEY (USER_ID) ENABLE,
CONSTRAINT BLOG_COMMENT_USER_UK1 UNIQUE (EMAIL) ENABLE,
CONSTRAINT BLOG_COMMENT_USER_UK2 UNIQUE (NICK_NAME) ENABLE,
CONSTRAINT BLOG_COMMENT_USER_CK3 CHECK ((BLOCKED = 'N' AND BLOCKED_ON IS NULL) OR (BLOCKED = 'Y' AND BLOCKED_ON IS NOT NULL)) ENABLE,
CONSTRAINT BLOG_COMMENT_USER_CK4 CHECK (USER_TYPE IN('R', 'A')) ENABLE
)
/
CREATE TABLE  BLOG_AUTHOR
(    AUTHOR_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
ACTIVE VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL ENABLE,
EMAIL VARCHAR2(256 CHAR) NOT NULL ENABLE,
USER_NAME VARCHAR2(30 CHAR) NOT NULL ENABLE,
PASSWD VARCHAR2(2000 CHAR),
AUTHOR_NAME VARCHAR2(80 CHAR) NOT NULL ENABLE,
BIO VARCHAR2(4000 CHAR),
AUTHOR_SEQ NUMBER(2,0) NOT NULL ENABLE,
EMAIL_NOTIFY VARCHAR2(1) DEFAULT 'Y' NOT NULL ENABLE,
CONSTRAINT BLOG_AUTHOR_CK1 CHECK (AUTHOR_ID > 0) ENABLE,
CONSTRAINT BLOG_AUTHOR_CK2 CHECK (AUTHOR_SEQ BETWEEN 1 AND 99) ENABLE,
CONSTRAINT BLOG_AUTHOR_CK3 CHECK (ACTIVE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_AUTHOR_PK PRIMARY KEY (AUTHOR_ID) ENABLE,
CONSTRAINT BLOG_AUTHOR_UK1 UNIQUE (EMAIL) ENABLE,
CONSTRAINT BLOG_AUTHOR_UK2 UNIQUE (USER_NAME) ENABLE,
CONSTRAINT BLOG_AUTHOR_UK3 UNIQUE (AUTHOR_SEQ) ENABLE,
CONSTRAINT BLOG_AUTHOR_CK4 CHECK (EMAIL_NOTIFY IN('Y', 'N')) ENABLE
)
/
CREATE TABLE  BLOG_CATEGORY
(    CATEGORY_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
ACTIVE VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL ENABLE,
CATEGORY_NAME VARCHAR2(80 CHAR) NOT NULL ENABLE,
CATEGORY_SEQ NUMBER(4,0) NOT NULL ENABLE,
CONSTRAINT BLOG_CATEGORY_CK1 CHECK (CATEGORY_ID > 0) ENABLE,
CONSTRAINT BLOG_CATEGORY_CK2 CHECK (ACTIVE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_CATEGORY_CK3 CHECK (CATEGORY_SEQ BETWEEN 1 AND 9999) ENABLE,
CONSTRAINT BLOG_CATEGORY_PK PRIMARY KEY (CATEGORY_ID) ENABLE,
CONSTRAINT BLOG_CATEGORY_UK1 UNIQUE (CATEGORY_NAME) ENABLE,
CONSTRAINT BLOG_CATEGORY_UK2 UNIQUE (CATEGORY_SEQ) ENABLE
)
/
CREATE TABLE  BLOG_ARTICLE
(    ARTICLE_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
AUTHOR_ID NUMBER(38,0) NOT NULL ENABLE,
ACTIVE VARCHAR2(1 CHAR) DEFAULT 'N' NOT NULL ENABLE,
CATEGORY_ID NUMBER(38,0) NOT NULL ENABLE,
ARTICLE_TITLE VARCHAR2(255 CHAR) NOT NULL ENABLE,
ARTICLE_TEXT CLOB,
DESCRIPTION VARCHAR2(255 CHAR) NOT NULL ENABLE,
ARTICLE_LENGTH NUMBER(38,0) NOT NULL ENABLE,
YEAR_MONTH_NUM NUMBER(6,0) NOT NULL ENABLE,
VALID_FROM DATE DEFAULT SYSDATE NOT NULL ENABLE,
KEYWORDS VARCHAR2(255 CHAR),
HASTAGS VARCHAR2(255 CHAR),
CONSTRAINT BLOG_ARTICLE_CK1 CHECK (ARTICLE_ID > 0) ENABLE,
CONSTRAINT BLOG_ARTICLE_CK2 CHECK (AUTHOR_ID > 0) ENABLE,
CONSTRAINT BLOG_ARTICLE_CK3 CHECK (CATEGORY_ID > 0) ENABLE,
CONSTRAINT BLOG_ARTICLE_CK4 CHECK (ACTIVE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_ARTICLE_CK5 CHECK (ARTICLE_LENGTH >= 0) ENABLE,
CONSTRAINT BLOG_ARTICLE_PK PRIMARY KEY (ARTICLE_ID) ENABLE
)
/
CREATE TABLE  BLOG_ARTICLE_LOG
(    ARTICLE_ID NUMBER(38,0) NOT NULL ENABLE,
VIEW_COUNT NUMBER(38,0) DEFAULT 0 NOT NULL ENABLE,
ARTICLE_RATE NUMBER DEFAULT 0 NOT NULL ENABLE,
ARTICLE_RATE_INT NUMBER(1,0) DEFAULT 0 NOT NULL ENABLE,
RATE_CLICK NUMBER(38,0) DEFAULT 0 NOT NULL ENABLE,
LAST_VIEW DATE DEFAULT NULL,
LAST_RATE DATE,
CONSTRAINT BLOG_ARTICLE_LOG_PK PRIMARY KEY (ARTICLE_ID) ENABLE,
CONSTRAINT BLOG_ARTICLE_LOG_CK1 CHECK (ARTICLE_ID > 0) ENABLE,
CONSTRAINT BLOG_ARTICLE_LOG_CK2 CHECK (VIEW_COUNT >= 0) ENABLE,
CONSTRAINT BLOG_ARTICLE_LOG_CK3 CHECK (ARTICLE_RATE BETWEEN 0 AND 5) ENABLE,
CONSTRAINT BLOG_ARTICLE_LOG_CK4 CHECK (ARTICLE_RATE_INT BETWEEN 0 AND 5) ENABLE,
CONSTRAINT BLOG_ARTICLE_LOG_CK5 CHECK (RATE_CLICK >= 0) ENABLE
)
/
CREATE TABLE  BLOG_ARTICLE_PREVIEW
(    APEX_SESSION_ID NUMBER(38,0) NOT NULL ENABLE,
AUTHOR_ID NUMBER(38,0),
CATEGORY_ID NUMBER(38,0),
ARTICLE_TITLE VARCHAR2(255 CHAR),
ARTICLE_TEXT CLOB,
CONSTRAINT BLOG_ARTICLE_PREVIEW_PK PRIMARY KEY (APEX_SESSION_ID) ENABLE
)
/
CREATE TABLE  BLOG_CATEGORY_LOG
(    CATEGORY_ID NUMBER(38,0) NOT NULL ENABLE,
VIEW_COUNT NUMBER(38,0) DEFAULT 1 NOT NULL ENABLE,
LAST_VIEW DATE DEFAULT SYSDATE NOT NULL ENABLE,
CONSTRAINT BLOG_CATEGORY_LOG_CK1 CHECK (CATEGORY_ID > 0) ENABLE,
CONSTRAINT BLOG_CATEGORY_LOG_CK2 CHECK (VIEW_COUNT > 0) ENABLE,
CONSTRAINT BLOG_CATEGORY_LOG_PK PRIMARY KEY (CATEGORY_ID) ENABLE
)
/
CREATE TABLE  BLOG_COMMENT
(    COMMENT_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
USER_ID NUMBER(38,0) NOT NULL ENABLE,
APEX_SESSION_ID NUMBER(38,0) NOT NULL ENABLE,
ARTICLE_ID NUMBER(38,0) NOT NULL ENABLE,
COMMENT_TEXT VARCHAR2(4000 CHAR) NOT NULL ENABLE,
MODERATED VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL ENABLE,
MODERATED_ON DATE DEFAULT SYSDATE,
PARENT_ID NUMBER(38,0),
ACTIVE VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL ENABLE,
NOTIFY_EMAIL_SENT VARCHAR2(1 CHAR) DEFAULT 'N' NOT NULL ENABLE,
NOTIFY_EMAIL_SENT_ON DATE,
CONSTRAINT BLOG_COMMENT_CK1 CHECK (COMMENT_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_CK2 CHECK (USER_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_CK3 CHECK (ARTICLE_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_CK4 CHECK (PARENT_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_PK PRIMARY KEY (COMMENT_ID) ENABLE,
CONSTRAINT BLOG_COMMENT_CK7 CHECK (MODERATED='N' AND MODERATED_ON IS NULL OR MODERATED='Y' AND MODERATED_ON IS NOT NULL) ENABLE,
CONSTRAINT BLOG_COMMENT_CK5 CHECK (ACTIVE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_COMMENT_CK6 CHECK (MODERATED IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_COMMENT_CK9 CHECK (NOTIFY_EMAIL_SENT='N' AND NOTIFY_EMAIL_SENT_ON IS NULL OR NOTIFY_EMAIL_SENT='Y' AND NOTIFY_EMAIL_SENT_ON IS NOT NULL) ENABLE,
CONSTRAINT BLOG_COMMENT_CK8 CHECK (NOTIFY_EMAIL_SENT IN('Y','N')) ENABLE
)
/
CREATE TABLE  BLOG_COMMENT_BLOCK
(    BLOCK_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
ACTIVE VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL ENABLE,
BLOCK_TYPE VARCHAR2(30 CHAR) NOT NULL ENABLE,
BLOCK_VALUE VARCHAR2(255 CHAR) NOT NULL ENABLE,
CONSTRAINT BLOG_COMMENT_BLOCK_CK1 CHECK (BLOCK_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_BLOCK_CK2 CHECK (ACTIVE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_COMMENT_BLOCK_CK3 CHECK (BLOCK_TYPE IN('EMAIL', 'IP', 'USER_AGENT')) ENABLE,
CONSTRAINT BLOG_COMMENT_BLOCK_PK PRIMARY KEY (BLOCK_ID) ENABLE,
CONSTRAINT BLOG_COMMENT_BLOCK_UK1 UNIQUE (BLOCK_VALUE) ENABLE
)
/
CREATE TABLE  BLOG_COMMENT_NOTIFY
(    ARTICLE_ID NUMBER(38,0) NOT NULL ENABLE,
USER_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
FOLLOWUP_NOTIFY VARCHAR2(1 CHAR) NOT NULL ENABLE,
CONSTRAINT BLOG_COMMENT_NOTIFY_CK1 CHECK (ARTICLE_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_NOTIFY_CK2 CHECK (USER_ID > 0) ENABLE,
CONSTRAINT BLOG_COMMENT_NOTIFY_CK3 CHECK (FOLLOWUP_NOTIFY IN('Y','N')) ENABLE,
CONSTRAINT BLOG_COMMENT_NOTIFY_PK PRIMARY KEY (ARTICLE_ID, USER_ID) ENABLE
)
/
CREATE TABLE  BLOG_CONTACT_MESSAGE
(    CONTACT_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
PROCESSED VARCHAR2(1 CHAR) DEFAULT 'N' NOT NULL ENABLE,
USER_ID NUMBER(38,0) NOT NULL ENABLE,
APEX_SESSION_ID NUMBER(38,0) NOT NULL ENABLE,
MESSAGE VARCHAR2(4000 CHAR) NOT NULL ENABLE,
CONSTRAINT BLOG_CONTACT_MESSAGE_CK1 CHECK (CONTACT_ID > 0) ENABLE,
CONSTRAINT BLOG_CONTACT_MESSAGE_CK2 CHECK (USER_ID > 0) ENABLE,
CONSTRAINT BLOG_CONTACT_MESSAGE_CK3 CHECK (PROCESSED IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_CONTACT_MESSAGE_PK PRIMARY KEY (CONTACT_ID) ENABLE
)
/
CREATE TABLE  BLOG_COUNTRY
(    COUNTRY_CODE VARCHAR2(2 CHAR) NOT NULL ENABLE,
COUNTRY_NAME VARCHAR2(60 CHAR) NOT NULL ENABLE,
VISIT_COUNT NUMBER(38,0) DEFAULT 0 NOT NULL ENABLE,
CONSTRAINT BLOG_COUNTRY_PK PRIMARY KEY (COUNTRY_CODE) ENABLE,
CONSTRAINT BLOG_COUNTRY_CK1 CHECK (VISIT_COUNT >= 0) ENABLE
) ORGANIZATION INDEX NOCOMPRESS
/
CREATE TABLE  BLOG_FAQ
(    FAQ_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
ACTIVE VARCHAR2(1 CHAR) NOT NULL ENABLE,
FAQ_SEQ NUMBER(4,0) NOT NULL ENABLE,
QUESTION VARCHAR2(4000 CHAR) NOT NULL ENABLE,
ANSWER VARCHAR2(4000 CHAR) NOT NULL ENABLE,
CONSTRAINT BLOG_FAQ_CK1 CHECK (FAQ_ID > 0) ENABLE,
CONSTRAINT BLOG_FAQ_CK2 CHECK (ACTIVE IN('Y','N')) ENABLE,
CONSTRAINT BLOG_FAQ_CK3 CHECK (FAQ_SEQ BETWEEN 1 AND 50) ENABLE,
CONSTRAINT BLOG_FAQ_PK PRIMARY KEY (FAQ_ID) ENABLE,
CONSTRAINT BLOG_FAQ_UK1 UNIQUE (FAQ_SEQ) ENABLE
)
/
CREATE TABLE  BLOG_FILE
(    FILE_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
ACTIVE VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL ENABLE,
FILE_NAME VARCHAR2(60 CHAR),
MIME_TYPE VARCHAR2(255 CHAR),
FILE_SIZE NUMBER(38,0) DEFAULT 1 NOT NULL ENABLE,
DAD_CHARSET VARCHAR2(255 CHAR),
FILE_TYPE VARCHAR2(30 CHAR) NOT NULL ENABLE,
BLOB_CONTENT BLOB NOT NULL ENABLE,
DESCRIPTION VARCHAR2(4000 CHAR),
FILE_ETAG VARCHAR2(50 CHAR) NOT NULL ENABLE,
FILE_MODIFIED_SINCE VARCHAR2(30 CHAR) NOT NULL ENABLE,
CONSTRAINT BLOG_FILE_CK1 CHECK (FILE_ID > 0) ENABLE,
CONSTRAINT BLOG_FILE_CK2 CHECK (ACTIVE IN('Y','N')) ENABLE,
CONSTRAINT BLOG_FILE_CK4 CHECK (FILE_SIZE >0) ENABLE,
CONSTRAINT BLOG_FILE_CK3 CHECK (FILE_TYPE IN('IMAGE','FILE','THEME')) ENABLE,
CONSTRAINT BLOG_FILE_PK PRIMARY KEY (FILE_ID) ENABLE,
CONSTRAINT BLOG_FILE_UK1 UNIQUE (FILE_NAME) ENABLE
)
/
CREATE TABLE  BLOG_FILE_LOG
(    FILE_ID NUMBER(38,0) NOT NULL ENABLE,
CLICK_COUNT NUMBER(38,0) DEFAULT 0 NOT NULL ENABLE,
LAST_CLICK DATE DEFAULT SYSDATE NOT NULL ENABLE,
CONSTRAINT BLOG_FILE_LOG_CK1 CHECK (FILE_ID > 0) ENABLE,
CONSTRAINT BLOG_FILE_LOG_CK2 CHECK (CLICK_COUNT >= 0) ENABLE,
CONSTRAINT BLOG_FILE_LOG_PK PRIMARY KEY (FILE_ID) ENABLE
)
/
CREATE TABLE  BLOG_LONG_TEXT
(    LONG_TEXT_TYPE VARCHAR2(40 CHAR) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
LONG_TEXT_DESCRIPTION VARCHAR2(255 CHAR) NOT NULL ENABLE,
LONG_TEXT CLOB,
CONSTRAINT BLOG_LONG_TEXT_CK3 CHECK (LONG_TEXT_TYPE IN('FOOTER','ABOUT','CONTACT','DISCLAIMER')) ENABLE,
CONSTRAINT BLOG_LONG_TEXT_PK PRIMARY KEY (LONG_TEXT_TYPE) ENABLE
)
/
CREATE TABLE  BLOG_PARAM
(    PARAM_NAME VARCHAR2(40 CHAR) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
EDITABLE VARCHAR2(1 CHAR) NOT NULL ENABLE,
PARAM_DESC VARCHAR2(255 CHAR) NOT NULL ENABLE,
PARAM_VALUE VARCHAR2(4000 CHAR),
PARAM_HELP VARCHAR2(4000 CHAR),
PARAM_TYPE VARCHAR2(20 CHAR) NOT NULL ENABLE,
PARAM_NULLABLE VARCHAR2(1 CHAR) NOT NULL ENABLE,
PARAM_GROUP VARCHAR2(10 CHAR) NOT NULL ENABLE,
PARAM_PARENT VARCHAR2(40 CHAR),
CONSTRAINT BLOG_PARAM_CK2 CHECK (EDITABLE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_PARAM_CK4 CHECK (PARAM_NULLABLE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_PARAM_CK3 CHECK (PARAM_TYPE IN('TEXT','TEXTAREA','NUMBER','YESNO')) ENABLE,
CONSTRAINT BLOG_PARAM_PK PRIMARY KEY (PARAM_NAME) ENABLE,
CONSTRAINT BLOG_PARAM_CK6 CHECK ((PARAM_NULLABLE = 'N' AND PARAM_VALUE IS NOT NULL) OR (PARAM_NULLABLE = 'Y')) ENABLE,
CONSTRAINT BLOG_PARAM_CK8 CHECK ((PARAM_TYPE = 'YESNO' AND PARAM_VALUE IS NOT NULL) OR (PARAM_TYPE != 'YESNO')) ENABLE,
CONSTRAINT BLOG_PARAM_CK7 CHECK ((PARAM_TYPE ='YESNO' AND PARAM_NULLABLE = 'N') OR (PARAM_TYPE !='YESNO')) ENABLE,
CONSTRAINT BLOG_PARAM_CK5 CHECK (PARAM_GROUP IN('SEO', 'UI', 'EMAIL', 'LOG', 'AUTH', 'RSS', 'INTERNAL')) ENABLE
)
/
CREATE TABLE  BLOG_RESOURCE
(    LINK_ID NUMBER(38,0) NOT NULL ENABLE,
CREATED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CREATED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
CHANGED_ON DATE DEFAULT SYSDATE NOT NULL ENABLE,
CHANGED_BY VARCHAR2(80 CHAR) NOT NULL ENABLE,
ACTIVE VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL ENABLE,
LINK_TYPE VARCHAR2(40 CHAR) NOT NULL ENABLE,
LINK_TITLE VARCHAR2(255 CHAR) NOT NULL ENABLE,
LINK_TEXT VARCHAR2(4000 CHAR) NOT NULL ENABLE,
LINK_URL VARCHAR2(255 CHAR) NOT NULL ENABLE,
CONSTRAINT BLOG_RESOURCE_CK3 CHECK (LINK_TYPE IN('BLOG','FAVORITE','RESOURCE')) ENABLE,
CONSTRAINT BLOG_RESOURCE_CK1 CHECK (LINK_ID > 0) ENABLE,
CONSTRAINT BLOG_RESOURCE_CK2 CHECK (ACTIVE IN('Y', 'N')) ENABLE,
CONSTRAINT BLOG_RESOURCE_PK PRIMARY KEY (LINK_ID) ENABLE
)
/
