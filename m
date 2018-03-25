Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeCYHqP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 03:46:15 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:37608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750782AbeCYHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 03:46:14 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:1978:2393:2559:2562:2693:2828:2890:3138:3139:3140:3141:3142:3622:3865:3866:3871:4042:4321:5007:10004:10400:10848:11658:11914:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21450:21627:30001:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: stove98_8d73f47c9013e
X-Filterd-Recvd-Size: 1201
Message-ID: <1521963970.24655.16.camel@perches.com>
Subject: Re: [PATCH v5 1/8] counter: Introduce the Generic Counter interface
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sun, 25 Mar 2018 00:46:10 -0700
In-Reply-To: <20180324173358.571e2fd8@archlinux>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
         <e64e423c19d69a9578e95de9db6ca41e231d63da.1520614431.git.vilhelm.gray@gmail.com>
         <20180324173358.571e2fd8@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-24 at 17:33 +0000, Jonathan Cameron wrote:
> checkpatch.pl --strict (but take into account some of the warnings will
> be silly so don't fix them all).

What checkpatch output is silly?
