Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeBVCN0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:13:26 -0500
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:40405 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751802AbeBVCNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:13:25 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3871:3872:4321:5007:7653:7903:9010:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21611:21627:21740:30054:30091,0,RBL:85.4.153.126:@perches.com:.lbl8.mailshell.net-62.14.60.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: month19_57bb3fbce6931
X-Filterd-Recvd-Size: 1610
Message-ID: <1519265600.4326.22.camel@perches.com>
Subject: Re: [PATCH] doc: process: Add "Root-caused-by" and "Suggested-by"
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Date: Wed, 21 Feb 2018 18:13:20 -0800
In-Reply-To: <20180222003749.GA4724@beast>
References: <20180222003749.GA4724@beast>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-21 at 16:37 -0800, Kees Cook wrote:
> As recently pointed out by Linus, "Root-caused-by" is a good tag to include
> since it can indicate significantly more work than "just" a Reported-by.
> This adds it and "Suggested-by" (which was also missing) to the documented
> list of tags. Additionally updates checkpatch.pl to match the process docs.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -464,9 +464,11 @@ our $logFunctions = qr{(?x:
>  our $signature_tags = qr{(?xi:
>  	Signed-off-by:|
>  	Acked-by:|
> +	Co-Developed-by:|
>  	Tested-by:|
>  	Reviewed-by:|
>  	Reported-by:|
> +	Root-caused-by:|
>  	Suggested-by:|
>  	To:|
>  	Cc:

Patch does not match commit description
