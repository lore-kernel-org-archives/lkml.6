Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDTQv1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:51:27 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34354 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDTQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:51:25 -0400
Date: Sat, 21 Apr 2018 00:51:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Atul Gupta <atul.gupta@chelsio.com>, Harsh Jain <harsh@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto : chtls_cm - Fix potential NULL pointer
 dereferences
Message-ID: <20180420165107.5opcf5tk2nbhxova@gondor.apana.org.au>
References: <20180403200912.GA25976@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403200912.GA25976@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 03:09:12PM -0500, Gustavo A. R. Silva wrote:
> Add null checks on lookup_tid() return value in order to prevent
> null pointer dereferences.
> 
> Addresses-Coverity-ID: 1467422 ("Dereference null return value")
> Addresses-Coverity-ID: 1467443 ("Dereference null return value")
> Addresses-Coverity-ID: 1467445 ("Dereference null return value")
> Addresses-Coverity-ID: 1467449 ("Dereference null return value")
> Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
