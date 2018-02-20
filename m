Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeBTEP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 23:15:28 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:39966 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeBTEP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 23:15:26 -0500
Date: Mon, 19 Feb 2018 23:15:23 -0500 (EST)
Message-Id: <20180219.231523.2226814242777657736.davem@davemloft.net>
To: fthain@telegraphics.com.au
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 2/4] net/8390: Fix msg_enable patch snafu
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LNX.2.21.1802201108100.8@nippy.intranet>
References: <alpine.LNX.2.21.1802200844340.8@nippy.intranet>
        <20180219.184343.1801583131809551924.davem@davemloft.net>
        <alpine.LNX.2.21.1802201108100.8@nippy.intranet>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 20 Feb 2018 11:42:26 +1100 (AEDT)

> If there was an unused variables I would happily remove that too but the 
> 'version' string is not unused. The etherh.c and mac8390.c files both 
> include "lib8390.c" and in there you'll find the 'version' string used in 
> ethdev_setup().

My bad, thanks for being so patient with me :)
