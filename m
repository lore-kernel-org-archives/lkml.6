Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeDCCeK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:34:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeDCCeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:34:08 -0400
Date: Mon, 02 Apr 2018 22:34:04 -0400 (EDT)
Message-Id: <20180402.223404.1004723633191084443.davem@davemloft.net>
To: neilb@suse.com
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rhashtable_walk fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <8760591103.fsf@notabene.neil.brown.name>
References: <152228607974.16370.14544827502467836789.stgit@noble>
        <20180330.101826.1844442556880257787.davem@davemloft.net>
        <8760591103.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Tue, 03 Apr 2018 12:23:40 +1000

>  I'm sorry if I've caused some confusion, but I didn't think that I was
>  submitting patches to you and know nothing about your two trees.
>  I was submitting patches to Thomas and Herbert, the registered
>  maintainers of rhashtable.  I assumed they would review, respond, and
>  take responsibility for getting them upstream, if that's what they
>  decided, based on whatever arrangements they have in place.
> 
>  If it is appropriate I can resend all of my patches that receive an
>  Ack as a coherent series, and send this to you nominating a particular
>  tree, but I'm unlikely to do that unless asked and told which tree to
>  nominate.

Herbert and Thomas generally review rhashtable patches, but rhashtable
itself is generally maintained in the networking tree(s).  So once
they review and ACK it, I would apply it.
