Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeEGJ16 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:27:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:50064 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeEGJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:27:57 -0400
Date: Mon, 7 May 2018 17:27:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] rhashtable: remove nulls_base and related code.
Message-ID: <20180507092748.yqqldkwkxkynaaju@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605427.18473.12277050439942480863.stgit@noble>
 <20180505091208.tnsxi6hdpjn456yz@gondor.apana.org.au>
 <877eoheqc2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eoheqc2.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 07:37:49AM +1000, NeilBrown wrote:
> 
> I can see no evidence that this is required for anything, as it isn't
> use and I'm fairly sure that in it's current form - it cannot be used.

Search for nulls in net/ipv4.  This is definitely used throughout
the network stack.  As the aim is to convert as many existing hash
tables to rhashtable as possible, we want to keep this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
