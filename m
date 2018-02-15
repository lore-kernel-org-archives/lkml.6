Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425236AbeBOPwr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:52:47 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39642 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425121AbeBOPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:52:44 -0500
Date: Thu, 15 Feb 2018 23:52:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin King <colin.king@canonical.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - Make function ccp_get_dma_chan_attr static
Message-ID: <20180215155234.GO7352@gondor.apana.org.au>
References: <20180206232001.14102-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206232001.14102-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:20:01PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Function ccp_get_dma_chan_attr is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/crypto/ccp/ccp-dmaengine.c:41:14: warning: symbol
> 'ccp_get_dma_chan_attr' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
