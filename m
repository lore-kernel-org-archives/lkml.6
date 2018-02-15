Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032595AbeBOC0W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:26:22 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:40793 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032447AbeBOC0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:26:21 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3870:3871:3872:3874:4321:5007:6119:7550:7903:8531:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:21080:21222:21611:21627:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: dolls11_543a8679adc32
X-Filterd-Recvd-Size: 1457
Message-ID: <1518661577.3678.44.camel@perches.com>
Subject: Re: [PATCH] block: Change 'unsigned' to 'unsigned int' throughout
 block layer
From: Joe Perches <joe@perches.com>
To: Al Viro <viro@ZenIV.linux.org.uk>, John Pittman <jpittman@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 14 Feb 2018 18:26:17 -0800
In-Reply-To: <20180215021321.GB30522@ZenIV.linux.org.uk>
References: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
         <20180215021321.GB30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-15 at 02:13 +0000, Al Viro wrote:
> On Wed, Feb 14, 2018 at 08:37:02PM -0500, John Pittman wrote:
> > In quite a few files throughout the block layer, the bare 'unsigned' is
> > used rather than the preferred 'unsigned int'.
> 
> Preferred by whom?

The kernel as a whole, ~12:1

> >  The issue was
> 
> What is that "issue" and why is it a problem in the first place?

it's not.

> Oh, good - so presumably it does have some explanations beyond "The Most Holy
> checkpatch.pl Spake Unto Us"; could the esteemed sir share those with us?

infidel...

;)
