Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeBAPRC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:17:02 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44620 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeBAPQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:16:56 -0500
Date: Thu, 01 Feb 2018 10:16:55 -0500 (EST)
Message-Id: <20180201.101655.1316424669256047119.davem@davemloft.net>
To: guro@fb.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, edumazet@google.com, hannes@cmpxchg.org,
        tj@kernel.org
Subject: Re: [PATCH net] net: memcontrol: charge allocated memory after
 mem_cgroup_sk_alloc()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180131215401.GA8956@castle>
References: <20180125001911.15597-1-guro@fb.com>
        <20180125.120302.1117695034222616751.davem@davemloft.net>
        <20180131215401.GA8956@castle>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>
Date: Wed, 31 Jan 2018 21:54:08 +0000

> So I really start thinking that reverting 9f1c2674b328
> ("net: memcontrol: defer call to mem_cgroup_sk_alloc()")
> and fixing the original issue differently might be easier
> and a proper way to go. Does it makes sense?

You'll need to work that out with Eric Dumazet who added the
change in question which you think we should revert.
