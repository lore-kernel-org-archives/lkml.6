Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeC3OSa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:18:30 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59578 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3OS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:18:28 -0400
Date: Fri, 30 Mar 2018 10:18:26 -0400 (EDT)
Message-Id: <20180330.101826.1844442556880257787.davem@davemloft.net>
To: neilb@suse.com
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rhashtable_walk fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <152228607974.16370.14544827502467836789.stgit@noble>
References: <152228607974.16370.14544827502467836789.stgit@noble>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Thu, 29 Mar 2018 12:19:09 +1100

> These two patches apply on top of my previous "rhashtable: reset iter
> when rhashtable_walk_start sees new table" patch.
> 
> The first fixes a bug that I found in rhltable_insert().
> 
> The second is an alternate to my "rhashtable: allow a walk of the hash
> table without missing object."
> This version doesn't require an API change and should be reliable for
> rhltables too (my first version didn't handle these correctly).

Neil, please don't mix and match patches.

Also when you need to change a patch in a series, please post the entire
new series not just the patch that changes.

Patch #1 in this series is unnecessary.  As Herbert explained this has
been fixed already.

So please repost freshly the patches that are relevant and you want me
to consider for inclusion.  Also be explicit and clear about which of
my two networking trees you are targetting these changes.

Thank you.
