Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeC1XVS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 19:21:18 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:33230 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750774AbeC1XVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 19:21:17 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3653:3866:3867:3868:3870:3872:4321:4362:5007:7576:7903:10004:10400:10848:11026:11232:11658:11914:12049:12296:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: soup11_2834273417f1b
X-Filterd-Recvd-Size: 1564
Message-ID: <1522279274.2210.15.camel@perches.com>
Subject: Re: [PATCH] ore: fix spelling mistake: "Multples" -> "multiples"
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>,
        Boaz Harrosh <ooo@electrozaur.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Mar 2018 16:21:14 -0700
In-Reply-To: <20180328230705.28145-1-colin.king@canonical.com>
References: <20180328230705.28145-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 00:07 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in ORE_ERR error message text and
> make it all lowercase.

thanks and more trivially:

> diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
[]
> @@ -68,7 +68,7 @@ int ore_verify_layout(unsigned total_comps, struct ore_layout *layout)
>  	}
>  	if (0 != (layout->stripe_unit & ~PAGE_MASK)) {
>  		ORE_ERR("Stripe Unit(0x%llx)"
> -			  " must be Multples of PAGE_SIZE(0x%lx)\n",
> +			  " must be multiples of PAGE_SIZE(0x%lx)\n",

"a multiple" might be more intelligible than "multiples"

It would be a more common usage too.

$ git grep -i "\".*multiples" | wc -l
10
$ git grep -i "\".*a multiple" | wc -l
62
