Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeDJQrn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:47:43 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:55721 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751624AbeDJQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:47:42 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2564:2682:2685:2692:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7903:8527:9010:9025:9040:10004:10400:10848:11232:11658:11914:12043:12740:12760:12895:13069:13076:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21451:21627:21740:30054:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: snake40_7d29fd2a70407
X-Filterd-Recvd-Size: 2621
Message-ID: <695c3bd58a41b1f902c0deabf7552fcd5a89b53f.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host
 drivers
From: Joe Perches <joe@perches.com>
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 09:47:38 -0700
In-Reply-To: <29ab4b56-f857-a2d6-0b28-833896e9f47c@axentia.se>
References: <20180410141125.4477-1-wsa@the-dreams.de>
         <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
         <20180410155250.rjrfd6v5unqlf25m@ninjato>
         <29ab4b56-f857-a2d6-0b28-833896e9f47c@axentia.se>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 18:42 +0200, Peter Rosin wrote:
> On 2018-04-10 17:52, Wolfram Sang wrote:
> > Hi Peter,
> > 
> > > Hmm, I think you are ducking out from the i2c-mux-pinctrl driver as well.
> > > Was that the intent?
> > 
> > Oops, nope! Sorry, I just forgot about the demux (I think you mean that
> > one) driver and will create a seperate entry for it.
> 
> Right, I meant the demux...
> 
> > > 
> > > > +I2C SUBSYSTEM DRIVERS
> > > > +L:	linux-i2c@vger.kernel.org
> > > > +W:	https://i2c.wiki.kernel.org/
> > > > +Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
> > > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> > > > +S:	Odd Fixes
> > > > +F:	Documentation/devicetree/bindings/i2c/
> > > > +F:	drivers/i2c/*/
> > > > +
> > > 
> > > And this includes all the other muxes, i.e. those that are "mine". Maybe
> > > not a problem, but what do I know?
> > 
> > Sorry again, I really didn't want to dump something on you or leave you
> > all alone with the muxes. I was just so focussed on the host drivers
> > that muxes simply slipped through my mind :( I can add myself to the
> > muxes section again, no problem. I'll let you decidei what you prefer,
> > both is fine for me. You are doing a great job there!
> 
> No no, you don't need to add yourself there. I understand the mux drivers,
> and it's pretty quiet, so no need for that. What I was worrying about was
> this "Odd Fixes" fallback entry needlessly covering the muxes when they
> are covered elsewhere.

If you want to exclude drivers/i2c/muxes from the
subsystem drivers block then you could add

X:	drivers/i2c/muxes/
