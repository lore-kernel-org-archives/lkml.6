Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D63CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14AB2184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeLWMaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:30:15 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39726 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLWMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 07:30:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gb2tZ-0005ay-Ks; Sun, 23 Dec 2018 20:30:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gb2tX-00059c-TK; Sun, 23 Dec 2018 20:30:11 +0800
Date:   Sun, 23 Dec 2018 20:30:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harsh Jain <harsh@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the crypto tree
Message-ID: <20181223123011.qxwfkoib6zadd2rn@gondor.apana.org.au>
References: <20181223231304.1654cf1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223231304.1654cf1d@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 11:13:04PM +1100, Stephen Rothwell wrote:
> Hi Herbert,
> 
> Commit
> 
>   6501ab5ed4d9 ("crypto: chelsio - Reset counters on cxgb4 Detach")
> 
> is missing a Signed-off-by from its author.

Hi Stephen:

I believe the issue here is not a missing sign-off from the author,
but rather that the author was incorrectly set to Harsh who sent
the email rather than Atul.

Harsh, please add a From header to the patch description in future
so that the Author field is set correctly.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
