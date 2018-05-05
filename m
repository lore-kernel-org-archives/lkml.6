Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEEJay (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:30:54 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35412 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeEEJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:30:53 -0400
Date: Sat, 5 May 2018 17:30:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH 5/8] rhashtable: remove rhashtable_walk_peek()
Message-ID: <20180505093048.daniququh6yi7wjt@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605435.18473.12657571579874985957.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605435.18473.12657571579874985957.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> This function has a somewhat confused behavior that is not properly
> described by the documentation.
> Sometimes is returns the previous object, sometimes it returns the
> next one.
> Sometimes it changes the iterator, sometimes it doesn't.
> 
> This function is not currently used and is not worth keeping, so
> remove it.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I don't have a problem with this.  But it would be good to hear
from Tom Herbert who added this.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
