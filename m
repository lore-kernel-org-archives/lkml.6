Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161411AbeCAT4Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:56:25 -0500
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:33985 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033214AbeCAT4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:56:23 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2110:2393:2525:2553:2559:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3351:3622:3865:3867:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7653:7903:8828:9025:10004:10400:10848:11232:11658:11914:12043:12050:12555:12740:12760:12895:13069:13071:13160:13229:13311:13357:13439:14180:14181:14659:14721:21060:21080:21451:21611:21627:21740:30054:30070:30090:30091,0,RBL:83.131.31.73:@perches.com:.lbl8.mailshell.net-62.8.110.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: judge77_1a3eb7d37ca61
X-Filterd-Recvd-Size: 1403
Message-ID: <1519934178.6786.2.camel@perches.com>
Subject: Re: [PATCH] media: tw9910: Whitespace alignment
From: Joe Perches <joe@perches.com>
To: jacopo mondi <jacopo@jmondi.org>
Cc: linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Date: Thu, 01 Mar 2018 11:56:18 -0800
In-Reply-To: <20180301190212.GD1641@w540>
References: <2601b3771b35242dba70e1a9e50b2f2bc3dd41d8.1519904988.git.joe@perches.com>
         <20180301190212.GD1641@w540>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 20:02 +0100, jacopo mondi wrote:
> Hi Joe,

Hello Jacopo

> On Thu, Mar 01, 2018 at 03:50:22AM -0800, Joe Perches wrote:
> > Update multiline statements to open parenthesis.
> > Update a ?: to a single line.
> 
> Thanks for the cleanup.
> You may want to rebase this on my series from a few days ago
> 
> https://patchwork.linuxtv.org/patch/47475/

My patch is completely trivial.

I didn't see your patch but presumably Mauro, if he
cares to apply this patch, can handle whatever conflicts
that might exist.

cheers, Joe
