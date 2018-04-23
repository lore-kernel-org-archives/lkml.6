Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeDWW3n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:29:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:54564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbeDWW3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:29:39 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date: Tue, 24 Apr 2018 08:29:13 +1000
Subject: [PATCH 0/4] A few rhashtables cleanups
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152452244405.1456.8175298512483573078.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 patches fixes documentation
1 fixes a bit in rhashtable_walk_start()
1 improves rhashtable_walk stability.

All reviewed and Acked.

Thanks,
NeilBrown


---

NeilBrown (4):
      rhashtable: remove outdated comments about grow_decision etc
      rhashtable: Revise incorrect comment on r{hl,hash}table_walk_enter()
      rhashtable: reset iter when rhashtable_walk_start sees new table
      rhashtable: improve rhashtable_walk stability when stop/start used.


 include/linux/rhashtable.h |   38 +++++++++++++++------------------
 lib/rhashtable.c           |   51 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 26 deletions(-)

--
Signature
