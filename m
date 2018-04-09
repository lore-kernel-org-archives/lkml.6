Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDIL7t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:59:49 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:58169 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751662AbeDIL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:59:48 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3871:3873:4321:5007:6119:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:30012:30054:30069:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: brake19_1af5e1443e52c
X-Filterd-Recvd-Size: 1736
Message-ID: <a96f9d11a31e403b0042990d17199c6bbe2667d6.camel@perches.com>
Subject: Re: [PATCH v4 6/9] vsprintf: Factor out %pV handler as va_format()
From: Joe Perches <joe@perches.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 09 Apr 2018 04:59:43 -0700
In-Reply-To: <20180409114455.6wt6zvn6dzlgyhvp@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-7-pmladek@suse.com>
         <1522851967.11185.1.camel@perches.com>
         <20180406131242.mnxutlobi7r6qi6u@pathway.suse.cz>
         <1523024355.6127.3.camel@perches.com>
         <20180409114455.6wt6zvn6dzlgyhvp@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 13:44 +0200, Petr Mladek wrote:
> What exactly is wrong?

I doubt the need.
Adding complexity doesn't seem useful.

> What you would suggest instead?

A static analysis on the source code instead
of runtime checking.

Perhaps a gcc plugin to validate extension to
pointer type or an external tool to do the same.
