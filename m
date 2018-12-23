Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33527C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0169F217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbeLWECv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:02:51 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:38984 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeLWECv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:02:51 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gauyX-0008MZ-B4; Sun, 23 Dec 2018 12:02:49 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gauyW-0004q9-7f; Sun, 23 Dec 2018 12:02:48 +0800
Date:   Sun, 23 Dec 2018 12:02:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nagadheeraj Rottela <rnagadheeraj@marvell.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srikanth Jampala <jsrikanth@marvell.com>
Subject: Re: [PATCH] crypto: cavium/nitrox - Added AEAD cipher support
Message-ID: <20181223040248.b42xz7hxdjtbk63c@gondor.apana.org.au>
References: <20181214111856.32030-1-rnagadheeraj@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214111856.32030-1-rnagadheeraj@marvell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:19:51AM +0000, Nagadheeraj Rottela wrote:
> Added support to offload AEAD ciphers to NITROX. Currently supported
> AEAD cipher is 'gcm(aes)'.
> 
> Signed-off-by: Nagadheeraj Rottela <rnagadheeraj@marvell.com>
> Reviewed-by: Srikanth Jampala <jsrikanth@marvell.com>
> ---
>  drivers/crypto/cavium/nitrox/Makefile          |   4 +-
>  drivers/crypto/cavium/nitrox/nitrox_aead.c     | 364 ++++++++++++++++
>  drivers/crypto/cavium/nitrox/nitrox_algs.c     | 559 +------------------------
>  drivers/crypto/cavium/nitrox/nitrox_common.h   |   6 +-
>  drivers/crypto/cavium/nitrox/nitrox_req.h      | 239 +++++++++--
>  drivers/crypto/cavium/nitrox/nitrox_reqmgr.c   |  38 +-
>  drivers/crypto/cavium/nitrox/nitrox_skcipher.c | 498 ++++++++++++++++++++++
>  7 files changed, 1103 insertions(+), 605 deletions(-)
>  create mode 100644 drivers/crypto/cavium/nitrox/nitrox_aead.c
>  create mode 100644 drivers/crypto/cavium/nitrox/nitrox_skcipher.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
