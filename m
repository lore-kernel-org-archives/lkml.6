Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeC1SLW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:11:22 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:57527 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752318AbeC1SLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:11:20 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3868:4321:5007:6119:10004:10400:10848:11232:11658:11914:12048:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30017:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: power92_62b67b7a7d700
X-Filterd-Recvd-Size: 1251
Message-ID: <1522260676.12357.121.camel@perches.com>
Subject: Re: [PATCH] crypto: cavium: zip: Remove unnecessary parentheses
From: Joe Perches <joe@perches.com>
To: Varsha Rao <rvarsha016@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: cocci <cocci@systeme.lip6.fr>
Date: Wed, 28 Mar 2018 11:11:16 -0700
In-Reply-To: <20180328175736.17360-1-rvarsha016@gmail.com>
References: <20180328175736.17360-1-rvarsha016@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 23:27 +0530, Varsha Rao wrote:
> This patch fixes the clang warning of extraneous parentheses, with the
> following coccinelle script.
> 
> @@
> identifier i;
> constant c;
> @@
> (
> -((i == c))
> +i == c
> > 
> 
> -((i <= c))
> +i <= c

Why just the "==" and "<=" cases?
Why not "<", ">" and ">=" too?

Why not expression instead of constant?
