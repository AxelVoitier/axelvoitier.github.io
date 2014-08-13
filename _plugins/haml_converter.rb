module Jekyll
  require 'haml'
  require 'ostruct'
  require 'cgi'
  require 'shorturl'
  require 'pp'
  
  module HamlHelpers

    @@shrsb_bookmarks_data = {
      'scriptstyle' => {
        'share' => 'Submit this to Script &amp; Style',
        'baseUrl' => 'http://scriptandstyle.com/submit?url=PERMALINK&amp;title=TITLE'
      },
      'blinklist' => {
        'share' => 'Share this on Blinklist',
        'baseUrl' => 'http://www.blinklist.com/index.php?Action=Blink/addblink.php&amp;Url=PERMALINK&amp;Title=TITLE'
      },
      'delicious' => {
        'share' => 'Share this on del.icio.us',
        'baseUrl' => 'http://delicious.com/post?url=PERMALINK&amp;title=TITLE'
      },
      'digg' => {
        'share' => 'Digg this!',
        'baseUrl' => 'http://digg.com/submit?phase=2&amp;url=PERMALINK&amp;title=TITLE'
      },
      'diigo' => {
        'share' => 'Post this on Diigo',
        'baseUrl' => 'http://www.diigo.com/post?url=PERMALINK&amp;title=TITLE&amp;desc=SEXY_TEASER'
      },
      'reddit' => {
        'share' => 'Share this on Reddit',
        'baseUrl' => 'http://reddit.com/submit?url=PERMALINK&amp;title=TITLE'
      },
      'yahoobuzz' => {
        'share' => 'Buzz up!',
        'baseUrl' => 'http://buzz.yahoo.com/submit/?submitUrl=PERMALINK&amp;submitHeadline=TITLE&amp;submitSummary=YAHOOTEASER&amp;submitCategory=YAHOOCATEGORY&amp;submitAssetType=YAHOOMEDIATYPE'
      },
      'stumbleupon' => {
        'share' => 'Stumble upon something good? Share it on StumbleUpon',
        'baseUrl' => 'http://www.stumbleupon.com/submit?url=PERMALINK&amp;title=TITLE'
      },
      'technorati' => {
        'share' => 'Share this on Technorati',
        'baseUrl' => 'http://technorati.com/faves?add=PERMALINK'
      },
      'mixx' => {
        'share' => 'Share this on Mixx',
        'baseUrl' => 'http://www.mixx.com/submit?page_url=PERMALINK&amp;title=TITLE'
      },
      'myspace' => {
        'share' => 'Post this to MySpace',
        'baseUrl' => 'http://www.myspace.com/Modules/PostTo/Pages/?u=PERMALINK&amp;t=TITLE'
      },
      'designfloat' => {
        'share' => 'Submit this to DesignFloat',
        'baseUrl' => 'http://www.designfloat.com/submit.php?url=PERMALINK&amp;title=TITLE'
      },
      'facebook' => {
        'share' => 'Share this on Facebook',
        'baseUrl' => 'http://www.facebook.com/share.php?v=4&amp;src=bm&amp;u=PERMALINK&amp;t=TITLE'
      },
      'twitter' => {
        'share' => 'Tweet This!',
        'baseUrl' => 'http://twitter.com/home?status='
      },
      'mail' => {
        'share' => 'Email this to a friend?',
        'baseUrl' => 'mailto:?subject=%22TITLE%22&amp;body=Link: PERMALINK %0D%0A%0D%0A----%0D%0A POST_SUMMARY'
      },
      'tomuse' => {
        'share' => 'Suggest this article to ToMuse',
        'baseUrl' => 'mailto:tips@tomuse.com?subject=New tip submitted via RobotTribune!&amp;body=Link: PERMALINK %0D%0A%0D%0A POST_SUMMARY'
      },
      'comfeed' => {
        'share' => 'Subscribe to the comments for this post?',
        'baseUrl' => 'PERMALINK'
      },
      'linkedin' => {
        'share' => 'Share this on LinkedIn',
        'baseUrl' => 'http://www.linkedin.com/shareArticle?mini=true&amp;url=PERMALINK&amp;title=TITLE&amp;summary=POST_SUMMARY&amp;source=SITE_NAME'
      },
      'newsvine' => {
        'share' => 'Seed this on Newsvine',
        'baseUrl' => 'http://www.newsvine.com/_tools/seed&amp;save?u=PERMALINK&amp;h=TITLE'
      },
      'googlebookmarks' => {
        'share' => 'Add this to Google Bookmarks',
        'baseUrl' => 'http://www.google.com/bookmarks/mark?op=add&amp;bkmk=PERMALINK&amp;title=TITLE'
      },
      'googlereader' => {
        'share' => 'Share this on Google Reader',
        'baseUrl' => 'http://www.google.com/reader/link?url=PERMALINK&amp;title=TITLE&amp;srcUrl=PERMALINK&amp;srcTitle=TITLE&amp;snippet=POST_SUMMARY'
      },
      'googlebuzz' => {
        'share' => 'Post on Google Buzz',
        'baseUrl' => 'http://www.google.com/buzz/post?url=PERMALINK&amp;imageurl='
      },
      'misterwong' => {
        'share' => 'Add this to Mister Wong',
        'baseUrl' => 'http://www.mister-wong.com/addurl/?bm_url=PERMALINK&amp;bm_description=TITLE&amp;plugin=sexybookmarks'
      },
      'izeby' => {
        'share' => 'Add this to Izeby',
        'baseUrl' => 'http://izeby.com/submit.php?url=PERMALINK'
      },
      'tipd' => {
        'share' => 'Share this on Tipd',
        'baseUrl' => 'http://tipd.com/submit.php?url=PERMALINK'
      },
      'pfbuzz' => {
        'share' => 'Share this on PFBuzz',
        'baseUrl' => 'http://pfbuzz.com/submit?url=PERMALINK&amp;title=TITLE'
      },
      'friendfeed' => {
        'share' => 'Share this on FriendFeed',
        'baseUrl' => 'http://www.friendfeed.com/share?title=TITLE&amp;link=PERMALINK'
      },
      'blogmarks' => {
        'share' => 'Mark this on BlogMarks',
        'baseUrl' => 'http://blogmarks.net/my/new.php?mini=1&amp;simple=1&amp;url=PERMALINK&amp;title=TITLE'
      },
      'twittley' => {
        'share' => 'Submit this to Twittley',
        'baseUrl' => 'http://twittley.com/submit/?title=TITLE&amp;url=PERMALINK&amp;desc=POST_SUMMARY&amp;pcat=TWITT_CAT&amp;tags=DEFAULT_TAGS'
      },
      'fwisp' => {
        'share' => 'Share this on Fwisp',
        'baseUrl' => 'http://fwisp.com/submit?url=PERMALINK'
      },
      'bobrdobr' => {
        'share' => 'Share this on BobrDobr',
        'baseUrl' => 'http://bobrdobr.ru/addext.html?url=PERMALINK&amp;title=TITLE'
      },
      'yandex' => {
        'share' => 'Add this to Yandex.Bookmarks',
        'baseUrl' => 'http://zakladki.yandex.ru/userarea/links/addfromfav.asp?bAddLink_x=1&amp;lurl=PERMALINK&amp;lname=TITLE'
      },
      'memoryru' => {
        'share' => 'Add this to Memory.ru',
        'baseUrl' => 'http://memori.ru/link/?sm=1&amp;u_data[url]=PERMALINK&amp;u_data[name]=TITLE'
      },
      '100zakladok' => {
        'share' => 'Add this to 100 bookmarks',
        'baseUrl' => 'http://www.100zakladok.ru/save/?bmurl=PERMALINK&amp;bmtitle=TITLE'
      },
      'moemesto' => {
        'share' => 'Add this to MyPlace',
        'baseUrl' => 'http://moemesto.ru/post.php?url=PERMALINK&amp;title=TITLE'
      },
      'hackernews' => {
        'share' => 'Submit this to Hacker News',
        'baseUrl' => 'http://news.ycombinator.com/submitlink?u=PERMALINK&amp;t=TITLE'
      },
      'printfriendly' => {
        'share' => 'Send this page to Print Friendly',
        'baseUrl' => 'http://www.printfriendly.com/print?url=PERMALINK'
      },
      'designbump' => {
        'share' => 'Bump this on DesignBump',
        'baseUrl' => 'http://designbump.com/submit?url=PERMALINK&amp;title=TITLE&amp;body=POST_SUMMARY'
      },
      'ning' => {
        'share' => 'Add this to Ning',
        'baseUrl' => 'http://bookmarks.ning.com/addItem.php?url=PERMALINK&amp;T=TITLE'
      },
      'identica' => {
        'share' => 'Post this to Identica',
        'baseUrl' => 'http://identi.ca//index.php?action=newnotice&amp;status_textarea=Reading:+&quot;SHORT_TITLE&quot;+-+from+FETCH_URL'
      },
      'xerpi' => {
        'share' => 'Save this to Xerpi',
        'baseUrl' => 'http://www.xerpi.com/block/add_link_from_extension?url=PERMALINK&amp;title=TITLE'
      },
      'wikio' => {
        'share' => 'Share this on Wikio',
        'baseUrl' => 'http://www.wikio.com/sharethis?url=PERMALINK&amp;title=TITLE'
      },
      'techmeme' => {
        'share' => 'Tip this to TechMeme',
        'baseUrl' => 'http://twitter.com/home/?status=Tip+@Techmeme+PERMALINK+&quot;TITLE&quot;&amp;source=shareaholic'
      },
      'sphinn' => {
        'share' => 'Sphinn this on Sphinn',
        'baseUrl' => 'http://sphinn.com/index.php?c=post&amp;m=submit&amp;link=PERMALINK'
      },
      'posterous' => {
        'share' => 'Post this to Posterous',
        'baseUrl' => 'http://posterous.com/share?linkto=PERMALINK&amp;title=TITLE&amp;selection=POST_SUMMARY'
      },
      'globalgrind' => {
        'share' => 'Grind this! on Global Grind',
        'baseUrl' => 'http://globalgrind.com/submission/submit.aspx?url=PERMALINK&amp;type=Article&amp;title=TITLE'
      },
      'pingfm' => {
        'share' => 'Ping this on Ping.fm',
        'baseUrl' => 'http://ping.fm/ref/?link=PERMALINK&amp;title=TITLE&amp;body=POST_SUMMARY'
      },
      'nujij' => {
        'share' => 'Submit this to NUjij',
        'baseUrl' => 'http://nujij.nl/jij.lynkx?t=TITLE&amp;u=PERMALINK&amp;b=POST_SUMMARY'
      },
      'ekudos' => {
        'share' => 'Submit this to eKudos',
        'baseUrl' => 'http://www.ekudos.nl/artikel/nieuw?url=PERMALINK&amp;title=TITLE&amp;desc=POST_SUMMARY'
      },
      'netvouz' => {
        'share' => 'Submit this to Netvouz',
        'baseUrl' => 'http://www.netvouz.com/action/submitBookmark?url=PERMALINK&amp;title=TITLE&amp;popup=no'
      },
      'netvibes' => {
        'share' => 'Submit this to Netvibes',
        'baseUrl' => 'http://www.netvibes.com/share?title=TITLE&amp;url=PERMALINK'
      },
      'fleck' => {
        'share' => 'Share this on Fleck',
        'baseUrl' => 'http://beta3.fleck.com/bookmarklet.php?url=PERMALINK&amp;title=TITLE'
      },
      'webblend' => {
        'share' => 'Blend this!',
        'baseUrl' => 'http://thewebblend.com/submit?url=PERMALINK&amp;title=TITLE&amp;body=POST_SUMMARY'
      },
      'wykop' => {
        'share' => 'Add this to Wykop!',
        'baseUrl' => 'http://www.wykop.pl/dodaj?url=PERMALINK&amp;title=TITLE'
      },
      'blogengage' => {
        'share' => 'Engage with this article!',
        'baseUrl' => 'http://www.blogengage.com/submit.php?url=PERMALINK'
      },
      'hyves' => {
        'share' => 'Share this on Hyves',
        'baseUrl' => 'http://www.hyves.nl/profilemanage/add/tips/?name=TITLE&amp;text=POST_SUMMARY+-+PERMALINK&amp;rating=5'
      },
      'pusha' => {
        'share' => 'Push this on Pusha',
        'baseUrl' => 'http://www.pusha.se/posta?url=PERMALINK&amp;title=TITLE'
      },
      'hatena' => {
        'share' => 'Bookmarks this on Hatena Bookmarks',
        'baseUrl' => 'http://b.hatena.ne.jp/add?mode=confirm&amp;url=PERMALINK&amp;title=TITLE'
      },
      'mylinkvault' => {
        'share' => 'Store this link on MyLinkVault',
        'baseUrl' => 'http://www.mylinkvault.com/link-page.php?u=PERMALINK&amp;n=TITLE'
      },
      'slashdot' => {
        'share' => 'Submit this to SlashDot',
        'baseUrl' => 'http://slashdot.org/bookmark.pl?url=PERMALINK&amp;title=TITLE'
      },
      'squidoo' => {
        'share' => 'Add to a lense on Squidoo',
        'baseUrl' => 'http://www.squidoo.com/lensmaster/bookmark?PERMALINK'
      },
      'propeller' => {
        'share' => 'Submit this story to Propeller',
        'baseUrl' => 'http://www.propeller.com/submit/?url=PERMALINK'
      },
      'faqpal' => {
        'share' => 'Submit this to FAQpal',
        'baseUrl' => 'http://www.faqpal.com/submit?url=PERMALINK'
      },
      'evernote' => {
        'share' => 'Clip this to Evernote',
        'baseUrl' => 'http://www.evernote.com/clip.action?url=PERMALINK&amp;title=TITLE'
      },
      'meneame' => {
        'share' => 'Submit this to Meneame',
        'baseUrl' => 'http://meneame.net/submit.php?url=PERMALINK'
      },
      'bitacoras' => {
        'share' => 'Submit this to Bitacoras',
        'baseUrl' => 'http://bitacoras.com/anotaciones/PERMALINK'
      },
      'jumptags' => {
        'share' => 'Submit this link to JumpTags',
        'baseUrl' => 'http://www.jumptags.com/add/?url=PERMALINK&amp;title=TITLE'
      },
      'bebo' => {
        'share' => 'Share this on Bebo',
        'baseUrl' => 'http://www.bebo.com/c/share?Url=PERMALINK&amp;Title=TITLE'
      },
      'n4g' => {
        'share' => 'Submit tip to N4G',
        'baseUrl' => 'http://www.n4g.com/tips.aspx?url=PERMALINK&amp;title=TITLE'
      },
      'strands' => {
        'share' => 'Submit this to Strands',
        'baseUrl' => 'http://www.strands.com/tools/share/webpage?title=TITLE&amp;url=PERMALINK'
      },
      'orkut' => {
        'share' => 'Promote this on Orkut',
        'baseUrl' => 'http://promote.orkut.com/preview?nt=orkut.com&amp;tt=TITLE&amp;du=PERMALINK&amp;cn=POST_SUMMARY'
      },
      'tumblr' => {
        'share' => 'Share this on Tumblr',
        'baseUrl' => 'http://www.tumblr.com/share?v=3&amp;u=PERMALINK&amp;t=TITLE'
      },
      'stumpedia' => {
        'share' => 'Add this to Stumpedia',
        'baseUrl' => 'http://www.stumpedia.com/submit?url=PERMALINK&amp;title=TITLE'
      },
      'current' => {
        'share' => 'Post this to Current',
        'baseUrl' => 'http://current.com/clipper.htm?url=PERMALINK&amp;title=TITLE'
      },
      'blogger' => {
        'share' => 'Blog this on Blogger',
        'baseUrl' => 'http://www.blogger.com/blog_this.pyra?t&amp;u=PERMALINK&amp;n=TITLE&amp;pli=1'
      },
      'plurk' => {
        'share' => 'Share this on Plurk',
        'baseUrl' => 'http://www.plurk.com/m?content=TITLE+-+PERMALINK&amp;qualifier=shares'
      },
      'dzone' => {
        'share' => 'Add this to DZone',
        'baseUrl' => 'http://www.dzone.com/links/add.html?url=PERMALINK&amp;title=TITLE&amp;description=POST_SUMMARY'
      },  
      'kaevur' => {
        'share' => 'Share this on Kaevur',
        'baseUrl' => 'http://kaevur.com/submit.php?url=PERMALINK'
      },
      'virb' => {
        'share' => 'Share this on Virb',
        'baseUrl' => 'http://virb.com/share?external&amp;v=2&amp;url=PERMALINK&amp;title=TITLE'
      },  
      'boxnet' => {
        'share' => 'Add this link to Box.net',
        'baseUrl' => 'https://www.box.net/api/1.0/import?url=PERMALINK&amp;name=TITLE&amp;description=POST_SUMMARY&amp;import_as=link'
      },
      'oknotizie' => {
        'share' => 'Share this on OkNotizie',
        'baseUrl' => 'http://oknotizie.virgilio.it/post?url=PERMALINK&amp;title=TITLE'
      },
      'bonzobox' => {
        'share' => 'Add this to BonzoBox',
        'baseUrl' => 'http://bonzobox.com/toolbar/add?pop=1&amp;u=PERMALINK&amp;t=TITLE&amp;d=POST_SUMMARY'
      },
      'plaxo' => {
        'share' => 'Share this on Plaxo',
        'baseUrl' => 'http://www.plaxo.com/?share_link=PERMALINK'
      },
      'springpad' => {
        'share' => 'Spring this on SpringPad',
        'baseUrl' => 'http://springpadit.com/clip.action?body=POST_SUMMARY&amp;url=PERMALINK&amp;format=microclip&amp;title=TITLE&amp;isSelected=true'
      },
      'zabox' => {
        'share' => 'Box this on Zabox',
        'baseUrl' => 'http://www.zabox.net/submit.php?url=PERMALINK'
      },
      'viadeo' => {
        'share' => 'Share this on Viadeo',
        'baseUrl' => 'http://www.viadeo.com/shareit/share/?url=PERMALINK&amp;title=TITLE&amp;urlaffiliate=31138'
      },
      'gmail' => {
        'share' => 'Email this via Gmail',
        'baseUrl' => 'https://mail.google.com/mail/?ui=2&amp;view=cm&amp;fs=1&amp;tf=1&amp;su=TITLE&amp;body=Link: PERMALINK %0D%0A%0D%0A----%0D%0A POST_SUMMARY'
      },
      'hotmail' => {
        'share' => 'Email this via Hotmail',
        'baseUrl' => 'http://mail.live.com/?rru=compose?subject=TITLE&amp;body=Link: PERMALINK %0D%0A%0D%0A----%0D%0A POST_SUMMARY'
      },
      'yahoomail' => {
        'share' => 'Email this via Yahoo! Mail',
        'baseUrl' => 'http://compose.mail.yahoo.com/?Subject=TITLE&amp;body=Link: PERMALINK %0D%0A%0D%0A----%0D%0A POST_SUMMARY'
      },
      'buzzster' => {
        'share' => 'Share this via Buzzster!',
        'baseUrl' => "javascript:var%20s=document.createElement('script');s.src='http://www.buzzster.com/javascripts/bzz_adv.js';s.type='text/javascript';void(document.getElementsByTagName('head')[0].appendChild(s));"
      }
    }

    def bookmark_list_item(name, options={})
      # If Twitter, check for custom tweet configuration and modify tweet accordingly
      if name == 'twitter'
          url = @@shrsb_bookmarks_data[name]['baseUrl'] + 'From+RoboTribune:+SHORT_TITLE+-+FETCH_URL'
      else # Otherwise, use default baseUrl format
	      url = @@shrsb_bookmarks_data[name]['baseUrl']
      end

	    html_options = {}
      html_options[:rel] = "nofollow"
      html_options[:title] = @@shrsb_bookmarks_data[name]['share']

	    if name == 'facebook'
		    html_options[:popup] = ['sharer', 'toolbar=0,status=0,width=626,height=436']
		  else
		    html_options[:rel] = 'external'
	    end

      if name == 'shr-buzzster'
        topt = ''
      else
  #      if shrsb_plugopts['targetopt'] == '_blank'
  #        $topt = ' class="external"';
  #      else
          topt = ''
  #      end
      end

      options.each do |key, value|
        url = url.gsub(key.upcase, value)
      end

      return "<li class='shr-#{name}'>" + link_to("&nbsp;", url, html_options) + "</li>"
    end

    def get_socials (post_summary, perms, title, short_title, mail_subject, shrsb_content, site_name, sites=[])
	    # Write the sexybookmarks menu
      socials = ''
      sites.each do |name|
        case name
          when 'twitter'
				    socials += bookmark_list_item(name, {
					    'short_title' => short_title,
					    'fetch_url' => ShortURL.shorten(perms, :tinyurl)
				    }) + "\n"
			    when 'identica'
				    socials += bookmark_list_item(name, {
					    'short_title' => short_title,
					    'fetch_url' => ShortURL.shorten(perms, :tinyurl)
				    }) + "\n"
			    when 'mail'
				    socials += bookmark_list_item(name, {
					    'title' => mail_subject,
					    'post_summary' => post_summary,
					    'permalink' => perms
				    }) + "\n"
			    when 'tomuse'
				    socials += bookmark_list_item(name, {
					    'title' => mail_subject,
					    'post_summary' => post_summary,
					    'permalink' => perms
				    }) + "\n"
			    when 'diigo'
				    socials += bookmark_list_item(name, {
					    'sexy_teaser' => shrsb_content,
					    'permalink' => perms,
					    'title' => title
				    }) + "\n"
			    when 'linkedin'
				    socials += bookmark_list_item(name, {
					    'post_summary' => post_summary,
					    'site_name' => site_name,
					    'permalink' => perms,
					    'title' => title
				    }) + "\n"
  #			  when 'comfeed'
  #				  socials += bookmark_list_item(name, {
  #					  'permalink' => urldecode(feedperms).feedstructure
  #				  }) + "\n"
  #			  when 'yahoobuzz'
  #				  socials += bookmark_list_item(name, {
  #					  'permalink' => perms,
  #					  'title' => title,
  #					  'yahooteaser' => shrsb_content,
  #					  'yahoocategory' => y_cat,
  #					  'yahoomediatype' => y_med
  #				  }) + "\n"
  #			  when 'twittley'
  #				  socials += bookmark_list_item(name, {
  #					  'permalink' => urlencode(perms),
  #					  'title' => title,
  #					  'post_summary' => post_summary,
  #					  'twitt_cat' => t_cat,
  #					  'default_tags' => d_tags
  #				  }) + "\n"
			    when 'tumblr'
				    socials += bookmark_list_item(name, {
					    'permalink' => urlencode(perms),
					    'title' => title
				    }) + "\n"
			    else
				    socials += bookmark_list_item(name, {
					    'post_summary' => post_summary,
					    'permalink' => perms,
					    'title' => title
				    }) + "\n"
		    end
	    end

	    return socials;
    end

    def strip_html(s)
      s.gsub(/<\/?[^>]*>/, '')
    end

    def urlencode (s)
      URI.escape(s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def get_publication_socials (pub, sites=[])
	    perms = pub.url
      title = pub.title
  #	  $feedperms = strtolower($perms);
	    mail_subject = urlencode(title)

	    # Determine how to handle post titles for Twitter
	    if title.length >= 80
		    short_title = urlencode(title[0..80] + '[..]')
	    else
		    short_title = urlencode(title)
	    end

	    title = urlencode(title)

      shrsb_content	= ''
      if pub.tags.include?('Shared')
        shrsb_content	= (pub.description)[0..200]
      else
        shrsb_content	= urlencode(strip_html(pub.content)[0..300]) # Was pub.html_content
      end

	    shrsb_content	= shrsb_content.gsub('+','%20')
	    pub_summary = shrsb_content
	    site_name = 'RoboTribune'
	    mail_subject = mail_subject.gsub('+','%20').gsub("&#8217;","'")
  #	  $y_cat = $shrsb_plugopts['ybuzzcat']
  #	  $y_med = $shrsb_plugopts['ybuzzmed']
  #	  $t_cat = $shrsb_plugopts['twittcat']

	    # Grab post tags for Twittley tags. If there aren't any, use default tags set in plugin options page
  #    d_tags = post.tag_list

	    # Check permalink setup for proper feed link
  #	  if (false !== strpos($feedperms,'?') || false !== strpos($feedperms,'.php',strlen($feedperms) - 4)) {
  #		  $feedstructure = '&amp;feed=comments-rss2';
  #	  } else {
  #		  if ('/' == $feedperms[strlen($feedperms) - 1]) {
  #			  $feedstructure = 'feed';
  #		  }
  #		  else {
  #			  $feedstructure = '/feed';
  #		  }
  #	  }


	    # Compatibility fix for NextGen Gallery Plugin...
  #	  if( (strpos($post_summary, '[') || strpos($post_summary, ']')) ) {
  #		  $post_summary = "";
  #	  }
  #	  if( (strpos($shrsb_content, '[') || strpos($shrsb_content,']')) ) {
  #		  $shrsb_content = "";
  #	  }


      return get_socials pub_summary, perms, title, short_title, mail_subject, shrsb_content, site_name, sites
    end
    
    def h(text)
      CGI.escapeHTML(text)
    end
    
    def link_to(text, url, attributes = {})
      #puts text, url, attributes, '########################'
      attributes = { :href => url }.merge(attributes)
      if attributes.include?(:popup)
        attributes[:onclick] = %{window.open(this.href,'#{attributes[:popup][0]}','#{attributes[:popup][1]}');return false;}
        attributes.delete(:popup)
        #puts attributes
      end
      attributes = attributes.map {|key, value| %{#{key}="#{h value}"} }.join(" ")
      "<a #{attributes}>#{text}</a>"
    end
    
    def image_tag(img, attributes = {})
      attributes = { :src => img}.merge(attributes)
      attributes = attributes.map {|key, value| %{#{key}="#{h value}"} }.join(" ")
      "<img #{attributes} />"
    end
    
    def render(path, locals = {})
      content = File.read(path)
      old_path = HamlHelpers.current_path
      old_payload = HamlHelpers.payload
      new_payload = old_payload.clone.merge(locals)
      rendered_content = Convertible.render_liquid(content, new_payload, HamlHelpers.info, path)
      HamlHelpers.current_path = old_path
      HamlHelpers.payload = old_payload
      rendered_content
    rescue Exception => e
      Jekyll.logger.error "Rendering Exception:", "#{e.message} in #{HamlHelpers.current_path}"
    end
    
    module_function
    def context; @context end
    def context= c; @context = c end
    def payload; @payload end
    def payload= c; @payload = c end
    def info; @info end
    def info= c; @info = c end
    def current_path; @current_path end
    def current_path= p; @current_path = p end
    
  end
  
  module Convertible
    
    #alias old_render_liquid render_liquid
  
    module_function
    
    def deep_ostruct(in_hash)
      OpenStruct.new(Hash[
          in_hash.map { |key, value|
            if value.is_a? Hash
              [key, Convertible.deep_ostruct(value)]
            else
              [key, value]
            end
          }
        ]
      )
    end
    
    def old_render_liquid(content, payload, info, path = nil)
      Liquid::Template.parse(content).render!(payload, info)
    rescue Tags::IncludeTagError => e
      Jekyll.logger.error "Liquid Exception:", "#{e.message} in #{e.path}, included in #{path || self.path}"
      raise e
    rescue Exception => e
      Jekyll.logger.error "Liquid Exception:", "#{e.message} in #{path || self.path}"
      raise e
    end
    
    def render_liquid(content, payload, info, path = nil)
      if path and File.extname(path) == '.haml'
          context = Convertible.deep_ostruct(payload)
          context.extend(HamlHelpers)
          HamlHelpers.context = context
          HamlHelpers.payload = payload
          HamlHelpers.info = info
          HamlHelpers.current_path = path
          
          engine = Haml::Engine.new(content, :format => :xhtml)
          content = engine.render(context)
      end
      
      old_render_liquid(content, payload, info, path)
    end
  
  end
  
#  class Converter
#  
#    def locals(locals = nil)
#        @locals = locals if locals
#        @locals
#    end
#  
#  end
#  
#  class Site
#    
#    def expose_data
#      #pp self.converters
#      self.converters.map do |c|
#        c.locals({:site => self})
#      end
#    end
#    
#  end
#
#  class Layout
#
#    alias old_initialize initialize
#
#    def initialize(site, base, name)
#      old_initialize(site, base, name)
#      
#      site.expose_data
#      
#      self.transform
#    end
#
#  end
#  
#  class HamlConverter < Converter
#    safe true
#    priority :low
#
#    def matches(ext)
#      ext =~ /haml/i
#    end
#
#    def output_ext(ext)
#      ".html"
#    end
#
#    def convert(content)
#      engine = Haml::Engine.new(content)
#      engine.render(Object.new, :site => OpenStruct.new(@locals[:site].site_payload['site']))
#    end
#  end

  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

     def matches(ext)
      ext =~ /sass/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content)
      engine.render
    end
  end
end
