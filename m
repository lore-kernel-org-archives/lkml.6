Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965368AbeCPPzt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:55:49 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59570 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754041AbeCPPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:55:46 -0400
Date: Fri, 16 Mar 2018 23:55:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: introduce SM4 symmetric cipher algorithm
Message-ID: <20180316155536.GE7095@gondor.apana.org.au>
References: <1520329484-23317-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520329484-23317-1-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:44:41AM +0000, Gilad Ben-Yossef wrote:
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016) and
> related tests.
> 
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.
> 
> SMS4 was originally created for use in protecting wireless
> networks, and is mandated in the Chinese National Standard for
> Wireless LAN WAPI (Wired Authentication and Privacy Infrastructure)
> (GB.15629.11-2003).
> 
> Tested on arm 64 and 32 bit.
> 
> Gilad Ben-Yossef (2):
>   crypto: introduce SM4 symmetric cipher algorithm
>   crypto: introduce SM4 testmgr tests
> 
>  crypto/Kconfig       |  25 ++++++
>  crypto/Makefile      |   1 +
>  crypto/sm4_generic.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/tcrypt.c      |   3 +
>  crypto/testmgr.c     |   9 ++
>  crypto/testmgr.h     | 131 +++++++++++++++++++++++++++
>  include/crypto/sm4.h |  28 ++++++
>  7 files changed, 441 insertions(+)
>  create mode 100644 crypto/sm4_generic.c
>  create mode 100644 include/crypto/sm4.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
