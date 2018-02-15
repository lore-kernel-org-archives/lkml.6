Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425268AbeBOPx2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:53:28 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39678 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424957AbeBOPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:53:25 -0500
Date: Thu, 15 Feb 2018 23:53:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] crypto: s5p-sss.c: Fix kernel Oops in AES-ECB mode
Message-ID: <20180215155312.GR7352@gondor.apana.org.au>
References: <CGME20180207155211eucas1p2d8d04871aaeb49efc30909d46e47e028@eucas1p2.samsung.com>
 <77384548-9870-40b8-46fc-4bd62747efd6@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77384548-9870-40b8-46fc-4bd62747efd6@partner.samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 04:52:09PM +0100, Kamil Konieczny wrote:
> In AES-ECB mode crypt is done with key only, so any use of IV
> can cause kernel Oops. Use IV only in AES-CBC and AES-CTR.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> Reported-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Cc: stable@vger.kernel.org # can be applied after commit 8f9702aad138
> 
> ---
> version 3:
> Change commit message: drop 'Fixes: 8f9702aad138' as the error was
> introduced earlier.

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
