Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeELPlf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 11:41:35 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:44066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751048AbeELPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 11:41:34 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3874:4321:5007:10004:10400:10450:10455:10848:11026:11232:11658:11914:12296:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:14721:19904:19999:21080:21326:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: ocean36_64c8e426eeb2d
X-Filterd-Recvd-Size: 1598
Message-ID: <2d0127b079b8c9547519ee8c38a42042ad946d50.camel@perches.com>
Subject: Re: [RFC: Coding Style] Best way to split a long function
 declaration with modifiers
From: Joe Perches <joe@perches.com>
To: Igor Stoppa <igor.stoppa@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Date: Sat, 12 May 2018 08:41:31 -0700
In-Reply-To: <4fdc0980-d0af-3a02-02e7-0beed8ba05e2@gmail.com>
References: <4fdc0980-d0af-3a02-02e7-0beed8ba05e2@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-05-12 at 18:19 +0300, Igor Stoppa wrote:
> I have been wondering if it's ok to break a long (function declaration) 
> line in the following way:
> 
> static __always_inline
> struct foo_bar *__get_foo_bar(type1 parm1, type2 parm2, type3 parm3)
> 
> 
> instead of:
> 
> static __always_inline struct foo_bar *__get_foo_bar(type1 parm1,
> 						     type2 parm2,
> 						     type3 parm3)
> 

I think so.

> I personally like more the former, not to mention that it uses also one 
> line less, but it seems less common in the sources.
> The coding style references do not seem to say anything explicit about 
> which style to prefer.

I think the first style should be preferred when the
combined character length of <type> <function_name> is
relatively long.
