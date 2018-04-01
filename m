Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753836AbeDASHQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 14:07:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56840 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbeDASHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 14:07:14 -0400
Date: Sun, 01 Apr 2018 14:07:12 -0400 (EDT)
Message-Id: <20180401.140712.1392918167775655287.davem@davemloft.net>
To: joe@perches.com
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH V2] treewide/net: Rename eth_stp_addr to ether_stp_addr
From: David Miller <davem@davemloft.net>
In-Reply-To: <5f5dafaeacbc9e9aa2d969701e510d31ef6e97db.1522521099.git.joe@perches.com>
References: <20180331173643.GD7460@lunn.ch>
        <5f5dafaeacbc9e9aa2d969701e510d31ef6e97db.1522521099.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Sat, 31 Mar 2018 11:34:06 -0700

> eth_stp_addr is not in the same form as the other global ether_<foo>_addr
> addresses like ether_broadcast_addr.
> 
> Convert it treewide.
> 
> Miscellanea:
> 
> o Add comment to the ether_stp_addr define to show it's for spanning-tree
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> V2: Remove gg from initial comment (bad editing)

Joe this was part of a larger series.

Please repost the entire series when you fix a patch contained
in that series, not just the patch that is changing.

Thank you.
