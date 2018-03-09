Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeCIPUM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:20:12 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:60992 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeCIPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:20:09 -0500
Date: Fri, 9 Mar 2018 23:19:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Tero Kristo <t-kristo@ti.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] crypto: omap-sham: Remove useless check for non-null
 request
Message-ID: <20180309151952.GG13567@gondor.apana.org.au>
References: <1519937413-24468-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519937413-24468-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 09:50:10PM +0100, Krzysztof Kozlowski wrote:
> ahash_request 'req' argument passed by the caller
> omap_sham_handle_queue() cannot be NULL here because it is obtained from
> non-NULL pointer via container_of().
> 
> This fixes smatch warning:
>     drivers/crypto/omap-sham.c:812 omap_sham_prepare_request() warn: variable dereferenced before check 'req' (see line 805)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
