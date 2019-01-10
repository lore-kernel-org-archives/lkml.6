Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8328DC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB2E2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfAJNKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:10:15 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:59498 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfAJNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:10:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gha5x-0001Da-5e; Thu, 10 Jan 2019 21:10:01 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gha5s-0000TE-Cj; Thu, 10 Jan 2019 21:09:56 +0800
Date:   Thu, 10 Jan 2019 21:09:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi2 - add a CRYPTO_DEV_FSL_CAAM dependency
Message-ID: <20190110130956.j7nitx5sw2xgr3pc@gondor.apana.org.au>
References: <20181220152815.3613164-1-arnd@arndb.de>
 <VI1PR0402MB3485B39F40CFFDED08D8701698BF0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3485B39F40CFFDED08D8701698BF0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:27:16PM +0000, Horia Geanta wrote:
>
> This indeed solves the issue, but as you mentioned won't allow for
> CRYPTO_DEV_FSL_DPAA2_CAAM=y when CRYPTO_DEV_FSL_CAAM=m.
> 
> I think a better solution is the following:
> 
> -- >8 --
> Subject: [PATCH] crypto: caam - move shared symbols in a common location

Hi Horia:

Please resend this patch with a new Subject line as patchwork
no longer tracks patches sent in reply to existing patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
