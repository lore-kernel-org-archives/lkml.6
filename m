Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeCaSB1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 14:01:27 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:36411 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752922AbeCaSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 14:01:25 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3872:3874:3876:4321:5007:10004:10400:10481:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14180:14659:19900:21060:21080:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: angle46_293fc5d747b23
X-Filterd-Recvd-Size: 1455
Message-ID: <1522519281.11653.16.camel@perches.com>
Subject: Re: [PATCH 02/12] treewide/net: Rename eth_stp_addr to
 ether_stp_addr
From: Joe Perches <joe@perches.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Date: Sat, 31 Mar 2018 11:01:21 -0700
In-Reply-To: <20180331173643.GD7460@lunn.ch>
References: <cover.1522479607.git.joe@perches.com>
         <a2d52bbcdcd36c5062bd4fa175df15acd5f8cb85.1522479607.git.joe@perches.com>
         <20180331173643.GD7460@lunn.ch>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-31 at 19:36 +0200, Andrew Lunn wrote:
> On Sat, Mar 31, 2018 at 12:05:17AM -0700, Joe Perches wrote:
> > --- a/net/bridge/br_device.c
> > +++ b/net/bridge/br_device.c
> > @@ -1,4 +1,4 @@
> > -/*
> > +gg/*
> 
> Hi Joe
> 
> This does not look good.

Definitely agree with that.  apologies for not noticing.

It's emacs editing nonsense like a superfluous :wq for vim
