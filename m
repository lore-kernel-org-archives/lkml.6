Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDXRiG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:38:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37818 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeDXRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:38:03 -0400
Date: Tue, 24 Apr 2018 13:38:01 -0400 (EDT)
Message-Id: <20180424.133801.2083907439536336055.davem@davemloft.net>
To: neilb@suse.com
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] A few rhashtables cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <152452244405.1456.8175298512483573078.stgit@noble>
References: <152452244405.1456.8175298512483573078.stgit@noble>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Tue, 24 Apr 2018 08:29:13 +1000

> 2 patches fixes documentation
> 1 fixes a bit in rhashtable_walk_start()
> 1 improves rhashtable_walk stability.
> 
> All reviewed and Acked.

Series applied to net-next, thanks Neil.
