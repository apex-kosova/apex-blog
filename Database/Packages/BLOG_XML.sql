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
