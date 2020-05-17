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
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_tab(
    p_app_id          in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_home_page,
    p_session         in varchar2 default null,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_post(
    p_post_id         in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_post_page,
    p_page_item       in varchar2 default blog_util.g_post_item,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_post(
    p_post_id         in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_post_page,
    p_page_item       in varchar2 default blog_util.g_post_item,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_category(
    p_category_id     in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_category_page,
    p_page_item       in varchar2 default blog_util.g_category_item,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_category(
    p_category_id     in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_category_page,
    p_page_item       in varchar2 default blog_util.g_category_item,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_archive(
    p_archive_id      in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_archive_page,
    p_page_item       in varchar2 default blog_util.g_archive_item,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_archive(
    p_archive_id      in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_archive_page,
    p_page_item       in varchar2 default blog_util.g_archive_item,
    p_canonical       in varchar2 default 'NO'
  ) return varchar2;
--------------------------------------------------------------------------------
  function get_tag(
    p_tag_id          in number,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_tag_page,
    p_page_item       in varchar2 default blog_util.g_tag_item,
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
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_search_page,
    p_page_item       in varchar2 default blog_util.g_search_item
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
    p_app_page_id   in varchar2 default blog_util.g_home_page,
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
    p_app_page_id   in varchar2 default blog_util.g_post_page,
    p_page_item     in varchar2 default blog_util.g_post_item,
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
        ,p_app_page_id  => p_app_page_id
        ,p_page_item    => p_page_item
        ,p_canonical    => p_canonical
      );

  end get_post;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_post(
    p_post_id       in varchar2,
    p_app_id        in varchar2 default null,
    p_session       in varchar2 default null,
    p_app_page_id   in varchar2 default blog_util.g_post_page,
    p_page_item     in varchar2 default blog_util.g_post_item,
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
        || ':'
        || p_app_page_id
        || ':'
        || p_session
        || '::NO:RP:'
        || p_page_item
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
         ,p_page        => p_app_page_id
         ,p_session     => p_session
         ,p_clear_cache => 'RP'
         ,p_items       => p_page_item
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
    p_app_page_id in varchar2 default blog_util.g_category_page,
    p_page_item   in varchar2 default blog_util.g_category_item,
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
        ,p_app_page_id  => p_app_page_id
        ,p_page_item    => p_page_item
        ,p_canonical    => p_canonical
      );

  end get_category;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_category(
    p_category_id in varchar2,
    p_app_id      in varchar2 default null,
    p_session     in varchar2 default null,
    p_app_page_id in varchar2 default blog_util.g_category_page,
    p_page_item   in varchar2 default blog_util.g_category_item,
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
       ,p_page        => p_app_page_id
       ,p_session     => p_session
       ,p_clear_cache => 'RP'
       ,p_items       => case when p_category_id is not null then p_page_item end
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
    p_app_page_id     in varchar2 default blog_util.g_archive_page,
    p_page_item       in varchar2 default blog_util.g_archive_item,
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
        ,p_app_page_id  => p_app_page_id
        ,p_page_item    => p_page_item
        ,p_canonical    => p_canonical
      );

  end get_archive;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
  function get_archive(
    p_archive_id      in varchar2,
    p_app_id          in varchar2 default null,
    p_session         in varchar2 default null,
    p_app_page_id     in varchar2 default blog_util.g_archive_page,
    p_page_item       in varchar2 default blog_util.g_archive_item,
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
        ,p_page        => p_app_page_id
        ,p_session     => p_session
        ,p_clear_cache => 'RP'
        ,p_items       => case when p_archive_id is not null then p_page_item end
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
    p_session     in varchar2 default null,--,p_plain_url   => true
    p_app_page_id in varchar2 default blog_util.g_tag_page,
    p_page_item   in varchar2 default blog_util.g_tag_item,
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
        ,p_page        => p_app_page_id
        ,p_session     => p_session
        ,p_clear_cache => 'RP'
        ,p_items       => p_page_item
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
      || ':'
      || blog_util.g_post_page
      || ':::NO:RP:'
      || blog_util.g_post_item
      || ','
      || blog_util.g_unsubscribe_item
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
    p_session       in varchar2 default null,
    p_app_page_id   in varchar2 default blog_util.g_search_page,
    p_page_item     in varchar2 default blog_util.g_search_item
  )
  as
  begin
    -- Get search page URL and redirect if there there is string for search
    if p_value is not null then
      apex_util.redirect_url (
        apex_page.get_url(
           p_application => p_app_id
          ,p_page        => p_app_page_id
          ,p_session     => p_session
          ,p_clear_cache => 'RP'
          ,p_items       => p_page_item
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
