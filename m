Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeCaSks (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 14:40:48 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:49733 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753011AbeCaSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 14:40:46 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:9025:10004:10400:10481:10848:11026:11232:11657:11658:11914:12043:12438:12555:12698:12737:12740:12760:12895:12986:13069:13071:13311:13357:13439:14180:14181:14659:14721:19900:21060:21080:21365:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: store25_5dbaec5bbfd0f
X-Filterd-Recvd-Size: 1721
Message-ID: <1522521642.11653.19.camel@perches.com>
Subject: Re: [PATCH 04/12] bridge: netfilter: Use the new global
 ether_<foo>_addr arrays
From: Joe Perches <joe@perches.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sat, 31 Mar 2018 11:40:42 -0700
In-Reply-To: <20180331182810.or7attmfpjxw4sfm@salvia>
References: <cover.1522479607.git.joe@perches.com>
         <df70bafdca663db034626f4f1525826ea263bf2c.1522479607.git.joe@perches.com>
         <20180331182810.or7attmfpjxw4sfm@salvia>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-31 at 20:28 +0200, Pablo Neira Ayuso wrote:
> Hi Joe,

Hi Pablo.

> On Sat, Mar 31, 2018 at 12:05:19AM -0700, Joe Perches wrote:
> > Remove the local consts and use the new globals.
> 
> This one is already upstream:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git/commit/?id=9124a20d8794663a396b5d6f91f66903848a042b
> 
> I can see you're using is_broadcast_ether_addr(e->destmsk) in this new
> version, we would need an incremental version.

No worries.  I did it against next-20180329
and that other commit wasn't there.
