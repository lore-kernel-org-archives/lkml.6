Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeDWIGO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:06:14 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39380 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbeDWIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:06:09 -0400
Date: Mon, 23 Apr 2018 16:06:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] rhashtable: remove incorrect comment on r{hl,
 hash}table_walk_enter()
Message-ID: <20180423080601.qlmwnvlb5vlq3qis@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
 <152403402192.16895.9740762152906281009.stgit2@noble>
 <20180418142854.wacgjdycxvfjh77s@gondor.apana.org.au>
 <87efjcqg2r.fsf@notabene.neil.brown.name>
 <20180419032237.yjvjuh6n7n6tggtr@gondor.apana.org.au>
 <87d0yqog56.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0yqog56.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:17AM +1000, NeilBrown wrote:
>
> Sound fair.  Could you Ack the following?  Then I'll resend all the
> patches that have an ack.
> I've realised that the "further improve stability of rhashtable_walk"
> patch isn't actually complete, so I'll withdraw that for now.

Looks good to me.

> From e16c037398b6c057787437f3a0aaa7fd44c3bee3 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.com>
> Date: Mon, 16 Apr 2018 11:05:39 +1000
> Subject: [PATCH] rhashtable: Revise incorrect comment on
>  r{hl,hash}table_walk_enter()
> 
> Neither rhashtable_walk_enter() or rhltable_walk_enter() sleep, though
> they do take a spinlock without irq protection.
> So revise the comments to accurately state the contexts in which
> these functions can be called.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
