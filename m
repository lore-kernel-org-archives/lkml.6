Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeC0PrS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:47:18 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45684 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeC0PrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:47:16 -0400
Date: Tue, 27 Mar 2018 23:47:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] rhashtable: reset intr when rhashtable_walk_start
 sees new table
Message-ID: <20180327154703.GA14001@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718427.11435.17689950338335773862.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152210718427.11435.17689950338335773862.stgit@noble>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 10:33:04AM +1100, NeilBrown wrote:
> The documentation claims that when rhashtable_walk_start_check()
> detects a resize event, it will rewind back to the beginning
> of the table.  This is not true.  We need to set ->slot and
> ->skip to be zero for it to be true.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
