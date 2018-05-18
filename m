Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeERIOg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:14:36 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:59375 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751644AbeERIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:14:29 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2110:2393:2538:2559:2562:2692:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6117:6119:7901:7903:10010:10400:10848:10967:11232:11657:11658:11914:12043:12663:12740:12760:12895:13161:13229:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:30003:30012:30022:30029:30041:30054:30067:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:1:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: box34_26dad2c1a4d2a
X-Filterd-Recvd-Size: 3335
Message-ID: <77d0d8ff4cb9984ac20546842292aafd9e3b2e25.camel@perches.com>
Subject: Re: [PATCH net-next ] net: mscc: Add SPDX identifier
From: Joe Perches <joe@perches.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 18 May 2018 01:14:25 -0700
In-Reply-To: <20180518075227.GF6828@piout.net>
References: <20180517192305.17517-1-alexandre.belloni@bootlin.com>
         <53ccb8c58e4c3e224ba694c0628096d0c041ba1a.camel@perches.com>
         <20180517193900.GE6828@piout.net>
         <ba4f4d2279b5f71e698136272637b42eeca05c54.camel@perches.com>
         <20180518075227.GF6828@piout.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 09:52 +0200, Alexandre Belloni wrote:
> On 17/05/2018 18:13:25-0700, Joe Perches wrote:
> > On Thu, 2018-05-17 at 21:39 +0200, Alexandre Belloni wrote:
> > > On 17/05/2018 12:28:59-0700, Joe Perches wrote:
> > > > On Thu, 2018-05-17 at 21:23 +0200, Alexandre Belloni wrote:
> > > > > ocelot_qsys.h is missing the SPDX identfier, fix that.
> > > > > 
> > > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > 
> > > > Only the copyright holders should ideally be modifying
> > > > these and also removing other license content.
> > > > 
> > > > For instance, what's the real intent here?
> > > > 
> > > 
> > > Well, if you have a look, I submitted that file this cycle and it is the
> > > only one that doesn't have the proper SPDX identifier. This is a mistake
> > > I'm fixing.
> > 
> > Just because you submitted it does not mean you
> > are the copyright holder.
> > 
> > > > > diff --git a/drivers/net/ethernet/mscc/ocelot_qsys.h b/drivers/net/ethernet/mscc/ocelot_qsys.h
> > > > 
> > > > []
> > > > > @@ -1,7 +1,7 @@
> > > > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > > 
> > > > GPL 2.0+ or 2.0?
> > > > 
> > > 
> > > 2.0
> > 
> > How do you know that?
> > 
> 
> The fact is that it should have been submitted with the SPDX identifier
> to be consistent with the rest of the driver. If you can't trust me on
> that, then, you can't probably trust anyone submitting anything new
> driver to the kernel.

Silly.

> I still don't understand why you are making an issue out of this.

Correctness in licensing text is important.

> Because my email address doesn't match the copyright holder's name
> doesn't mean I'm not allowed to fix my own mistake.

Mostly, it's a question of what the original
license is.  As far as I can tell, microsemi
publishes their code only under an MIT license.

The MIT license does allow sublicensing, so
it does seem you can choose what additional
license restrictions you can assert as long
as the original MIT license is also followed.

cheers, Joe
