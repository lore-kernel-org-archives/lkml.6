Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeECXAT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:00:19 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:40542 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeECXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:00:17 -0400
Date: Fri, 4 May 2018 07:00:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "'Antoine Tenart'" <antoine.tenart@bootlin.com>
Cc: David Laight <David.Laight@aculab.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        "oferh@marvell.com" <oferh@marvell.com>,
        "igall@marvell.com" <igall@marvell.com>
Subject: Re: [PATCH 01/10] crypto: aead - allow to allocate AEAD requests on
 the stack
Message-ID: <20180503230006.oq6vycplwsomfprw@gondor.apana.org.au>
References: <20180502095725.31935-1-antoine.tenart@bootlin.com>
 <20180502095725.31935-2-antoine.tenart@bootlin.com>
 <02ad9eb93c494314a85db69886cf787a@AcuMS.aculab.com>
 <20180503122330.GB3324@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503122330.GB3324@kwain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 02:23:30PM +0200, 'Antoine Tenart' wrote:
>
> I was expecting this question :) The thing is this define looks *a lot*
> like the ones defined in other places in the crypto framework, such as
> SKCIPHER_REQUEST_ON_STACK and AHASH_REQUEST_ON_STACK. Those haven't been
> tackled down so far by the whole VLA removal so the idea was that the
> same solution will apply to the 3 of them (and then I'm not really
> adding a new one).

Those constructs only exist for reasons of backwards compatibility.

There is no such reason for AEAD.  So why do you need this?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
