Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeCZBPf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:15:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44340 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCZBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:15:34 -0400
Date: Sun, 25 Mar 2018 21:15:32 -0400 (EDT)
Message-Id: <20180325.211532.2200869889572938343.davem@davemloft.net>
To: glider@google.com
Cc: dvyukov@google.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: make sure nladdr has correct size in
 netlink_connect()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180323124902.41625-1-glider@google.com>
References: <20180323124902.41625-1-glider@google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>
Date: Fri, 23 Mar 2018 13:49:02 +0100

> KMSAN reports use of uninitialized memory in the case when |alen| is
> smaller than sizeof(struct sockaddr_nl), and therefore |nladdr| isn't
> fully copied from the userspace.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
> ---
> v2: fixed a typo spotted by Eric Dumazet

Applied and queued up for -stable, thank you.
