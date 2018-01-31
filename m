Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeAaWtB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:49:01 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:60410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751643AbeAaWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:49:00 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7522:7974:10004:10400:10848:11232:11658:11914:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14659:21060:21080:21325:21326:21611:21627:30041:30054:30055:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wire77_88947b251a82e
X-Filterd-Recvd-Size: 1560
Message-ID: <1517438936.7489.8.camel@perches.com>
Subject: Re: checkpatch changes for 4.16
From: Joe Perches <joe@perches.com>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 31 Jan 2018 14:48:56 -0800
In-Reply-To: <20180131214630.GF11433@eros>
References: <20180131214630.GF11433@eros>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 08:46 +1100, Tobin C. Harding wrote:
> Hi Joe,
> 
> Can I please bother you with a maintainer question.  I know everyone is
> super busy right now, I'm asking for a smidgen of your time instead of
> doing it wrong and taking up some of Linus' time since it's merge window
> and all that.
> 
> I have the checkpatch set queued ready to do a GIT PULL to Linus.  My
> concern is that the subject line may not be unique if checkpatch changes
> are coming in from various trees this merge window. I have tagged the
> pull request with

Personally, I think you could let Andrew Morton pick them
up as very few patches for checkpatch go in any other way.

What patches are you submitting again?

Is it just

commit 7b1924a1d930 ("vsprintf: add printk specifier %px")

or is there something else?
