Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965682AbeBMTcz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:32:55 -0500
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:37115 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965508AbeBMTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:32:52 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3865:3866:3868:3871:3873:4321:5007:10004:10400:10848:11026:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: trick00_35e67ad25871f
X-Filterd-Recvd-Size: 1379
Message-ID: <1518550368.22190.53.camel@perches.com>
Subject: Re: [PATCH] mm/gup: Fixed coding style error and warnings.
From: Joe Perches <joe@perches.com>
To: Mario Leinweber <marioleinweber@web.de>, akpm@linux-foundation.org
Cc: mingo@kernel.org, kirill.shutemov@linux.intel.com,
        aneesh.kumar@linux.vnet.ibm.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2018 11:32:48 -0800
In-Reply-To: <20180213191722.11228-1-marioleinweber@web.de>
References: <20180213191722.11228-1-marioleinweber@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should have a changelog.

On Tue, 2018-02-13 at 14:17 -0500, Mario Leinweber wrote:
[]
> diff --git a/mm/gup.c b/mm/gup.c
[]
> @@ -1635,7 +1640,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>  					 PMD_SHIFT, next, write, pages, nr))
>  				return 0;
>  		} else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
> -				return 0;
> +			return 0;

And of all these changes, this might be the only really useful one
as the
indentation is misleading.
