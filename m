Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeEDRHu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:07:50 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeEDRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:07:49 -0400
Date: Fri, 04 May 2018 13:07:47 -0400 (EDT)
Message-Id: <20180504.130747.817364093811964755.davem@davemloft.net>
To: neilb@suse.com
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Assorted rhashtable fixes and cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <152540595840.18473.11298241115621799037.stgit@noble>
References: <152540595840.18473.11298241115621799037.stgit@noble>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Fri, 04 May 2018 13:54:14 +1000

> This series contains some bugfixes, mostly minor though one
> is worthy of a stable backport I think - tagged with Fixes and Cc: stable.
> 
> Then there are improvements to walking, which have been discussed
> to some degree already.
> Finally a code simplification which I think is correct...

Please do not mix bug fixes and features or improvements.

Please target the serious bug fixes for 'net' and then you can
target the features and improvements for 'net-next'.

This is especially important if you want a change queued up for
-stable, as the change must first go into 'net' for that to happen.

Thank you.
