Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeCTOsF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:48:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55238 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:48:00 -0400
Date: Tue, 20 Mar 2018 10:47:59 -0400 (EDT)
Message-Id: <20180320.104759.796804827689233281.davem@davemloft.net>
To: liran.alon@oracle.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@oracle.com, yuval.shaia@oracle.com
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <liran.alon@oracle.com>
Date: Tue, 13 Mar 2018 17:07:22 +0200

> Before this commit, dev_forward_skb() always cleared packet's
> per-network-namespace info. Even if the packet doesn't cross
> network namespaces.

There was a lot of discussion about this patch.

Particularly whether it could potentially break current
users or not.

If this is resolved and the patch should still be applied,
please repost and the folks involved in this dicussion should
add their ACKs.

Thanks.
