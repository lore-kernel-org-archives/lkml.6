Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeFBP2F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 11:28:05 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:51604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751553AbeFBP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 11:28:02 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3870:4321:4823:5007:7875:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:21080:21451:21611:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: wire57_28e4832ce1f12
X-Filterd-Recvd-Size: 1903
Message-ID: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
Subject: Re: [PATCH v2 0/5] staging: mt7621-spi: Fix Coding style issues.
From: Joe Perches <joe@perches.com>
To: Sankalp Negi <sankalpnegi2310@gmail.com>, gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name
Date: Sat, 02 Jun 2018 08:27:59 -0700
In-Reply-To: <20180602142605.6846-1-sankalpnegi2310@gmail.com>
References: <20180601091553.GA5821@kroah.com>
         <20180602142605.6846-1-sankalpnegi2310@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-02 at 19:56 +0530, Sankalp Negi wrote:
> This patch series lists different changes for coding style fixes
> as reported by checkpatch.pl, changes can be broken down as :
> 
> 1. Indent switch and case labels at the same level
> 2. Fix a line over 80 columns
> 3. Place tabs for indentation instead of spaces
> 4. Add a space before open paranthesis in switch 
> 5. Remove unnecessary braces {} from single statement if
> 
> version 2 changes
> - segregated changes in individual commits as per fix category
> 
> Sankalp Negi (5):
>   staging: mt7621-spi: Fix Coding style issues reported by
>     checkpatch.pl.
>   staging: mt7621-spi: Fix Coding style issues reported by
>     checkpatch.pl.
>   staging: mt7621-spi: Fix Coding style issues reported by
>     checkpatch.pl.
>   staging: mt7621-spi: Fix Coding style issues reported by
>     checkpatch.pl.
>   staging: mt7621-spi: Fix Coding style issues reported by
>     checkpatch.pl.

Plese use unique subjects for each patch in a series.
