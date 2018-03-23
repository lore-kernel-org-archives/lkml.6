Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCWHuB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:50:01 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:42232 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750789AbeCWHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:50:00 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2693:2737:2828:3138:3139:3140:3141:3142:3353:3622:3698:3865:3866:3867:3868:3870:3871:3874:4250:4321:5007:6119:7808:7901:7903:7974:8603:10004:10400:10848:11232:11658:11914:12109:12740:12760:12895:13069:13149:13161:13229:13230:13255:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21433:21627:21740:30022:30054:30060:30070:30083:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: rule08_3a01d3567765c
X-Filterd-Recvd-Size: 2456
Message-ID: <1521791397.24655.7.camel@perches.com>
Subject: Re: git send-email and sending the cover-letter to all cc addresses
 found in a patch series
From: Joe Perches <joe@perches.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>, gitster@pobox.com
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Mar 2018 00:49:57 -0700
In-Reply-To: <20180323073858.GA12077@light.dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
         <20180322090059.19361-24-linux@dominikbrodowski.net>
         <20180322172959.GX4043@hirez.programming.kicks-ass.net>
         <CA+55aFwM8mMyZZ9wH2ExAkTKg9Mwie1hOtXz87ivi0nhsZ49Ug@mail.gmail.com>
         <20180323073858.GA12077@light.dominikbrodowski.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 08:38 +0100, Dominik Brodowski wrote:
> On Thu, Mar 22, 2018 at 10:44:54AM -0700, Linus Torvalds wrote:
> > On Thu, Mar 22, 2018 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > But why !? Either Cc me on more of the series such that the whole makes
> > > sense, or better yet, write a proper Changelog.
> > 
> > This is a common issue. We should encourage people to always send at
> > least the cover-page to everybody who gets cc'd, even if they don't
> > get the whole series.
> 
> Will try to do that in future. Does git send-email have such an option? Or
> do I have to specify all cc addresses in the cover letter manually? I found
> some reference to an unresolved discussion on git@ of that topic in 2016, so
> I might not be the only one who could make use of that feature...

The main problem might be the quantity of recipients.

Many spam filters look at how many recipients on an email
to eliminate likely spam.

kernel.org mailing lists have a maximum email header size.
Too many recipients aren't delivered to the lists.

Using BCC could work, but replies then don't go to all
of the recipients.

Generally, I send only to listed the 0/n patch only
to lists and individual patches to maintainers.
