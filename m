Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeCRS0C (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 14:26:02 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:43631 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750766AbeCRSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 14:25:57 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:69:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4031:4321:4605:5007:7901:7903:10004:10400:10848:11232:11658:11914:12043:12555:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:21740:30012:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: plate11_50cab79003f60
X-Filterd-Recvd-Size: 1940
Message-ID: <1521397553.27411.38.camel@perches.com>
Subject: Re: coccinelle & linux-kernel: unindent blocks by reversing tests?
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
Date: Sun, 18 Mar 2018 11:25:53 -0700
In-Reply-To: <alpine.DEB.2.20.1803181848370.2420@hadrien>
References: <1521391861.27411.27.camel@perches.com>
         <alpine.DEB.2.20.1803181848370.2420@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-18 at 18:50 +0100, Julia Lawall wrote:
> 
> On Sun, 18 Mar 2018, Joe Perches wrote:
> 
> > There are many blocks of code that could be
> > unindented and so neatened by reversing tests.
[]
> > Which often saves many vertical lines by reducing
> > now unnecessary line-wrapping done at 80-columns.
> 
> I tried it.  One can't easily make the transformation when there is a
> variable declaration in the block.  And Coccinelle doesn't move leading
> comments over to the left.  Most of the examples I found seemed to have
> only one level of opportunity.  I don't know if the churn is worth it in
> that case.  On a more complex example, the pretty printer crashes, so I'll
> have to look into that.

[]

> > A trivial hand-produced example selected randomly:
[]
> > ---
> >  .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        | 455 +++++++++------------
> >  1 file changed, 201 insertions(+), 254 deletions(-)

Dunno about the churn, but converting many lines of badly
wrapped simple statements and reducing line count seems
somewhat worthwhile.
