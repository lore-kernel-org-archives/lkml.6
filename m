Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeCLXp1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:45:27 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:39992 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751333AbeCLXp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:45:26 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1381:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3866:3867:3868:3871:3872:4321:5007:10004:10400:10848:11658:11914:12048:12050:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: pump00_2f3d264ce131a
X-Filterd-Recvd-Size: 1200
Message-ID: <1520898323.2049.21.camel@perches.com>
Subject: Re: [PATCH] clang-format: add configuration file
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, rdunlap@infradead.org,
        apw@canonical.com, corbet@lwn.net, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Date: Mon, 12 Mar 2018 16:45:23 -0700
In-Reply-To: <20180312233952.niz2cuz7psv4fe2s@gmail.com>
References: <20180312233952.niz2cuz7psv4fe2s@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 00:39 +0100, Miguel Ojeda wrote:
> clang-format is a tool to format C/C++/... code according to a set
> of rules and heuristics. Like all tools, it is not perfect nor
> covers every single case, but it is good enough to be helpful.

Yes, thanks.

It'd also be nice to remove Lindent as clang-format
is a much better tool today and indent is unmaintained
for about a decade.
