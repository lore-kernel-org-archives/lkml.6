Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeEGJa0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:30:26 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:50156 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeEGJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:30:25 -0400
Date: Mon, 7 May 2018 17:30:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] rhashtable: further improve stability of
 rhashtable_walk
Message-ID: <20180507093019.qkz75qm7rocnbfnl@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605438.18473.4797800779538116583.stgit@noble>
 <20180505094212.hpqjyv5ijibviuwh@gondor.apana.org.au>
 <87vac1db5t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vac1db5t.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 07:50:54AM +1000, NeilBrown wrote:
>
> Do we?  How could we fix it for both rhashtable and rhltable?

Well I suggested earlier to insert the walker object into the
hash table, which would be applicable regardless of whether it
is a normal rhashtable of a rhltable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
