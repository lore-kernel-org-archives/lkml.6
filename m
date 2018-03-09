Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbeCIPSM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:18:12 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:60912 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeCIPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:18:09 -0500
Date: Fri, 9 Mar 2018 23:17:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
        Horia Geanta <horia.geanta@nxp.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  2/2] crypto: talitos - do not perform unnecessary dma
 synchronisation
Message-ID: <20180309151759.GD13567@gondor.apana.org.au>
References: <7c934f0788d60bd82fb1cb51d712c9ab1ea7fcb4.1519660621.git.christophe.leroy@c-s.fr>
 <e57399f4eb1de4b6330a47bdf8c82c9982999a8e.1519660621.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57399f4eb1de4b6330a47bdf8c82c9982999a8e.1519660621.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:40:06PM +0100, Christophe Leroy wrote:
> req_ctx->hw_context is mainly used only by the HW. So it is not needed
> to sync the HW and the CPU each time hw_context in DMA mapped.
> This patch modifies the DMA mapping in order to limit synchronisation
> to necessary situations.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
