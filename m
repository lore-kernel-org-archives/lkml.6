Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeDDPtN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:49:13 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34086 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeDDPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:49:10 -0400
Date: Wed, 4 Apr 2018 23:48:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, cluster-devel@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [Cluster-devel] [PATCH v2 0/2] gfs2: Stop using
 rhashtable_walk_peek
Message-ID: <20180404154859.GA12104@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com>
 <1366548861.16037365.1522856788263.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366548861.16037365.1522856788263.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 11:46:28AM -0400, Bob Peterson wrote:
>
> The patches look good. The big question is whether to add them to this
> merge window while it's still open. Opinions?

We're still hashing out the rhashtable interface so I don't think
now is the time to rush things.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
