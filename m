Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934563AbeCPP4Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:56:24 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59582 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753976AbeCPP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:56:19 -0400
Date: Fri, 16 Mar 2018 23:56:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: hash.h: Prevent use of req->result in ahash
 update
Message-ID: <20180316155610.GG7095@gondor.apana.org.au>
References: <CGME20180307104934eucas1p18af0e65a519299997b5d2f7fb78cd39f@eucas1p1.samsung.com>
 <7850c31c-8703-51fb-0710-3b4920935bfc@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7850c31c-8703-51fb-0710-3b4920935bfc@partner.samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 11:49:33AM +0100, Kamil Konieczny wrote:
> Prevent improper use of req->result field in ahash update, init, export and
> import functions in drivers code. A driver should use ahash request context
> if it needs to save internal state.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
