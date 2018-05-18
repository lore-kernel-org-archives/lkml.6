Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeERBNb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:13:31 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:52481 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751524AbeERBNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:13:30 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2538:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3871:3872:3873:3874:4250:4321:5007:6117:6119:7901:10004:10400:10848:10967:11232:11657:11658:11914:12043:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30067:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: frame24_1198e3f12730
X-Filterd-Recvd-Size: 2140
Message-ID: <ba4f4d2279b5f71e698136272637b42eeca05c54.camel@perches.com>
Subject: Re: [PATCH net-next ] net: mscc: Add SPDX identifier
From: Joe Perches <joe@perches.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 May 2018 18:13:25 -0700
In-Reply-To: <20180517193900.GE6828@piout.net>
References: <20180517192305.17517-1-alexandre.belloni@bootlin.com>
         <53ccb8c58e4c3e224ba694c0628096d0c041ba1a.camel@perches.com>
         <20180517193900.GE6828@piout.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-17 at 21:39 +0200, Alexandre Belloni wrote:
> On 17/05/2018 12:28:59-0700, Joe Perches wrote:
> > On Thu, 2018-05-17 at 21:23 +0200, Alexandre Belloni wrote:
> > > ocelot_qsys.h is missing the SPDX identfier, fix that.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > 
> > Only the copyright holders should ideally be modifying
> > these and also removing other license content.
> > 
> > For instance, what's the real intent here?
> > 
> 
> Well, if you have a look, I submitted that file this cycle and it is the
> only one that doesn't have the proper SPDX identifier. This is a mistake
> I'm fixing.

Just because you submitted it does not mean you
are the copyright holder.

> > > diff --git a/drivers/net/ethernet/mscc/ocelot_qsys.h b/drivers/net/ethernet/mscc/ocelot_qsys.h
> > 
> > []
> > > @@ -1,7 +1,7 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > 
> > GPL 2.0+ or 2.0?
> > 
> 
> 2.0

How do you know that?
