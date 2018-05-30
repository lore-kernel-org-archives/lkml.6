Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeE3QRM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:17:12 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:54584 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeE3QRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:17:11 -0400
Date: Thu, 31 May 2018 00:17:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Crypto Fixes for 4.17
Message-ID: <20180530161704.2v5zcfn5wt4hsbxc@gondor.apana.org.au>
References: <20161119102748.GA4277@gondor.apana.org.au>
 <20161213132414.GA7898@gondor.apana.org.au>
 <20170223125141.GA17400@gondor.apana.org.au>
 <20170714141855.GA29426@gondor.apana.org.au>
 <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au>
 <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus: 

This push fixes a potential kernel panic in the inside-secure driver.


Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus


Antoine Tenart (1):
      crypto: inside-secure - do not use memset on MMIO

 drivers/crypto/inside-secure/safexcel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
