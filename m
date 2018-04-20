Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeDTQvh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:51:37 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34370 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeDTQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:51:33 -0400
Date: Sat, 21 Apr 2018 00:51:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin King <colin.king@canonical.com>
Cc: Harsh Jain <harsh@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Michael Werner <werner@chelsio.com>, linux-crypto@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] crypto: chtls: remove redundant assignment to
 cdev->ports
Message-ID: <20180420165127.5lpk4covlw2zkzdn@gondor.apana.org.au>
References: <20180406165847.29310-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406165847.29310-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 05:58:47PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a double assignment to cdev->ports, the first is redundant
> as it is over-written so remove it.
> 
> Detected by CoverityScan, CID#1467432 ("Unused value")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
