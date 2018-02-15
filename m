Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425195AbeBOPwN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:52:13 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39622 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424999AbeBOPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:52:11 -0500
Date: Thu, 15 Feb 2018 23:51:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>, linux-crypto@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: s5p-sss.c: Fix kernel Oops in AES-ECB mode
Message-ID: <20180215155158.GM7352@gondor.apana.org.au>
References: <CGME20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f@eucas1p1.samsung.com>
 <224788c7-426b-d3a9-d0a6-412d2b8afb75@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224788c7-426b-d3a9-d0a6-412d2b8afb75@partner.samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 06:40:20PM +0100, Kamil Konieczny wrote:
> 
> In AES-ECB mode crypt is done with key only, so any use of IV
> can cause kernel Oops, as reported by Anand Moon.
> Fixed it by using IV only in AES-CBC and AES-CTR.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> Reported-by: Anand Moon <linux.amoon@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
