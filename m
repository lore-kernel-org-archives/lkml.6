Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeCYRES (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 13:04:18 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:40610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753472AbeCYREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 13:04:13 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:1978:2393:2553:2559:2562:2693:2828:2890:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3873:4042:4321:5007:10004:10400:10848:10967:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21450:21627:30001:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: space86_41b5fb756c71b
X-Filterd-Recvd-Size: 1790
Message-ID: <1521997449.24655.22.camel@perches.com>
Subject: Re: [PATCH v5 1/8] counter: Introduce the Generic Counter interface
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, benjamin.gaignard@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Mar 2018 10:04:09 -0700
In-Reply-To: <20180325175624.4cdaaefe@archlinux>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
         <e64e423c19d69a9578e95de9db6ca41e231d63da.1520614431.git.vilhelm.gray@gmail.com>
         <20180324173358.571e2fd8@archlinux> <1521963970.24655.16.camel@perches.com>
         <20180325175624.4cdaaefe@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-25 at 17:56 +0100, Jonathan Cameron wrote:
> On Sun, 25 Mar 2018 00:46:10 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > On Sat, 2018-03-24 at 17:33 +0000, Jonathan Cameron wrote:
> > > checkpatch.pl --strict (but take into account some of the warnings will
> > > be silly so don't fix them all).  
> > 
> > What checkpatch output is silly?
> 
> Sorry - bad word choice.

No worries.  Just checking.

> It guides you to where you should look very
> well, but sometimes the patch author should consider the warning and
> decide to ignore it.  

Very true.  It's a brainless tool and all who use
it should seriously consider ignoring its output
whenever they deem appropriate.
