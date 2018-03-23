Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCWP6Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:58:25 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:36170 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:58:24 -0400
Date: Fri, 23 Mar 2018 23:58:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-crypto@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: talitos: Delete an error message for a
 failed memory allocation in talitos_edesc_alloc()
Message-ID: <20180323155804.GA2186@gondor.apana.org.au>
References: <ad256dc9-a064-37f9-fb8e-aea22ba40a2b@users.sourceforge.net>
 <13bfdc03-1dee-2f1c-da8d-1e452f10c850@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13bfdc03-1dee-2f1c-da8d-1e452f10c850@users.sourceforge.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 02:32:58PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 12 Mar 2018 14:18:23 +0100
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
