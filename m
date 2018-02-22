Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeBVPNR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:13:17 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:57104 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932922AbeBVPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:13:13 -0500
Date: Thu, 22 Feb 2018 23:12:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH] crypto: nx-842: Delete an error message for a failed
 memory allocation in nx842_pseries_init()
Message-ID: <20180222151249.GH29815@gondor.apana.org.au>
References: <8261d041-ccd9-c0f8-4530-a4afb43ee7ab@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8261d041-ccd9-c0f8-4530-a4afb43ee7ab@users.sourceforge.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 05:17:08PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Feb 2018 17:05:13 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
