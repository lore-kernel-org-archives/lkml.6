Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeC2PmF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:42:05 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:50032 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeC2PmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:42:04 -0400
Date: Thu, 29 Mar 2018 23:41:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel <cluster-devel@redhat.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
Message-ID: <20180329154153.GA23562@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com>
 <20180329123544.GA22551@gondor.apana.org.au>
 <CAHc6FU4i5LDoqXXTgAKtTA8EtGyawxXtY4iavo7NjHCsbX1G8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4i5LDoqXXTgAKtTA8EtGyawxXtY4iavo7NjHCsbX1G8w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 03:15:54PM +0200, Andreas Gruenbacher wrote:
>
> For all I know, Neil's latest plan is to get rhashtable_walk_peek
> replaced and removed because it is unfixable. This patch removes the
> one and only user.

His latest patch makes rhashtable_walk_peek stable in the face of
removals.

https://patchwork.ozlabs.org/patch/892534/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
