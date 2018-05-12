Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeELQYp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 12:24:45 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:40061 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750854AbeELQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 12:24:44 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:3873:4321:5007:7514:10004:10400:10848:11232:11658:11914:12296:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: cloth77_2932b06e6052e
X-Filterd-Recvd-Size: 1623
Message-ID: <f7cbb08dded668f07401276266689933f31dd23d.camel@perches.com>
Subject: Re: [RFC: Coding Style] Best way to split a long function
 declaration with modifiers
From: Joe Perches <joe@perches.com>
To: "igor.stoppa@gmail.com" <igor.stoppa@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Date: Sat, 12 May 2018 09:24:41 -0700
In-Reply-To: <CAH2bzCT0BhTy6-hTkaevt1VyYaZpq=AvF6cRpPHs=tzzU76twg@mail.gmail.com>
References: <4fdc0980-d0af-3a02-02e7-0beed8ba05e2@gmail.com>
         <2d0127b079b8c9547519ee8c38a42042ad946d50.camel@perches.com>
         <CAH2bzCT0BhTy6-hTkaevt1VyYaZpq=AvF6cRpPHs=tzzU76twg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-05-12 at 19:07 +0300, igor.stoppa@gmail.com wrote:
> On 12 May 2018 at 18:41, Joe Perches <joe@perches.com> wrote:
> 
> > 
> > I think the first style should be preferred when the
> > combined character length of <type> <function_name> is
> > relatively long.
> > 
> 
> thank you, I could provide a patch to the docs for this case, if it's not
> considered too much of a corner case.

I think it should not considered anything like a mandate.

Perhaps it could be described as an optional/possible style
but perhaps as well it's not necessary as coding_style for
this does not have to be rigidly specified.

cheers, Joe
