Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED840C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5655217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391691AbeLWECX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:02:23 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:38974 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeLWECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:02:23 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gauy3-0008KL-Kx; Sun, 23 Dec 2018 12:02:19 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gauy0-0004pB-8F; Sun, 23 Dec 2018 12:02:16 +0800
Date:   Sun, 23 Dec 2018 12:02:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: crypto_user_stat: remove unused dump
 functions
Message-ID: <20181223040216.ebailnnyyq4fzkpg@gondor.apana.org.au>
References: <1544690198-21993-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544690198-21993-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:36:37AM +0000, Corentin Labbe wrote:
> This patch removes unused dump functions for crypto_user_stats.
> There are remains of the copy/paste of crypto_user_base to
> crypto_user_stat and I forgot to remove them.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  crypto/crypto_user_base.c            |  4 +---
>  crypto/crypto_user_stat.c            | 33 ----------------------------
>  include/crypto/internal/cryptouser.h | 12 ----------
>  3 files changed, 1 insertion(+), 48 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
