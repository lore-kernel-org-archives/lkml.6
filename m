Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeEEHQx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:16:53 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35148 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeEEHQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:16:52 -0400
Date: Sat, 5 May 2018 15:16:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cleanup and hardware keys
Message-ID: <20180505071638.qi34i47lodltuyge@gondor.apana.org.au>
References: <1524468316-6606-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524468316-6606-1-git-send-email-gilad@benyossef.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 08:25:13AM +0100, Gilad Ben-Yossef wrote:
> Small cleanup and add support for CryptoCell hardware keys.
> 
> Changes from v1:
> - The cleanup patch is new, as Herbert took the previous one :-)
> - Hardware key API uses the "paes" designator to indicate a protected key,
>   same as s390, as per Herbert preference
> - Avoid direct casting and reference of key material, as pointed out by
>   Herbert
> 
> Gilad Ben-Yossef (2):
>   crypto: ccree: enable support for hardware keys
>   crypto: ccree: use proper printk format
> 
>  crypto/testmgr.c                 |  43 +++++
>  drivers/crypto/ccree/cc_cipher.c | 350 ++++++++++++++++++++++++++++++++++-----
>  drivers/crypto/ccree/cc_cipher.h |  30 +---
>  drivers/crypto/ccree/cc_driver.c |   2 +-
>  4 files changed, 362 insertions(+), 63 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
