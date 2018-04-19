Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeDSBrk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:47:40 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51416 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbeDSBrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:47:39 -0400
Date: Wed, 18 Apr 2018 21:47:37 -0400 (EDT)
Message-Id: <20180418.214737.1146004592657647139.davem@davemloft.net>
To: neilb@suse.com
Cc: herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] rhashtable: remove outdated comments about
 grow_decision etc
From: David Miller <davem@davemloft.net>
In-Reply-To: <878t9kqfhq.fsf@notabene.neil.brown.name>
References: <152403402187.16895.84802790561768231.stgit2@noble>
        <20180418142940.qd34y2ykjvmyjjh5@gondor.apana.org.au>
        <878t9kqfhq.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Thu, 19 Apr 2018 09:09:05 +1000

> On Wed, Apr 18 2018, Herbert Xu wrote:
> 
>> On Wed, Apr 18, 2018 at 04:47:01PM +1000, NeilBrown wrote:
>>> grow_decision and shink_decision no longer exist, so remove
>>> the remaining references to them.
>>> 
>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>
>> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Thanks.  Is that Ack sufficient for this patch to go upstream, or is
> there something else that I need to do?

One patch being ACK'd does not release the whole series to be applied
and the whole series will be treated as a complete unit for that
purpose.

So if discussion is holding up one patch in the series, it holds up
the entire series.

So get the entire series in acceptable condition, or submit only one
change at a time individually and wait for that one to be accepted
before you submit and ask for feedback on the next one.

I hope that makes things clear for you.
