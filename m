Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeCRS0Z (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 14:26:25 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:51101 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754162AbeCRS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 14:26:24 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3873:4250:4321:5007:7974:10004:10400:10848:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:14721:14799:21080:21451:21627:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: knot81_5496834ec343e
X-Filterd-Recvd-Size: 1569
Message-ID: <1521397579.27411.39.camel@perches.com>
Subject: Re: [PATCH v2] clang-format: add configuration file
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Date: Sun, 18 Mar 2018 11:26:19 -0700
In-Reply-To: <20180318171632.qfkemw3mwbcukth6@gmail.com>
References: <20180318171632.qfkemw3mwbcukth6@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-18 at 18:16 +0100, Miguel Ojeda wrote:
>   * Uses clang's tooling support behind the scenes to parse and rewrite
>     the code. It is not based on ad-hoc regexps.

Did you look at the results of a typical and generally
style conforming
subsystem when reformatted with the new
rules you propose here with
clang-format?

One of the issues with hard-n-fast code formatters like
clang-format is taste.

clang-format doesn't have any so it can't know when _not_
to  reformat blocks according to its rules.

Tools like clang-format are generally fine for a first-pass
reformat of non-style compliant code, but are IMO generally
unsuitable for continuous automated use.
