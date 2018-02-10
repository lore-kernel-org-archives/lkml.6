Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeBJVb0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:31:26 -0500
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:38704 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752541AbeBJVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:31:25 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1373:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2553:2568:2612:2629:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:2975:3000:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7514:7809:8599:9025:9388:10004:10049:10400:10848:11232:11658:11914:12043:12555:12702:12737:12740:12760:12776:12895:12903:12933:13200:13229:13439:14094:14181:14651:14659:14721:21080:21451:21611:21622:30054:30079:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: seed78_295304015b95e
X-Filterd-Recvd-Size: 3179
Message-ID: <1518298282.16865.28.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: auxdisplay: remove obsolete webpages
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Sat, 10 Feb 2018 13:31:22 -0800
In-Reply-To: <634edbaa-f877-8f61-b61c-79e060edf8b5@infradead.org>
References: <20180210095651.y7kvf3oqp6pzvh33@gmail.com>
         <634edbaa-f877-8f61-b61c-79e060edf8b5@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-10 at 09:32 -0800, Randy Dunlap wrote:
> On 02/10/2018 01:56 AM, Miguel Ojeda wrote:
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Are you merging this directly to Linus?  or what?

A generic negative of these removals, even for ancient
drivers that may or may not work anymore, is that the
old links may still be found on things like the
wayback machine/archive.org.

Miguel, do you have a copy of this link source?

If you do, should it be introduced as a .rst into
Documentation/ somewhere?

> Thanks.
> 
> > ---
> >  MAINTAINERS | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e6c26cb47d02..01e302f7967e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2484,8 +2484,6 @@ F:	kernel/audit*
> >  
> >  AUXILIARY DISPLAY DRIVERS
> >  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> > -W:	http://miguelojeda.es/auxdisplay.htm
> > -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
> >  S:	Maintained
> >  F:	drivers/auxdisplay/
> >  F:	include/linux/cfag12864b.h
> > @@ -3373,16 +3371,12 @@ F:	include/linux/usb/wusb*
> >  
> >  CFAG12864B LCD DRIVER
> >  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> > -W:	http://miguelojeda.es/auxdisplay.htm
> > -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
> >  S:	Maintained
> >  F:	drivers/auxdisplay/cfag12864b.c
> >  F:	include/linux/cfag12864b.h

Another suggestion would be to move
"include/linux/cfag12864b.h" into drivers/auxdisplay

> >  CFAG12864BFB LCD FRAMEBUFFER DRIVER
> >  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> > -W:	http://miguelojeda.es/auxdisplay.htm
> > -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
> >  S:	Maintained
> >  F:	drivers/auxdisplay/cfag12864bfb.c
> >  F:	include/linux/cfag12864b.h
> > @@ -7866,8 +7860,6 @@ F:	kernel/kprobes.c
> >  
> >  KS0108 LCD CONTROLLER DRIVER
> >  M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> > -W:	http://miguelojeda.es/auxdisplay.htm
> > -W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
> >  S:	Maintained
> >  F:	Documentation/auxdisplay/ks0108
> >  F:	drivers/auxdisplay/ks0108.c
> > 
> 
> 
