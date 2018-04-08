Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeDHRHL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 13:07:11 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:55113 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751372AbeDHRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 13:07:10 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3871:3872:3873:3874:4321:5007:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14180:14659:21060:21080:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: uncle96_21518f3089e13
X-Filterd-Recvd-Size: 1181
Message-ID: <7d9467ac5aee4b81b5c58c167ac553c75dd26f4c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: relax check for revert commit
From: Joe Perches <joe@perches.com>
To: Jia He <hejianet@gmail.com>, Andy Whitcroft <apw@canonical.com>
Cc: linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
Date: Sun, 08 Apr 2018 10:07:07 -0700
In-Reply-To: <d5f5fbc7-d01f-05e1-f8ac-c1db8ba5fd9e@gmail.com>
References: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
         <1522679339-19067-2-git-send-email-hejianet@gmail.com>
         <d5f5fbc7-d01f-05e1-f8ac-c1db8ba5fd9e@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-04-08 at 10:12 +0800, Jia He wrote:
> Hi Andy & Joe
> 
> Although it is minor, it is a real bug, I thought.
> 
> Is there any comment? Thank you

If you really want to do something useful here,
quote the quote characters and compare for that.
