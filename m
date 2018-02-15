Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425217AbeBOPwn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:52:43 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39632 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424990AbeBOPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:52:40 -0500
Date: Thu, 15 Feb 2018 23:52:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin King <colin.king@canonical.com>
Cc: Harsh Jain <harsh@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: chelsio - Make function aead_ccm_validate_input
 static
Message-ID: <20180215155225.GN7352@gondor.apana.org.au>
References: <20180206230920.13764-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206230920.13764-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:09:20PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Function aead_ccm_validate_input is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/crypto/chelsio/chcr_algo.c:2627:5: warning: symbol
> 'aead_ccm_validate_input' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
