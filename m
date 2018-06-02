Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeFBPtH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 11:49:07 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59044 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeFBPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 11:49:06 -0400
Date: Sat, 2 Jun 2018 23:48:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH 10/18] rhashtable: remove rhashtable_walk_peek()
Message-ID: <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824964.30340.6329146982899668633.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152782824964.30340.6329146982899668633.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
> This function has a somewhat confused behavior that is not properly
> described by the documentation.
> Sometimes is returns the previous object, sometimes it returns the
> next one.
> Sometimes it changes the iterator, sometimes it doesn't.
> 
> This function is not currently used and is not worth keeping, so
> remove it.
> 
> A future patch will introduce a new function with a
> simpler interface which can meet the same need that
> this was added for.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Please keep Tom Herbert in the loop.  IIRC he had an issue with
this patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
